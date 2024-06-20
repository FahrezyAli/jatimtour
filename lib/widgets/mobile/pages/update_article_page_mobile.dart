import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:textfield_tags/textfield_tags.dart';

import '../../../constants.dart';
import '../../../models/article_model.dart';
import '../../../services/article_services.dart' as article_services;
import '../../universal/fields/tags_field.dart';
import 'mobile_scaffold.dart';

class UpdateArticlePageMobile extends StatefulWidget {
  final String articleId;
  const UpdateArticlePageMobile({required this.articleId, super.key});

  @override
  State<UpdateArticlePageMobile> createState() =>
      _UpdateArticlePageMobileState();
}

class _UpdateArticlePageMobileState extends State<UpdateArticlePageMobile> {
  late Future _futureArticle;
  CroppedFile? _coverImage;
  final _titleController = TextEditingController();
  final _datePublishedController = TextEditingController();
  DateTime _datePublished = DateTime.now();
  String? _selectedCity;
  final _quillController = QuillController.basic();
  late double _distanceToField;
  final _tagsController = StringTagController();
  late List<String> _initialTags;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final croppedImage = await _cropImage(File(pickedImage.path));
      setState(
        () {
          if (croppedImage != null) {
            _coverImage = croppedImage;
          }
        },
      );
    }
  }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 2.0, ratioY: 1.0),
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: kPinkColor,
        )
      ],
    );
    if (croppedImage != null) {
      return croppedImage;
    }
    return null;
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    final time = await showTimePicker(
      // ignore: use_build_context_synchronously
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && time != null) {
      setState(() {
        _datePublished = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        _datePublishedController.text =
            intl.DateFormat.yMd().add_Hm().format(_datePublished);
      });
    }
  }

  void _showErrorSnackBar(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error,
          style: const TextStyle(
            fontFamily: "Inter",
            fontSize: 12.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _updateArticle() async {
    if (_selectedCity == null || _tagsController.getTags!.isEmpty) {
      _showErrorSnackBar("Semua field harus diisi");
    } else if (_datePublished.isBefore(DateTime.now())) {
      _showErrorSnackBar("Tanggal Publikasi tidak valid");
    } else {
      await article_services.updateArticle(
        widget.articleId,
        title: _titleController.text,
        coverImage: await _coverImage!.readAsBytes(),
        datePublished: _datePublished,
        city: _selectedCity!,
        content: jsonEncode(_quillController.document.toDelta().toJson()),
        tags: _tagsController.getTags!,
      );
      Modular.to.pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _futureArticle = article_services.getArticle(widget.articleId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _quillController.dispose();
    _datePublishedController.dispose();
    _tagsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      actions: [
        IconButton(
          onPressed: () => _updateArticle(),
          icon: const Icon(Icons.save),
        )
      ],
      body: FutureBuilder(
        future: _futureArticle,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final article = snapshot.data!.data()!;
            _titleController.text = article.title;
            _quillController.document =
                Document.fromJson(jsonDecode(article.content));
            _datePublished = article.datePublished;
            _datePublishedController.text =
                intl.DateFormat.yMd().add_Hm().format(_datePublished);
            _selectedCity = article.city;
            _initialTags = List<String>.from(article.tags);
            return _buildPage(snapshot.data!.data()!);
          }
        },
      ),
    );
  }

  Widget _buildPage(ArticleModel article) {
    return Form(
      child: ListView(
        children: [
          Material(
            child: InkWell(
              child: Ink.image(
                height: 180,
                width: 360,
                image: NetworkImage(article.coverImageUrl),
                fit: BoxFit.cover,
              ),
              onTap: () async {
                await _pickImage(ImageSource.gallery);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Judul Artikel",
                hintStyle: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              textInputAction: TextInputAction.next,
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
            child: Row(
              children: [
                const Text("Tanggal Publikasi: ",
                    style: TextStyle(fontFamily: "Inter", fontSize: 16.0)),
                Expanded(
                  child: TextFormField(
                    controller: _datePublishedController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () => _selectDate(),
                        icon: const Icon(Icons.calendar_today),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
            child: Row(
              children: [
                const Text("Kota: ",
                    style: TextStyle(fontFamily: "Inter", fontSize: 16.0)),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCity,
                    isDense: false,
                    iconSize: 0.0,
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    onChanged: (String? value) {
                      setState(
                        () {
                          _selectedCity = value!;
                        },
                      );
                    },
                    items: cityList.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16.0,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
            child: TagsField(
              tagsController: _tagsController,
              distanceToField: _distanceToField,
              initialTags: _initialTags,
              validator: (String tags) {
                if (_tagsController.getTags!.contains(tags)) {
                  _showErrorSnackBar("Tag sudah ada");
                  return "";
                }
                return null;
              },
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                controller: _quillController,
                sharedConfigurations: const QuillSharedConfigurations(
                  locale: Locale('id'),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  scrollable: false,
                  controller: _quillController,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('id'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
