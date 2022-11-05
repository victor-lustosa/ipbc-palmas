import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipbc_palmas/app/shared/components/top-bar/top_bar_widget.dart';

import '../infra/repositories/lyric_repository.dart';
import '../../shared/configs/app_fonts.dart';
import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_icons.dart';
import '../../shared/configs/app_routes.dart';
import '../blocs/lyric_bloc.dart';
import '../domain/use-cases/lyrics_use_cases.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LyricsListView extends StatefulWidget {
  const LyricsListView({super.key});

  @override
  State<LyricsListView> createState() => _LyricsListViewState();
}

class _LyricsListViewState extends State<LyricsListView> {
  late List lyrics;
  late List<String> lettersCarousel;
  late LyricBloc bloc;
  String selectedValue = 'A';
  fillLettersCarousel() {
    var aCode = 'A'.codeUnitAt(0);
    var zCode = 'Z'.codeUnitAt(0);
    lettersCarousel = List<String>.generate(
      zCode - aCode + 1,
      (index) => String.fromCharCode(aCode + index),
    );
  }

  changeColors(element) {
    selectedValue = element;
  }

  @override
  void initState() {
    lyrics = [];
    lettersCarousel = [];
    fillLettersCarousel();
    bloc = LyricBloc(
        lyricsUseCase:
            LyricsUseCases(repository: context.read<LyricRepository>()));
    bloc.add(GetLyricsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<LyricBloc, LyricState>(
              bloc: bloc,
              buildWhen: (context, current) =>
                  context.runtimeType != current.runtimeType &&
                  (current is SuccessfullyFetchedLyricsState),
              builder: (context, state) {
                if (state is InitialState) {
                  return const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.darkGreen)));
                } else if (state is SuccessfullyFetchedLyricsState) {
                  lyrics = state.entities;
                  return RefreshIndicator(
                    color: AppColors.darkGreen,
                    onRefresh: () async {
                      bloc.add(GetLyricsEvent());
                    },
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: TopBarWidget()),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Row(
                            children: [
                              /*Column(
                                children: const [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        size: 40,
                                        Icons.navigate_before_rounded,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),*/
                              Padding(
                                padding: const EdgeInsets.only(bottom: 33.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 28.0),
                                      child: SvgPicture.asset(
                                        AppIcons.lyricsIconName,
                                        color: AppColors.black,
                                        matchTextDirection: true,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text("Músicas/Letras",
                                            style: AppFonts.h2)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 26.0),
                          child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: lettersCarousel.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: lettersCarousel[index] == selectedValue
                                          ? 50
                                          : 40,
                                      child: ElevatedButton(
                                          onPressed: () => {
                                                setState(() {
                                                  changeColors(lettersCarousel[index]);
                                                })
                                              },
                                          style: ButtonStyle(
                                            overlayColor: MaterialStateProperty.all(AppColors.darkGreen),
                                            elevation: const MaterialStatePropertyAll(0),
                                            shape: MaterialStateProperty.all(const CircleBorder()),
                                            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                                            backgroundColor: MaterialStateProperty
                                                .all(lettersCarousel[index] ==
                                                        selectedValue
                                                    ? AppColors.darkGreen
                                                    : AppColors
                                                        .white), // <-- Button color
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: Text(lettersCarousel[index],
                                                      style: lettersCarousel[index] == selectedValue ?
                                                      AppFonts.carouselGreen :
                                                      AppFonts.carouselWhite)),
                                            ],
                                          )),
                                    );
                                  })),
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: lyrics.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 3),
                                  title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                                '${lyrics[index].title} - ${lyrics[index].group}',
                                                style: AppFonts.body),
                                          ],
                                        ),
                                        Column(children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, AppRoutes.lyricRoute,
                                                  arguments: lyrics[index]);
                                            },
                                            icon: const Icon(
                                              size: 33,
                                              Icons.navigate_next_outlined,
                                              color: AppColors.darkGreen,
                                            ),
                                          )
                                        ])
                                      ]),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.lyricRoute,
                                        arguments: lyrics[index]);
                                  });
                            }),
                      ],
                    ),
                  );
                } else {
                  return Text('aconteceu um erro [Establishment_page_one]');
                }
              }),
        ),
      ),
    );
  }
}
