import 'package:addresses_app/add_address_screen.dart';
import 'package:addresses_app/database_helper.dart';
import 'package:flutter/material.dart';

import 'address_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AddressModel> myAddresses = [];
  @override
  void initState() {
    fetchAddresses();
    super.initState();
  }

  Future<void> fetchAddresses() async {
    final addresses = await DatabaseHelper.instance.getAllAddresses();
    myAddresses = addresses;
    setState(() {});
  }

  Future<void> deleteAddresses(int id) async {
    await DatabaseHelper.instance.deleteAddress(id);
    fetchAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Addresses",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => const AddAddressScreen(),
                    ),
                  )
                  .then(
                    (value) => fetchAddresses(),
                  );
            },
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: const Icon(
                Icons.add_location_alt_outlined,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // TextFormField(
              //   onChanged: (value) {
              //     myAddresses = addresses
              //         .where(
              //           (element) => element.city!
              //               .toLowerCase()
              //               .contains(value.toLowerCase()),
              //         )
              //         .toList();
              //     setState(() {});
              //   },
              // ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle),
                                    child: const Icon(Icons.location_city,
                                        color: Colors.white, size: 40),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(myAddresses[index].name!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                        '${myAddresses[index].city!} - ${myAddresses[index].region!} \n ${myAddresses[index].note!}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade700)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddAddressScreen(
                                                        model:
                                                            myAddresses[index]),
                                              ),
                                            )
                                            .then(
                                              (value) => fetchAddresses(),
                                            );
                                      },
                                      child: Column(
                                        children: [
                                          Icon(Icons.edit_location_alt_outlined,
                                              color: Colors.grey.shade700),
                                          Text(
                                            'Edit',
                                            style: TextStyle(
                                                color: Colors.grey.shade700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Warning'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                    'Are you suer, you want to delete this address?'),
                                                Row(
                                                  children: [
                                                    MaterialButton(
                                                      shape: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .blue)),
                                                      minWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3.2,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      height: 50,
                                                      color: Colors.blue,
                                                      child: Text(
                                                          'cancel'
                                                              .toUpperCase(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                    ),
                                                    MaterialButton(
                                                      shape: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .blue)),
                                                      minWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3.2,
                                                      onPressed: () {
                                                        deleteAddresses(
                                                            myAddresses[index]
                                                                .id!);
                                                        Navigator.pop(context);
                                                      },
                                                      height: 50,
                                                      color: Colors.blue,
                                                      child: Text(
                                                          'delete'
                                                              .toUpperCase(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Column(
                                        children: [
                                          Icon(Icons.edit_location_alt_outlined,
                                              color: Colors.red),
                                          Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemCount: myAddresses.length),
              ),
            ],
          )),
    );
  }
}
