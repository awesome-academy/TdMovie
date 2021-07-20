import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/base/base.dart';
import 'package:td_movie/blocs/cast_detail/blocs.dart';
import 'package:td_movie/domain/model/cast.dart';
import 'package:td_movie/platform/repositories/cast_repository.dart';

class CastDetailBloc extends Bloc<BaseEvent, BaseState>{
  final CastRepository castRepository;

  CastDetailBloc(this.castRepository) : super(InitState());

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async*{
    if(event is GetCastDetail){
      try{
        yield LoadingState();
        final cast = await castRepository.getCastDetail(event.id);
        yield LoadedState<Cast>(data: cast);
      }catch(e){
        yield ErrorState(data: e.toString());
      }
    }
  }
}
