import 'package:flutter/material.dart';

class LivingIconView extends StatefulWidget {
  LivingIconView({Key key, this.showImg}) : super(key: key);
  final bool showImg;

  @override
  _LivingIconViewState createState() => _LivingIconViewState();
}

class _LivingIconViewState extends State<LivingIconView> {
  @override
  Widget build(BuildContext context) {
    print(widget.showImg);
    if (widget.showImg) {
      return Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(1.5),
            color: Color.fromARGB(255, 255, 221, 221),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Image(
                  image: AssetImage(
                      'assets/images/Live/live_top_banner_live_icon.png'),
                  width: 12.0,
                  height: 12.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0, top: 0, right: 2.0),
                child: Container(
                  child: Text(
                    '直播中',
                    style: (TextStyle(
                      fontSize: 12.0,
                      color: Color.fromARGB(255, 217, 54, 57),
                    )),
                    textAlign: TextAlign.center,
                  ),
                  width: 36,
                  height: 18,
                ),
              )
            ],
          ));
    }
    return Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(1.5),
          color: Color.fromARGB(255, 217, 54, 57),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 0),
              child: Container(
                child: Text(
                  '直播中',
                  style: (TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  )),
                  textAlign: TextAlign.center,
                ),
                width: 44,
                height: 18,
              ),
            )
          ],
        ));
  }
}
