// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/auth/auth_bloc.dart' as _i5;
import '../../application/edit_profile_pics/edit_profile_bloc.dart' as _i8;
import '../../application/profile/profile_bloc.dart' as _i9;
import '../../infrastructure/accounts/account_repo.dart' as _i3;
import '../../infrastructure/accounts/account_services.dart' as _i4;
import '../../infrastructure/profile/profile_repo.dart' as _i6;
import '../../infrastructure/profile/profile_services.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AccountRepo>(() => _i4.AccountServices());
  gh.factory<_i5.AuthBloc>(() => _i5.AuthBloc(get<_i3.AccountRepo>()));
  gh.lazySingleton<_i6.ProfileRepo>(() => _i7.ProfileServices());
  gh.factory<_i8.EditProfileBloc>(
      () => _i8.EditProfileBloc(get<_i6.ProfileRepo>()));
  gh.factory<_i9.ProfileBloc>(() => _i9.ProfileBloc(get<_i6.ProfileRepo>()));
  return get;
}
