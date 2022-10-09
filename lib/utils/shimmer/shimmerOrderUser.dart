import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitaris/utils/spacing.dart';

class ShimmerOrderUser extends StatelessWidget {
  const ShimmerOrderUser({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
              margin: FxSpacing.fromLTRB(24, 12, 12, 0),
              padding: FxSpacing.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: true,
                      child: Container(
                        height: 40,
                        width: 4,
                        color: Colors.grey.withBlue(10),
                      )),
                  FxSpacing.width(20),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                enabled: true,
                                child: Container(
                                  height: 10,
                                  width: 80,
                                  color: Colors.white,
                                ),
                              ),
                              FxSpacing.height(5),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                enabled: true,
                                child: Container(
                                  height: 10,
                                  width: 80,
                                  color: Colors.white,
                                ),
                              ),
                              FxSpacing.height(5),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                enabled: true,
                                child: Container(
                                  height: 10,
                                  width: 80,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }
}
