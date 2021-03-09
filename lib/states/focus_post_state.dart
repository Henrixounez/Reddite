import 'package:mobx/mobx.dart';
import 'package:draw/draw.dart';

part 'focus_post_state.g.dart';

class FocusPostState = _FocusPostState with _$FocusPostState;

abstract class _FocusPostState with Store {
  @observable
  Submission _post;

  @computed
  Submission get post => _post;

  @action
  setPost(Submission v) {
    this._post = v;
  }
  @action
  unload() {
    this._post = null;
  }
}

final focusPostStore = FocusPostState();
