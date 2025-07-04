import 'package:cached_network_image/cached_network_image.dart';
import 'package:cats_app/config/app_config.dart';
import 'package:cats_app/domain/entities/cat.dart';
import 'package:cats_app/presentation/screens/detail_screen.dart';
import 'package:cats_app/presentation/widgets/detail_info.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CatCard extends StatelessWidget {
  final Cat cat;

  const CatCard({
    super.key,
    required this.cat,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = cat.catImage != null && cat.catImage!.isNotEmpty;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailScreen(),
            settings: RouteSettings(arguments: {'cat': cat}),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppConfig.instance.colorSecondary,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            DetailInfo(title: cat.name, text: "Mas..."),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: Hero(
                tag: cat.id,
                child: hasImage
                    ? CachedNetworkImage(
                        imageUrl: cat.catImage!,
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(
                          child: Lottie.asset(
                            'assets/lotties/loading.json',
                            width: 300,
                            height: 300,
                            fit: BoxFit.fill,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.image_not_supported_outlined,
                          size: 300.0,
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported_outlined,
                              size: 300.0,
                              color: AppConfig.instance.colorLetter,
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            DetailInfo(
              title: 'Origin: ${cat.origin}',
              text: 'Intelligence: ${cat.intelligence}',
            ),
          ],
        ),
      ),
    );
  }
}
