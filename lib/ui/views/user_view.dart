import 'package:flutter/material.dart';
import '../viewmodels/user_viewmodel.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final UserViewModel _viewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User View'),
      ),
      body: const Center(
        child: Text('User View'),
      ),
    );
  }
}
