import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitaris/utils/container.dart';
import 'package:sitaris/utils/spacing.dart';

class ShimmerListProductUser extends StatelessWidget {
  const ShimmerListProductUser({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => FxContainer(
          onTap: () {
            // controller.goToSingleCoinScreen(coin);
          },
          color: Colors.white,
          margin: FxSpacing.bottom(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: 30,
                  height: 30,
                  child: FxContainer(
                    color: Colors.grey.withOpacity(0.5),
                    width: 30,
                    height: 30,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: true,
                      child: Container(
                        height: 5,
                        width: 5,
                        color: Colors.white,
                      ),
                    ),
                  )),
              FxSpacing.width(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: true,
                      child: Container(
                        height: 5,
                        width: 50,
                        color: Colors.white,
                      ),
                    ),
                    FxSpacing.height(5),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: true,
                      child: Container(
                        height: 5,
                        width: 50,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              FxSpacing.width(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: Container(
                      height: 5,
                      width: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
