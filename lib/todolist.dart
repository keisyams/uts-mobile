import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<Todo> {
  final List<TodoItem> _todoList = [];
  final TextEditingController _controller = TextEditingController();

  void _addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todoList.add(
          TodoItem(
            title: _controller.text,
            isCompleted: false,
            dateTime: DateTime.now(),
          ),
        );
        _controller.clear();
      });
    }
  }

  void _removeTodo(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  void _toggleTodo(int index) {
    setState(() {
      _todoList[index].isCompleted = !_todoList[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputSection(),
            const SizedBox(height: 20),
            Expanded(
              child: _todoList.isEmpty
                  ? Center(
                      child: Text(
                        'No tasks yet!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _todoList.length,
                      itemBuilder: (context, index) {
                        return _buildTodoItem(index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter task',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: _addTodo,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTodoItem(int index) {
    final todo = _todoList[index];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: () => _toggleTodo(index),
        leading: CircleAvatar(
          backgroundColor: todo.isCompleted ? Colors.green : Colors.grey,
          child: todo.isCompleted
              ? const Icon(Icons.check, color: Colors.white)
              : const Icon(Icons.check_box_outline_blank, color: Colors.white),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: todo.isCompleted ? Colors.grey : Colors.black,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _removeTodo(index),
        ),
      ),
    );
  }
}

class TodoItem {
  final String title;
  bool isCompleted;
  final DateTime dateTime;

  TodoItem({
    required this.title,
    required this.isCompleted,
    required this.dateTime,
  });
}
