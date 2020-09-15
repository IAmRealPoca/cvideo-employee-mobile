import 'dart:async';

import 'package:cvideo_mobile/src/app_components/app_colors.dart';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:cvideo_mobile/src/screens/scr006/ui/screen006_cvdetail.ui.dart';
import 'package:cvideo_mobile/src/screens/scr006/ui/sizes_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_section.dart';

class SCR006 extends StatefulWidget {
  @override
  State<SCR006> createState() => _LoadCVDetailState();
}

class _LoadCVDetailState extends State<SCR006> {
  Completer<void> _refreshCompleter;

  void initState() {
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext mainContext) {
    final ScreenArguments args = ModalRoute.of(mainContext).settings.arguments;
    String lang = AppLocalizations.of(mainContext).locale.languageCode;
    String cvId = args.cvId;
    List<Resume> listResume = args.listResume;
    BuildContext contextList = args.contextList;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (authenContext, authenState) {
        if (authenState is AuthenticationFailure) {
          return Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              currentIndex: 1,
            ),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.SCR001_SCREEN);
                },
              ),
              iconTheme: IconThemeData(
                color: AppColors.primaryColor, //change your color here
              ),
              title:
                  Text(AppLocalizations.of(context).translate("scr006.title")),
              centerTitle: true,
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
                              .translate("scr006.btnLogin"),
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
          return BlocProvider<LoadCVDetailBloc>(create: (context) {
            return LoadCVDetailBloc(repository: DetailCVRepository(cvId))
              ..add(FetchCVDetail(lang: lang));
          }, child: Builder(
            builder: (blocContext) {
              return Scaffold(
                bottomNavigationBar: AppBottomNavigationBar(
                  currentIndex: 1,
                ),
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      BlocProvider.of<LoadListCVBloc>(contextList)
                          .add(FetchListCVEvent(lang: lang));
                      Navigator.pop(context);
                    },
                  ),
                  iconTheme: IconThemeData(
                    color: AppColors.primaryColor,
                  ),
                  title: Text(
                      AppLocalizations.of(context).translate("scr006.title")),
                  centerTitle: true,
                ),
                body: BlocBuilder<LoadCVDetailBloc, LoadCVDetailState>(
                    builder: (context, state) {
                  if (state is GetCVDetailUtinity) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.primaryDarkColor),
                      ),
                    );
                  }
                  if (state is GetCVDetailLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.primaryDarkColor),
                      ),
                    );
                  }
                  if (state is GetCVDetailSuccess) {
                    _refreshCompleter?.complete();
                    _refreshCompleter = Completer();

                    if (state.cvDetail.employee == null) {
                      return Center(
                        child: Text(AppLocalizations.of(context)
                            .translate("scr006.errorNoUser")),
                      );
                    } else if (state.listSession.isEmpty) {
                      return buildContent(
                          context,
                          state.employee,
                          state.listSession,
                          state.cvDetail,
                          listResume,
                          blocContext,
                          lang);
                    } else {
                      return RefreshIndicator(
                          child: buildContent(
                              context,
                              state.employee,
                              state.listSession,
                              state.cvDetail,
                              listResume,
                              blocContext,
                              lang),
                          onRefresh: () {
                            BlocProvider.of<LoadCVDetailBloc>(context).add(
                                FetchRefreshCVDtail(
                                    cvDetail: state.cvDetail,
                                    employee: state.employee,
                                    listSession: state.listSession,
                                    lang: lang));
                            return _refreshCompleter.future;
                          });
                    }
                  }
                  if (state is DeleteDetailSuccess) {
                    _refreshCompleter?.complete();
                    _refreshCompleter = Completer();
                    return RefreshIndicator(
                        child: buildContent(
                            context,
                            state.employee,
                            state.listSession,
                            state.cvDetail,
                            listResume,
                            blocContext,
                            lang),
                        onRefresh: () {
                          BlocProvider.of<LoadCVDetailBloc>(context).add(
                              FetchRefreshCVDtail(
                                  cvDetail: state.cvDetail,
                                  employee: state.employee,
                                  listSession: state.listSession,
                                  lang: lang));
                          return _refreshCompleter.future;
                        });
                  }
                  if (state is UpdateTextSuccess) {
                    _refreshCompleter?.complete();
                    _refreshCompleter = Completer();
                    return RefreshIndicator(
                        child: buildContent(
                            context,
                            state.employee,
                            state.listSession,
                            state.cvDetail,
                            listResume,
                            blocContext,
                            lang),
                        onRefresh: () {
                          BlocProvider.of<LoadCVDetailBloc>(context).add(
                              FetchRefreshCVDtail(
                                  cvDetail: state.cvDetail,
                                  employee: state.employee,
                                  listSession: state.listSession,
                                  lang: lang));
                          return _refreshCompleter.future;
                        });
                  }
                  if (state is AddFieldSuccess) {
                    _refreshCompleter?.complete();
                    _refreshCompleter = Completer();
                    return RefreshIndicator(
                        child: buildContent(
                            context,
                            state.employee,
                            state.listSession,
                            state.cvDetail,
                            listResume,
                            blocContext,
                            lang),
                        onRefresh: () {
                          BlocProvider.of<LoadCVDetailBloc>(context).add(
                              FetchRefreshCVDtail(
                                  cvDetail: state.cvDetail,
                                  employee: state.employee,
                                  listSession: state.listSession,
                                  lang: lang));
                          return _refreshCompleter.future;
                        });
                  }
                  if (state is FetchSectionTypeSuccess) {
                    return AddSession(
                      listType: state.listSessionType,
                      cvId: int.parse(cvId),
                      lang: lang,
                    );
                  } else {
                    return Center(
                      child: Text(AppLocalizations.of(context)
                          .translate("scr006.errorFetchFailed")),
                    );
                  }
                }),
              );
            },
          ));
        }
      },
    );
  }
}

class ScreenArguments {
  final String cvId;
  final String titleCV;
  final List<Resume> listResume;
  final BuildContext contextList;
  ScreenArguments({this.cvId, this.titleCV, this.listResume, this.contextList});
}
