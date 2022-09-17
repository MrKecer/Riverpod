import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student/models/students/students.dart';
import 'package:student/service/service.dart';

class StudnetAdd extends ConsumerStatefulWidget {
  const StudnetAdd({super.key});

  @override
  ConsumerState<StudnetAdd> createState() => _StudnetAddState();
}

class _StudnetAddState extends ConsumerState<StudnetAdd> {
  final _formkey = GlobalKey<FormState>();
  final Map<String, dynamic> addStudents = {};

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Öğrenci Ekle"),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Öğrenci Bilgileri", textScaleFactor: 1.7),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 70,
                    child: TextFormField(
                      onSaved: (newValue) {
                        addStudents["name"] = newValue;
                        print("kaydedildi");
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Değer boş";
                        }
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(),
                          labelText: "Ad"),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 70,
                    child: TextFormField(
                      onSaved: (newValue) {
                        addStudents["surname"] = newValue;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Değer boş";
                        }
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(),
                          labelText: "Soyad"),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 70,
                    child: TextFormField(
                      onSaved: (newValue) {
                        addStudents["age"] = int.parse(newValue!);
                      },
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Lütfen geçerli bir değer giriniz.";
                        }
                        if (int.tryParse(value) == null) {
                          return "Sayılarla yaş giriniz";
                        }
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(),
                          labelText: "Yaş"),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      hint: const Text("Cinsiyet Seçiniz"),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      items: const [
                        DropdownMenuItem(
                          value: "woman",
                          child: Text("Kadın"),
                        ),
                        DropdownMenuItem(
                          value: "man",
                          child: Text("Erkek"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          addStudents["gender"] = value;
                        });
                      },
                      validator: (value) {
                        if (value?.isEmpty != false) {
                          return "Değer boş";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: isLoading
              ? null
              : () async {
                  final formState = _formkey.currentState;
                  if (formState == null) {
                    return;
                  }
                  if (formState.validate() == true) {
                    formState.save();
                  }

                  try {
                    setState(() {
                      isLoading = true;
                    });

                    await ref
                        .read(dataServiceProvider)
                        .studentAdd(Students.fromJson(addStudents));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
          child: const Icon(Icons.add)),
    );
  }
}
