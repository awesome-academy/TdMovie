import 'package:flutter/material.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/services/api/urls.dart';

class CastItem extends StatelessWidget {
  const CastItem({
    Key key,
    @required this.cast,
  }) : super(key: key);

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (cast.profilePath != null)
                  ? Image.network(
                      '${Urls.originalImagePath}${cast.profilePath}',
                      fit: BoxFit.cover,
                    )
                  : Image(
                      image: AssetImage(
                        (cast.gender == 1)
                            ? 'assets/images/default_profile_f.jpg'
                            : 'assets/images/default_profile_m.jpg',
                      ),
                    ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            cast.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          SizedBox(height: 4),
          Text(
            cast.character,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
