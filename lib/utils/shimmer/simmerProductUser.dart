import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductUser extends StatelessWidget {
  const ShimmerProductUser({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4];
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.8,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ...list
              .map((e) => Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 12),
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Column(
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: Colors.grey.withOpacity(0.5),
                            child: SizedBox(
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
                                )),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              enabled: true,
                              child: Container(
                                height: 5,
                                width: 20,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  )))
              .toList()
        ]),
      ),
    );
  }
}
