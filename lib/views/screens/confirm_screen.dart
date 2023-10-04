import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/controllers/upload_video_controller.dart';
import 'package:flutter_tiktok_clone/views/widgets/text_input_filed.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({super.key, required this.videoFile, required this.videoPath});
  final File videoFile;
  final String videoPath;

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  final TextEditingController songController = TextEditingController();
  final TextEditingController captionController = TextEditingController();
  @override
  void initState() {
    initializeVideo();
    super.initState();
  }

  bool isLoading = false;

  void initializeVideo() async {
    controller = VideoPlayerController.file(widget.videoFile);
    await controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    captionController.dispose();
    songController.dispose();
  }

  final myKey = GlobalKey<FormState>();
  UploadVideoController uploadVideoController = Get.put(UploadVideoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Center(
                    child: controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: VideoPlayer(controller),
                          )
                        : const CircularProgressIndicator(
                            color: Colors.red,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: myKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width - 20,
                          child: TextInputField(
                            controller: songController,
                            labelText: 'Song Name',
                            icon: Icons.music_note,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter song name';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            isPassword: false,
                            onTapIcon: () {},
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width - 20,
                          child: TextInputField(
                            controller: captionController,
                            labelText: 'Caption',
                            icon: Icons.closed_caption,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter caption';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            isPassword: false,
                            onTapIcon: () {},
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final isValid = myKey.currentState!.validate();
                            if (isValid) {
                              if (mounted) {
                                setState(() {
                                  isLoading = true;
                                });
                                await uploadVideoController.uploadVideo(
                                  songController.text,
                                  captionController.text,
                                  widget.videoPath,
                                  context,
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              }
                            }
                          },
                          child: const Text(
                            'Share!',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
