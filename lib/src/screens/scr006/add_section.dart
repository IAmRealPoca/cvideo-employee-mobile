import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/sizes_helpers.dart';

class AddSession extends StatelessWidget {
  final List<SessionType> listType;
  final int cvId;
  final String lang;

  const AddSession({Key key, this.listType, this.cvId, this.lang})
      : super(key: key);
  @override
  Widget build(BuildContext context1) {
    TextEditingController _controllerSessionText = TextEditingController();
    TextEditingController _controllerSessionDisplayName =
        TextEditingController();
    bool _validate = false;
    return Scaffold(
        body: ListView.builder(
      itemCount: listType.length,
      itemBuilder: (BuildContext context, intdex) {
        return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: displayHeight(context1) * 0.05,
                margin: EdgeInsets.fromLTRB(3, 5, 3, 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: AppColors.primaryDarkColor,
                    )),
                child: Text(
                  listType[intdex].typeName,
                  style: TextStyle(
                      color: AppColors.primaryDarkColor, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            onTap: () => {
                  showDialog(
                      context: context1,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            AppLocalizations.of(context)
                                .translate("scr006.addSectionTitle"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.primaryDarkColor,
                                fontWeight: FontWeight.bold),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          actions: <Widget>[
                            //button of dialog
                            Container(
                              margin: EdgeInsets.all(5),
                              child: FlatButton(
                                  child: new Text(
                                    AppLocalizations.of(context)
                                        .translate("scr006.btnCancel"),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  onPressed: () => Navigator.of(context).pop()),
                            ),
                            SizedBox(
                              width: 9,
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(3),
                              child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: AppColors.primaryDarkColor,
                                      )),
                                  child: new Text(
                                    AppLocalizations.of(context)
                                        .translate("scr006.btnCreateSection"),
                                    style: TextStyle(
                                        color: AppColors.primaryDarkColor),
                                  ),
                                  onPressed: () => {
                                        if (_validate == true)
                                          {
                                            //show error
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return new AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20.0))),
                                                      title: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                "scr006.errorEmpty"),
                                                      ),
                                                      actions: <Widget>[
                                                        new FlatButton(
                                                          child: new Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                              "scr006.btnUnderStood",
                                                            ),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red[300]),
                                                          ),
                                                          onPressed: () => {
                                                            _controllerSessionDisplayName
                                                                    .text =
                                                                listType[intdex]
                                                                    .typeName,
                                                            _validate = false,
                                                            Navigator.of(
                                                                    context)
                                                                .pop()
                                                          },
                                                        )
                                                      ]);
                                                })
                                          }
                                        else
                                          {
                                            Navigator.of(context).pop(),
                                            BlocProvider.of<LoadCVDetailBloc>(
                                                    context1)
                                                .add(AddSessionEvent(
                                                    listType[intdex].typeId,
                                                    Session(
                                                        icon: "",
                                                        sessionField: [],
                                                        sessionId: 0,
                                                        sessionText:
                                                            _controllerSessionText
                                                                .text,
                                                        sessionTitle:
                                                            _controllerSessionDisplayName
                                                                .text),
                                                    cvId,
                                                    lang)),
                                          }
                                      }),
                            ),
                          ],
                          content: Builder(
                            builder: (context) {
                              //place to input
                              return Container(
                                width: displayWidth(context),
                                height: displayHeight(context) * 0.25,
                                margin: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextField(
                                        controller:
                                            _controllerSessionDisplayName
                                              ..text =
                                                  listType[intdex].typeName,
                                        decoration: new InputDecoration(
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.teal)),
                                            hintText: AppLocalizations.of(
                                                    context)
                                                .translate(
                                                    "scr006.hintTextSectionTitle"),
                                            labelText: AppLocalizations.of(
                                                    context)
                                                .translate(
                                                    "scr006.sectionTitle"),
                                            prefixIcon: Icon(
                                              Icons.title,
                                              color: AppColors.primaryDarkColor,
                                            ),
                                            prefixText: ' ',
                                            suffixStyle: TextStyle(
                                              color: AppColors.primaryDarkColor,
                                            )),
                                        //validation
                                        onChanged: (value) {
                                          value.isEmpty
                                              ? _validate = true
                                              : _validate = false;
                                        }),
                                    SizedBox(
                                      width: 10,
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: _controllerSessionText,
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: AppLocalizations.of(context)
                                              .translate("scr006.sectionText"),
                                          labelText: AppLocalizations.of(
                                                  context)
                                              .translate(
                                                  "scr006.hintTextSectionText"),
                                          prefixIcon: Icon(
                                            Icons.description,
                                            color: AppColors.primaryDarkColor,
                                          ),
                                          prefixText: ' ',
                                          suffixStyle: TextStyle(
                                            color: AppColors.primaryDarkColor,
                                          )),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      })
                });
      },
    ));
  }
}
