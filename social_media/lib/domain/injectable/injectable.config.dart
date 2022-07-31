// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/auth/auth_bloc.dart' as _i5;
import '../../application/edit_profile_pics/edit_profile_bloc.dart' as _i14;
import '../../application/home/home_feed_bloc.dart' as _i15;
import '../../application/others_profile/others_profile_bloc.dart' as _i16;
import '../../application/post_actions/post_actions_bloc.dart' as _i17;
import '../../application/post_crud/post_crud_bloc.dart' as _i18;
import '../../application/profile/profile_bloc.dart' as _i19;
import '../../application/search/search_bloc.dart' as _i20;
import '../../infrastructure/accounts/account_repo.dart' as _i3;
import '../../infrastructure/accounts/account_services.dart' as _i4;
import '../../infrastructure/home/home_repo.dart' as _i6;
import '../../infrastructure/home/home_services.dart' as _i7;
import '../../infrastructure/post/post_repo.dart' as _i8;
import '../../infrastructure/post/post_services.dart' as _i9;
import '../../infrastructure/profile/profile_repo.dart' as _i10;
import '../../infrastructure/profile/profile_services.dart' as _i11;
import '../../infrastructure/search/search_repo.dart' as _i12;
import '../../infrastructure/search/search_service.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AccountRepo>(() => _i4.AccountServices());
  gh.factory<_i5.AuthBloc>(() => _i5.AuthBloc(get<_i3.AccountRepo>()));
  gh.lazySingleton<_i6.HomeRepo>(() => _i7.HomeServices());
  gh.lazySingleton<_i8.PostRepo>(() => _i9.PostServices());
  gh.lazySingleton<_i10.ProfileRepo>(() => _i11.ProfileServices());
  gh.lazySingleton<_i12.SearchRepo>(() => _i13.SearchServices());
  gh.factory<_i14.EditProfileBloc>(
      () => _i14.EditProfileBloc(get<_i10.ProfileRepo>()));
  gh.factory<_i15.HomeFeedBloc>(() => _i15.HomeFeedBloc(get<_i6.HomeRepo>()));
  gh.factory<_i16.OthersProfileBloc>(
      () => _i16.OthersProfileBloc(get<_i10.ProfileRepo>()));
  gh.factory<_i17.PostActionsBloc>(
      () => _i17.PostActionsBloc(get<_i8.PostRepo>()));
  gh.factory<_i18.PostCrudBloc>(
      () => _i18.PostCrudBloc(get<_i10.ProfileRepo>()));
  gh.factory<_i19.ProfileBloc>(() => _i19.ProfileBloc(get<_i10.ProfileRepo>()));
  gh.factory<_i20.SearchBloc>(() => _i20.SearchBloc(get<_i12.SearchRepo>()));
  return get;
}
