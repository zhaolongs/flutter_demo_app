import 'package:flutter/material.dart';
import 'package:flutter_test_app/tk/demo6/config/colors.dart';
import 'package:flutter_test_app/tk/demo6/config/size.dart';
import 'package:flutter_test_app/tk/demo6/config/strings.dart';
import 'package:flutter_test_app/tk/demo6/piechart/piechartcustompainter.dart';


class PieChart extends StatefulWidget {
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart>
    with SingleTickerProviderStateMixin {
  double total = 0;
  @override
  void initState() {

    super.initState();
    category.forEach((e) => total += e['amount']);
  }

  @override
  Widget build(BuildContext context) {

    var width = SizeConfig.getWidth(context);
    double fontSize(double size) {
      return size * width / 414;
    }

    return LayoutBuilder(
      builder: (context, constraint) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              shape: BoxShape.circle,
              boxShadow: AppColors.neumorpShadow),
          child: Stack(
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: constraint.maxWidth * 0.6,
                  child: CustomPaint(
                    child: Container(),
                    foregroundPainter: PieChartCustomPainter(
                        width: constraint.maxWidth * 0.5,
                        categories: category,
                       ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: constraint.maxWidth * .5,
                  decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(3, 3),
                            color: Colors.black38)
                      ]),
                  child: Center(
                      child: Text(
                    "\$" + total.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: fontSize(22)),
                  )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
