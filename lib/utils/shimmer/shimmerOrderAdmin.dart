import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitaris/utils/spacing.dart';

class ShimmerOrderAdmin extends StatelessWidget {
  const ShimmerOrderAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
              padding: FxSpacing.xy(16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: CircleAvatar(
                        backgroundColor: Colors.grey.withBlue(10),
                        child: Container()),
                  ),
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
              ));
        }

        // GridView.count(
        //   shrinkWrap: true,
        //   physics: ClampingScrollPhysics(),
        //   crossAxisCount: 2,
        //   padding: const EdgeInsets.only(top: 10),
        //   mainAxisSpacing: 20,
        //   childAspectRatio: 2 / 2,
        //   crossAxisSpacing: 20,
        //   children: [
        //     Shimmer.fromColors(
        //       baseColor: Colors.grey[300]!,
        //       highlightColor: Colors.grey[100]!,
        //       enabled: true,
        //       child: Container(
        //         width: double.infinity,
        //         height: Utils.dynamicHeight(30),
        //         decoration: BoxDecoration(
        //             color: Colors.white, border: Border.all(width: 0.3)),
        //       ),
        //     ),
        //     Shimmer.fromColors(
        //       baseColor: Colors.grey[300]!,
        //       highlightColor: Colors.grey[100]!,
        //       enabled: true,
        //       child: Container(
        //         width: double.infinity,
        //         height: Utils.dynamicHeight(30),
        //         decoration: BoxDecoration(
        //             color: Colors.white, border: Border.all(width: 0.3)),
        //       ),
        //     )
        //   ],
        // )
        );
  }
}
