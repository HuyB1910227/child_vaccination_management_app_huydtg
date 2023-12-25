import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/appointment_card/appointment_prepare.dart';
import '../models/patient/patient.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'ui/screens.dart';
import './ui/main_screen.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart';
Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tzdata.initializeTimeZones();
  final vnTimeZone = getLocation('Asia/Ho_Chi_Minh');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthManager()),
        ChangeNotifierProxyProvider<AuthManager,
            PatientGeneralInformationManager>(
          create: (context) => PatientGeneralInformationManager(),
          update: (ctx, authManager, patientGeneralInformationManager) {
            patientGeneralInformationManager!.authToken = authManager.authToken;
            return patientGeneralInformationManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager,
            DiseaseGeneralInformationManager>(
          create: (context) => DiseaseGeneralInformationManager(),
          update: (ctx, authManager, diseaseGeneralInformationManager) {
            diseaseGeneralInformationManager!.authToken = authManager.authToken;
            return diseaseGeneralInformationManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager,
            VaccineGeneralInformationManager>(
          create: (context) => VaccineGeneralInformationManager(),
          update: (ctx, authManager, vaccineGeneralInformationManager) {
            vaccineGeneralInformationManager!.authToken = authManager.authToken;
            return vaccineGeneralInformationManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, DiseaseManager>(
          create: (context) => DiseaseManager(),
          update: (ctx, authManager, diseaseManager) {
            diseaseManager!.authToken = authManager.authToken;
            return diseaseManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, VaccineManager>(
          create: (context) => VaccineManager(),
          update: (ctx, authManager, vaccineManager) {
            vaccineManager!.authToken = authManager.authToken;
            return vaccineManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, AgeManager>(
          create: (context) => AgeManager(),
          update: (ctx, authManager, ageManager) {
            ageManager!.authToken = authManager.authToken;
            return ageManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, InjectionManager>(
          create: (context) => InjectionManager(),
          update: (ctx, authManager, injectionManager) {
            injectionManager!.authToken = authManager.authToken;
            return injectionManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager,
            ImmunizationUnitGeneralInformationManager>(
          create: (context) => ImmunizationUnitGeneralInformationManager(),
          update:
              (ctx, authManager, immunizationUnitGeneralInformationManager) {
            immunizationUnitGeneralInformationManager!.authToken =
                authManager.authToken;
            return immunizationUnitGeneralInformationManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, ImmunizationUnitManager>(
          create: (context) => ImmunizationUnitManager(),
          update: (ctx, authManager, immunizationUnitManager) {
            immunizationUnitManager!.authToken = authManager.authToken;
            return immunizationUnitManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, FixedScheduleManager>(
          create: (context) => FixedScheduleManager(),
          update: (ctx, authManager, fixedScheduleManager) {
            fixedScheduleManager!.authToken = authManager.authToken;
            return fixedScheduleManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, NutritionManager>(
          create: (context) => NutritionManager(),
          update: (ctx, authManager, nutritionManager) {
            nutritionManager!.authToken = authManager.authToken;
            return nutritionManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, VaccineLotManager>(
          create: (context) => VaccineLotManager(),
          update: (ctx, authManager, vaccineLotManager) {
            vaccineLotManager!.authToken = authManager.authToken;
            return vaccineLotManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, AssignmentManager>(
          create: (context) => AssignmentManager(),
          update: (ctx, authManager, assignmentManager) {
            assignmentManager!.authToken = authManager.authToken;
            return assignmentManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, HistoryManager>(
          create: (context) => HistoryManager(),
          update: (ctx, authManager, historyManager) {
            historyManager!.authToken = authManager.authToken;
            return historyManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, PatientManager>(
          create: (context) => PatientManager(),
          update: (ctx, authManager, patientManager) {
            patientManager!.authToken = authManager.authToken;
            return patientManager;
          },
        ),
        ChangeNotifierProvider<ProvincesManager>(
          create: (context) => ProvincesManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, CustomerManager>(
          create: (context) => CustomerManager(),
          update: (ctx, authManager, customerManager) {
            customerManager!.authToken = authManager.authToken;
            return customerManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, NotificationTokenManager>(
          create: (context) => NotificationTokenManager(),
          update: (ctx, authManager, notificationTokenManager) {
            notificationTokenManager!.authToken = authManager.authToken;
            return notificationTokenManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, NotificationManager>(
          create: (context) => NotificationManager(),
          update: (ctx, authManager, notificationManager) {
            notificationManager!.authToken = authManager.authToken;
            return notificationManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, AppointmentCardManager>(
          create: (context) => AppointmentCardManager(),
          update: (ctx, authManager, appointmentCardManager) {
            appointmentCardManager!.authToken = authManager.authToken;
            return appointmentCardManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, AvatarManager>(
          create: (context) => AvatarManager(),
          update: (ctx, authManager, avatarManager) {
            avatarManager!.authToken = authManager.authToken;
            return avatarManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, UserManager>(
          create: (context) => UserManager(),
          update: (ctx, authManager, userManager) {
            userManager!.authToken = authManager.authToken;
            return userManager;
          },
        ),
      ],
      child: Consumer<AuthManager>(
        builder: (cxt, authManager, child) {
          return MaterialApp(
            title: "Welcome to Angelo",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: '.SF UI Display',
                colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.purple,
            ).copyWith(
              // secondary: Colors.amberAccent,
                  secondary: Colors.deepPurple,
            )),
            home:
                authManager.isAuth
                    ? const MainScreen()
                    : FutureBuilder(
                        future: authManager.tryAutoLogin(),
                        builder: (ctx, snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? const SplashScreen()
                              : const AuthScreen();
                        }),
            routes: {
              PatientGeneralInformationScreen.routeName: (cxt) =>
                  const PatientGeneralInformationScreen(),
              DiseaseGeneralInformationScreen.routeName: (cxt) =>
                  const DiseaseGeneralInformationScreen(),
              VaccineGeneralInformationScreen.routeName: (cxt) =>
                  const VaccineGeneralInformationScreen(),
              ImmunizationUnitGeneralInformationScreen.routeName: (cxt) =>
                  const ImmunizationUnitGeneralInformationScreen(),
              HistoryGeneralInformationScreen.routeName: (cxt) =>
                  const HistoryGeneralInformationScreen(),
              CustomerDetailScreen.routeName: (cxt) =>
                  const CustomerDetailScreen(),
              NotificationScreen.routeName: (cxt) => const NotificationScreen(),
              EditPasswordScreen.routeName: (cxt) => const EditPasswordScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == DiseaseDetailScreen.routeName) {
                final diseaseId = settings.arguments as int;
                return MaterialPageRoute(builder: (ctx) {
                  return DiseaseDetailScreen(diseaseId);
                });
              }
              if (settings.name == VaccineDetailScreen.routeName) {
                final vaccineId = settings.arguments as String;
                return MaterialPageRoute(builder: (ctx) {
                  return VaccineDetailScreen(vaccineId);
                });
              }
              if (settings.name == ImmunizationUnitDetailScreen.routeName) {
                final immunizationUnitId = settings.arguments as String;
                return MaterialPageRoute(builder: (ctx) {
                  return ImmunizationUnitDetailScreen(immunizationUnitId);
                });
              }
              if (settings.name == PatientDetailScreen.routeName) {
                final patientId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return PatientDetailScreen(patientId);
                    // return PatientDetailScreen(patientId: patientId,);
                  },
                );
              }
              if (settings.name == NutritionDetailScreen.routeName) {
                final patientId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return NutritionDetailScreen(patientId: patientId);
                  },
                );
              }
              if (settings.name == DiseaseGroupGeneralScreen.routeName) {
                final patientId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return DiseaseGroupGeneralScreen(patientId);
                  },
                );
              }
              if (settings.name == AssignmentDetailScreen.routeName) {
                final assignmentIds = settings.arguments as List<int>;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return AssignmentDetailScreen(assignmentIds);
                  },
                );
              }
              if (settings.name == HistoryDetailScreen.routeName) {
                final historyId = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return HistoryDetailScreen(historyId);
                  },
                );
              }
              if (settings.name == PatientEditScreen.routeName) {
                final patient = settings.arguments as Patient?;
                if (patient != null) {
                  return MaterialPageRoute(builder: (ctx) {
                    return PatientEditScreen(patient);
                  });
                }
              }
              if (settings.name == AppointmentCardDetailScreen.routeName) {
                final appointmentCardId = settings.arguments as int;
                return MaterialPageRoute(builder: (ctx) {
                  return AppointmentCardDetailScreen(appointmentCardId);
                });
              }
              if (settings.name == EditUsernameScreen.routeName) {
                final username = settings.arguments as String;
                return MaterialPageRoute(builder: (ctx) {
                  return EditUsernameScreen(username);
                });
              }
              if (settings.name == RegistrationAppointmentCardFormScreen.routeName) {
                final appointmentPrepare = settings.arguments as AppointmentPrepare;
                return MaterialPageRoute(builder: (ctx) {
                  return RegistrationAppointmentCardFormScreen(appointmentPrepare);
                });
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
