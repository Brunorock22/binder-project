import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trabalho_sistemas/model/special_dates.dart';

class CalendarCustom extends StatefulWidget {
  @override
  _CalendarCustomState createState() => _CalendarCustomState();
}

class _CalendarCustomState extends State<CalendarCustom> {
  CalendarController _controller;
  Map<DateTime, List> _events = Map();

  @override
  void initState() {
    super.initState();
    getSpecialDates().catchError((e) {
      print(e);
    });
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: Scaffold(

                body: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TableCalendar(
                        events: _events,
                        locale: 'pt_BR',
                        headerStyle: HeaderStyle(
                            centerHeaderTitle: true,
                            formatButtonVisible: false,
                            titleTextStyle: TextStyle(
                              fontSize: 25.0,
                            )),
                        initialCalendarFormat: CalendarFormat.month,
                        calendarStyle: CalendarStyle(
                          selectedColor: Theme.of(context).primaryColor,
                          todayStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white),
                          selectedStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                        calendarController: _controller,
                        onDaySelected: _onDaySelected,
                      ),
                    ],
                  ),
                )
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, List events) {
//    listSpecial.forEach((specialDate) {
//      DateTime updateDateTime = DateTime.fromMillisecondsSinceEpoch(
//          specialDate.dataEspecial.millisecondsSinceEpoch);
//
//      if (updateDateTime.day == day.day &&
//          updateDateTime.month == day.month &&
//          updateDateTime.year == day.year) {
//        _modalBottomSheetMenu(day, events, specialDate);
//      }
//    });
  }

  Widget _modalBottomSheetMenu(
      DateTime day, List events, SpecialDates specialDate) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        context: context,
        builder: (builder) {
          return ListView(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0))),
                    child: Container(
                      height: 150,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: NetworkImage(specialDate.imageData),
                          ),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Text(
                      specialDate.tituloData,
                      style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                      textAlign: TextAlign.start,
                    )),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),

                  child: Text("Texto do bottom sheet")
              )],
          );
        });
  }

  Future<Map<DateTime, List>> getSpecialDates() async {
//    var querySnapshot =
//    await Firestore.instance.collection("datas_especiais").getDocuments();
//
//    var items = querySnapshot.documents;
//
//    var list = items.map((DocumentSnapshot docSnapshot) {
//      return docSnapshot.data;
//    }).toList();
//    setState(() {
//      list.forEach((l) {
//        print(l['data_especial']);
//        DateTime updateDateTime = DateTime.fromMillisecondsSinceEpoch(
//            l['data_especial'].millisecondsSinceEpoch);
//        _events.putIfAbsent(updateDateTime, () => [l['titulo_data']]);
//
//        listSpecial.add(new SpecialDates(l['data_especial'], l['titulo_data'],
//            l['descricao_data'], l['imagem_data']));
//      });
//    });
//    print(_events);
  }
}
