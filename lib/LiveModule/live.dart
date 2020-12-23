import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/LiveModule/AllLiveRoomList/live_room_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Live extends StatefulWidget {
  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {
  void _jumpToLiveRoomList() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return LiveRoomList();
    }));
    // Fluttertoast.showToast(
    //     msg: 'ms‘g',
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.CENTER, // 消息框弹出的位置
    //     // timeInSecForIos: 1,  // 消息框持续的时间（目前的版本只有ios有效）
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    // //第二种
    // Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
    //   return LiveRoomList();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
          color: Colors.blue,
          onPressed: _jumpToLiveRoomList,
          child: Text('跳转直播间列表'),
          highlightColor: Colors.blue[700],
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
      ),
    );
  }
}
