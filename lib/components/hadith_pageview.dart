import 'package:flutter/material.dart';
import 'package:sitatu_jawahir/constants/colors.dart' as colors;

import '../models/hadith.dart';

class HadithPageview extends StatelessWidget {
  final List<dynamic> hadithContent;

  const HadithPageview({Key? key, required this.hadithContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: hadithContent.length,
      itemBuilder: (context, index) {
        var hadiths = hadithContent[index];
        var english = hadiths['english']['text'];
        var narrator = hadiths['english']['narrator'];
        var hadith = Hadith(
          arabic: hadiths['arabic'],
          english: english,
          id: hadiths['idInBook'],
          narrator: narrator,
        );
        return Scaffold(
          backgroundColor: colors.primaryColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: const Offset(0, 10),
                        color: Colors.black.withOpacity(.5),
                      ),
                    ],
                    color: colors.tileColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          '${hadith.id}',
                          style: TextStyle(
                            color: colors.fontColorLight,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Text(
                        hadith.arabic,
                        style: TextStyle(
                          fontSize: 20,
                          color: colors.fontColorLight,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        hadith.narrator,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: colors.fontColorLight,
                        ),
                      ),
                      Text(
                        hadith.english,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: colors.fontColorLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
