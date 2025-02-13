import 'package:anime_world/config/colors.dart';
import 'package:anime_world/customs/alert_dialog.dart';
import 'package:anime_world/customs/custom_widgets.dart';
import 'package:anime_world/providers/characters.dart';
import 'package:anime_world/providers/details_data.dart';
import 'package:anime_world/providers/internet_checker.dart';
import 'package:anime_world/providers/random.dart';
import 'package:anime_world/providers/navigation_index.dart';
import 'package:anime_world/providers/recommendation_img.dart';
import 'package:anime_world/customs/custom_methods.dart';
import 'package:anime_world/providers/top_rated.dart';
import 'package:anime_world/screens/no_connection.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);

    // _controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 10),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    BackButtonInterceptor.remove(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    MyAlertDialog.showExitConfirmation(context);
    return true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<RecommendationImg>(context).startSliding();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<NavigationIndex, InternetChecker>(
      builder: (context, providerOuter, connectionProviderCheck, child) =>
          !connectionProviderCheck.isConnected
              ? const NoConnection()
              : Scaffold(
                  backgroundColor: ColorsClass.dark,
                  bottomNavigationBar: BottomNavigationBar(
                      currentIndex: providerOuter.index,
                      backgroundColor: ColorsClass.dark,
                      iconSize: CustomMethods.width(context, 14),
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      selectedItemColor: ColorsClass.lightBlue,
                      unselectedItemColor: ColorsClass.milk,
                      onTap: (value) {
                        if (value == 3) {
                          MyAlertDialog.showExitConfirmation(context);
                        } else {
                          providerOuter.changeIndex(context, value);
                        }
                      },
                      type: BottomNavigationBarType.fixed,
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home_outlined),
                            label: "Home",
                            activeIcon: Icon(Icons.home)),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.list_alt_sharp), label: "Details"),
                        BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.search), label: "Search"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.logout_rounded), label: "Leave"),
                      ]),
                  body: Stack(
                    children: [
                      Lottie.asset(
                        'assets/animations/snow.json',
                        repeat: true,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: ColorsClass.milk,
                                    width: CustomMethods.width(context, 550)))),
                        child: ScrollConfiguration(
                          behavior: NoGlowScrollBehavior(),
                          child: CustomScrollView(
                            slivers: [
                              SliverAppBar(
                                elevation: 0,
                                floating: false,
                                backgroundColor: ColorsClass.dark,
                                expandedHeight:
                                    CustomMethods.width(context, 1.6),
                                flexibleSpace: FlexibleSpaceBar(
                                  background: SizedBox(
                                    // height: CustomMethods.width(context, 1.2),
                                    child: Container(
                                      color: ColorsClass.dark,
                                      padding: EdgeInsets.fromLTRB(
                                        CustomMethods.width(context, 50),
                                        0,
                                        CustomMethods.width(context, 50),
                                        0,
                                      ),
                                      child: Consumer<RecommendationImg>(
                                        builder: (context, provider, child) =>
                                            Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // Trying to get the Detailed data
                                                Provider.of<DetailsData>(
                                                        context,
                                                        listen: false)
                                                    .getDetailedInfo(
                                                        provider
                                                            .recomendationsData[
                                                                provider.index]
                                                            .id!,
                                                        context);
                                                Provider.of<CharactersProvider>(
                                                        context,
                                                        listen: false)
                                                    .getAllCharacters(provider
                                                        .recomendationsData[
                                                            provider.index]
                                                        .id!);
                                                Provider.of<NavigationIndex>(
                                                        context,
                                                        listen: false)
                                                    .changeIndex(context, 1);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                  CustomMethods.width(
                                                      context, 23),
                                                  CustomMethods.width(
                                                      context, 50),
                                                  CustomMethods.width(
                                                      context, 23),
                                                  CustomMethods.width(
                                                      context, 17),
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: ColorsClass.milk,
                                                    width: CustomMethods.width(
                                                        context, 600),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    CustomMethods.width(
                                                        context, 20),
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              CustomMethods
                                                                  .width(
                                                                      context,
                                                                      20)),
                                                      child: CachedNetworkImage(
                                                        imageUrl: provider
                                                                .recomendationsData[
                                                                    provider
                                                                        .index]
                                                                .img ??
                                                            "https://wallpapers.com/images/hd/dark-background-b59iy2towqy5yrgb.jpg",
                                                        fit: BoxFit.fill,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        placeholder:
                                                            (context, url) =>
                                                                Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: ColorsClass
                                                                .milk,
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(
                                                          Icons
                                                              .image_not_supported_outlined,
                                                          color: ColorsClass
                                                              .lightBlue,
                                                          size: CustomMethods
                                                              .width(
                                                                  context, 7),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          CustomMethods.width(
                                                              context, 20),
                                                        ),
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.43),
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.43),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: CustomMethods
                                                              .width(
                                                                  context, 40),
                                                          right: CustomMethods
                                                              .width(
                                                                  context, 31),
                                                        ),
                                                        width: double.infinity,
                                                        height:
                                                            CustomMethods.width(
                                                                context, 8.3),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorsClass
                                                              .dark
                                                              .withOpacity(0.7),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                              CustomMethods
                                                                  .width(
                                                                      context,
                                                                      20),
                                                            ),
                                                            bottomRight:
                                                                Radius.circular(
                                                              CustomMethods
                                                                  .width(
                                                                      context,
                                                                      20),
                                                            ),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                provider
                                                                        .recomendationsData[
                                                                            provider.index]
                                                                        .title ??
                                                                    "...",
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorsClass
                                                                      .milk
                                                                      .withOpacity(
                                                                          0.7),
                                                                  fontFamily:
                                                                      "PatuaOne",
                                                                  fontSize: CustomMethods
                                                                      .width(
                                                                          context,
                                                                          19),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: CustomMethods
                                                                    .width(
                                                                        context,
                                                                        15)),
                                                            Text(
                                                              "⭐ ${provider.recomendationsData[provider.index].score ?? "--"}",
                                                              style: TextStyle(
                                                                color: ColorsClass
                                                                    .milk
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontFamily:
                                                                    "PatuaOne",
                                                                fontSize:
                                                                    CustomMethods
                                                                        .width(
                                                                            context,
                                                                            19),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  provider.increment();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ColorsClass.milk
                                                        .withOpacity(0.8),
                                                  ),
                                                  padding: EdgeInsets.all(
                                                    CustomMethods.width(
                                                        context, 30),
                                                  ),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: ColorsClass.dark,
                                                    size: CustomMethods.width(
                                                        context, 15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: GestureDetector(
                                                onTap: () {
                                                  provider.decrement();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ColorsClass.milk
                                                        .withOpacity(0.8),
                                                  ),
                                                  padding: EdgeInsets.all(
                                                    CustomMethods.width(
                                                        context, 30),
                                                  ),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_back_ios_rounded,
                                                    color: ColorsClass.dark,
                                                    size: CustomMethods.width(
                                                        context, 15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SliverList.list(children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: CustomMethods.width(context, 17)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: CustomMethods.width(context, 57),
                                        height:
                                            CustomMethods.width(context, 15),
                                        decoration: BoxDecoration(
                                            color: ColorsClass.lightBlue,
                                            borderRadius: BorderRadius.circular(
                                                CustomMethods.width(
                                                    context, 15))),
                                      ),
                                      CustomWidgets.width(context, 67),
                                      Text(
                                        "Top Rated",
                                        style: TextStyle(
                                            color: ColorsClass.milk
                                                .withOpacity(0.7),
                                            fontFamily: "PatuaOne",
                                            fontSize: CustomMethods.width(
                                                context, 16)),
                                      ),
                                    ],
                                  ),
                                ),
                                CustomWidgets.height(context, 37),
                                Consumer<TopRated>(
                                  builder: (context, provider, child) =>
                                      SizedBox(
                                    height: CustomMethods.width(context, 1.9),
                                    child: ListView.builder(
                                      itemCount: provider.topRatedAnimes.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () {
                                          // Trigger detailed data retrieval
                                          Provider.of<DetailsData>(context,
                                                  listen: false)
                                              .getDetailedInfo(
                                            provider.topRatedAnimes[index].id!,
                                            context,
                                          );
                                          Provider.of<CharactersProvider>(
                                                  context,
                                                  listen: false)
                                              .getAllCharacters(
                                            provider.topRatedAnimes[index].id!,
                                          );
                                          Provider.of<NavigationIndex>(context,
                                                  listen: false)
                                              .changeIndex(context, 1);
                                        },
                                        child: Container(
                                          margin: index == 0
                                              ? EdgeInsets.only(
                                                  left: CustomMethods.width(
                                                      context, 17),
                                                  right: CustomMethods.width(
                                                      context, 17),
                                                )
                                              : EdgeInsets.only(
                                                  right: CustomMethods.width(
                                                      context, 17),
                                                ),
                                          width:
                                              CustomMethods.width(context, 2.7),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: ColorsClass.milk,
                                              width: CustomMethods.width(
                                                  context, 600),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              CustomMethods.width(context, 20),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: provider
                                                        .topRatedAnimes[index]
                                                        .img ??
                                                    "https://i.pinimg.com/736x/f6/76/83/f67683016eb44f1fa4ef785fa0f71039.jpg",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      CustomMethods.width(
                                                          context, 20),
                                                    ),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: ColorsClass.milk,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                  Icons
                                                      .image_not_supported_outlined,
                                                  color: ColorsClass.lightBlue,
                                                  size: CustomMethods.width(
                                                      context, 7),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    CustomMethods.width(
                                                        context, 20),
                                                  ),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black
                                                          .withOpacity(0.37),
                                                      Colors.black
                                                          .withOpacity(0.37),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                    CustomMethods.width(
                                                        context, 40),
                                                  ),
                                                  alignment: Alignment.center,
                                                  width: double.infinity,
                                                  height: CustomMethods.width(
                                                      context, 10.7),
                                                  decoration: BoxDecoration(
                                                    color: ColorsClass.dark
                                                        .withOpacity(0.83),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(
                                                        CustomMethods.width(
                                                            context, 20),
                                                      ),
                                                      bottomRight:
                                                          Radius.circular(
                                                        CustomMethods.width(
                                                            context, 20),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          provider
                                                                  .topRatedAnimes[
                                                                      index]
                                                                  .title ??
                                                              "...",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: ColorsClass
                                                                .milk
                                                                .withOpacity(
                                                                    0.7),
                                                            fontFamily:
                                                                "PatuaOne",
                                                            fontSize:
                                                                CustomMethods
                                                                    .width(
                                                                        context,
                                                                        31),
                                                          ),
                                                        ),
                                                      ),
                                                      CustomWidgets.width(
                                                          context, 63),
                                                      Text(
                                                        "⭐ ${provider.topRatedAnimes[index].score ?? "--"}",
                                                        style: TextStyle(
                                                          color: ColorsClass
                                                              .milk
                                                              .withOpacity(0.7),
                                                          fontFamily:
                                                              "PatuaOne",
                                                          fontSize:
                                                              CustomMethods
                                                                  .width(
                                                                      context,
                                                                      33),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                CustomWidgets.height(context, 20),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          CustomMethods.width(context, 17)),
                                  child: Text(
                                    "Think you’ve seen it all? Think again. This section features popular animes that are rewriting the rules of the genre.",
                                    style: TextStyle(
                                        color:
                                            ColorsClass.milk.withOpacity(0.7),
                                        fontFamily: "PatuaOne",
                                        fontSize:
                                            CustomMethods.width(context, 25)),
                                  ),
                                ),
                                CustomWidgets.height(context, 40),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: CustomMethods.width(context, 17)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: CustomMethods.width(context, 57),
                                        height:
                                            CustomMethods.width(context, 15),
                                        decoration: BoxDecoration(
                                            color: ColorsClass.lightBlue,
                                            borderRadius: BorderRadius.circular(
                                                CustomMethods.width(
                                                    context, 15))),
                                      ),
                                      CustomWidgets.width(context, 67),
                                      Text(
                                        "Random",
                                        style: TextStyle(
                                            color: ColorsClass.milk
                                                .withOpacity(0.7),
                                            fontFamily: "PatuaOne",
                                            fontSize: CustomMethods.width(
                                                context, 16)),
                                      ),
                                    ],
                                  ),
                                ),
                                CustomWidgets.height(context, 37),
                              ]),
                              Consumer<Popular>(
                                builder: (context, provider, child) =>
                                    SliverPadding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        CustomMethods.width(context, 27),
                                  ),
                                  sliver: SliverGrid(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing:
                                          CustomMethods.width(context, 15),
                                      crossAxisSpacing:
                                          CustomMethods.width(context, 25),
                                      childAspectRatio: 1 / 1.37,
                                    ),
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            // Trigger detailed data retrieval
                                            Provider.of<DetailsData>(context,
                                                    listen: false)
                                                .getDetailedInfo(
                                              provider.popularAnimes[index].id!,
                                              context,
                                            );
                                            Provider.of<CharactersProvider>(
                                                    context,
                                                    listen: false)
                                                .getAllCharacters(
                                              provider.popularAnimes[index].id!,
                                            );
                                            Provider.of<NavigationIndex>(
                                                    context,
                                                    listen: false)
                                                .changeIndex(context, 1);
                                          },
                                          child: Container(
                                            width: CustomMethods.width(
                                                context, 2.7),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: ColorsClass.milk,
                                                width: CustomMethods.width(
                                                    context, 600),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                CustomMethods.width(
                                                    context, 20),
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: provider
                                                          .popularAnimes[index]
                                                          .img ??
                                                      "https://i.pinimg.com/736x/22/80/23/2280238f9ad9f2278c6ac2301a8f20de.jpg",
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        CustomMethods.width(
                                                            context, 20),
                                                      ),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: ColorsClass.milk,
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(
                                                    Icons
                                                        .image_not_supported_outlined,
                                                    color:
                                                        ColorsClass.lightBlue,
                                                    size: CustomMethods.width(
                                                        context, 7),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      CustomMethods.width(
                                                          context, 20),
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black
                                                            .withOpacity(0.37),
                                                        Colors.black
                                                            .withOpacity(0.37),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                      CustomMethods.width(
                                                          context, 40),
                                                    ),
                                                    alignment: Alignment.center,
                                                    width: double.infinity,
                                                    height: CustomMethods.width(
                                                        context, 8.7),
                                                    decoration: BoxDecoration(
                                                      color: ColorsClass.dark
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                          CustomMethods.width(
                                                              context, 20),
                                                        ),
                                                        bottomRight:
                                                            Radius.circular(
                                                          CustomMethods.width(
                                                              context, 20),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            provider
                                                                    .popularAnimes[
                                                                        index]
                                                                    .title ??
                                                                "...",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              color: ColorsClass
                                                                  .milk
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontFamily:
                                                                  "PatuaOne",
                                                              fontSize:
                                                                  CustomMethods
                                                                      .width(
                                                                          context,
                                                                          27),
                                                            ),
                                                          ),
                                                        ),
                                                        CustomWidgets.width(
                                                            context, 51),
                                                        Text(
                                                          "⭐ ${provider.popularAnimes[index].score ?? "--"}",
                                                          style: TextStyle(
                                                            color: ColorsClass
                                                                .milk
                                                                .withOpacity(
                                                                    0.7),
                                                            fontFamily:
                                                                "PatuaOne",
                                                            fontSize:
                                                                CustomMethods
                                                                    .width(
                                                                        context,
                                                                        27),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      childCount: provider.popularAnimes.length,
                                    ),
                                  ),
                                ),
                              ),
                              SliverList.list(children: [
                                CustomWidgets.height(context, 17),
                              ])
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
    );
  }
}

// Scroll Sqweezing Effect Remover
class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
