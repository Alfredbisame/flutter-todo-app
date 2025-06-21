import 'package:bloc_todo/components/custom.dropdown.dart';
import 'package:bloc_todo/components/custom.input.dart';
import 'package:bloc_todo/components/custom.time.picker.dart';
import 'package:bloc_todo/components/primary.button.dart';
import 'package:bloc_todo/models/task_model.dart';
import 'package:bloc_todo/services/task_service.dart';
import 'package:bloc_todo/theme/app.colors.dart';
import 'package:bloc_todo/utils/dimensions.dart';
import 'package:bloc_todo/utils/utilities.dart';
import 'package:bloc_todo/views/app.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/custom.date.picker.dart';

class TaskCreateScreen extends StatefulWidget {
  const TaskCreateScreen({super.key});

  @override
  State<TaskCreateScreen> createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskService = TaskService();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? selectedTime;
  String? selectedDate;
  DateTime? taskDate;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createTask() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    if (taskDate == null || selectedTime == null) {
      setState(() {
        _errorMessage = "Please select both date and time";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final task = TaskModel(
        title: _titleController.text,
        description: _descriptionController.text,
        taskDate: taskDate!,
        taskTime: selectedTime!,
      );

      final success = await _taskService.createTask(task);

      if (success) {
        Get.snackbar(
          'Success',
          'Task created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back();
      } else {
        setState(() {
          _errorMessage = "Failed to create task. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppView(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.primaryColor,
                title: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "Create Task",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomInput(
                          label: "Title",
                          hintText: "Enter task title",
                          controller: _titleController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.height),
                        CustomInput(
                          label: "Description",
                          hintText: "Enter description here",
                          minLines: 2,
                          controller: _descriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.height),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomDatePicker(
                                label: "Date",
                                handleChange: (date) {
                                  if (date != null) {
                                    setState(() {
                                      taskDate = date;
                                      selectedDate =
                                          "${date.day}/${date.month}/${date.year}";
                                    });
                                  }
                                },
                                hintText: "Select date",
                                value: selectedDate,
                              ),
                            ),
                            SizedBox(width: 10.width),
                            Expanded(
                              child: CustomTimePicker(
                                label: "Time",
                                hintText: "Select time",
                                value: selectedTime,
                                handleChange: (time) {
                                  if (time != null) {
                                    setState(() {
                                      selectedTime = time.toFormattedString();
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.height),
                        CustomDropdown(
                          items: ["Personal", "Work", "Health", "Environment"],
                          selectedValue: "Personal",
                          onChanged: (String? val) {},
                          itemLabel: (String item) => item,
                        ),
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          title: _isLoading ? "Creating..." : "Create Task",
                          onPressed: _isLoading ? null : _createTask,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
