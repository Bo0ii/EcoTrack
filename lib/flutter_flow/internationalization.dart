import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es', 'de', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
    String? deText = '',
    String? arText = '',
  }) =>
      [enText, esText, deText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // SignUp
  {
    'dkhje2l8': {
      'en': 'Get Started',
      'ar': 'البدء',
      'de': 'Loslegen',
      'es': 'Empezar',
    },
    '4csg2iu0': {
      'en': 'Create your admin account below.',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'de': 'Erstellen Sie unten Ihr Konto.',
      'es': 'Crea tu cuenta a continuación.',
    },
    'l81negs7': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'coon3al0': {
      'en': 'Enter your email...',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'ouv48osh': {
      'en': 'Household ID',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    '4g3ga8aa': {
      'en': 'Create your Household ID',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'vlx6vp10': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    'fkxrymcx': {
      'en': 'Enter your password...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    'y0z1ljkc': {
      'en': 'Confirm Password',
      'ar': 'تأكيد كلمة المرور',
      'de': 'Kennwort bestätigen',
      'es': 'Confirmar contraseña',
    },
    'ocps2kgq': {
      'en': 'Enter your password...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    'mx8hvqr7': {
      'en': 'Create Account',
      'ar': 'إنشاء حساب',
      'de': 'Benutzerkonto erstellen',
      'es': 'Crear una cuenta',
    },
    'n3b2xi6h': {
      'en': 'Already have an account?',
      'ar': 'هل لديك حساب؟',
      'de': 'Sie haben bereits ein Konto?',
      'es': '¿Ya tienes una cuenta?',
    },
    'tdpcb8xc': {
      'en': 'Login',
      'ar': 'هل لديك حساب؟',
      'de': 'Sie haben bereits ein Konto?',
      'es': '¿Ya tienes una cuenta?',
    },
    'momge5oj': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // SignUpUser
  {
    'ty9bx73l': {
      'en': 'Get Started',
      'ar': 'البدء',
      'de': 'Loslegen',
      'es': 'Empezar',
    },
    '13n4kxb9': {
      'en': 'Create your user account below.',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'de': 'Erstellen Sie unten Ihr Konto.',
      'es': 'Crea tu cuenta a continuación.',
    },
  },
  'f6z06k4w': {
    'en': 'Email Address',
    'ar': 'عنوان البريد الالكترونى',
    'de': 'E-Mail-Addresse',
    'es': 'Dirección de correo electrónico',
  },
  'rp8d9lu6': {
    'en': 'Enter your email...',
    'ar': 'أدخل بريدك الإلكتروني ...',
    'de': 'Geben sie ihre E-Mail Adresse ein...',
    'es': 'Introduce tu correo electrónico...',
  },
  '3cnutfhh': {
    'en': 'Household ID',
    'ar': 'عنوان البريد الالكترونى',
    'de': 'E-Mail-Addresse',
    'es': 'Dirección de correo electrónico',
  },
  'o3vi3tty': {
    'en': 'Enter your Admin\'s Household ID',
    'ar': 'أدخل بريدك الإلكتروني ...',
    'de': 'Geben sie ihre E-Mail Adresse ein...',
    'es': 'Introduce tu correo electrónico...',
  },
  'qjovmml5': {
    'en': 'Password',
    'ar': 'كلمة المرور',
    'de': 'Passwort',
    'es': 'Contraseña',
  },
  'pvzavgvg': {
    'en': 'Enter your password...',
    'ar': 'ادخل رقمك السري...',
    'de': 'Geben Sie Ihr Passwort ein...',
    'es': 'Ingresa tu contraseña...',
  },
  'ulf3epcn': {
    'en': 'Confirm Password',
    'ar': 'تأكيد كلمة المرور',
    'de': 'Kennwort bestätigen',
    'es': 'Confirmar contraseña',
  },
  'y8dbvi7a': {
    'en': 'Enter your password...',
    'ar': 'ادخل رقمك السري...',
    'de': 'Geben Sie Ihr Passwort ein...',
    'es': 'Ingresa tu contraseña...',
  },
  '9656lzeb': {
    'en': 'Create Account',
    'ar': 'إنشاء حساب',
    'de': 'Benutzerkonto erstellen',
    'es': 'Crear una cuenta',
  },
  '1iuuh0qt': {
    'en': 'Already have an account?',
    'ar': 'هل لديك حساب؟',
    'de': 'Sie haben bereits ein Konto?',
    'es': '¿Ya tienes una cuenta?',
  },
  'ban9mmyi': {
    'en': 'Login',
    'ar': 'هل لديك حساب؟',
    'de': 'Sie haben bereits ein Konto?',
    'es': '¿Ya tienes una cuenta?',
  },
  '336l7s2c': {
    'en': 'Home',
    'ar': 'مسكن',
    'de': 'Heim',
    'es': 'Casa',
  },
  // Profile
  {
    'zs80efpx': {
      'en': 'Family',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1a3ym4zm': {
      'en': 'Help Center',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vdi1d9pt': {
      'en': 'Settings',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bohl61wf': {
      'en': 'Notification Settings',
      'ar': '',
      'de': '',
      'es': '',
    },
    'iv28e0rj': {
      'en': 'Language',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4m4s8u8w': {
      'en': 'English (eng)',
      'ar': '',
      'de': '',
      'es': '',
    },
    'e5fg9tjx': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jcfog6xl': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // Miscellaneous
  {
    'lzyb73wy': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kx9cdks4': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gxxjrygc': {
      'en':
          'In order to connect to new devices and plugs, this app requires permission to access the bluetooth',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1kpwgsy1': {
      'en':
          'In order to send alerts and power anomalies, this app requires permission to access the Notification',
      'ar': '',
      'de': '',
      'es': '',
    },
    'efvtwj7k': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ec5hfa1e': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q5ljwvfo': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'j4rmwb3h': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6ah1b18f': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2kos1hen': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '80xmlsor': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bdpn4cqa': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7hafdwsg': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'b6744836': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hnjt9kdz': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'aox3s4fb': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l8hv5a7z': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4pjwb70a': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0xlokf4y': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8twlwiwt': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q6cpk963': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7pbx3r45': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ofd56nis': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    's73lmp4e': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ibj095pc': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '10ell21v': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    't4xzlq9q': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '513nj4m0': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'a1jxfgju': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wifi_provisioning': {
      'en': 'WiFi Provisioning',
      'ar': 'إعداد شبكة WiFi',
      'de': 'WLAN-Bereitstellung',
      'es': 'Aprovisionamiento WiFi',
    },
  },
].reduce((a, b) => a..addAll(b)); 