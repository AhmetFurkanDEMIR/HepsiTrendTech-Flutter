import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rest_api/service/service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({super.key});

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  Uint8List? image;
  bool processControlVariable = false;
  List? galleryData;
  String? selectedGender;
  selectImageFunc(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              'Fotoğraf Seç',
            ),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: const Text(
                  'Kamerayı Aç',
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  XFile? file =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (file != null) {
                    image = await file.readAsBytes();
                    setState(() {});
                  }
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: const Text(
                  'Galeriden Seç',
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  XFile? file = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (file != null) {
                    image = await file.readAsBytes();
                    setState(() {});
                  }
                },
              ),
            ],
          );
        });
  }

  void uploadImage(Uint8List image) async {
    if (selectedGender != null) {
      setState(() {
        processControlVariable = true;
      });
      final data = await Service().uploadImage(image, selectedGender!);
      data!.removeAt(0);
      try {
        log(data[0].toString());
      } catch (e) {
        log('error: ' + e.toString());
      }
      setState(() {
        galleryData = data;
      });
      setState(() {
        processControlVariable = false;
      });
      setState(() {});
    }
  }

  void _launchUrl(String url) async {
    final Uri _url = await Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: processControlVariable == false && galleryData == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: image != null,
                        child: Container(
                          width: 200,
                          height: 200,
                          child: image != null
                              ? Image.memory(image!)
                              : const Placeholder(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 52.0, vertical: 10.0),
                        child: MaterialButton(
                          height: MediaQuery.of(context).size.height * 0.1,
                          onPressed: () {
                            if (image == null) {
                              selectImageFunc(context);
                            } else {
                              setState(() {
                                image = null;
                              });
                            }
                          },
                          color: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              image == null
                                  ? const Text(
                                      "Resim seç ",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : const Text(
                                      "Resmi temizle",
                                      style: TextStyle(color: Colors.white),
                                    ),
                              // const Icon(Icons.photo_size_select_actual_outlined, color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: image != null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 52.0, vertical: 10.0),
                          child: MaterialButton(
                            height: MediaQuery.of(context).size.height * 0.1,
                            onPressed: () => uploadImage(image!),
                            color: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  "Ara  ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.image_search,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: image != null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 52.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListTile(
                                title: const Text('Erkek'),
                                leading: Radio(
                                  value: '0',
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = '0';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Kadın'),
                                leading: Radio(
                                  value: '1',
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = '1';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : processControlVariable == false && galleryData != null
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: galleryData?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final imageUrl = galleryData?[index]['img_url'];
                          final productUrl = galleryData?[index]['pr_url'];

                          return GestureDetector(
                            onTap: () {
                              _launchUrl(galleryData?[index]['pr_url']);
                              log(galleryData?[index]['pr_url']);
                            },
                            child: GridTile(
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                              footer: GridTileBar(
                                backgroundColor: Colors.black45,
                                title: Text(galleryData?[index]['pr_price']),
                                subtitle: Text(galleryData?[index]['pr_name']),
                              ),
                            ),
                          );
                        },
                      )
                    : const CircularProgressIndicator(
                        color: Color.fromARGB(255, 225, 113, 15),
                      )),
        floatingActionButton: Visibility(
          visible: processControlVariable == false && galleryData != null,
          child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  galleryData = null;
                  image = null;
                });
                setState(() {});
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Icon(Icons.cleaning_services)),
        ),
      ),
    );
  }
}
