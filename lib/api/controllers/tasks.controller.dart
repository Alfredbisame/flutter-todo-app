import 'package:bloc_todo/api/repositories/repository.dart';
import 'package:bloc_todo/dtos/http.request.dto.dart';
import 'package:bloc_todo/dtos/paged.results.dto.dart';
import 'package:bloc_todo/models/task.dart';
import 'package:get/get.dart';

import '../../components/response.modal.dart';
import '../../enums/dialog.variants.dart';

class TasksController extends GetxController {
  final Repository repository;
  TasksController({required this.repository});

  //variables;
  var totalCount = 0;
  var totalPages = 0;
  var pageSize = 10;
  var page = 0;
  var loading = false;
  List<Task> tasks = [];

  //handle get tasks
  Future<void> getTasks({int pageIndex = 0}) async {
    try {
      loading = true;
      update();
      var authUser = await repository.getAuthUser();

      var request = HttpRequestDto(
        "/api/tasks",
        token: authUser?.token,
        params: {
          "page": "${pageIndex + 1}",
          "pageSize": "$pageSize",
          // "status": "Pending",
        },
      );
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(
          ResponseModal(message: res.message, variant: DialogVariant.Error),
        );
      }
      var data = PagedResults.fromJson(res.data, Task.fromJson);
      if (pageIndex == 0) {
        tasks = data.results;
      } else {
        tasks.addAll(data.results);
      }
      totalCount = data.totalCount;
      totalPages = data.totalPages;
      page = data.page;
      pageSize = data.pageSize;
      loading = false;
      update();
    } catch (e) {
      loading = false;
      update();
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      Get.dialog(
        ResponseModal(
          message: "Sorry, an error occurred",
          variant: DialogVariant.Error,
        ),
      );
    }
  }
}
