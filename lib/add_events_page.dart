import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:lista_contatos/calendar.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  CalendarClient calendarClient = CalendarClient();
  String startTimeFormated = '';
  String endTimeFormated = '';
  DateTime startTime;
  DateTime endTime;
  TextEditingController _eventName = TextEditingController();

  adicionarEvento() {
    if (_eventName.text != '' && startTime != null && endTime != null) {
      calendarClient.insert(
        _eventName.text,
        startTime,
        endTime,
      );

      return;
    }

    return AwesomeDialog(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
        dialogBackgroundColor: Colors.white,
        context: context,
        autoHide: Duration(seconds: 2),
        borderSide: BorderSide(color: Colors.grey, width: 0.5),
        width: 400,
        headerAnimationLoop: false,
        animType: AnimType.BOTTOMSLIDE,
        dialogType: DialogType.WARNING,
        title: 'Evento Invalido',
        desc: 'Verifique se todos os dados estão preenchidos corretamente')
      ..show();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: Column(
        children: [
          Container(
            child: TextFormField(
              controller: _eventName,
              decoration: InputDecoration(
                labelText: 'Nome do Evento',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.event_available,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 00.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2019, 3, 5),
                          maxTime: DateTime(2200, 6, 7),
                          onChanged: (date) {}, onConfirm: (date) {
                        setState(() {
                          this.startTime = date;
                          this.startTimeFormated =
                              DateFormat('dd/MM/yyyy HH:mm')
                                  .format(date)
                                  .toString();
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.pt);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4e4376),
                      textStyle:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    child: Text(
                      'Inicio do Evento',
                      style: TextStyle(color: Colors.white),
                    )),
                startTimeFormated != ""
                    ? Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey[600])),
                        child: Text(
                          '$startTimeFormated',
                          style: GoogleFonts.petrona(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 00.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2019, 3, 5),
                          maxTime: DateTime(2200, 6, 7),
                          onChanged: (date) {}, onConfirm: (date) {
                        setState(() {
                          this.endTime = date;
                          this.endTimeFormated = DateFormat('dd/MM/yyyy HH:mm')
                              .format(date)
                              .toString();
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.pt);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4e4376),
                      textStyle:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    child: Text(
                      'Fim do Evento',
                      style: TextStyle(color: Colors.white),
                    )),
                endTimeFormated != ""
                    ? Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey[600])),
                        child: Text(
                          '$endTimeFormated',
                          style: GoogleFonts.petrona(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 00.0, 0.0),
            child: ElevatedButton(
                onPressed: () {
                  adicionarEvento();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF4e4376),
                  textStyle:
                      TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
                child: Text(
                  'Adicionar Evento',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
