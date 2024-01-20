import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gdocs/models/error_model.dart';
import 'package:gdocs/repository/auth_repository.dart';
import 'package:gdocs/router.dart';
import 'package:routemaster/routemaster.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child:  MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  ErrorModel? errorModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  void getUserData() async{
      errorModel=await ref.read(authRepositoryProvider).getUserData();
      if(errorModel!=null && errorModel!.data!=null){
        ref.read(userProvider.notifier).update((state) => errorModel!.data);
      }
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'Slim Shady',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        final user=ref.watch(userProvider);
        if(user!=null && user.token.isNotEmpty){
            return loggedInRoute;
        }
        return loggedOutRoute;
      }),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}

