import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File _image;
  bool isVideo = false;
  VideoPlayerController _controller;

  String _retrieveDataError;
  dynamic _pickImageError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Demo'),
      ),
      body: _buildPreview(),
      floatingActionButton: _buildFloatingButtons(),
    );
  }

  Widget _buildPreview() {
    return (isVideo ? _previewVideo(_controller) : _previewImage());
  }

  Widget _buildFloatingButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () {
            isVideo = false;
            _onButtonPressed(ImageSource.gallery);
          },
          heroTag: 'image0',
          tooltip: 'Pick Image from gallery',
          child: const Icon(Icons.photo_library),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: FloatingActionButton(
            onPressed: () {
              isVideo = false;
              _onButtonPressed(ImageSource.camera);
            },
            heroTag: 'image1',
            tooltip: 'Take a Photo',
            child: const Icon(Icons.camera_alt),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              isVideo = true;
              _onButtonPressed(ImageSource.gallery);
            },
            heroTag: 'video0',
            tooltip: 'Pick Video from gallery',
            child: const Icon(Icons.video_library),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              isVideo = true;
              _onButtonPressed(ImageSource.camera);
            },
            heroTag: 'video1',
            tooltip: 'Take a Video',
            child: const Icon(Icons.videocam),
          ),
        ),
      ],
    );
  }

  Future<void> _retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.type == RetrieveType.video) {
          isVideo = true;
          _controller = VideoPlayerController.file(response.file)
            ..addListener(_onVideoControllerUpdate)
            ..setVolume(1.0)
            ..initialize()
            ..setLooping(true)
            ..play();
        } else {
          isVideo = false;
          _image = response.file;
        }
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  Widget _previewVideo(VideoPlayerController controller) {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    } else if (controller.value.initialized) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: AspectRatioVideoPlayer(controller),
      );
    } else {
      return const Text(
        'Error Loading Video',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_image != null) {
      return Image.file(_image);
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  void _onButtonPressed(ImageSource source) async {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.removeListener(_onVideoControllerUpdate);
    }
    if (isVideo) {
      ImagePicker.pickVideo(source: source).then((File file) {
        if (file != null && mounted) {
          setState(() {
            _controller = VideoPlayerController.file(file)
              ..addListener(_onVideoControllerUpdate)
              ..setVolume(1.0)
              ..initialize()
              ..setLooping(true)
              ..play();
          });
        }
      });
    } else {
      try {
        _image = await ImagePicker.pickImage(source: source);
      } catch (e) {
        _pickImageError = e;
      }
      setState(() {});
    }
  }

  void _onVideoControllerUpdate() {
    setState(() {});
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.removeListener(_onVideoControllerUpdate);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

class AspectRatioVideoPlayer extends StatefulWidget {
  AspectRatioVideoPlayer(this.controller);

  final VideoPlayerController controller;

  @override
  AspectRatioVideoPlayerState createState() => AspectRatioVideoPlayerState();
}

class AspectRatioVideoPlayerState extends State<AspectRatioVideoPlayer> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller.value.initialized) {
      initialized = controller.value.initialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onVideoControllerUpdate);
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value?.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return Container();
    }
  }
}
