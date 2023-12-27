import 'package:flutter/material.dart';
import '../../../models/patient/patient.dart';
import 'patient_detail_screen.dart';
import '../patient_general_information_manager.dart';
import '../patient_manager.dart';
import '../../provinces/provinces_manager.dart';
import 'package:provider/provider.dart';
import '../../shared/dialog_utils.dart';
import '../../../models/patient/patient_general_information.dart';
import '../../../models/provinces/province.dart';
import '../../../models/provinces/district.dart';
import '../../../models/provinces/ward.dart';
import 'package:intl/intl.dart';

class PatientEditScreen extends StatefulWidget {
  static const routeName = '/edit-patient';

  final Patient patient;
  const PatientEditScreen(this.patient,{super.key});

  @override
  State<PatientEditScreen> createState() => _PatientEditScreenState();
}

class _PatientEditScreenState extends State<PatientEditScreen> {
  final _editForm = GlobalKey<FormState>();
  late Patient _editedPatient;
  var _isLoading = false;
  bool _hasInitialized = false;
  DateTime? _selectedDate;
  String? _selectedGender = 'Nam';




  String noResult = "";


  Province? _selectedProvince;
  District? _selectedDistrict;
  Ward? _selectedWard;




  List<Province> _allProvinces = [];

  @override
  void initState() {
    _editedPatient = widget.patient;
    context.read<ProvincesManager>().fetchAllProvinces();
    final addressParts = _editedPatient.address.split(" ; ");
    if (noResult == "") {
      noResult = addressParts[0];
    }

    super.initState();
  }



  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });


    try {
      if (_editedPatient.id != null) {
        final provinceResult = context.read<ProvincesManager>().selectedProvince;
        final districtResult = context.read<ProvincesManager>().selectedDistrict;
        final wardResult = context.read<ProvincesManager>().selectedWard;
        String? newAddress = generatNewAddress(provinceResult, districtResult, wardResult, noResult);
        print("updating");
        _editedPatient = _editedPatient.copyWith(address: newAddress);
        print(newAddress);
        print(_editedPatient.address);
        await context.read<PatientManager>().editPatient(_editedPatient);

      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong');

    }



    setState(() {
      _isLoading = false;
    });

    if (mounted) {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientDetailScreen(_editedPatient.id)));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cập nhật thông tin thành công'),
        ),
      );
    }
  }


  //validate



  String? _validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Chưa chọn giới tính';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasInitialized) {
      return FutureBuilder<void>(
        future: context.read<ProvincesManager>().initForUpdateProvince(_editedPatient.address),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _hasInitialized = true;
            return Consumer<ProvincesManager>(
                builder: (context, provincesManager, child) {
                  _selectedProvince = provincesManager.selectedProvince;
                  _selectedDistrict = provincesManager.selectedDistrict;
                  _selectedWard = provincesManager.selectedWard;
                  _allProvinces = provincesManager.allProvinces;
                  return Scaffold(
                    appBar: AppBar(
                        title: const Text('Chỉnh sửa thông tin'),
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                              PatientDetailScreen.routeName,
                              arguments: widget.patient.id,
                            );
                          },
                        ),

                    ),
                    body: _isLoading
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _editForm,
                        child: ListView(
                          children: <Widget>[
                            buildFullNameField(),
                            buildDateOfBirthField(),
                            buildGenderField(),
                            buildProvinceField(_allProvinces, _selectedProvince),
                            buildDistrictField(_selectedDistrict),
                            buildWardsField(_selectedWard),
                            buildNoField(),
                            const SizedBox(height: 20,),
                            saveInformationButton(),
                          ],
                        ),
                      ),
                    ),
                  );
                });

          } else {
            return Scaffold(
                appBar: AppBar(
                    title: const Text('Chỉnh sửa thông tin'),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          PatientDetailScreen.routeName,
                          arguments: widget.patient.id,
                        );
                      },
                    ),

                ),
                body:  const Center(
                  child: CircularProgressIndicator(),
                )
            );
          }
        },
      );
    }
    return Consumer<ProvincesManager>(
        builder: (context, provincesManager, child) {
          _selectedProvince = provincesManager.selectedProvince;
          _selectedDistrict = provincesManager.selectedDistrict;
          _selectedWard = provincesManager.selectedWard;
          _allProvinces = provincesManager.allProvinces;
          return Scaffold(
            appBar: AppBar(
                title: const Text('Chỉnh sửa thông tin'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      PatientDetailScreen.routeName,
                      arguments: widget.patient.id,
                    );
                  },
                ),

            ),
            body: _isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    buildFullNameField(),
                    buildDateOfBirthField(),
                    buildGenderField(),
                    buildProvinceField(context.select<ProvincesManager, List<Province>>((provincesManager) => provincesManager.allProvinces), _selectedProvince),
                    buildDistrictField(_selectedDistrict),
                    buildWardsField(_selectedWard),
                    buildNoField(),
                    const SizedBox(height: 20,),
                    saveInformationButton(),
                  ],
                ),
              ),
            ),
          );
        });
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  TextFormField buildFullNameField() {
    return TextFormField(
        initialValue: _editedPatient.fullName,
        decoration: const InputDecoration(
            labelText: 'Họ và tên'
        ),
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator:(value) {
          if (value!.isEmpty) {
            return 'Vui lòng nhập họ tên.';
          }
          return null;
        },
        onSaved: (value) {
          _editedPatient = _editedPatient.copyWith(fullName: value);
        }
    );
  }


  String? _validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng chọn ngày sinh.';
    }
    final selectedDate = DateTime.tryParse(value);
    if (selectedDate == null) {
      return 'Sai định dạng ngày (yyyy-MM-dd).';
    }
    final currentDate = DateTime.now();
    if (selectedDate.isAfter(currentDate)) {
      return 'Ngày sinh không lớn hơn ngày hiện tại.';
    }
    return null;
  }


  TextFormField buildDateOfBirthField() {
    String? initialDateText;
    if (_editedPatient.dateOfBirth != null) {
      initialDateText = DateFormat('yyyy-MM-dd').format(_editedPatient.dateOfBirth!);
    }
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Ngày sinh'),
      readOnly: true,
      onTap: () => _selectDate(context),
      controller: TextEditingController(
        text: _selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
            : initialDateText ?? '',
      ),
      validator: _validateDateOfBirth,
      onSaved: (value) {
        _editedPatient = _editedPatient.copyWith(dateOfBirth: _selectedDate);
      },
    );
  }

  final List<String> _genderOptions = ['Nam', 'Nữ'];

  String _genderValueToString(int value) {
    return _genderOptions[value];
  }

  int _genderStringToValue(String? gender) {
    return _genderOptions.indexOf(gender ?? "Nam");
  }
  DropdownButtonFormField<String> buildGenderField() {
    if (_editedPatient.gender == 0 || _editedPatient.gender == 1) {
       _selectedGender = _genderValueToString(_editedPatient.gender);
    }
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(labelText: 'Giới tính'),
      items: _genderOptions.map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          if (value == "Nam" || value == "Nữ") {
            _selectedGender = value;
          } else {
            _selectedGender = "Nam";
          }
          _editedPatient = _editedPatient.copyWith(gender: _genderStringToValue(_selectedGender));
        });
      },
      validator: _validateGender,

    );
  }





  DropdownButtonFormField<Province> buildProvinceField(List<Province> allProvinces, Province? selectedProvince) {

    if (allProvinces == null || allProvinces.isEmpty) {
      return DropdownButtonFormField<Province>(
        items: [],
        value: null,
        onChanged: (value) {
          print("error");
        }
      );
    }
    Province? sProvince = null;
    if (selectedProvince?.code != null || selectedProvince?.code != -1) {
      sProvince = allProvinces.firstWhere((element) => element.code == selectedProvince!.code, orElse: null);
    }
    // print(selectedProvince!.name);
    return DropdownButtonFormField<Province>(
      decoration: const InputDecoration(labelText: 'Tỉnh/ Thành phố'),
      items: allProvinces.map((province) {
        return DropdownMenuItem<Province>(
          value: province,
          child: Text(province.name),
        );
      }).toList(),
      value: sProvince ?? null,
      onChanged: (value){
            print("Đã thay đổi");
            print(value?.code);
            context.read<ProvincesManager>().setSelectedProvince(value);
            if (value != null) {
              context.read<ProvincesManager>().setSelectedDistrict(null);
              context.read<ProvincesManager>().setSelectedWard(null);
              context.read<ProvincesManager>().fetchDistrictsOfProvinces(value.code);
            }


      },
    );
  }
  late List<District> _districtOption;
  late List<Ward> _wardOption;


  DropdownButtonFormField<District> buildDistrictField(District? selectedDistrict) {
    final provincesManager = context.read<ProvincesManager>();
    _districtOption = provincesManager.districtsOption;
    print(_districtOption);
    if (_districtOption.isEmpty) {
      return DropdownButtonFormField<District>(
          decoration: const InputDecoration(labelText: 'Quận/ Huyện'),
          items: [],
          value: null,
          onChanged: (value) {
            print("error");
          }
      );
    }
    // print(selectedDistrict!.code);
    int? selectedIndex = 0;
    if (selectedDistrict != null) {
      selectedIndex = _districtOption.indexWhere((element) => element.code == selectedDistrict.code);
    }
    if (selectedIndex == -1) {
      selectedIndex = 0;
      context.read<ProvincesManager>().fetchWardsOfDistrictCode(_districtOption[0].code);
    }
    return DropdownButtonFormField<District>(
      decoration: const InputDecoration(labelText: 'Quận/ Huyện'),
      items: _districtOption.map((district) {
        return DropdownMenuItem<District>(
          value: district,
          child: Text(district.name),
        );
      }).toList(),
      value: _districtOption[selectedIndex],
      onChanged: (value) {

        context.read<ProvincesManager>().setSelectedDistrict(value);
        if (value != null) {
          context.read<ProvincesManager>().setSelectedWard(null);
          context.read<ProvincesManager>().fetchWardsOfDistrictCode(value.code);
        }


      },

      validator: _validateDistrict,
    );
  }


  String? _validateDistrict(District? value) {
    final districtData = context.read<ProvincesManager>().selectedDistrict;
    if (districtData == null) {
      return 'Chưa chọn quận/huyện';
    }
    return null;
  }

  DropdownButtonFormField<Ward> buildWardsField(Ward? selectedWard) {
    final provincesManager = context.read<ProvincesManager>();
    _wardOption = provincesManager.wardsOption;
    if (_wardOption.isEmpty) {
      return DropdownButtonFormField<Ward>(
          decoration: const InputDecoration(labelText: 'Phường/ Xã'),
          items: [],
          value: null,
          onChanged: (value) {
            print("error");
          }
      );
    }
    int? selectedIndex = 0;
    if (selectedWard != null) {
      // print("ward not null");
      selectedIndex = _wardOption.indexWhere((element) => element.code == selectedWard.code);
    }
    if (selectedIndex == -1) {
      // print("ward not found ward");
      selectedIndex = 0;
    }
    return DropdownButtonFormField<Ward>(
      decoration: const InputDecoration(labelText: 'Phường/ Xã'),
      items: _wardOption.map((ward) {
        return DropdownMenuItem<Ward>(
          value: ward,
          child: Text(ward.name),
        );
      }).toList(),
      value: _wardOption[selectedIndex],
      onChanged: (value) {

        context.read<ProvincesManager>().setSelectedWard(value);

      },

      validator: _validateWard,

    );
  }

  String? _validateWard(Ward? value) {
    final wardData = context.read<ProvincesManager>().selectedWard;
    if (wardData == null) {
      return 'Chưa chọn phường/xã';
    }
    return null;
  }

  String? generatNewAddress(Province? province, District? district, Ward? ward, String no) {
    if (province != null && district != null && ward != null && no != null) {
      return "$no ; ${ward.name} ; ${district.name} ; ${province.name}";
    }
    return null;
  }



  TextFormField buildNoField() {
    return TextFormField(
        initialValue: noResult,
        decoration: const InputDecoration(
            labelText: 'Địa chỉ'
        ),
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Vui lòng nhập địa chỉ.';
          }
          return null;
        },
        onSaved: (value) {
          noResult = value.toString();
        }
    );
  }

  Widget saveInformationButton() {
    return ElevatedButton(
      onPressed: _saveForm,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        primary: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.purple),
        ),
      ),
      child: Ink(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            alignment: Alignment.center,
            child: const Text("Lưu", style: TextStyle(color: Colors.purpleAccent)),
          )),
    );
  }
}
