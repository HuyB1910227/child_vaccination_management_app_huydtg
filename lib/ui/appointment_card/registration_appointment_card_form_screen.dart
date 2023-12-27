import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import '../../models/appointment_card/appointment_card.dart';
import '../../models/immunization_unit/immunization_unit.dart';
import 'appointment_card_manager.dart';
import '../immunization_unit/immunization_unit_detail/immunization_unit_detail_manager.dart';
import '../../models/patient/patient.dart';
import '../../models/patient/patient_general_information.dart';
import '../patient/patient_general_information_manager.dart';
import '../shared/dialog_utils.dart';
import 'package:provider/provider.dart';
import '../../models/appointment_card/appointment_prepare.dart';

class RegistrationAppointmentCardFormScreen extends StatefulWidget {
  static const routeName = '/user/registration-appointment-card';
  final AppointmentPrepare appointmentPrepare;

  const RegistrationAppointmentCardFormScreen(this.appointmentPrepare,
      {super.key});

  @override
  State<RegistrationAppointmentCardFormScreen> createState() =>
      _RegistrationAppointmentCardFormScreenState();
}

class _RegistrationAppointmentCardFormScreenState
    extends State<RegistrationAppointmentCardFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _isSubmitting = ValueNotifier<bool>(false);

  late PatientGeneralInformation _selectedPatientGeneralInformation;
  TimeOfDay? _selectedTime = TimeOfDay.now();
  late Future<void> _fetchPatients;
  late Future<ImmunizationUnit?> _fetchImmunizationUnit;
  List<PatientGeneralInformation> _listPatient = [];
  TimeOfDay minTimeToValidate = TimeOfDay.now();
  TimeOfDay maxTimeToValidate = TimeOfDay.now();
  late ImmunizationUnit _immunizationUnit;

  @override
  void initState() {

    minTimeToValidate = TimeOfDay(
        hour: widget.appointmentPrepare.workingCalendar.startTime.hour,
        minute: widget.appointmentPrepare.workingCalendar.startTime.minute);
    maxTimeToValidate = TimeOfDay(
        hour: widget.appointmentPrepare.workingCalendar.endTime.hour,
        minute: widget.appointmentPrepare.workingCalendar.endTime.minute);
    _fetchPatients = context
        .read<PatientGeneralInformationManager>()
        .fetchPatientGeneralInformation();

    super.initState();
    _fetchImmunizationUnit = context
        .read<ImmunizationUnitManager>()
        .fetchImmunizationUnitById(
            widget.appointmentPrepare.immunizationUnitId);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;


    try {
      DateTime appointmentDate = _generateAppointmentDate(_selectedTime!);
      Patient patient = Patient.fromPatientGeneralInformation(_selectedPatientGeneralInformation);
      AppointmentCard appointmentCard = AppointmentCard(
          id: 0,
          appointmentDate: appointmentDate,
          status: 0,
          patient: patient,
          immunizationUnit: _immunizationUnit);
      AppointmentCard? result = await context.read<AppointmentCardManager>().createAppointmentCard(appointmentCard);
      if (result != null) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gửi phiếu đăng ký thành công. Quý khách có thể xem lại các phiếu đăng ký ở Lịch trình tiêm chủng'),
          ),
        );
      } else {
        showErrorDialog(context,
            'Gửi đăng ký thất bại! Quý khách vui lòng kiểm tra kết nối mạng và thử lại sau.');
      }

    } catch (error) {
      print(error);
      showErrorDialog(context,
          'Gửi đăng ký thất bại! Quý khách vui lòng kiểm tra kết nối mạng và thử lại sau.');
    }
    _isSubmitting.value = false;
  }

  DateTime _generateAppointmentDate(TimeOfDay selectedTime) {
    DateTime selectedDate = widget.appointmentPrepare.workingCalendar.date;
    int hour = selectedTime.hour;
    int minute = selectedTime.minute;
    DateTime appointmentDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      hour,
      minute,
    );
    return appointmentDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Đăng ký tiêm chủng"),
        ),
        body: FutureBuilder(
          future: _fetchImmunizationUnit,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final immunizationUnit = snapshot.data as ImmunizationUnit;
              if (immunizationUnit != null) {
                _immunizationUnit = immunizationUnit;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              width: double.infinity,
                              color: Colors.purpleAccent,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      "CƠ SỞ TIÊM CHỦNG",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.local_hospital, color: Colors.white, size: 80,),
                                        Expanded(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(immunizationUnit.name, style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),),
                                            Text(immunizationUnit.address, style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),),
                                            Text(immunizationUnit.hotline, style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),),
                                          ],
                                        )),

                                      ],
                                    ),

                                  ]),
                            ),
                          ),
                        ),
                        buildDateField(),
                        buildAppointmentTimeField(),
                        Consumer<PatientGeneralInformationManager>(builder:
                            (context, patientGeneralInformationManager, child) {
                          _listPatient =
                              patientGeneralInformationManager.patients;
                          if (_listPatient.isNotEmpty)
                            return buildPatientField();
                          return const Text(
                              "Lỗi không tìm thấy thành viên! Vui lòng thử lại sau.");
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _isSubmitting,
                          builder: (context, isSubmitting, child) {
                            if (isSubmitting) {
                              return const CircularProgressIndicator();
                            }
                            return _buildSubmitButton();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: Text(
                  "Đã xảy ra lỗi! Quý khách vui lòng thử lại sau.",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  TextFormField buildDateField() {
    String initialDateText = DateFormat('yyyy-MM-dd')
        .format(widget.appointmentPrepare.workingCalendar.date);
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Đăng ký ngày hẹn: '),
      readOnly: true,
      controller: TextEditingController(text: initialDateText),
    );
  }

  TextFormField buildAppointmentTimeField() {
    String? initialDateText;
    initialDateText = TimeOfDay.now().format(context);
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Đăng ký thời gian: '),
      readOnly: true,
      onTap: () => _selectAppointmentTime(context),
      controller: TextEditingController(
        text: _selectedTime != null
            ? _selectedTime!.format(context)
            : initialDateText ?? '',
      ),
      validator: _validateAppointmentTime,
      onSaved: (value) {
        // _editedPatient = _editedPatient.copyWith(dateOfBirth: _selectedDate);
      },
    );
  }

  Future<void> _selectAppointmentTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        print("got _selectedTime");
      });
    }
  }

  String? _validateAppointmentTime(String? value) {
    if (_selectedTime == null) {
      return "Chưa nhập thời gian.";
    }
    var min = minTimeToValidate.hour + minTimeToValidate.minute / 60.0;
    var max = maxTimeToValidate.hour + maxTimeToValidate.minute / 60.0;

    var currentValue = _selectedTime!.hour + _selectedTime!.minute / 60.0;
    if (min > currentValue) {
      return "Thời gian hẹn tiêm không được nhỏ hơn: ${minTimeToValidate.format(context)}";
    }
    if (max < currentValue) {
      return "Thời gian hẹn tiêm không được lớn hơn: ${maxTimeToValidate.format(context)}";
    }
    return null;
  }

  DropdownButtonFormField<PatientGeneralInformation> buildPatientField() {
    return DropdownButtonFormField<PatientGeneralInformation>(
      decoration: const InputDecoration(labelText: 'Thành viên'),
      items: _listPatient.isNotEmpty
          ? _listPatient.map((PatientGeneralInformation patient) {
              return DropdownMenuItem<PatientGeneralInformation>(
                value: patient,
                child: Text(patient.fullName),
              );
            }).toList()
          : [],
      value: null,
      validator: (value) {
        if (value == null) {
          return "Chưa chọn thành viên cần đăng ký";
        }
        return null;
      },
      onChanged: (value) {
        _selectedPatientGeneralInformation = value!;
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        primary: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Colors.purple),
        ),
      ),
      child: Ink(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            alignment: Alignment.center,
            child: const Text("Đăng ký",
                style: TextStyle(color: Colors.purpleAccent)),
          )),
    );
  }
}
