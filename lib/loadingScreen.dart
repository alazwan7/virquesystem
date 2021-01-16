
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*1,
      height: size.height*1,
      decoration: BoxDecoration(
          color: Color(0xfffafafa).withOpacity(0.1)
      ),
      child: Center(
        child: TweenAnimationBuilder(
            duration: Duration(seconds: 45),
            tween: Tween<double>(begin: 0, end: 120 *3.142),
            builder: (_ ,double angle, __){
              return Transform.rotate(angle: angle,child: SvgPicture.asset("assets/images/830.svg"),);
            }
        ),
      ),
    );
  }
}