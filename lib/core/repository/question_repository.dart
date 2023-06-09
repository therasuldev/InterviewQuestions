// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:flutter_interview_questions/core/interface/i_question_repository.dart';
import 'package:flutter_interview_questions/core/local_service/cache_service.dart';

class QuestionRepository extends IQuestionRepository {
  QuestionRepository({
    CacheService? cacheService,
  }) : _cacheService = cacheService ?? CacheService();

  final CacheService _cacheService;

  @override
  Future<List<Map<String, dynamic>>> loadQuestions({String? type}) async {
    List<Map<String, dynamic>> questions = [];

    var jsonStr = await rootBundle.loadString('prg_lang/$type.json');
    Map<String, dynamic> jsonMap = await json.decode(jsonStr);

    for (var i = 1; i <= jsonMap.length; i++) {
      questions.add(jsonMap['$i']);
    }

    _cacheService.questions.put(type, questions);
    return await getQuestions(type!);
  }

  @override
  Future<List<Map<String, dynamic>>> getQuestions(String category) async {
    return await _cacheService.questions.get(category);
  }
}
