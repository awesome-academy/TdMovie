import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:td_movie/domain/model/cast.dart';
import 'package:td_movie/platform/services/api/urls.dart';
import 'package:td_movie/ui/components/collapsed_appbar_title.dart';

class CastDetail extends StatelessWidget {
  const CastDetail({Key key, this.cast}) : super(key: key);

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: SafeArea(
          child: Stack(
            children: [
              _buildBackdropCast(cast.profilePath),
              _buildColorFilter(),
              _buildContent(context, cast),
            ],
          ),
        ),
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
        )),
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
  final height = MediaQuery.of(context).size.height * 3.5 / 7 - 56;
  return NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return [
        SliverAppBar(
          backgroundColor: Colors.black,
          expandedHeight: height * 1.5,
          floating: false,
          pinned: true,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: 4,
                left: 8,
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
            background: Stack(
              children: [
                _buildBackdropCast(cast.profilePath),
                _buildColorFilter(),
                Center(
                  child: _buildPosterImage(
                    cast.profilePath,
                    height: height,
                  ),
                ),
              ],
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
          _buildBiography(cast.biography),
        ],
      ),
    ),
  );
}

Widget _buildCastName(String name){
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

Widget _buildBiography(String biography){
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
          biography,
          expandText: 'Show More',
          maxLines: 3,
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
      foregroundDecoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.white),
        ),
      ),
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
    height: height * 1.4,
    width: height * 1.2 * 2 / 3,
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(profileImageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.transparent,
      ),
      foregroundDecoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}
