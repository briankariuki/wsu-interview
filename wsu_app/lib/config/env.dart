import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/foundation.dart';

String kBaseApiUrl = kReleaseMode ? env['BASE_API_URL'] : env['BASE_API_URL_2'];

String kAppName = env['APP_NAME'];
