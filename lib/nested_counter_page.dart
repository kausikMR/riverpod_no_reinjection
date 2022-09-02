import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_reinject/counter_page.dart';

class NestedCounterPage extends ConsumerWidget {
  const NestedCounterPage({super.key});

  /// [NESTED ROUTING] solves us the problem of reinjection of statemanagement into our (fullscreen player)
  /// Reinjection causes more problems / What this solves:
  /// 1. Spawing a new instance of the provider, causing unknown behaviour of the player in fullscreen
  /// 2. No compile time safety, we might forget to reinject a new provider that again causes the above mentioned problem
 
  static final _navKey = GlobalKey<NavigatorState>(); /// navKey helps us to navigate to the next page ()

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ProviderScope( /// this is where the package starts and injected with a single provider scope on top
        child: Navigator( /// by using this navigator we create a nested stack of pages
          key: _navKey,
          initialRoute: '/',
          onGenerateRoute: _onGeneratedRoute,
        ),
      ),
    );
  }

  Route _onGeneratedRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case '/':
        page = CounterPage(index: 1, onNavNext: _onNavigateNext, onNavPrev: _onNavigatePrev);
        break;
      case '/2':
        page = CounterPage(index: 2, onNavNext: _onNavigateNext, onNavPrev: _onNavigatePrev);
        break;
      case '/3':
        page = CounterPage(index: 3, onNavNext: _onNavigateNext, onNavPrev: _onNavigatePrev);
        break;
      default:
        throw UnimplementedError();
    }

    return MaterialPageRoute(builder: (context) => page);
  }

  void _onNavigateNext(int index) {
    _navKey.currentState!.pushNamed('/$index');
  }

  void _onNavigatePrev(int index) {
    _navKey.currentState!.pop();
  }
}


final counterProvider = StateNotifierProvider<CounterStateNotifier, int>((ref) {
  return CounterStateNotifier(0);
});

class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier(super.state);

  void increment() => state++;
}
