import 'dart:async';

import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/sizes_helpers.dart';
import 'ui/srcreen003_listcv_ui.dart';

// ignore: must_be_immutable
class SCR003 extends StatefulWidget {
  @override
  _SCR003State createState() => _SCR003State();
}

class _SCR003State extends State<SCR003> {
  Completer<void> _refreshCompleter;

  List<SkillsDetail> listskills;

  List<Resume> listresume;

  void initState() {
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    /// Set screen rotation to only vertical
    String lang = AppLocalizations.of(context).locale.languageCode;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationFailure) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).translate("scr003.cvManage"),
              style: TextStyle(color: Colors.white),
            ),
            elevation: 0.0,
          ),
          bottomNavigationBar: AppBottomNavigationBar(
            currentIndex: 1,
          ),
          body: Center(
              child: Container(
            height: displayHeight(context) * .06,
            width: displayWidth(context) * .4,
            child: RawMaterialButton(
                elevation: 2,
                fillColor: AppColors.primaryColor,
                shape: StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)
                            .translate("scr003.loginNow"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.SCR001_SCREEN);
                }),
          )),
        );
      } else {
        return BlocProvider<LoadListCVBloc>(
            create: (context) {
              return LoadListCVBloc(repository: ResumeRepository())
                ..add(
                  FetchListCVEvent(lang: lang),
                );
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  AppLocalizations.of(context).translate("scr003.cvManage"),
                  style: TextStyle(color: Colors.white),
                ),
                elevation: 0.0,
              ),
              bottomNavigationBar: AppBottomNavigationBar(
                currentIndex: 1,
              ),
              body: BlocBuilder<LoadListCVBloc, LoadListCVState>(
                  builder: (context, state) {
                if (state is GetListCVUnitity) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.primaryDarkColor),
                    ),
                  );
                }
                if (state is GetListCVLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.primaryDarkColor),
                    ),
                  );
                }
                if (state is GetListCVSuccess) {
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                  listskills = state.listSkills;
                  listresume = state.listResume;
                  if (state.listResume.isEmpty) {
                    return buildNoCVScreen(
                        context,
                        AppLocalizations.of(context).translate("scr003.noCV"),
                        state.listSkills,
                        state.listResume,
                        lang);
                  } else {
                    ///load list CVs when get success
                    return RefreshIndicator(
                      child: buildSuccessScreen(
                          context, state.listResume, state.listSkills, lang),
                      onRefresh: () {
                        BlocProvider.of<LoadListCVBloc>(context).add(
                            FetchRefresh(
                                listResume: state.listResume, lang: lang));
                        return _refreshCompleter.future;
                      },
                    );
                  }
                }
                if (state is DeleteCVSuccess) {
                  listskills = state.listSkills;
                  listresume = state.listResume;
                  return RefreshIndicator(
                      child: buildSuccessScreen(
                          context, state.listResume, state.listSkills, lang),
                      onRefresh: () {
                        BlocProvider.of<LoadListCVBloc>(context).add(
                            FetchRefresh(
                                listResume: state.listResume, lang: lang));
                        return _refreshCompleter.future;
                      });
                }
                return buildFailedScreen(
                  context,
                  AppLocalizations.of(context).translate("scr003.fetchFailed"),
                );
              }),
            ));
      }
    });
  }
}
