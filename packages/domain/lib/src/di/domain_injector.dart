import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:domain/src/di/domain_injector.config.dart';

@InjectableInit(initializerName: r'$initDomain')
void configureDomainDependencies(GetIt getIt) => $initDomain(getIt);
