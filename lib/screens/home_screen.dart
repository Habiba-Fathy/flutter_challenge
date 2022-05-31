import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/providers/app_provider.dart';
import 'package:flutter_challenge/widgets/loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indicatorIndex = 0;

  @override
  Widget build(BuildContext context) {
    final data = context.watch<AppProvider>().data;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              if (data?.images != null && data!.images!.isNotEmpty)
                CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.width / 1.5,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _indicatorIndex = index;
                      });
                    },
                  ),
                  items: [
                    ...data.images!.map(
                      (image) => CachedNetworkImage(
                        imageUrl: image,
                        // height: 240,
                        width: MediaQuery.of(context).size.width,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).shadowColor,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const LoadingWidget(
                          size: 64,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.5,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Theme.of(context).shadowColor,
                              size: 18,
                            ),
                            onPressed: () {},
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.share,
                                  color: Theme.of(context).shadowColor,
                                  size: 22,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.star_border,
                                  color: Theme.of(context).shadowColor,
                                  size: 22,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (data?.images != null && data!.images!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DotsIndicator(
                              dotsCount: data.images!.length,
                              mainAxisSize: MainAxisSize.max,
                              position: _indicatorIndex.toDouble(),
                              decorator: DotsDecorator(
                                spacing:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                size: const Size(8, 8),
                                activeSize: const Size(12, 12),
                                color: Theme.of(context)
                                    .dividerColor
                                    .withOpacity(0.5), // Inactive color
                                activeColor: const Color(0xFF000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 14),
                        const Text('data'),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Text(
                              '${data?.title}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
