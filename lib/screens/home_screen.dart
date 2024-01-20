import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gdocs/colors.dart';
import 'package:gdocs/common/widgets/loader.dart';
import 'package:gdocs/models/document_model.dart';
import 'package:gdocs/repository/auth_repository.dart';
import 'package:gdocs/repository/document_repository.dart';
import 'package:routemaster/routemaster.dart';

import '../models/error_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  void signOut(WidgetRef ref) {
    ref.read(authRepositoryProvider).signOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createDocument(WidgetRef ref, BuildContext context) async {
    String token = ref.read(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);
    final errorModel =
        await ref.read(documentRespositoryProvider).createDoucument(token);
    if (errorModel.data != null) {
      navigator.push('/document/${errorModel.data.id}');
    } else {
      snackbar.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }
  void naviagateToDocument(BuildContext context,String documentId){
    Routemaster.of(context).push('/document/$documentId');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => createDocument(ref, context),
                icon: const Icon(
                  Icons.add,
                  color: kBlackColor,
                )),
            IconButton(
                onPressed: () => signOut(ref),
                icon: const Icon(
                  Icons.logout,
                  color: kRedColor,
                )),
          ],
        ),
        body: FutureBuilder(
          future: ref
              .watch(documentRespositoryProvider)
              .getDoucuments(ref.watch(userProvider)!.token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            return Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: 600,
                child: ListView.builder(
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) {
                      DocumentModel document = snapshot.data!.data[index];
                      return InkWell(
                        onTap: () =>naviagateToDocument(context, document.id),
                        child: Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: SizedBox(
                            height: 50,
                            child: Card(
                              child: Center(
                                child: Text(
                                  document.title,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            );
          },
        ));
  }
}
