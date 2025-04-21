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
  },
  // Profile
  {
    'zs80efpx': {
      'en': 'Family',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8hi5yk52': {
      'en': 'Notifications',
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
    '6doeb31k': {
      'en': 'Search...',
      'ar': '',
      'de': '',
      'es': '',
    },
    'd1gb7mrh': {
      'en': 'English',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hlf0tlus': {
      'en': 'Arabic',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8az2ewtm': {
      'en': 'Currency',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2ps6j9io': {
      'en': 'AED',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5uw1dl76': {
      'en': 'Profile Settings',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fysiy3go': {
      'en': 'Edit Profile',
      'ar': '',
      'de': '',
      'es': '',
    },
    'myonm7ju': {
      'en': 'Log out of account',
      'ar': '',
      'de': '',
      'es': '',
    },
    'oqxzcghm': {
      'en': 'Log Out?',
      'ar': '',
      'de': '',
      'es': '',
    },
    '73o88tsa': {
      'en': 'Profile',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // secondpage
  {
    '8uobly0a': {
      'en': 'Are you an Admin ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fktbdluu': {
      'en':
          'If you are a the parent of the hosuehold choose admin to control your household!',
      'ar': '',
      'de': '',
      'es': '',
    },
    'sf2n1b0k': {
      'en': 'Are you a User',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bjxuhrjn': {
      'en': 'Select user to connect wit the house hould and be a big family !',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dgm2nw35': {
      'en': 'User',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7s3bx8or': {
      'en': 'Admin',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hiqj19lj': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // connect
  {
    't1i1qr8i': {
      'en': 'Connect your device',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n1ptc1l3': {
      'en': 'Click on the detectable devices',
      'ar': '',
      'de': '',
      'es': '',
    },
    'sqodoskq': {
      'en': 'Cant find your Device?',
      'ar': 'ليس لديك حساب؟',
      'de': 'Sie haben kein Konto?',
      'es': '¿No tienes una cuenta?',
    },
    'nxo3vtwz': {
      'en': 'Press here',
      'ar': 'ليس لديك حساب؟',
      'de': 'Sie haben kein Konto?',
      'es': '¿No tienes una cuenta?',
    },
    'o0tevk9p': {
      'en': 'ecot2',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l33uw80m': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // ForgetPassword
  {
    'dsp80sg7': {
      'en': 'Forgot Password?',
      'ar': '',
      'de': '',
      'es': '',
    },
    'm5ozu23z': {
      'en': 'Enter your email to receive a password reset link.',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4ejcyajj': {
      'en': 'Email',
      'ar': '',
      'de': '',
      'es': '',
    },
    'haq24o97': {
      'en': 'Existing Email',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'jizhs3w3': {
      'en': '   Invalid email',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rajsvet1': {
      'en': 'Send Confirmation',
      'ar': 'إنشاء حساب',
      'de': 'Benutzerkonto erstellen',
      'es': 'Crear una cuenta',
    },
    '96hl49ab': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // CheckEmail
  {
    '7xhtonw5': {
      'en': 'Check Your Email',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kk32ee64': {
      'en':
          'We’ve sent a password reset link to your email. Follow the instructions to set a new password.',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8j0qqe9q': {
      'en': 'Back to Sign in',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xs85yvjb': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // GradiantContaner
  {
    'q04mxmgm': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // PinCodeNotDone
  {
    '0fdjls8g': {
      'en': 'Verify your email',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6r3yz9ih': {
      'en':
          'Enter the verification code sent to your email to confirm your account.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'k10x2g1m': {
      'en': 'Enter Code',
      'ar': '',
      'de': '',
      'es': '',
    },
    'd3ymp0ip': {
      'en': 'RESEND CODE',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gcepl7kl': {
      'en': 'Code resent to your email',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kdqznhlz': {
      'en': 'Continue',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5agrl8sa': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // S1
  {
    '4809zrnp': {
      'en': '1/3',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zf2b07lf': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ip11v6ea': {
      'en': 'Add a New ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'r7r9tghv': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2b140zbj': {
      'en': 'To manage your home, you need to create a new home',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0aoklso2': {
      'en': 'HouseHold Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    'h5wkjhfj': {
      'en': 'My Home',
      'ar': '',
      'de': '',
      'es': '',
    },
    't8vv2ish': {
      'en': 'Continue',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // s6
  {
    '93nnyk5b': {
      'en': '3/3',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ykmf4r82': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gm0rr9u9': {
      'en': 'Set Up Your ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vznnuz6h': {
      'en': 'Profile',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hht1dqe7': {
      'en': 'Your Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6xvejv0k': {
      'en': 'Please enter a valid number...',
      'ar': '',
      'de': '',
      'es': '',
    },
    'e70ab1q7': {
      'en': 'Your Age',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8dkuvk6k': {
      'en': 'i.e. 34',
      'ar': '',
      'de': '',
      'es': '',
    },
    '65v4msoj': {
      'en': 'Your Title',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ks00ilzw': {
      'en': 'Complete ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5mdw7gym': {
      'en': 'Your Name is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vml4fcxq': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ayf2exym': {
      'en': 'Your Age is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zol3xax1': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    '3ilwmuhp': {
      'en': 'Your Title is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8qmpxbz0': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // EditProfile
  {
    '0hopqnx3': {
      'en': 'Set Up Your ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '43uvxdxq': {
      'en': 'Profile',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hjz0xunk': {
      'en': 'Your Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    'nkxzjdoh': {
      'en': 'Please enter a valid number...',
      'ar': '',
      'de': '',
      'es': '',
    },
    'g4e1qxzv': {
      'en': 'Your Age',
      'ar': '',
      'de': '',
      'es': '',
    },
    'pgrqp2c8': {
      'en': 'i.e. 34',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zq1fl92t': {
      'en': 'Your Title',
      'ar': '',
      'de': '',
      'es': '',
    },
    '592et0h0': {
      'en': 'House Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    'nmpx72em': {
      'en': 'Your Name is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'cyji8wl5': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    'npcjfdy0': {
      'en': 'Your Age is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    '3xrzadnd': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2knqha7s': {
      'en': 'Your Title is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xmj45j4n': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0z3tma9n': {
      'en': 'Save Edits',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // Automation
  {
    '4k35f01s': {
      'en': 'Turn On All the Lights',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5967xbqh': {
      'en': '1 task',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kvrh075z': {
      'en': 'Go to Office',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6aet0z08': {
      'en': '2 tasks',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kpjxlzrh': {
      'en': 'Energy Saver Mode',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dvcx8ptu': {
      'en': '2 tasks',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q9y230ct': {
      'en': 'Work Mode Activate',
      'ar': '',
      'de': '',
      'es': '',
    },
    'au2ycjg0': {
      'en': '1 task',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xg4oqths': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // DetailedDeviceInfo
  {
    'is8st656': {
      'en': '|',
      'ar': '',
      'de': '',
      'es': '',
    },
    'f2rpbdb5': {
      'en': 'Reset Readings',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mfh3e9qn': {
      'en': 'Permissions',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zes5ikq5': {
      'en': 'Eco Mode',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rnz4c9mg': {
      'en': 'Set Working Time',
      'ar': '',
      'de': '',
      'es': '',
    },
    'osmajlnj': {
      'en': 'From',
      'ar': '',
      'de': '',
      'es': '',
    },
    'f7d90p1a': {
      'en': 'To',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hl0gec9n': {
      'en': 'Power Readings',
      'ar': '',
      'de': '',
      'es': '',
    },
    'g0ggr0ed': {
      'en': 'Power',
      'ar': '',
      'de': '',
      'es': '',
    },
    's58fghde': {
      'en': 'Current',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2cddtbln': {
      'en': 'Voltage',
      'ar': '',
      'de': '',
      'es': '',
    },
    'cdoyfcvv': {
      'en': 'Frequency',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qiesls9f': {
      'en': 'Energy',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fy5u81fv': {
      'en': 'Power Cost',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ti6rapig': {
      'en': 'Sharjah',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ee1msmsm': {
      'en': 'Emirate',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jsa8lrj4': {
      'en': 'Search...',
      'ar': '',
      'de': '',
      'es': '',
    },
    'a4kwvw79': {
      'en': 'Dubai',
      'ar': '',
      'de': '',
      'es': '',
    },
    '85dk5ymh': {
      'en': 'Sharjah',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vaq39f3w': {
      'en': 'Abudahbi',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mjea3s19': {
      'en': 'Other',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ju8vatuf': {
      'en': 'Monthly Cost (0.2% error)',
      'ar': '',
      'de': '',
      'es': '',
    },
    'swo9pvoh': {
      'en': 'Predicted Tomorrow\'s Cost',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6g7cux5o': {
      'en': 'Projected Monthly Cost',
      'ar': '',
      'de': '',
      'es': '',
    },
    'toyq71wa': {
      'en': 'Anomoly Protection',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wfusp8x7': {
      'en': 'Power Threshold',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9wpc1a5c': {
      'en': 'Learning Phase',
      'ar': '',
      'de': '',
      'es': '',
    },
    'us9ppq2j': {
      'en': 'Device\'s Health',
      'ar': '',
      'de': '',
      'es': '',
    },
    'g7sqpkmq': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // GradiantContainerDark
  {
    'c19rhgd9': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // HomeNew
  {
    '9au8deaz': {
      'en': 'Welcome',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ksjukim8': {
      'en': ' km/h',
      'ar': '',
      'de': '',
      'es': '',
    },
    'igqb1lr7': {
      'en': '°',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fruq26hn': {
      'en': ' %',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qpjmrwry': {
      'en': 'Total Cost    ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0o0gi6ar': {
      'en': '%',
      'ar': '',
      'de': '',
      'es': '',
    },
    '74rfgz26': {
      'en': 'AED',
      'ar': '',
      'de': '',
      'es': '',
    },
    'i31t5q9c': {
      'en': 'Energy Usage ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'z6roqs91': {
      'en': '%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'p66nlew2': {
      'en': 'kWh',
      'ar': '',
      'de': '',
      'es': '',
    },
    'yoov8sfe': {
      'en': ' | ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'se6ti893': {
      'en': 'Power : ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'v5q6tb8d': {
      'en': ' W',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xgpwvs20': {
      'en': ' | ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l8einlq7': {
      'en': 'Voltage          ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ynv8e713': {
      'en': ' V',
      'ar': '',
      'de': '',
      'es': '',
    },
    'pba69bju': {
      'en': 'Current           ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fj08ebdc': {
      'en': ' A ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'd0ssd8fl': {
      'en': 'Cost                  ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'b497fyjw': {
      'en': ' AED',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xmyybe6m': {
      'en': 'Status   ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vezv3vay': {
      'en': 'Show Details',
      'ar': '',
      'de': '',
      'es': '',
    },
    'tgqtv76v': {
      'en': 'Eco-Energy Tip ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'v7weflxu': {
      'en': 'Powered by AI',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ekaexsfw': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // permissionList
  {
    '5f4q23tv': {
      'en': 'Manage Device ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jevywbkc': {
      'en': 'Permissions ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kdz55hqr': {
      'en': 'Manage which users can view or control the device.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l2w3hl7x': {
      'en': 'User',
      'ar': '',
      'de': '',
      'es': '',
    },
    'umzuqfkd': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // notiSettings
  {
    'e50x4ad4': {
      'en': 'Push Notifications',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rrx166ap': {
      'en':
          'Receive Push notifications from our application on a semi regular basis.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'e5wswlxp': {
      'en': 'Email Notifications',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zbsm9zqa': {
      'en':
          'Receive email notifications from our marketing team about new features.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'm4o3rzgz': {
      'en': 'Camera Control',
      'ar': '',
      'de': '',
      'es': '',
    },
    's8h1qkff': {
      'en':
          'Allow us to track your location, this helps keep track of spending and keeps you safe.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'oqrff2pq': {
      'en': 'Save Changes',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jm8bqf2z': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // S3
  {
    'lln3eihg': {
      'en': '2/3',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7e8fft30': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'pitjxl1j': {
      'en': 'Add your first ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '22d6c4oz': {
      'en': 'Device',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q3xjroai': {
      'en':
          'Select the Device that will be connected to the plug ( blurred devices are coming soon ! )',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8o38s3x7': {
      'en': 'Socket  ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8k1l6oq7': {
      'en': 'Home lighting                 ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'd6vuz15c': {
      'en': 'LED strips                   ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'tlk30uvk': {
      'en': 'Sensors                          ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l0hyo863': {
      'en': 'Light bulbs             ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kwc6xze3': {
      'en': 'Switches                   ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wi3ml5t0': {
      'en': 'Hubs and remotes',
      'ar': '',
      'de': '',
      'es': '',
    },
    '36hxl5u1': {
      'en': 'Security cameras',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6qu0633t': {
      'en': 'Televisions',
      'ar': '',
      'de': '',
      'es': '',
    },
    'y6bgarqj': {
      'en': 'Air conditioners',
      'ar': '',
      'de': '',
      'es': '',
    },
    'urikajql': {
      'en': 'Fridges',
      'ar': '',
      'de': '',
      'es': '',
    },
    '73llmur9': {
      'en': 'Laptops',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ehuytjgb': {
      'en': 'Later',
      'ar': '',
      'de': '',
      'es': '',
    },
    'oqbhli8d': {
      'en': 'Continue',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zigslkla': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // S4QR
  {
    'xd1oek3n': {
      'en': 'Scan a New ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zoeas37l': {
      'en': 'Device',
      'ar': '',
      'de': '',
      'es': '',
    },
    'sjqdwaq4': {
      'en': 'Use your camera to scan the QR code found on the device label',
      'ar': '',
      'de': '',
      'es': '',
    },
    'cbtkv0uo': {
      'en': 'DeviceID ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'feez9fy4': {
      'en': '( cant be changed )',
      'ar': '',
      'de': '',
      'es': '',
    },
    'recira3f': {
      'en': 'Device Name ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'aitpbt7m': {
      'en': '( change if needed )',
      'ar': '',
      'de': '',
      'es': '',
    },
    'uz4fmurd': {
      'en': '',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'pmt57xhu': {
      'en': 'Room Location ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '02aqmf2t': {
      'en': '( choose one option )',
      'ar': '',
      'de': '',
      'es': '',
    },
    'irmjmqry': {
      'en': 'My Room',
      'ar': '',
      'de': '',
      'es': '',
    },
    'komytxs1': {
      'en': 'Living Room',
      'ar': '',
      'de': '',
      'es': '',
    },
    '684x2hxe': {
      'en': 'Kitchen',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9xkzvcxr': {
      'en': 'Later',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fgurz041': {
      'en': 'Next ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'o0c3nn63': {
      'en':
          'Note: Once the device is saved, it cannot be modified unless you delink it and repeat the setup process.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'adrkrdwx': {
      'en': 'Scan QR Code',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zz558dg1': {
      'en': 'Cancel',
      'ar': '',
      'de': '',
      'es': '',
    },
    'g5lxnu8r': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // S5Network
  {
    'hkkp1gf0': {
      'en': 'Connect Your ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bc1rn13x': {
      'en': 'Device',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zm0jev5s': {
      'en':
          'EcoTrack is connecting automatically\nsit tight, it’ll be ready in a moment!',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zdh9v0k2': {
      'en': ' Wifi',
      'ar': '',
      'de': '',
      'es': '',
    },
    'g7b9ehhc': {
      'en': 'Confirm Connection',
      'ar': '',
      'de': '',
      'es': '',
    },
    'po8tyyof': {
      'en':
          'If you encounter any issues, please check that your Wi-Fi is enabled and you\'re within range of your network.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'crnpck07': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // FirstPage
  {
    '8uxb8w7l': {
      'en': 'Welcome!',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fdfullqu': {
      'en':
          'Thanks for joining! Access or create your account below, and get started on your journey!',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fltlc9lt': {
      'en': 'Get Started',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rpeyjiya': {
      'en': 'Sign in',
      'ar': '',
      'de': '',
      'es': '',
    },
    '11mbl6j5': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // LoginPage
  {
    '9ohe5dgl': {
      'en': 'Welcome back',
      'ar': 'البدء',
      'de': 'Loslegen',
      'es': 'Empezar',
    },
    'v9n5z6y0': {
      'en': 'Login to access your account below.',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'de': 'Erstellen Sie unten Ihr Konto.',
      'es': 'Crea tu cuenta a continuación.',
    },
    'itjxolop': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'tmhf4zhj': {
      'en': 'Enter your email...',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'yaw27xlt': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    'h5in6nzn': {
      'en': 'Enter your password...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    '121g354w': {
      'en': 'Forgot Password?',
      'ar': 'هل نسيت كلمة السر؟',
      'de': 'Passwort vergessen?',
      'es': '¿Has olvidado tu contraseña?',
    },
    'm1r2tpx6': {
      'en': 'Login',
      'ar': 'تسجيل الدخول',
      'de': 'Anmeldung',
      'es': 'Acceso',
    },
    'ua4niyl4': {
      'en': 'Don\'t have an account?',
      'ar': 'ليس لديك حساب؟',
      'de': 'Sie haben kein Konto?',
      'es': '¿No tienes una cuenta?',
    },
    'asve1mzt': {
      'en': 'Create',
      'ar': 'ليس لديك حساب؟',
      'de': 'Sie haben kein Konto?',
      'es': '¿No tienes una cuenta?',
    },
    'jttk8mes': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // GradiantContanerCopy
  {
    'nu43sigl': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // Family
  {
    'khx1jfms': {
      'en': 'My Family',
      'ar': '',
      'de': '',
      'es': '',
    },
    'r5vdput9': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // Notifications
  {
    '9gt8ydn1': {
      'en': 'Power Surge Detected',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hqfd7kcb': {
      'en': 'info abt the error',
      'ar': '',
      'de': '',
      'es': '',
    },
    'm2yslery': {
      'en': '10 minutes ago',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ole2ude5': {
      'en': 'Power anomly detected',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mch3n6ho': {
      'en': 'info abt the error can be need maintance error or crtical',
      'ar': '',
      'de': '',
      'es': '',
    },
    'x4j2cy1i': {
      'en': '2 hours ago',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8xim1cwq': {
      'en': 'High power consumption ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '93arh39l': {
      'en': 'info abt the error',
      'ar': '',
      'de': '',
      'es': '',
    },
    'acogdp1x': {
      'en': 'Yesterday at 3:47 PM',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lrq7otvb': {
      'en': 'Notifications',
      'ar': '',
      'de': '',
      'es': '',
    },
    't70yu9zt': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // CarbonEmissions
  {
    '2qotv0t4': {
      'en': 'Track Your ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2npmpv11': {
      'en': 'Emissions',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9a6v0wa5': {
      'en': 'Monitor your devices\' carbon footprints in real time',
      'ar': '',
      'de': '',
      'es': '',
    },
    'osrcamii': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // Dashboard01RecentActivity
  {
    'fatcmz8i': {
      'en': 'Recent Activity',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5n6bg7qs': {
      'en': 'Below is an overview of tasks & activity completed.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'x6o56al9': {
      'en': 'Tasks',
      'ar': '',
      'de': '',
      'es': '',
    },
    'v5wevbra': {
      'en': 'Completed',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // succsess
  {
    'vwhd7ggi': {
      'en': 'You have successfully registered and logged in.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vned2tsd': {
      'en': 'Continue to setup',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // InformationDialog
  {
    'c387mvl8': {
      'en': 'Ok',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // NavBar
  {
    '5uuzclk7': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
    'degm4x7v': {
      'en': 'Eco',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zwnag98c': {
      'en': 'Smart',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2qvomys8': {
      'en': 'Me',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // Signout
  {
    'g8k6isnh': {
      'en': 'Are you sure you want to sign out ?',
      'ar': '',
      'de': '',
      'es': '',
    },
    'nlyc059p': {
      'en': 'Signout',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // ProccessingQR
  {
    'kgjve6zb': {
      'en': 'You have successfully registered your device !',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jwvh4eaq': {
      'en': 'Back to home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // DeLink
  {
    'tvfx1jwz': {
      'en': 'Are you sure you want to Delink your device ?',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bcampsbo': {
      'en': 'No',
      'ar': '',
      'de': '',
      'es': '',
    },
    'njkyhfuq': {
      'en': 'Yes',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // succsessUser
  {
    '31nzucyp': {
      'en': 'You have successfully registered and logged in.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bll665cz': {
      'en': 'Continue to setup',
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
          'in order to connect to new devices and plugs, this app requries permission to access the bluetooth',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1kpwgsy1': {
      'en':
          'in order to send alerts and power anomolies, this app requries permission to access the Notfication',
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
  },
].reduce((a, b) => a..addAll(b));
