import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixelperks/controller/preview_controller.dart';
import 'package:pixelperks/widget/center_error.dart';
import 'package:pixelperks/widget/center_loader.dart';
import 'package:pixelperks/widget/preview_grid.dart';

class Latest extends StatelessWidget {
  const Latest({super.key});

  @override
  Widget build(context) {
    final PreviewController pc = Get.put(PreviewController());

    return Obx(
      () {
        // state cached :')
        if (pc.server[Endpoint.latest]!.isNotEmpty) {
          return PreviewGrid(server: pc.server[Endpoint.latest]!);
        }

        return FutureBuilder(
          future: fetchInitial('latest'),
          builder: (ctx, snap) {
            if (snap.hasData) {
              Timer(const Duration(microseconds: 100), () {
                pc.addSateCache(snap.data!.images, Endpoint.latest);
              });

              // return PreviewGrid(server: snap.data!.images);
            }

            if (snap.hasError) {
              return const CenterError();
            }

            return const CenterLoader(msg: 'Each wallpapers with uniquness..');
          },
        );
      },
    );
  }
}
