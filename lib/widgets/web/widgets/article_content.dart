import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:jatimtour/models/article.dart';

class ArticleReg extends StatefulWidget {
  final Article? article;
  final TextEditingController textController;

  const ArticleReg({
    Key? key,
    required this.article,
    required this.textController,
  }) : super(key: key);

  @override
  State<ArticleReg> createState() => _ArticleRegState();
}

class _ArticleRegState extends State<ArticleReg> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController hashtagsController = TextEditingController();
  TextEditingController headerUrlController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.article != null) {
      final article = widget.article!;
      titleController.text = article.title;
      contentController.text = article.content;
      cityController.text = article.city;
      hashtagsController.text = article.hashtags;
      headerUrlController.text = article.headerUrl;
      dateController.text = DateFormat('dd-MM-yyyy').format(article.date);
    }
  }

  File? _pickedImage;

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage =
            File(pickedFile.path); // Store the picked image as a File object
      });
    }
  }

  String? _selectedCity;
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  @override
  void dispose() {
    hashtagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Buat Artikel',
          style: TextStyle(color: Color.fromARGB(255, 193, 181, 201)),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: _pickedImage != null
                            ? DecorationImage(
                                image: FileImage(
                                    _pickedImage!), // Assuming _pickedImage is a File
                                fit: BoxFit.cover,
                              )
                            : null, // If _pickedImage is null, don't show any image
                      ),
                    ),
                    Positioned(
                      top: 100,
                      bottom: 100,
                      right: 250,
                      left: 250,
                      child: ElevatedButton(
                        onPressed: _pickImage,
                        child: Text(
                          'Tambah Gambar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: dateController,
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
                          decoration: InputDecoration(
                            hintText: 'Tanggal Event',
                            hintStyle:
                                TextStyle(fontSize: 12, color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      DropdownButton<String>(
                        hint: Text(_selectedCity ?? 'Kota'),
                        value: _selectedCity,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedCity = value;
                          });
                        },
                        items: <String>[
                          'BANGKALAN',
                          'BANYUWANGI',
                          'BATU',
                          'BLITAR',
                          'BOJONEGORO',
                          'BONDOWOSO',
                          'GRESIK',
                          'JEMBER',
                          'JOMBANG',
                          'KEDIRI',
                          'PAMENANG',
                          'LAMONGAN',
                          'LUMAJANG',
                          'MADIUN',
                          'MAGETAN',
                          'MALANG',
                          'MOJOKERTO',
                          'NGANJUK',
                          'NGAWI',
                          'PACITAN',
                          'PAMEKASAN',
                          'PASURUAN',
                          'PONOROGO',
                          'PROBOLINGGO',
                          'SAMPANG',
                          'SIDOARJO',
                          'SITUBONDO',
                          'SUMENEP',
                          'TRENGGALEK',
                          'TUBAN',
                          'TULUNGAGUNG',
                          'SURABAYA'
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            );
                          },
                        ).toList(),
                        underline: Container(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Positioned(
                    right: 250,
                    left: 250,
                    child: TextField(
                      controller: titleController,
                      maxLength: 100,
                      decoration: const InputDecoration(
                        hintText: 'Judul Artikel Anda',
                        hintStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: contentController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Tulis Artikel Anda....',
                        hintStyle: TextStyle(fontSize: 20),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: hashtagsController,
                      maxLength: 300,
                      decoration: const InputDecoration(
                        hintText: 'Ketik hashtags Anda ... ',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String headerUrl = headerUrlController.text.trim();
                      String city = _selectedCity ?? '';
                      DateTime date = _selectedDate ?? DateTime.now();
                      String title = titleController.text.trim();
                      String content = contentController.text.trim();
                      String hashtags = hashtagsController.text.trim();
                      if (title.isNotEmpty &&
                          city.isNotEmpty &&
                          content.isNotEmpty &&
                          hashtags.isNotEmpty) {
                        if (widget.article != null) {
                          Article updatedArticle = Article(
                            title: title,
                            content: content,
                            date: date,
                            city: city,
                            hashtags: hashtags,
                            headerUrl: headerUrl,
                          );
                          Navigator.pop(context, updatedArticle);
                        } else {
                          Article newArticle = Article(
                            title: title,
                            content: content,
                            date: date,
                            city: city,
                            hashtags: hashtags,
                            headerUrl: headerUrl,
                          );
                          Navigator.pop(context, newArticle);
                        }
                      }
                    },
                    child: const Text('Save'),
                  ),
                  const SizedBox(height: 15),
                ],
              )),
        ),
      ),
    );
  }
}
