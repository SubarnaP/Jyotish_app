import 'package:flutter/material.dart';

class KundaliFormScreen extends StatefulWidget {
  final String? initialName;
  final DateTime? initialDate;

  const KundaliFormScreen({
    super.key,
    this.initialName,
    this.initialDate,
  });

  @override
  State<KundaliFormScreen> createState() => _KundaliFormScreenState();
}

class _KundaliFormScreenState extends State<KundaliFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _placeController = TextEditingController();
  DateTime? _dateOfBirth;
  TimeOfDay? _timeOfBirth;
  String? _selectedZodiacSign;

  final List<String> _zodiacSigns = [
    'Aries', 'Taurus', 'Gemini', 'Cancer',
    'Leo', 'Virgo', 'Libra', 'Scorpio',
    'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialName != null) {
      _nameController.text = widget.initialName!;
    }
    if (widget.initialDate != null) {
      _dateOfBirth = widget.initialDate;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _timeOfBirth ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _timeOfBirth) {
      setState(() {
        _timeOfBirth = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Print form data to console
      print('''
        Name: ${_nameController.text}
        Date of Birth: ${_dateOfBirth?.toString() ?? 'Not selected'}
        Time of Birth: ${_timeOfBirth?.format(context) ?? 'Not selected'}
        Place: ${_placeController.text}
        Zodiac Sign: $_selectedZodiacSign
      ''');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kundali Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(_dateOfBirth == null
                    ? 'Select Date of Birth'
                    : 'Date: ${_dateOfBirth?.toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: Theme.of(context).dividerColor),
                ),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(_timeOfBirth == null
                    ? 'Select Time of Birth'
                    : 'Time: ${_timeOfBirth?.format(context)}'),
                trailing: const Icon(Icons.access_time),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: Theme.of(context).dividerColor),
                ),
                onTap: () => _selectTime(context),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _placeController,
                decoration: const InputDecoration(
                  labelText: 'Place of Birth',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter birth place' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedZodiacSign,
                decoration: const InputDecoration(
                  labelText: 'Zodiac Sign',
                  border: OutlineInputBorder(),
                ),
                items: _zodiacSigns.map((String sign) {
                  return DropdownMenuItem<String>(
                    value: sign,
                    child: Text(sign),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedZodiacSign = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select your zodiac sign' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Generate Kundali'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
