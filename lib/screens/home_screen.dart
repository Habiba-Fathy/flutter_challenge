import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/providers/app_provider.dart';
import 'package:flutter_challenge/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

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
                          height: (MediaQuery.of(context).size.width / 1.5),
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
                              placeholder: (context, url) => LoadingWidget(
                                size: 64.sp,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error, size: 24.sp),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        children: [
                          SizedBox(height: 30.sp),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  iconSize: 18.sp,
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Theme.of(context).shadowColor,
                                    // size: 18.sp,
                                  ),
                                  onPressed: () {},
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      iconSize: 20.sp,
                                      icon: Icon(
                                        Icons.share,
                                        color: Theme.of(context).shadowColor,
                                        // size: 22.sp,
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      iconSize: 20.sp,
                                      icon: Icon(
                                        (data.isLiked ?? false) || liked
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: (data.isLiked ?? false) || liked
                                            ? Colors.amber
                                            : Theme.of(context).shadowColor,
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
                                  EdgeInsets.symmetric(horizontal: 16.0.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  DotsIndicator(
                                    dotsCount: data.images!.length,
                                    mainAxisSize: MainAxisSize.max,
                                    position: _indicatorIndex.toDouble(),
                                    decorator: DotsDecorator(
                                      spacing: EdgeInsets.symmetric(
                                          horizontal: 2.0.sp),
                                      size: Size(7.sp, 7.sp),
                                      activeSize: Size(10.sp, 10.sp),
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
                          SizedBox(height: 30.sp),
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
                          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                          child: Column(
                            children: [
                              SizedBox(height: 10.sp),
                              Row(
                                children: [
                                  Text(
                                    '# ${data.interest}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.sp),
                              Row(
                                children: [
                                  Text(
                                    '${data.title}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        ?.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.sp),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: Theme.of(context).shadowColor,
                                    size: 14.sp,
                                  ),
                                  SizedBox(width: 4.sp),
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
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  )
                                ],
                              ),
                              SizedBox(height: 4.sp),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/pin-svgrepo-com.svg',
                                    color: Theme.of(context).shadowColor,
                                    height: 18.sp,
                                  ),
                                  SizedBox(width: 4.sp),
                                  Text(
                                    '${data.address}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 10.sp,
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
                          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                          child: Column(
                            children: [
                              SizedBox(height: 2.sp),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 14.sp,
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
                                          LoadingWidget(
                                        size: 30.sp,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.person,
                                        size: 22.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.sp),
                                  Text(
                                    '${data.trainerName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.sp),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${data.trainerInfo}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                            fontSize: 10.sp,
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
                          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
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
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.sp),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${data.occasionDetail}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                            fontSize: 10.sp,
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
                          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
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
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.sp),
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
                                          fontSize: 10.sp,
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
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.sp),
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
                                          fontSize: 10.sp,
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
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.sp),
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
                                          fontSize: 10.sp,
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
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.sp),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 50.sp,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'قم بالحجز الآن',
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontSize: 14.sp,
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
