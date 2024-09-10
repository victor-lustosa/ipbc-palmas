import '../core_module.dart';

final supabase = Supabase.instance.client;

class CoreModule extends Module {
  static BindConfig<T> blocConfig<T extends Bloc>() {
    return BindConfig(
      notifier: (bloc) => bloc.stream,
      onDispose: (bloc) => bloc.close(),
    );
  }

  @override
  void exportedBinds(Injector i) {
    i.addSingleton<SupabaseDatasource>(
      () => SupabaseDatasource(
        supabaseClient: Supabase.instance.client,
      ),
    );
    i.addSingleton<Repository<List>>(
      () => Repository<List>(
        datasource: i.get<SupabaseDatasource>(),
      ),
    );
  }
}
