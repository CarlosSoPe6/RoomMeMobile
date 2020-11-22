import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FallBackAvatar extends StatefulWidget {
  final NetworkImage image;
  final String initials;
  final TextStyle textStyle;
  final Color circleBackground;
  final double radius;
  final int msAnimationDuration;

  FallBackAvatar({@required this.image, @required this.initials, @required this.circleBackground, @required this.textStyle, @required this.radius, this.msAnimationDuration});

  @override
  _FallBackAvatarState createState() => _FallBackAvatarState();
}

class _FallBackAvatarState extends State<FallBackAvatar> {

  bool _imgSuccess = false;

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    ImageStreamListener listener = ImageStreamListener(_setImage, onError: _setError);

    widget.image.resolve(ImageConfiguration()).addListener(listener);
  }

  void _setImage(ImageInfo image, bool sync) {
    setState(() => _imgSuccess = true);
  }

  void _setError(dynamic dyn, StackTrace st) {
    setState(() => _imgSuccess = false);
    dispose();
  }

  Widget _fallBackAvatar() {
    return Container(
      height: widget.radius*2,
      width: widget.radius*2,
      decoration: BoxDecoration(
        color: widget.circleBackground,
        borderRadius: BorderRadius.all(Radius.circular(widget.radius))
      ),
      child: Center(child: Text(widget.initials, style: widget.textStyle))
    );
  }


  Widget _avatarImage() {
    return CircleAvatar(
      backgroundImage: widget.image,
      backgroundColor: widget.circleBackground
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: widget.msAnimationDuration ?? 500),
      child: _imgSuccess ? _avatarImage() : _fallBackAvatar(),
    );
  }
}