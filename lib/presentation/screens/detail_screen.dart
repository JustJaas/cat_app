import 'package:cached_network_image/cached_network_image.dart';
import 'package:cats_app/config/app_config.dart';
import 'package:cats_app/domain/entities/cat.dart';
import 'package:cats_app/presentation/widgets/cat_appbar.dart';
import 'package:cats_app/presentation/widgets/detail_indicator.dart';
import 'package:cats_app/presentation/widgets/detail_info.dart';
import 'package:cats_app/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> descriptionSlideAnimation;
  late Animation<double> descriptionFadeAnimation;

  final List<Animation<Offset>> _indicatorSlideAnimations = [];
  final List<Animation<double>> _indicatorFadeAnimations = [];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    descriptionSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    descriptionFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    final int numberOfIndicators = 8;
    for (int i = 0; i < numberOfIndicators; i++) {
      final beginInterval = 0.5 + (i * 0.07);
      final endInterval = 0.9 + (i * 0.07);

      _indicatorSlideAnimations.add(
        Tween<Offset>(
          begin: const Offset(0.2, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(beginInterval, endInterval,
                curve: Curves.easeOutCubic),
          ),
        ),
      );
      _indicatorFadeAnimations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(beginInterval, endInterval, curve: Curves.easeIn),
          ),
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final arguments = ModalRoute.of(context)?.settings.arguments! as Map;
    Cat cat = arguments['cat'];

    return Scaffold(
        appBar: CatAppBar(text: cat.name),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.4,
                  width: double.infinity,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Hero(
                          tag: cat.id,
                          child: cat.catImage == null
                              ? emptyImage()
                              : CachedNetworkImage(
                                  imageUrl: cat.catImage!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  errorWidget: (context, url, error) =>
                                      emptyImage(),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          TextWidget(text: cat.description),
                          Divider(thickness: 0.2, height: 15),
                          DetailInfo(title: "Origin", text: cat.origin),
                          Divider(thickness: 0.2, height: 15),
                          DetailInfo(
                            title: "Life Span",
                            text: '${cat.lifeSpan} years',
                          ),
                          Divider(thickness: 0.2, height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextWidget(text: "Hypoallergenic"),
                              cat.hypoallergenic == 0
                                  ? const TextWidget(text: "No")
                                  : const TextWidget(text: "Yes"),
                            ],
                          ),
                          Divider(thickness: 0.2, height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width * 0.3,
                                child: const TextWidget(text: "Temperament"),
                              ),
                              Expanded(
                                child: Text(
                                  cat.temperament,
                                  softWrap: true,
                                  maxLines: 3,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 0.2, height: 25),
                          DetailIndicator(
                              title: "Intelligence", value: cat.intelligence),
                          DetailIndicator(
                              title: "Adaptability", value: cat.adaptability),
                          DetailIndicator(
                            title: "Affection Level",
                            value: cat.affectionLevel,
                          ),
                          DetailIndicator(
                              title: "Health Issues", value: cat.healthIssues),
                          DetailIndicator(
                              title: "Social Needs", value: cat.socialNeeds),
                          DetailIndicator(
                              title: "Dog Friendly", value: cat.dogFriendly),
                          DetailIndicator(
                              title: "Stranger Friendly",
                              value: cat.strangerFriendly),
                          DetailIndicator(
                              title: "Child Friendly",
                              value: cat.childFriendly),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Icon emptyImage() {
    return Icon(
      Icons.image_not_supported_outlined,
      size: 300.0,
      color: AppConfig.instance.colorLetter,
    );
  }
}
