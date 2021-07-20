import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/blocs/blocs.dart';
import 'package:td_movie/blocs/movies_by_type/movies_by_type_bloc.dart';
import 'package:td_movie/blocs/movies_by_type/movies_by_type_event.dart';
import 'package:td_movie/di/injection.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';
import 'package:td_movie/ui/components/common/movie_item.dart';
import 'package:td_movie/ui/components/common/route_to_detail.dart';
import 'package:td_movie/ui/screen/movie_by_type/movies_by_type_page.dart';

import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.switchResult(
          onHomeLoadSuccess: (successState) {
            return Container(
              color: Colors.black,
              child: SafeArea(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 4),
                  itemCount: successState.data.length,
                  itemBuilder: (context, row) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: _buildHomePageRow(successState.data[row]),
                    );
                  },
                ),
              ),
            );
          },
          onHomeLoadFailure: (failState) {
            return Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 80.0,
                    ),
                    SizedBox(height: 16.0),
                    Text('${failState.error.toString()}'),
                  ],
                ),
              ),
            );
          },
          onHomeLoadInProgress: (loadingState) {
            return Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16.0),
                    Text(
                      'Loading at the moment, please hold the line.',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHomePageRow(HomeViewModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                model.headerTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            MaterialButton(
              child: Text(
                'Show More',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(_navigateToMoviesByType(model.headerTitle));
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 300,
            ),
            child: ListView.builder(
              itemCount: model.items.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              itemBuilder: (innerContext, column) {
                final movie = model.items[column];
                return InkWell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: MovieItem(movie: movie),
                  ),
                  onTap: () {
                    Navigator.of(innerContext).push(navigateToDetail(movie));
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Route _navigateToMoviesByType(String type) {
    return PageRouteBuilder(
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) => BlocProvider(
        create: (_) => MoviesByTypeBloc(
          getIt.get<MovieRepository>(),
        )..add(GetMoviesByType(type)),
        child: MoviesByTypePage(type: type),
      ),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) => buildCommonTransitions(
        context,
        animation,
        secondaryAnimation,
        child,
      ),
    );
  }
}
