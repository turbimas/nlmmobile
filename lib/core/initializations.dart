import 'package:nlmmobile/core/services/cache/cache_manager.dart';

void initSync() {}

Future initAsync() async {
  await CacheManager.initCache();
}
