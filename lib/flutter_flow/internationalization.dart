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
  // loginPage
  {
    'o07j3mgv': {
      'en': 'Welcome back',
      'ar': 'البدء',
      'de': 'Loslegen',
      'es': 'Empezar',
    },
    'fzxvw3mu': {
      'en': 'Login to access your account below.',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'de': 'Erstellen Sie unten Ihr Konto.',
      'es': 'Crea tu cuenta a continuación.',
    },
    'a9j78va9': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'i7f18cve': {
      'en': 'Enter your email...',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'wztjmbn8': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    'lw1jpm1f': {
      'en': 'Enter your password...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    'm2xyjvuf': {
      'en': 'Forgot Password?',
      'ar': 'هل نسيت كلمة السر؟',
      'de': 'Passwort vergessen?',
      'es': '¿Has olvidado tu contraseña?',
    },
    'qbmoi1av': {
      'en': 'Login',
      'ar': 'تسجيل الدخول',
      'de': 'Anmeldung',
      'es': 'Acceso',
    },
    'cjqb8ial': {
      'en': 'Don\'t have an account?',
      'ar': 'ليس لديك حساب؟',
      'de': 'Sie haben kein Konto?',
      'es': '¿No tienes una cuenta?',
    },
    'a0iimirx': {
      'en': 'Create',
      'ar': 'ليس لديك حساب؟',
      'de': 'Sie haben kein Konto?',
      'es': '¿No tienes una cuenta?',
    },
    '2bb3vct7': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // SignUp
  {
    'gpokmd81': {
      'en': 'Get Started',
      'ar': 'البدء',
      'de': 'Loslegen',
      'es': 'Empezar',
    },
    'oitrrwgg': {
      'en': 'Create your admin account below.',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'de': 'Erstellen Sie unten Ihr Konto.',
      'es': 'Crea tu cuenta a continuación.',
    },
    'gcwdqm4g': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'iam0xgwx': {
      'en': 'Enter your email...',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'l16nk7lc': {
      'en': 'Household ID',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'k5vo9myg': {
      'en': 'Create your Household ID',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'bqv15dcf': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    'joih97mn': {
      'en': 'Enter your password...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    'rzpiwq9p': {
      'en': 'Confirm Password',
      'ar': 'تأكيد كلمة المرور',
      'de': 'Kennwort bestätigen',
      'es': 'Confirmar contraseña',
    },
    'eyfkffka': {
      'en': 'Enter your password...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    '5kmjfwsk': {
      'en': 'Create Account',
      'ar': 'إنشاء حساب',
      'de': 'Benutzerkonto erstellen',
      'es': 'Crear una cuenta',
    },
    '9ssznj0g': {
      'en': 'Already have an account?',
      'ar': 'هل لديك حساب؟',
      'de': 'Sie haben bereits ein Konto?',
      'es': '¿Ya tienes una cuenta?',
    },
    '3twynvfz': {
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
  // dashboarv11
  {
    'd97epumj': {
      'en': 'Energy Price Overview',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hf5fzwau': {
      'en': 'High',
      'ar': '',
      'de': '',
      'es': '',
    },
    's0qckn56': {
      'en': 'Current Price',
      'ar': '',
      'de': '',
      'es': '',
    },
    'z0n5a4hn': {
      'en': '0.38 AED/kWh',
      'ar': '',
      'de': '',
      'es': '',
    },
    'b4zlgoks': {
      'en': 'Connected Appliances',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0wz5jpjh': {
      'en': 'Living Room AC',
      'ar': '',
      'de': '',
      'es': '',
    },
    'nxjq3vxz': {
      'en': 'Current Usage: 1.2 kWh',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7sxhuqk2': {
      'en': 'Show More',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zefb8v5h': {
      'en': 'Kitchen Refrigerator',
      'ar': '',
      'de': '',
      'es': '',
    },
    'brtit68o': {
      'en': 'Current Usage: 0.8 kWh',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0llj0gye': {
      'en': 'Show More',
      'ar': '',
      'de': '',
      'es': '',
    },
    'y5g916po': {
      'en': 'Bedroom TV',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jvwwtg8t': {
      'en': 'Current Usage: 0.1 kWh',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8jiupqoy': {
      'en': 'Show More',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8vio7zha': {
      'en': 'View Historical Data',
      'ar': '',
      'de': '',
      'es': '',
    },
    'sqxjupc3': {
      'en': 'Electric Water Heater',
      'ar': '',
      'de': '',
      'es': '',
    },
    'h2xgfxnd': {
      'en': 'Bathroom | Online',
      'ar': '',
      'de': '',
      'es': '',
    },
    'auicrzms': {
      'en': 'Page Title',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // SignUpUser
  {
    'yn3jmm0u': {
      'en': 'Get Started',
      'ar': 'البدء',
      'de': 'Loslegen',
      'es': 'Empezar',
    },
    'jvf5tw8d': {
      'en': 'Create your user account below.',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'de': 'Erstellen Sie unten Ihr Konto.',
      'es': 'Crea tu cuenta a continuación.',
    },
    '4qjj4v09': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'z7tuawbm': {
      'en': 'Enter your email...',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    '2lenel3p': {
      'en': 'Household ID',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'opb17kbn': {
      'en': 'Enter your Admin\'s Household ID',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'lxlpakk0': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    '0r7iw7yi': {
      'en': 'Enter your password...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    'jxd2t0av': {
      'en': 'Confirm Password',
      'ar': 'تأكيد كلمة المرور',
      'de': 'Kennwort bestätigen',
      'es': 'Confirmar contraseña',
    },
    'hv68q02q': {
      'en': 'Enter your password...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    'cel6ravu': {
      'en': 'Your password must contain:',
      'ar': '',
      'de': '',
      'es': '',
    },
    'edrm55vi': {
      'en': 'Create Account',
      'ar': 'إنشاء حساب',
      'de': 'Benutzerkonto erstellen',
      'es': 'Crear una cuenta',
    },
    'byzno26g': {
      'en': 'Already have an account?',
      'ar': 'هل لديك حساب؟',
      'de': 'Sie haben bereits ein Konto?',
      'es': '¿Ya tienes una cuenta?',
    },
    'lgecb1p0': {
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
  // Firstpage
  {
    'fi38cktm': {
      'en': 'A new era of power',
      'ar': '',
      'de': '',
      'es': '',
    },
    'isyqs3a0': {
      'en': 'Welcome!',
      'ar': '',
      'de': '',
      'es': '',
    },
    '92pr3p01': {
      'en':
          'Thanks for joining! Access or create your account below, and get started on your journey!',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ltpmkebs': {
      'en': 'Get Started',
      'ar': '',
      'de': '',
      'es': '',
    },
    'so8u1695': {
      'en': 'Sign in',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q27ypsq9': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // OLDMAINPAGE
  {
    'n52gbdwl': {
      'en': 'Welcome',
      'ar': '',
      'de': '',
      'es': '',
    },
    'anfdcn4n': {
      'en': 'Cancel',
      'ar': '',
      'de': '',
      'es': '',
    },
    '01f6l04r': {
      'en': '35%',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5kmgo5uj': {
      'en': '45',
      'ar': '',
      'de': '',
      'es': '',
    },
    'cp3e6q8n': {
      'en': 'C',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hntzu2r3': {
      'en': 'Feels like 35',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jjscr9ak': {
      'en': '6%',
      'ar': '',
      'de': '',
      'es': '',
    },
    '3qgp327i': {
      'en': 'Total Cost    ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n30vxmgv': {
      'en': '+12.4%',
      'ar': '',
      'de': '',
      'es': '',
    },
    't1mb35j0': {
      'en': '\$418.75',
      'ar': '',
      'de': '',
      'es': '',
    },
    's1sah9vj': {
      'en': 'Energy Usage ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mzfl2no6': {
      'en': '+8.2%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'nbcwjj66': {
      'en': '189.12',
      'ar': '',
      'de': '',
      'es': '',
    },
    'evfp4yiq': {
      'en': 'kWh',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2caar63u': {
      'en': 'View Historical Data',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rlr1oyqm': {
      'en': 'Reset Power Readings',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lpsfngtk': {
      'en': 'Living room | ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4lgk5ghn': {
      'en': 'Power : ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gh1ljzwe': {
      'en': ' W',
      'ar': '',
      'de': '',
      'es': '',
    },
    '715mx34s': {
      'en': ' | ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ghampuld': {
      'en': 'Voltage                 ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'p3nic564': {
      'en': '  V',
      'ar': '',
      'de': '',
      'es': '',
    },
    'cgz0zve9': {
      'en': 'Current                  ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2z32nuje': {
      'en': '  A',
      'ar': '',
      'de': '',
      'es': '',
    },
    'obgjlswk': {
      'en': 'Cost                          ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'r7k3a2i7': {
      'en': '69.65 AED',
      'ar': '',
      'de': '',
      'es': '',
    },
    'inpkn9yz': {
      'en': 'Status                 ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '578y4igu': {
      'en': 'Safe',
      'ar': '',
      'de': '',
      'es': '',
    },
    'r9i9h8o2': {
      'en': 'Energy-Saving Tip',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5oodtx7e': {
      'en':
          'Use natural light when possible and turn off lights in unoccupied rooms to reduce energy consumption.',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0ajfnfhk': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // Profile
  {
    'jlxkbgiq': {
      'en': 'Family',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qdcvtjbo': {
      'en': 'Notifications',
      'ar': '',
      'de': '',
      'es': '',
    },
    's084vgnp': {
      'en': 'Help Center',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0jt7y3dl': {
      'en': 'Settings',
      'ar': '',
      'de': '',
      'es': '',
    },
    'brh4f54m': {
      'en': 'Notification Settings',
      'ar': '',
      'de': '',
      'es': '',
    },
    'w4aruek2': {
      'en': 'Language',
      'ar': '',
      'de': '',
      'es': '',
    },
    '36enqi08': {
      'en': 'English (eng)',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9t6hbyot': {
      'en': 'Currency',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fa2su5ie': {
      'en': 'US Dollar (\$)',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xc8ihf3k': {
      'en': 'Profile Settings',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0sm01n6s': {
      'en': 'Edit Profile',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dop9v87a': {
      'en': 'Log out of account',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rl7so1sm': {
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
      'en': 'connect your device',
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
      'en': 'ANDY\'S PHONE',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wfha0poz': {
      'en': 'MY PC',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jh0fjujg': {
      'en': 'MY PHONE',
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
    '57h6d48j': {
      'en': 'Enter your existing email',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
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
      'en': ' <  Back to Sign in',
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
  // S4
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
    'wvyvacew': {
      'en': 'Turn On All the Lights',
      'ar': '',
      'de': '',
      'es': '',
    },
    'aywilaq4': {
      'en': '1 task',
      'ar': '',
      'de': '',
      'es': '',
    },
    'tv4ftfsb': {
      'en': 'Go to Office',
      'ar': '',
      'de': '',
      'es': '',
    },
    'a0518ar5': {
      'en': '2 tasks',
      'ar': '',
      'de': '',
      'es': '',
    },
    'yflf2zt7': {
      'en': 'Energy Saver Mode',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ez666agi': {
      'en': '2 tasks',
      'ar': '',
      'de': '',
      'es': '',
    },
    'yosu5i9x': {
      'en': 'Work Mode Activate',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dzvt62ww': {
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
    'bpndu0y5': {
      'en': 'Device name',
      'ar': '',
      'de': '',
      'es': '',
    },
    'w7lelomu': {
      'en': 'Duration',
      'ar': '',
      'de': '',
      'es': '',
    },
    'is8st656': {
      'en': '|',
      'ar': '',
      'de': '',
      'es': '',
    },
    'yxfjfc3l': {
      'en': 'safe',
      'ar': '',
      'de': '',
      'es': '',
    },
    '54vcgkun': {
      'en': 'Eco Mode',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kqbptuxf': {
      'en': 'Set Working Time',
      'ar': '',
      'de': '',
      'es': '',
    },
    'oswidgl2': {
      'en': 'From',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zuxqda1h': {
      'en': '17:30',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mq9c57hg': {
      'en': 'To',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kqzfs3bg': {
      'en': '22:30',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1ywqpj78': {
      'en': 'Power Readings',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zzedc7py': {
      'en': 'Power',
      'ar': '',
      'de': '',
      'es': '',
    },
    '860eda19': {
      'en': 'Current',
      'ar': '',
      'de': '',
      'es': '',
    },
    'c6ofng7m': {
      'en': 'Voltage',
      'ar': '',
      'de': '',
      'es': '',
    },
    'm1sd8i3m': {
      'en': 'Frequency',
      'ar': '',
      'de': '',
      'es': '',
    },
    '17fkp1s6': {
      'en': '5.7',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n5145gge': {
      'en': 'Energy',
      'ar': '',
      'de': '',
      'es': '',
    },
    'avflsqqg': {
      'en': 'Power Cost',
      'ar': '',
      'de': '',
      'es': '',
    },
    '13vi0aov': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vmfp62od': {
      'en': 'Emiratre',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1v3e4a2j': {
      'en': 'Search...',
      'ar': '',
      'de': '',
      'es': '',
    },
    's45b7kh0': {
      'en': 'Option 1',
      'ar': '',
      'de': '',
      'es': '',
    },
    'anrwu918': {
      'en': 'Option 2',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dtry9pz7': {
      'en': 'Option 3',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mj2t7qec': {
      'en': 'Current Cost (0.2% error)',
      'ar': '',
      'de': '',
      'es': '',
    },
    'foe5uilr': {
      'en': 'Predicted Tomorrow\'s Cost',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kn20cbz0': {
      'en': '391',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ewrwwbmr': {
      'en': 'Projected Monthly Cost',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kunbndet': {
      'en': '5.7',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dti4c3ix': {
      'en': 'Anomoly Protection',
      'ar': '',
      'de': '',
      'es': '',
    },
    'd5b7peo2': {
      'en': 'Power Anomaly',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vzg791bz': {
      'en': '60w',
      'ar': '',
      'de': '',
      'es': '',
    },
    'knblbvgc': {
      'en': 'Mean Power',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7wmxc9ik': {
      'en': '391',
      'ar': '',
      'de': '',
      'es': '',
    },
    'b5baiz4n': {
      'en': 'Standard deviation',
      'ar': '',
      'de': '',
      'es': '',
    },
    'a0what33': {
      'en': '5.7',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hcvdyd5s': {
      'en': 'Reset Power Readings',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9mwunvmg': {
      'en': 'Permissions',
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
    'a66m8mjv': {
      'en': 'Welcome',
      'ar': '',
      'de': '',
      'es': '',
    },
    'twtru3br': {
      'en': 'Cancel',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wou3jv4i': {
      'en': '35%',
      'ar': '',
      'de': '',
      'es': '',
    },
    's5m5q71g': {
      'en': '45',
      'ar': '',
      'de': '',
      'es': '',
    },
    '11wkwzlr': {
      'en': 'C',
      'ar': '',
      'de': '',
      'es': '',
    },
    'd56rhxwq': {
      'en': 'Feels like 35',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ilzvi4m8': {
      'en': '6%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'sjayvjmo': {
      'en': 'Total Cost    ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'de46b1lb': {
      'en': '+12.4%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hlqby4lp': {
      'en': '\$418.75',
      'ar': '',
      'de': '',
      'es': '',
    },
    'yl2z6s0l': {
      'en': 'Energy Usage ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'b1883c4k': {
      'en': '+8.2%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'o0hhr745': {
      'en': '189.12',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4slxa9jb': {
      'en': 'kWh',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6rf9skog': {
      'en': 'Living room | ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'w142hbxz': {
      'en': ' | ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zk0bgagh': {
      'en': 'Power : ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'uavfaycc': {
      'en': ' W',
      'ar': '',
      'de': '',
      'es': '',
    },
    'liftgzmw': {
      'en': ' | ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n79mija1': {
      'en': 'Voltage        ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'g3s9ukip': {
      'en': ' V',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n2h2iw8n': {
      'en': 'Current         ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7ddcdiva': {
      'en': ' A ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qg3wn1vg': {
      'en': 'Cost                 ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'cbzqhgtl': {
      'en': '69.65 ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '44z1bqcj': {
      'en': ' AED',
      'ar': '',
      'de': '',
      'es': '',
    },
    '3rfnacnq': {
      'en': 'Status           ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '17sfxzw9': {
      'en': 'Safe',
      'ar': '',
      'de': '',
      'es': '',
    },
    'k2g7akbr': {
      'en': 'Eco Energy Tip',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bd3llfzp': {
      'en':
          'Use natural light when possible and turn off lights in unoccupied rooms to reduce energy consumption.',
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
  // UserViewSelect
  {
    '38gsw9po': {
      'en': 'Invite Friends',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gp2biyji': {
      'en': '#',
      'ar': '',
      'de': '',
      'es': '',
    },
    'j7o4fmu7': {
      'en': 'Selected',
      'ar': '',
      'de': '',
      'es': '',
    },
    'z3izyygw': {
      'en': 'Friend Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wa6moz7a': {
      'en': 'City, State',
      'ar': '',
      'de': '',
      'es': '',
    },
    'oe4znlpw': {
      'en': 'Friend Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0nvuir23': {
      'en': 'City, State',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9k9i8xd3': {
      'en': 'Friend Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    'i3mq5w06': {
      'en': 'City, State',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2zzp2jb5': {
      'en': 'Friend Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    '17cj4pev': {
      'en': 'City, State',
      'ar': '',
      'de': '',
      'es': '',
    },
    'exrzqev0': {
      'en': 'Friend Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lvgw7mhb': {
      'en': 'City, State',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fxsyluou': {
      'en': 'Send Invites',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hrgpiucg': {
      'en': 'Invite Friends',
      'ar': '',
      'de': '',
      'es': '',
    },
    'f6u0ysgu': {
      'en': 'Invite your friends to join you!',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9xfgm82v': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // permissionList
  {
    'rk5bq10b': {
      'en': 'Permissions',
      'ar': '',
      'de': '',
      'es': '',
    },
    'icmg6gur': {
      'en': 'Control the permissions of the users',
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
  // S3
  {
    'ouefurm9': {
      'en': '2/3',
      'ar': '',
      'de': '',
      'es': '',
    },
    'b44huvon': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7g1bo4eh': {
      'en': 'Add ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jnvsatui': {
      'en': 'New ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lns31xvm': {
      'en': 'Device',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jtj05zv6': {
      'en':
          'Select the rooms in your house. Don\'t worry, you can add more later.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qpg6i5o7': {
      'en': 'Light bulbs                 ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ga61d2iz': {
      'en': 'Home lighting                 ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'p02um42d': {
      'en': 'LED strips                   ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vu7m0brk': {
      'en': 'Sensors                          ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zzwo6wny': {
      'en': 'Sockets               ',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qs7ihfba': {
      'en': 'Switches                   ',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9i8s61hy': {
      'en': 'Hubs and remotes',
      'ar': '',
      'de': '',
      'es': '',
    },
    '3hzryux2': {
      'en': 'Security cameras',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gvkdeoza': {
      'en': 'Televisions',
      'ar': '',
      'de': '',
      'es': '',
    },
    'pnmswxc7': {
      'en': 'Air conditioners',
      'ar': '',
      'de': '',
      'es': '',
    },
    '46v8dtm3': {
      'en': 'Fridges',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1yu46h7d': {
      'en': 'Laptops',
      'ar': '',
      'de': '',
      'es': '',
    },
    'weqct8zt': {
      'en': 'Previous',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dihehefy': {
      'en': 'Continue',
      'ar': '',
      'de': '',
      'es': '',
    },
    'p3bxa7nj': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // Notifactionpage
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
      'en': 'Location Services',
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
