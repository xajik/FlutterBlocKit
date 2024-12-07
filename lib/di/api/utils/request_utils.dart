import 'dart:io';

import 'package:dio/dio.dart';

Map<String, String> jsonContentHeader() =>
    {HttpHeaders.contentTypeHeader: ContentType.json.toString()};

Options jsonContenOptions() => Options(
      headers: jsonContentHeader(),
    );
