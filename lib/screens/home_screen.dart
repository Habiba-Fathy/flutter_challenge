import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/providers/app_provider.dart';
import 'package:flutter_challenge/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indicatorIndex = 0;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    final data = context.read<AppProvider>().data;
    DateFormat arLang = DateFormat('', 'ar');
    arLang.dateSymbols.FIRSTDAYOFWEEK = 7;
    arLang.dateSymbols.ZERODIGIT = "0";
    liked = data?.isLiked ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<AppProvider>().data;
    return Scaffold(
      body: data == null
          ? const LoadingWidget()
          : Column(
              children: [
                Stack(
                  children: [
                    if (data.images != null && data.images!.isNotEmpty)
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
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).shadowColor,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const LoadingWidget(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                                        (data.isLiked ?? false) || liked
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: (data.isLiked ?? false) || liked
                                            ? Colors.amber
                                            : Theme.of(context).shadowColor,
                                        size: 22,
                                      ),
                                      onPressed: () {
                                        liked = !liked;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          if (data.images != null && data.images!.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  DotsIndicator(
                                    dotsCount: data.images!.length,
                                    mainAxisSize: MainAxisSize.max,
                                    position: _indicatorIndex.toDouble(),
                                    decorator: DotsDecorator(
                                      spacing: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      size: const Size(8, 8),
                                      activeSize: const Size(12, 12),
                                      color: Theme.of(context)
                                          .shadowColor
                                          .withOpacity(0.5), // Inactive color
                                      activeColor:
                                          Theme.of(context).shadowColor,
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
                              Row(
                                children: [
                                  Text(
                                    '# ${data.interest}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    '${data.title}',
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
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: Theme.of(context).shadowColor,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    DateFormat('EEEE, dd MMMM, HH:mm a ', 'ar')
                                        .format(
                                            DateFormat("yyyy-MM-dd'T'HH:mm:ssZ")
                                                .parse(data.date ?? ''))
                                        .replaceAll(' م ', ' مساءاً ')
                                        .replaceAll(' ص ', ' صباحاً '),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/pin-svgrepo-com.svg',
                                    color: Theme.of(context).shadowColor,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${data.address}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).shadowColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    child: CachedNetworkImage(
                                      imageUrl: data.trainerImg ?? '',
                                      // height: 240,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).shadowColor,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const LoadingWidget(
                                        size: 30,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.person),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${data.trainerName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${data.trainerInfo}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).shadowColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'عن الدورة',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${data.occasionDetail}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).shadowColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'تكلفة الدورة',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الحجز العادي',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    'SAR',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الحجز المميز',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    'SAR',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الحجز السريع',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    'SAR',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'قم بالحجز الآن',
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
