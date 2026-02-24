import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ParoApp());
}

class ParoApp extends StatefulWidget {
  const ParoApp({super.key});

  @override
  State<ParoApp> createState() => _ParoAppState();

  static _ParoAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_ParoAppState>();
  }
}

class _ParoAppState extends State<ParoApp> {
  Locale _locale = const Locale('ar');
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showSplash = false;
        });
      }
    });
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString('language') ?? 'ar';
    setState(() {
      _locale = Locale(savedLang);
    });
  }

  void setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paro',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
        Locale('ku'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return const Locale('ar');
      },
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: const Color(0xFFFDF8F2),
        primarySwatch: Colors.brown,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown,
          backgroundColor: const Color(0xFFFDF8F2),
        ),
      ),
      home: _showSplash ? const SplashScreen() : const MainScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF9C7C5D).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Par',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9C7C5D),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.sports_soccer,
                      size: 50,
                      color: Color(0xFF9C7C5D),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Paro',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppTranslations {
  static Map<String, Map<String, String>> _translations = {
    'ar': {
      'home': 'الرئيسية',
      'chat': 'درشة',
      'analytics': 'تحليلات',
      'camps': 'مخيمات',
      'live_matches': 'المباريات الحية',
      'upcoming_matches': 'المباريات القادمة',
      'favorite_matches': 'الفرق والمباريات الخاصة بي',
      'popular_leagues': 'البطولات الشائعة',
      'today': 'اليوم',
      'tomorrow': 'غدًا',
      'match_details': 'تفاصيل المباراة',
      'stats': 'إحصائيات',
      'lineups': 'التشكيلات',
      'analysis': 'تحليل',
      'substitutes': 'مقاعد البدلاء',
      'absent_players': 'اللاعبون الغائبون',
      'possession': 'الاستحواذ',
      'shots': 'تسديدات',
      'shots_on_target': 'على المرمى',
      'expected_goals': 'الأهداف المتوقعة (xG)',
      'corners': 'الركنيات',
      'yellow_cards': 'بطاقات صفراء',
      'red_cards': 'بطاقات حمراء',
      'fouls': 'أخطاء',
      'passes': 'تمريرات',
      'key_players': 'أهم اللاعبين',
      'rating': 'تقييم',
      'type_message': 'أكتب رسالتك ... (الإيموجي ممنوع)',
      'send': 'إرسال',
      'arabic': 'العربية',
      'english': 'الإنجليزية',
      'kurdish': 'الكردية',
      'away_team': 'الفريق الضيف',
      'minute': 'الدقيقة',
      'status': 'الحالة',
      'blocked_word': '🚫 هذه الكلمة ممنوعة!',
      'emoji_blocked': '⛔ الإيموجي ممنوع',
    },
    'en': {
      'home': 'Home',
      'chat': 'Chat',
      'analytics': 'Analytics',
      'camps': 'Camps',
      'live_matches': 'Live Matches',
      'upcoming_matches': 'Upcoming Matches',
      'favorite_matches': 'My Teams & Matches',
      'popular_leagues': 'Popular Leagues',
      'today': 'Today',
      'tomorrow': 'Tomorrow',
      'match_details': 'Match Details',
      'stats': 'Stats',
      'lineups': 'Lineups',
      'analysis': 'Analysis',
      'substitutes': 'Substitutes',
      'absent_players': 'Absent Players',
      'possession': 'Possession',
      'shots': 'Shots',
      'shots_on_target': 'On Target',
      'expected_goals': 'Expected Goals (xG)',
      'corners': 'Corners',
      'yellow_cards': 'Yellow Cards',
      'red_cards': 'Red Cards',
      'fouls': 'Fouls',
      'passes': 'Passes',
      'key_players': 'Key Players',
      'rating': 'Rating',
      'type_message': 'Type your message... (No emoji)',
      'send': 'Send',
      'arabic': 'Arabic',
      'english': 'English',
      'kurdish': 'Kurdish',
      'away_team': 'Away Team',
      'minute': 'Minute',
      'status': 'Status',
      'blocked_word': '🚫 This word is forbidden!',
      'emoji_blocked': '⛔ Emoji not allowed',
    },
    'ku': {
      'home': 'سەرەکی',
      'chat': 'درشة',
      'analytics': 'شیکردنەوە',
      'camps': 'کەمپەکان',
      'live_matches': 'یارییە ڕاستەوخۆکان',
      'upcoming_matches': 'یارییە داهاتووەکان',
      'favorite_matches': 'تیمەکان و یارییەکانم',
      'popular_leagues': 'خولە بەناوبانگەکان',
      'today': 'ئەمڕۆ',
      'tomorrow': 'بەیانی',
      'match_details': 'ووردەکاری یاری',
      'stats': 'ئامارەکان',
      'lineups': 'پێکهاتەکان',
      'analysis': 'شیکردنەوە',
      'substitutes': 'یەدەگ',
      'absent_players': 'یاریزانە دیارنەکەوتووەکان',
      'possession': 'خاوەندارێتی',
      'shots': 'تەقەکردن',
      'shots_on_target': 'بەرەو ئامانج',
      'expected_goals': 'ئامانجی چاوەڕوانکراو (xG)',
      'corners': 'گۆشە',
      'yellow_cards': 'کارتی زەرد',
      'red_cards': 'کارتی سوور',
      'fouls': 'هەڵە',
      'passes': 'پاس',
      'key_players': 'یاریزانە دیارەکان',
      'rating': 'هەڵسەنگاندن',
      'type_message': 'پەیامەکەت بنووسە ... (ئیمۆجی قەدەغەیە)',
      'send': 'ناردن',
      'arabic': 'عەرەبی',
      'english': 'ئینگلیزی',
      'kurdish': 'کوردی',
      'away_team': 'تیمە میوان',
      'minute': 'خولەک',
      'status': 'بارودۆخ',
      'blocked_word': '🚫 ئەم وشەیە قەدەغەیە!',
      'emoji_blocked': '⛔ ئیمۆجی قەدەغەیە',
    },
  };

  static String translate(String key, String languageCode) {
    if (_translations.containsKey(languageCode) &&
        _translations[languageCode]!.containsKey(key)) {
      return _translations[languageCode]![key]!;
    }
    return _translations['ar']![key]!;
  }
}

class Team {
  final String name;
  final String logo;
  final String? country;
  Team(this.name, [this.logo = '', this.country]);
}

class League {
  final String name;
  final String country;
  final String? logo;
  League(this.name, this.country, [this.logo]);
}

class MatchModel {
  final String id;
  final String league;
  final String homeTeam;
  final String awayTeam;
  final String? homeTeamLogoUrl;
  final String? awayTeamLogoUrl;
  final int homeScore;
  final int awayScore;
  final int minute;
  final String status;
  final String time;
  final String date;

  MatchModel({
    required this.id,
    required this.league,
    required this.homeTeam,
    required this.awayTeam,
    this.homeTeamLogoUrl,
    this.awayTeamLogoUrl,
    required this.homeScore,
    required this.awayScore,
    required this.minute,
    required this.status,
    this.time = '',
    required this.date,
  });
}

class Player {
  final String name;
  final String position;
  final int? shirtNumber;
  final double? rating;
  final String? photo;
  Player(this.name, this.position, {this.shirtNumber, this.rating, this.photo});
}

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final String language;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.language,
    required this.timestamp,
  });
}

class ChatRoom {
  String id;
  String name;
  String languageCode;
  Color color;
  String welcomeMessage;
  bool isActive;
  int order;

  ChatRoom({
    required this.id,
    required this.name,
    required this.languageCode,
    required this.color,
    required this.welcomeMessage,
    this.isActive = true,
    this.order = 0,
  });
}

class DraggableItem {
  String id;
  String title;
  String type;
  bool visible;
  int order;

  DraggableItem({
    required this.id,
    required this.title,
    required this.type,
    this.visible = true,
    this.order = 0,
  });
}

class TeamColors {
  static Map<String, Map<String, Color>> teamColorMap = {
    'ريال مدريد': {
      'primary': Colors.white,
      'secondary': Colors.amber.shade700,
    },
    'برشلونة': {
      'primary': Colors.blue.shade700,
      'secondary': Colors.red.shade600,
    },
    'أتلتيكو مدريد': {
      'primary': Colors.red.shade800,
      'secondary': Colors.blue.shade900,
    },
    'ريال سوسيداد': {
      'primary': Colors.blue.shade500,
      'secondary': Colors.white,
    },
    'مانشستر سيتي': {
      'primary': Colors.blue.shade400,
      'secondary': Colors.cyan.shade800,
    },
    'ليفربول': {
      'primary': Colors.red.shade600,
      'secondary': Colors.green.shade900,
    },
    'تشيلسي': {
      'primary': Colors.blue.shade800,
      'secondary': Colors.yellow.shade700,
    },
    'أرسنال': {
      'primary': Colors.red.shade700,
      'secondary': Colors.white,
    },
    'يوفنتوس': {
      'primary': Colors.black,
      'secondary': Colors.white,
    },
    'إنتر ميلان': {
      'primary': Colors.blue.shade900,
      'secondary': Colors.black,
    },
    'ميلان': {
      'primary': Colors.red.shade800,
      'secondary': Colors.black,
    },
    'الأهلي': {
      'primary': Colors.green.shade800,
      'secondary': Colors.white,
    },
    'النصر': {
      'primary': Colors.yellow.shade700,
      'secondary': Colors.blue.shade900,
    },
    'الهلال': {
      'primary': Colors.blue.shade500,
      'secondary': Colors.white,
    },
    'العراق': {
      'primary': Colors.green.shade800,
      'secondary': Colors.red.shade700,
    },
  };

  static Color getPrimaryColor(String teamName) {
    return teamColorMap[teamName]?['primary'] ?? Colors.grey.shade400;
  }

  static Color getSecondaryColor(String teamName) {
    return teamColorMap[teamName]?['secondary'] ?? Colors.grey.shade600;
  }

  static bool areColorsDifferent(Color c1, Color c2) {
    double diff = (c1.red - c2.red).abs() +
                  (c1.green - c2.green).abs() +
                  (c1.blue - c2.blue).abs();
    return diff > 100;
  }
}

class CrowdSystem {
  static List<Map<String, dynamic>> generateCrowd(int count) {
    List<Map<String, dynamic>> crowd = [];
    final rand = Random();
    
    for (int i = 0; i < count; i++) {
      crowd.add({
        'x': rand.nextDouble(),
        'y': rand.nextDouble(),
        'team': rand.nextInt(2),
        'hasBanner': rand.nextDouble() > 0.7,
        'bannerText': _getRandomBanner(rand.nextInt(2)),
        'isJumping': false,
        'isCheering': false,
      });
    }
    return crowd;
  }

  static String _getRandomBanner(int team) {
    List<String> bannersTeam1 = [
      'نحن الأبطال!',
      '💪 فريقي',
      '⚽ الفوز لنا',
      '🔥 نشعل المدرجات',
      '🇸🇦',
    ];
    
    List<String> bannersTeam2 = [
      'هيا بنا!',
      '🌟 الأفضل',
      '🏆 الكأس لنا',
      '💙💙',
      '🇪🇸',
    ];
    
    return team == 0 
        ? bannersTeam1[Random().nextInt(bannersTeam1.length)]
        : bannersTeam2[Random().nextInt(bannersTeam2.length)];
  }
}

class SeatedCrowdPainter extends CustomPainter {
  final List<Map<String, dynamic>> crowd;
  final double crowdShakeX;
  final double crowdShakeY;
  final bool isCheering;
  
  SeatedCrowdPainter({
    required this.crowd,
    this.crowdShakeX = 0.0,
    this.crowdShakeY = 0.0,
    this.isCheering = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintSeat = Paint()..color = Colors.grey.shade800;
    final paintTeam1 = Paint()..color = Colors.red.shade600;
    final paintTeam2 = Paint()..color = Colors.blue.shade600;
    final textPainter = TextPainter(textDirection: TextDirection.rtl);

    for (var person in crowd) {
      double x, y;
      int section = (person['y'] * 4).floor();
      
      if (section == 0) {
        x = person['x'] * size.width + crowdShakeX;
        y = person['y'] * 80 + crowdShakeY;
      } else if (section == 1) {
        x = person['x'] * size.width + crowdShakeX;
        y = size.height - 80 + person['y'] * 80 + crowdShakeY;
      } else if (section == 2) {
        x = size.width - 60 + person['x'] * 60 + crowdShakeX;
        y = person['y'] * size.height + crowdShakeY;
      } else {
        x = person['x'] * 60 + crowdShakeX;
        y = person['y'] * size.height + crowdShakeY;
      }

      canvas.drawRect(Rect.fromLTWH(x - 8, y - 10, 16, 20), paintSeat);

      if (person['team'] == 0) {
        canvas.drawCircle(Offset(x, y - 5), 6, paintTeam1);
      } else {
        canvas.drawCircle(Offset(x, y - 5), 6, paintTeam2);
      }

      if (person['hasBanner'] && person['bannerText'] != null) {
        textPainter.text = TextSpan(
          text: person['bannerText'],
          style: const TextStyle(color: Colors.white, fontSize: 8),
        );
        textPainter.layout();
        canvas.drawRect(Rect.fromLTWH(x - 15, y - 25, 30, 15), Paint()..color = Colors.black.withOpacity(0.7));
        textPainter.paint(canvas, Offset(x - 12, y - 23));
      }

      if (person['isJumping'] || isCheering) {
        canvas.drawCircle(Offset(x, y - 15), 4, Paint()..color = Colors.white);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PlayerImageService {
  static const String apiKey = '1';
  static Map<String, String> _imageCache = {};
  
  static Future<String?> fetchPlayerImage(String playerName) async {
    if (_imageCache.containsKey(playerName)) return _imageCache[playerName];
    
    try {
      final response = await http.get(
        Uri.parse('https://www.thesportsdb.com/api/v1/json/$apiKey/searchplayers.php?p=$playerName'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['player'] != null && data['player'].isNotEmpty) {
          final imageUrl = data['player'][0]['strThumb'] ?? 
                          data['player'][0]['strCutout'] ?? 
                          data['player'][0]['strRender'];
          if (imageUrl != null) {
            _imageCache[playerName] = imageUrl;
            return imageUrl;
          }
        }
      }
    } catch (e) {
      print('خطأ في جلب صورة اللاعب $playerName: $e');
    }
    return null;
  }
}

class FootballApiService {
  static const String baseUrl = 'https://v3.football.api-sports.io';
  static const String apiKey = '82c4530ecf902cf785959baf1ef650fc';
  
  static Map<String, dynamic> _cache = {};
  static DateTime _lastFetch = DateTime.now().subtract(const Duration(hours: 1));
  
  static Future<List<MatchModel>> fetchMatchesByDate(DateTime date) async {
    final cacheKey = 'matches_${date.year}_${date.month}_${date.day}';
    
    if (_cache.containsKey(cacheKey) && DateTime.now().difference(_lastFetch).inHours < 1) {
      return _cache[cacheKey];
    }
    
    final formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/fixtures?date=$formattedDate'),
        headers: {'x-apisports-key': apiKey, 'x-rapidapi-host': 'v3.football.api-sports.io'},
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final matches = _parseMatches(data);
        _cache[cacheKey] = matches;
        _lastFetch = DateTime.now();
        return matches;
      } else {
        throw Exception('فشل تحميل المباريات: ${response.statusCode}');
      }
    } catch (e) {
      print('خطأ في جلب المباريات: $e');
      return [];
    }
  }
  
  static List<MatchModel> _parseMatches(Map<String, dynamic> data) {
    List<MatchModel> matches = [];
    
    if (data['response'] != null) {
      for (var item in data['response']) {
        try {
          final fixture = item['fixture'];
          final league = item['league'];
          final teams = item['teams'];
          final goals = item['goals'];
          final status = item['fixture']['status'];
          
          String matchStatus = 'scheduled';
          int minute = 0;
          
          if (status['short'] == 'LIVE' || status['short'] == '1H' || 
              status['short'] == '2H' || status['short'] == 'HT') {
            matchStatus = 'live';
            minute = status['elapsed'] ?? 0;
          } else if (status['short'] == 'FT' || status['short'] == 'AET' || 
                    status['short'] == 'PEN') {
            matchStatus = 'finished';
            minute = 90;
          }
          
          matches.add(MatchModel(
            id: fixture['id'].toString(),
            league: league['name'],
            homeTeam: teams['home']['name'],
            awayTeam: teams['away']['name'],
            homeTeamLogoUrl: teams['home']['logo'],
            awayTeamLogoUrl: teams['away']['logo'],
            homeScore: goals['home'] ?? 0,
            awayScore: goals['away'] ?? 0,
            minute: minute,
            status: matchStatus,
            time: fixture['date'],
            date: fixture['date'].split('T')[0],
          ));
        } catch (e) {
          print('خطأ في تحليل مباراة: $e');
        }
      }
    }
    
    return matches;
  }

  static Future<Map<String, dynamic>> fetchMatchEvents(String fixtureId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/fixtures/events?fixture=$fixtureId'),
        headers: {'x-apisports-key': apiKey, 'x-rapidapi-host': 'v3.football.api-sports.io'},
      );
      if (response.statusCode == 200) return json.decode(response.body);
      return {};
    } catch (e) {
      print('خطأ في جلب الأحداث: $e');
      return {};
    }
  }
}
