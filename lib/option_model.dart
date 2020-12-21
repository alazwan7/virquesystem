import 'package:flutter/material.dart';

class Option {
  Icon icon;
  String title;
  String subtitle;

  Option({this.icon, this.title, this.subtitle});
}

final options = [
  Option(
    icon: Icon(Icons.format_list_numbered_sharp, size: 40.0),
    title: 'Number of Today Visitor',
    subtitle: 'showed the Real-Time number of visitor.',
  ),
  Option(
    icon: Icon(Icons.account_circle, size: 40.0),
    title: 'Your Profile',
    subtitle: 'You can choose to edit your profile.',
  ),
  Option(
    icon: Icon(Icons.feedback, size: 40.0),
    title: 'Send FeedBack',
    subtitle: 'Let us know what we can improve.',
  ),
  Option(
    icon: Icon(Icons.logout, size: 40.0),
    title: 'Log Out',
    subtitle: 'You can exit at anytime.',
  ),
];