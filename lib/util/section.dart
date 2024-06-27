import 'package:flutter/material.dart';
import 'package:salon_app/util/var.dart';

class ServiceCard extends StatelessWidget {
  final String desc, serviceName, image;

  const ServiceCard(
      {super.key,
      required this.serviceName,
      required this.desc,
      required this.image});

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(15),
      width: currentWidth / 1.4,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.orange[300],
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          // judul card
          Expanded(
              flex: 1,
              child: Text(
                serviceName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )),

          // isi card
          Expanded(
            flex: 5,
            child: Row(
              children: [
                // card description
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(15),
                  height: 170,
                  width: 2 * (currentWidth / 1.4 - 30) / 3,
                  child: Text(
                    desc,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),

                // service picture
                SizedBox(
                  height: 170,
                  width: (currentWidth / 1.4 - 30) / 3,
                  child: Image.asset(image),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FormSection extends StatefulWidget {
  final String text, hintText;
  final TextEditingController controller;

  const FormSection(
      {super.key,
      required this.text,
      required this.controller,
      required this.hintText});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: currentWidth / 2,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 0,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              color: Colors.black,
              width: 0.8,
            ),
          ),
          child: TextFormField(
            style: const TextStyle(fontSize: 15, color: Colors.black),
            controller: widget.controller,
            expands: false,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class DropDownServices extends StatefulWidget {
  Function(String?) selectedService;

  DropDownServices({super.key, required this.selectedService});

  @override
  State<DropDownServices> createState() => _DropDownServicesState();
}

class _DropDownServicesState extends State<DropDownServices> {
  String selectedItem = services[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Service',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownButton<String>(
          items: services.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedItem = newValue!;
            });
            widget.selectedService(selectedItem);
          },
          value: selectedItem,
          style: const TextStyle(fontSize: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          focusColor: Colors.orange,
          dropdownColor: Colors.orange[100],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}

class ReservedDateTime extends StatefulWidget {
  final TextEditingController controllerDate;
  Function(String?) selectedTime;

  ReservedDateTime({super.key, required this.controllerDate, required this.selectedTime});

  @override
  State<ReservedDateTime> createState() => _ReservedDateTimeState();
}

class _ReservedDateTimeState extends State<ReservedDateTime> {
  List<String> hours = [
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20'
  ];

  String valueHour = '9';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // for date picker
        const Text(
          'Select Date',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: widget.controllerDate,
          decoration: const InputDecoration(
            fillColor: Colors.orange,
            labelText: 'Date',
            labelStyle: TextStyle(color: Colors.black),
            filled: true,
            prefixIcon: Icon(
              Icons.calendar_today,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange)),
          ),
          readOnly: true,
          onTap: () {
            _selectDate();
          },
        ),
        const SizedBox(
          height: 10,
        ),
        // for time picker
        const Text(
          'Select Time',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownButton<String>(
          items: hours.map((hour) {
            return DropdownMenuItem(
              value: hour,
              child: Text('$hour:00 - ${(int.parse(hour) + 1)}:00'),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              valueHour = newValue!;
              widget.selectedTime('$valueHour:00:00');
            });
          },
          value: valueHour,
          style: const TextStyle(fontSize: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          focusColor: Colors.orange,
          dropdownColor: Colors.orange[100],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        )
      ],
    );
  }

  Future<void> _selectDate() async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (datePicked != null) {
      setState(() {
        widget.controllerDate.text = datePicked.toString().split(" ")[0];
      });
    }
  }
}
