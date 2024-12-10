import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? location;
  final String? phoneNumber;
  final File? image; // Tambahkan parameter untuk gambar

  const EditProfilePage({
    super.key,
    this.firstName, // Optional parameter
    this.lastName, // Optional parameter
    this.location, // Optional parameter
    this.phoneNumber,
    this.image, // Inisialisasi parameter
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController locationController;
  late TextEditingController phoneNumberController;
  File? _image; // Variabel untuk menyimpan gambar profil

  final ImagePicker _picker = ImagePicker();
  final box = GetStorage();

  var selectedImagePath = ''.obs;
  var isImageLoading = false.obs;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    locationController = TextEditingController(text: widget.location);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
    _image = widget.image; // Set gambar dari halaman sebelumnya
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    locationController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  // Future<void> _pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path); // Set gambar yang dipilih
  //     });
  //   } else {
  //     print('object')
  // }

  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path); // Set the selected image
        });
        // Save image path in GetStorage
        box.write('profileImage', pickedFile.path);
      } else {
        print('No Image selected');
      }
    } catch (e) {
      print('Error Picking Image: $e');
    } finally {
      isImageLoading.value = false;
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path); // Set the captured image
        });
        // Save image path in GetStorage
        box.write('profileImage', pickedFile.path);
      } else {
        print('No Image captured');
      }
    } catch (e) {
      print('Error Capturing Image: $e');
    } finally {
      isImageLoading.value = false;
    }
  }

  // Fungsi untuk menampilkan pilihan sumber gambar
  Future<void> _showImageSourceSelection() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Ambil Foto Baru'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              "Edit Profile",
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'WorkSans',
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            ClipOval(
              child: _image != null
                  ? Image.file(
                      _image!,
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      'assets/img/svg/profile.svg',
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.firstName ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  widget.lastName ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: _showImageSourceSelection, // Panggil fungsi pemilih gambar
              child: Text(
                "Change Your Photo Profile",
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 150, 231),
                  fontFamily: 'WorkSans',
                  fontSize: 10,
                ),
              ),
            ),
            SizedBox(height: 20),
            buildTextField("First Name", firstNameController),
            buildTextField("Last Name", lastNameController),
            buildTextField("Location", locationController),
            buildTextField("Phone Number", phoneNumberController),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 43,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 15, 133, 29),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                onPressed: () {
                  // Kirim data yang diubah ke halaman ProfilePage
                  Navigator.pop(context, {
                    'firstName': firstNameController.text,
                    'lastName': lastNameController.text,
                    'location': locationController.text,
                    'phoneNumber': phoneNumberController.text,
                    'image': _image // Kirim gambar profil baru
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed("/home");
                  },
                  child: Text(
                    "Save Changes",
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
