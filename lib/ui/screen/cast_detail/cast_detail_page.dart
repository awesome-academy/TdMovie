import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/base/base.dart';
import 'package:td_movie/blocs/cast_detail/blocs.dart';
import 'package:td_movie/domain/model/cast.dart';
import 'package:td_movie/platform/services/api/urls.dart';
import 'package:td_movie/ui/components/collapsed_appbar_title.dart';
import 'package:td_movie/ui/components/common/progress_loading.dart';

class CastDetailPage extends StatelessWidget {
  const CastDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CastDetailBloc, BaseState>(
        builder: (context, state) {
          if (state is LoadedState) {
            return Container(
              color: Colors.black,
              child: SafeArea(
                child: Stack(
                  children: [
                    _buildBackdropCast(state.data.profilePath),
                    _buildColorFilter(),
                    _buildContent(context, state.data),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: ProgressLoading(size: 32),
          );
        },
      ),
    );
  }
}

Widget _buildBackdropCast(String profilePath) {
  String profileImageUrl = '${Urls.originalImagePath}$profilePath';
  return Container(
    decoration: BoxDecoration(
      color: Colors.transparent,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(profileImageUrl),
      ),
    ),
  );
}

Widget _buildColorFilter() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      gradient: LinearGradient(
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
        colors: List<double>.generate(15, (index) => (index + 3) / 10)
            .map((e) => e < 1 ? Colors.black.withOpacity(e) : Colors.black)
            .toList(),
      ),
    ),
  );
}

Widget _buildContent(BuildContext context, Cast cast) {
  final height = MediaQuery.of(context).size.height * 0.30;
  return NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return [
        SliverAppBar(
          backgroundColor: Colors.black,
          expandedHeight: height * 1.44,
          floating: false,
          pinned: true,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: 4,
                left: 12,
                bottom: 8,
              ),
              child: _buildBackButton(context),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: CollapsedAppBarTitle(
              child: Text(cast.name),
            ),
            background: Center(
              child: _buildPosterImage(
                cast.profilePath,
                height: height,
              ),
            ),
          ),
        ),
      ];
    },
    body: SingleChildScrollView(
      padding: EdgeInsets.only(left: 12.0, right: 12.0),
      child: Column(
        children: [
          _buildCastName(cast.name),
          SizedBox(height: 8),
          _buildPlaceOfBirth(cast.placeOfBirth),
          SizedBox(height: 8),
          _buildBirthdayAndPopularity(cast.birthday, cast.popularity),
          SizedBox(height: 16),
          _buildBiography(cast.biography),
        ],
      ),
    ),
  );
}

Widget _buildCastName(String name) {
  return Center(
    child: Text(
      name,
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _buildPlaceOfBirth(String place) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.place,
        color: Colors.lightBlueAccent,
      ),
      Text(
        place == null ? "Place of birth unknown" : place,
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
      ),
    ],
  );
}

Widget _buildBirthdayAndPopularity(String birthday, double popularity) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        children: [
          Icon(
            Icons.date_range,
            color: Colors.pinkAccent,
          ),
          Text(
            birthday == null ? "Birthday unknown" : birthday,
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      SizedBox(
        width: 20,
      ),
      Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Text(
            '$popularity',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ],
  );
}

Widget _buildBiography(String biography) {
  return Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Biography',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 8),
        child: ExpandableText(
          biography == "" ? "Biography unknown" : biography,
          expandText: 'Show More',
          maxLines: 10,
          expandOnTextTap: true,
          collapseOnTextTap: true,
          linkColor: Colors.blue,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

Widget _buildBackButton(BuildContext context) {
  return SizedBox(
    width: 40,
    height: 40,
    child: Container(
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}

Widget _buildPosterImage(String profilePath, {double height}) {
  String profileImageUrl = '${Urls.originalImagePath}$profilePath';
  return SizedBox(
    height: height,
    width: height,
    child: Container(
      child: CircleAvatar(
        backgroundImage: NetworkImage(profileImageUrl),
        backgroundColor: Colors.transparent,
      ),
    ),
  );
}
