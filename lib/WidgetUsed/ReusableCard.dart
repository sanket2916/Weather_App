import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final String parameter;
  final String parameterValue;
  final IconData? icon;
  final bool isLeft;

  ReusableCard({required this.parameter, required this.parameterValue, this.icon, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: isLeft? EdgeInsets.fromLTRB(10, 5, 5, 10) : EdgeInsets.fromLTRB(5, 5, 10, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0x8F000000),
          ),
          // color: Color(0x8F000000),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$parameter',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    parameterValue,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}
