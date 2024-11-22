import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sitatu_jawahir/constants/colors.dart' as colors;

import '../models/hadith_books.dart';
import 'chapters_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<List<dynamic>> chapterData = [];
  final List<List<dynamic>> hadithData = [];
  final List<String> jsonPaths = [
    'assets/data/muslim.json',
    'assets/data/malik.json',
    'assets/data/ahmed.json',
    'assets/data/bukhari.json',
    'assets/data/ibnmajah.json',
    'assets/data/tirmidhi.json',
  ];

  final List<HadithBooks> hadithBooks = [
    HadithBooks(
      authorArabic: 'الإمام مسلم بن الحجاي',
      authorEnglish: 'Imam Muslim ibn al-Hajjaj al-Naysaburi',
      length: '74596',
      titleArabic: "صحيح مسلم",
      titleEnglish: "Sahih Muslim",
    ),
    HadithBooks(
      authorArabic: "الإمام مالك بن أنس",
      authorEnglish: "Imam Malik ibn Anas",
      length: '1985',
      titleArabic: "موطأ مالك",
      titleEnglish: "Muwatta Malik",
    ),
    HadithBooks(
      authorArabic: "الإمام أحمد بن حنبل",
      titleArabic: "مسند الإمام أحمد بن حنبل",
      authorEnglish: "Imam Ahmad ibn Hanbal",
      length: '1374',
      titleEnglish: "Musnad Ahmad ibn Hanbal",
    ),
    HadithBooks(
      titleArabic: "حيح البخاري",
      authorArabic: "الإمام محمد بن إسماعيل البخاري",
      authorEnglish: "Imam Muhammad ibn Ismail al-Bukhari",
      length: '7277',
      titleEnglish: "Sahih al-Bukhari",
    ),
    HadithBooks(
      titleArabic: "سنن ابن ماجه",
      authorArabic: "الإمام محمد بن يزيد بن ماجه القزويني",
      authorEnglish: "Imam Muhammad ibn Yazid Ibn Majah al-Qazwini",
      length: '4345',
      titleEnglish: "Sunan ibn Majah",
    ),
    HadithBooks(
      authorArabic: "الإمام أبو عيسى محمد بن عيسى الترمذي",
      authorEnglish: "Imam Abu Isa Muhammad ibn Isa al-Tirmidhi",
      length: '679',
      titleArabic: "جامع الترمذي",
      titleEnglish: "Jami' al-Tirmidhi",
    )
  ];

  Future<void> _loadJsonData() async {
    for (final path in jsonPaths) {
      final String response = await rootBundle.loadString(path);
      final data = json.decode(response);
      chapterData.add(data['chapters']);
      hadithData.add(data['hadiths']);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryColor,
      appBar: AppBar(
        backgroundColor: colors.primaryColor,
        centerTitle: true,
        title: const Text(
          'Sitatu Jawahir',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: chapterData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: hadithBooks.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final hadithBook = hadithBooks[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChapterScreen(
                            chapters: chapterData[index],
                            hadiths: hadithData[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: colors.tileColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            color: Colors.black.withOpacity(.2),
                            offset: const Offset(1, 3),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 30),
                          child: Column(
                            children: [
                              Text(
                                hadithBook.titleEnglish,
                                style: TextStyle(
                                  color: colors.fontColorLight,
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                hadithBook.titleArabic,
                                style: TextStyle(
                                  color: colors.fontColorLight,
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.my_library_books_rounded,
                                    color: colors.fontColorLight,
                                    size: 17,
                                  ),
                                  Text(
                                    '${hadithBook.length} hadiths',
                                    style: TextStyle(
                                      color: colors.fontColorLight,
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
