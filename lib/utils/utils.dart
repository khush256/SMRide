import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Util {
  static convertTimeTo12Hour(time24) {
    // time24=time24.substring(1,time24.length-1);
    var time2 = time24.split('(');
    time2 = time2[1].split(')');
    time24 = time2[0];
    var time = time24.split(':');
    var hours = int.parse(time[0]);
    var mins = int.parse(time[1]);
    var amOrPm = 'AM';
    if (hours > 12) {
      hours = hours - 12;
      amOrPm = 'PM';
    }
    //Converting to string
    var shours = hours.toString();
    var smins = mins.toString();
    if (shours.length == 1) shours = '0' + shours;
    if (smins.length == 1) smins = '0' + smins;
    //Checking 12 AM & PM
    if (hours == 0) {
      shours = '12';
      amOrPm = 'AM';
    } else if (hours == 12) {
      amOrPm = 'PM';
    }
    var time12 = shours.toString() + ':' + smins.toString() + ' ' + amOrPm;
    return time12;
  }

  static convertTime(DateTime time24) {
    return DateFormat('h:mm a').format(time24);
  }

  static openPhone(url) async {
    url = 'tel: ' + url;
    if (await canLaunchUrl(Uri.parse(url)) && url != '') {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static errorToast(String msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      backgroundColor: Colors.red,
    );
  }

  static successToast(String msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      backgroundColor: Colors.green,
    );
  }
}
