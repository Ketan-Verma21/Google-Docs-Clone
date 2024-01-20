import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gdocs/colors.dart';
import 'package:gdocs/models/document_model.dart';
import 'package:gdocs/models/error_model.dart';
import 'package:gdocs/repository/auth_repository.dart';
import 'package:gdocs/repository/document_repository.dart';

class DocumentScreen extends ConsumerStatefulWidget {
  final String id;
  const DocumentScreen({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  final quill.QuillController _controller = quill.QuillController.basic();
  TextEditingController titleController =
      TextEditingController(text: 'Untitled Document');
  ErrorModel? errorModel;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDocument();
  }
  void fetchDocument() async{
    errorModel=await ref.read(documentRespositoryProvider).getTitle(ref.read(userProvider)!.token,widget.id);
    if(errorModel!.data!=null){
      titleController.text=(errorModel!.data as DocumentModel).title;
      setState(() {

      });
    }
  }
  void updateTitle(WidgetRef ref,String title) {
      ref.read(documentRespositoryProvider).updateTitle(token: ref.read(userProvider)!.token, title: title, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.lock,
                size: 16,
              ),
              label: const Text("Share"),
              style: ElevatedButton.styleFrom(backgroundColor: kBlueColor),
            ),
          )
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Image.asset(
                "assets/images/docs-logo.png",
                height: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  onSubmitted:(value)=>updateTitle(ref, value) ,
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kBlueColor)),
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              )
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child:  Container(
            decoration: BoxDecoration(
                border: Border.all(color: kGreyColor, width: 0.1)),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            quill.QuillToolbar.simple(configurations: quill.QuillSimpleToolbarConfigurations(controller: _controller)),
            const SizedBox(height: 10,),
            Expanded(
              child: SizedBox(
                width: 750,
                child: Card(
                  color: kWhiteColor,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: quill.QuillEditor.basic(
                      configurations: quill.QuillEditorConfigurations(
                        controller: _controller,
                        readOnly: false
                      )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
