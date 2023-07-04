import 'package:auto_route/auto_route.dart';
import 'package:cryptocurrency_tracker/app/widgets/failure/failure_widget.dart';
import 'package:cryptocurrency_tracker/app/widgets/list_tile/custom_list_tile.dart';
import 'package:cryptocurrency_tracker/app/widgets/text/centered_text.dart';
import 'package:cryptocurrency_tracker/core/extensions/context_extensions.dart';
import 'package:cryptocurrency_tracker/feature/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';

@RoutePage()
class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          return switch (state.status) {
            FavoritesStatus.loading => const Center(
                child: UIKitAdaptiveIndicator(),
              ),
            FavoritesStatus.empty => const CenteredText(text: 'You dont have any favorites.'),
            FavoritesStatus.failure => FailureWidget(onPressed: () => context.read<FavoritesCubit>().getFavorites()),
            FavoritesStatus.success => Padding(
                padding: context.paddingAllLow,
                child: ListView.builder(
                  itemCount: state.favorites.length,
                  itemBuilder: (context, index) {
                    final favorites = state.favorites[index];
                    return CustomListTile(
                      id: favorites.id,
                      name: favorites.name,
                      symbol: favorites.symbol,
                      image: favorites.image,
                      marketCapRank: favorites.marketCapRank,
                    );
                  },
                ),
              )
          };
        },
      ),
    );
  }
}
