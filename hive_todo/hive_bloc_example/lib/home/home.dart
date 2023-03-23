import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_bloc_example/service/authentication_service.dart';
import 'package:hive_bloc_example/service/todo_services.dart';
import 'package:hive_bloc_example/todos/todos.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Example Hive")),
      body: BlocProvider(
        create: (context) => HomeBloc(
            RepositoryProvider.of<AuthenticationService>(context),
            RepositoryProvider.of<TodoServices>(context))
          ..add(RegisteringServiceEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessfullLoadedState) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TodosPage(username: state.username)));
              print("ini username ${jsonEncode(state.username.toString())}");
            }
            if (state is HomeInitial) {
              if (state.error != null) {
                showDialog(
                    context: context,
                    builder: ((context) => AlertDialog(
                        title: const Text("Error"),
                        content: Text(state.error.toString()))));
              }
            }
          },
          builder: (context, state) {
            return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is HomeInitial) {
                return Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          label: Text("Username"),
                          hintText: "Masukkan Username"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: "Masukkan Password",
                        label: Text("Username"),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              context.read<HomeBloc>().add(LoginEvent(
                                  usernameController.text,
                                  passwordController.text));
                            },
                            child: const Text("Login")),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            onPressed: () {
                              context.read<HomeBloc>().add(RegisterAccountEvent(
                                  usernameController.text,
                                  passwordController.text));
                            },
                            child: const Text("Register"))
                      ],
                    )
                  ],
                );
              }

              return Container();
            });
          },
        ),
      ),
    );
  }
}
