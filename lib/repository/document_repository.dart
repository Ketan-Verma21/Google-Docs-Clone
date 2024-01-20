import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gdocs/models/document_model.dart';
import 'package:http/http.dart';

import '../constants.dart';
import '../models/error_model.dart';
final documentRespositoryProvider=Provider((ref) => DocumentRepository(client: Client()));
class DocumentRepository{
  final Client _client;

  DocumentRepository({required Client client}):_client=client;
  Future<ErrorModel> createDoucument(String token)async{
    ErrorModel error = ErrorModel(
        error: 'Some unexpected error occurred',
        data: null);
    try{

        var res= await _client.post(Uri.parse('$host/doc/create'),
            headers:{
              'Content-Type': 'application/json; charset=utf-8',
              'x-auth-token': token
            },
            body:jsonEncode({
              'createdAt':DateTime.now().microsecondsSinceEpoch,

            })
        );
        switch(res.statusCode){
          case 200:

            error=ErrorModel(error: null, data:DocumentModel.fromJson(res.body) );
            break;
          default:
            error=ErrorModel(error: res.body, data:null );
            break;

        }

    }catch(e){
      error=ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
  Future<ErrorModel> getDoucuments(String token)async{
    ErrorModel error = ErrorModel(
        error: 'Some unexpected error occurred',
        data: null);
    try{

      var res= await _client.get(Uri.parse('$host/docs/me'),
          headers:{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': token
          }
      );
      switch(res.statusCode){
        case 200:
          List<DocumentModel> documents=[];
          for(int i=0; i<jsonDecode(res.body).length; i++){
            documents.add(DocumentModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
          }
          error=ErrorModel(error: null, data:documents );
          break;
        default:
          error=ErrorModel(error: res.body, data:null );
          break;

      }

    }catch(e){
      error=ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
  void updateTitle({required String token,required String title, required String id})async{
     await _client.post(Uri.parse('$host/doc/title'),
          headers:{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': token
          },
          body:jsonEncode({
            'id':id,
            'title':title
          })
      );

  }
  Future<ErrorModel> getTitle(String token,String id)async{
    ErrorModel error = ErrorModel(
        error: 'Some unexpected error occurred',
        data: null);
    try{

      var res= await _client.get(Uri.parse('$host/doc/$id'),
          headers:{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': token
          }
      );
      switch(res.statusCode){
        case 200:
          
          error=ErrorModel(error: null, data:DocumentModel.fromJson(res.body) );
          break;
        default:
          throw 'This Document does not exist, please create a new one';

      }

    }catch(e){
      error=ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}