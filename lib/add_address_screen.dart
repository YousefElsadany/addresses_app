import 'package:addresses_app/address_model.dart';
import 'package:addresses_app/database_helper.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressModel? model;
  const AddAddressScreen({super.key, this.model});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  @override
  void initState() {
    nameController.text = widget.model == null ? '' : widget.model!.name!;
    cityController.text = widget.model == null ? '' : widget.model!.city!;
    regionController.text = widget.model == null ? '' : widget.model!.region!;
    noteController.text = widget.model == null ? '' : widget.model!.note!;
    super.initState();
  }

  Future<void> saveAddress() async {
    final address = AddressModel(
        id: widget.model?.id,
        name: nameController.text,
        city: cityController.text,
        region: regionController.text,
        note: noteController.text);
    if (widget.model == null) {
      await DatabaseHelper.instance.insertAddress(address);
    } else {
      await DatabaseHelper.instance.updateAddress(address);
    }
    Navigator.pop(context);
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: Text(
          widget.model == null ? 'Add New Address' : 'Edit Address',
          style: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "cancel".toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              textFieldWidget(
                  title: 'Name',
                  hintText: 'Example " My Location "',
                  icon: Icons.business_outlined,
                  controller: nameController),
              const SizedBox(height: 20),
              textFieldWidget(
                  title: 'City',
                  hintText: 'Example " Cairo "',
                  icon: Icons.location_city,
                  controller: cityController),
              const SizedBox(height: 20),
              textFieldWidget(
                  title: 'Region',
                  hintText: 'Example " Nasr City "',
                  icon: Icons.location_city,
                  controller: regionController),
              const SizedBox(height: 20),
              textFieldWidget(
                  title: 'Note',
                  hintText: 'Ente Note',
                  isNote: true,
                  maxLines: 8,
                  controller: noteController),
              const SizedBox(height: 60),
              MaterialButton(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.blue)),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    // );
                    saveAddress();
                  }
                },
                height: 50,
                color: Colors.blue,
                child: Text('Save'.toUpperCase(),
                    style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textFieldWidget(
    {required String title,
    required String hintText,
    int? maxLines,
    required TextEditingController controller,
    bool isNote = false,
    IconData? icon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 10),
      TextFormField(
        controller: controller,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        keyboardType: TextInputType.text,
        maxLines: maxLines,
        validator: isNote == true
            ? null
            : (value) {
                if (value!.isEmpty) {
                  return '$title is requird';
                }
                return null;
              },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon:
              icon == null ? null : Icon(icon, color: Colors.grey.shade500),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
      ),
    ],
  );
}
