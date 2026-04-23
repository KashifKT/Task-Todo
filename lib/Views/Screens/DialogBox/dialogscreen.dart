
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Utils/utilsDialogBox.dart';
import 'package:todo_app/Views/Screens/Form%20Pages/logoutalert.dart';
import 'package:todo_app/Views/Screens/Task%20Screens/task_detail_page.dart';
import '../../../Controls/task_provider.dart';
import '../../../Models/taskModel.dart';
import '../../../Utils/utilsCirInd.dart';
import 'dialogAppear.dart';

enum TaskSortOption { recent, ascending, descending }

class DialogScreen extends StatefulWidget {
  const DialogScreen({super.key});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  bool _isLoading = true;
  bool _isSearching = false;
  String _searchQuery = "";
  TextEditingController _searchController = TextEditingController();
  TaskSortOption _selectedSort = TaskSortOption.recent;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      setState(() => _isLoading = true);
      await Provider.of<TaskProvider>(context, listen: false).loadTasks();
    } catch (e) {
      debugPrint('Error loading tasks: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepOrange,
      shadowColor: Colors.black,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      leading: Scaffold.of(context).hasDrawer
          ? IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      )
          : null,
      title: _isSearching
          ? TextField(
        controller: _searchController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Search tasks...',
          border: InputBorder.none,
          isDense: true,
        ),
        onChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
      )
          : const Text(
        "My Tasks",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        _isSearching
            ? IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchQuery = "";
              _searchController.clear();
            });
          },
        )
            : IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
        PopupMenuButton<TaskSortOption>(
          icon: const Icon(Icons.filter_alt),
          onSelected: (option) {
            setState(() {
              _selectedSort = option;
            });
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: TaskSortOption.recent,
              child: Text("Recently Added"),
            ),
            const PopupMenuItem(
              value: TaskSortOption.ascending,
              child: Text("Search by Ascending"),
            ),
            const PopupMenuItem(
              value: TaskSortOption.descending,
              child: Text("Search by Descending"),
            ),
          ],
        ),
      ],
      elevation: 10,
    );
  }

  List<TaskModel> _filterAndSortTasks(List<TaskModel> tasks) {
    List<TaskModel> filtered = tasks
        .where((task) =>
        task.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    switch (_selectedSort) {
      case TaskSortOption.recent:
        filtered.sort((a, b) =>
            (b.createdAt ?? DateTime.now()).compareTo(a.createdAt ?? DateTime.now()));
        break;
      case TaskSortOption.ascending:
        filtered.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case TaskSortOption.descending:
        filtered.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = _filterAndSortTasks(taskProvider.tasks);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange),
              child: Text("Menu", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      appBar: _buildAppBar(context),
      body: _isLoading
          ? Center(child: crlInd())
          : tasks.isEmpty
          ? const Center(child: Text("No Task Yet"))
          : RefreshIndicator(
        color: Colors.deepOrange,
        onRefresh: _loadTasks,
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskDetailPage(index: index, task: task)));
              },
              child: Card(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: task.imageUrl != null
                      ? CircleAvatar(
                    backgroundImage: NetworkImage(task.imageUrl!),
                  )
                      : const CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.task, color: Colors.white),
                  ),
                  title: Text(
                    task.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(task.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green,
                          semanticLabel: 'Update',),
                        onPressed: () => DialogAppeare().showupdateDialog(
                            context, index, task),
                      ),
                      IconButton(onPressed: (){
                        iconDelBtn(context, index);
                      }, icon: Icon(Icons.delete, color: Colors.deepOrange, semanticLabel: 'Delete',))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepOrange,
        splashColor: Colors.orangeAccent,
        onPressed: () => DialogAppeare().showaddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
