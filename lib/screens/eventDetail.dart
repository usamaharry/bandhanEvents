import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/event.dart';

class EventDetail extends StatelessWidget {
  static const routeName = '/eventDeatil';

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as Event;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          onPressed: () async {
            print('gege');
            launch('tel://${event.phone}');
          },
          child: Icon(
            CupertinoIcons.phone,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        leading: CupertinoButton(
          child: Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                child: Text(
                  event.name[0],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Text(
                  event.name,
                  style: TextStyle(
                    fontFamily: 'quickSand',
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.grey[850],
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Personal',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            event.address,
                            style: TextStyle(
                              fontFamily: 'quickSand',
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            event.phone,
                            style: TextStyle(
                              fontFamily: 'quickSand',
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            event.cnic,
                            style: TextStyle(
                              fontFamily: 'quickSand',
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.grey[850],
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            event.type,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Ladies' +
                                '             ' +
                                event.ladies.toString(),
                            style: TextStyle(
                              fontFamily: 'quickSand',
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Gents' + '              ' + event.gents.toString(),
                            style: TextStyle(
                              fontFamily: 'quickSand',
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Advance' +
                                '         ' +
                                event.advance.toInt().toString(),
                            style: TextStyle(
                              fontFamily: 'quickSand',
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Per Head' +
                                '        ' +
                                event.perHead.toInt().toString(),
                            style: TextStyle(
                              fontFamily: 'quickSand',
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.grey[850],
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Items',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        ...event.items.map(
                          (e) {
                            return e != 'Items'
                                ? Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontFamily: 'quickSand',
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13,
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          },
                        ).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.grey[850],
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Services',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        ...event.services.map(
                          (e) {
                            return e != 'Service'
                                ? Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontFamily: 'quickSand',
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13,
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          },
                        ).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.grey[850],
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Others',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            event.others,
                            style: TextStyle(
                              fontFamily: 'quickSand',
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
