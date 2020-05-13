//======================================================
// IMPORT 
//======================================================
import 'package:flutter/material.dart';

//======================================================
// MAIN STL CLASS 
//======================================================
class BadgeIcon extends StatelessWidget {
  //======================================================
  // CONSTRUCTURE 
  //======================================================  
  BadgeIcon(
      {this.icon,
      this.badgeCount = 0,
      this.showIfZero = false,
      this.badgeColor = Colors.red,
      TextStyle badgeTextStyle})
      : this.badgeTextStyle =
            badgeTextStyle ?? TextStyle(color: Colors.white, fontSize: 8);
  //=================================================================
  // PARAMETER 
  //=================================================================            
  final Widget icon;
  final int badgeCount;
  final bool showIfZero;
  final Color badgeColor;
  final TextStyle badgeTextStyle;

//=================================================================
// OVERIDE 
//=================================================================
  @override
  Widget build(BuildContext context) {
//=================================================================
// RETURN ICON 
//=================================================================    
    return Stack(children: <Widget>[
      icon,
      //===========================================================
      // SHOW 0 OR NOT
      //===========================================================      
      if (badgeCount > 0 || showIfZero) badge(badgeCount),
    ]);
  }

  //==============================================================
  // WIDGET BADGE 
  //==============================================================
  Widget badge(int count) => Positioned(
        right: 0,
        top: 0,
        //========================================================
        // CONTAINER 
        //========================================================        
        child: new Container(
          padding: EdgeInsets.all(1),
          //======================================================
          // CIRCLE 
          //======================================================          
          decoration: new BoxDecoration(color: badgeColor, 
          borderRadius: BorderRadius.circular(7.5),),
          //======================================================
          // MIN SIZE 
          //======================================================          
          constraints: BoxConstraints(minWidth: 15,minHeight: 15,),
          //======================================================
          // SHOW COUNT 
          //======================================================          
          child: Text(count.toString(),style: TextStyle(color: Colors.white,fontSize: 10,),textAlign: TextAlign.center,
          ),
        ),
      );
}
