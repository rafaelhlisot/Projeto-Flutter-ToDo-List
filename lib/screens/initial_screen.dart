import 'package:flutter/material.dart';
import 'package:projeto/components/task.dart';
import 'package:projeto/data/task_dao.dart';
import 'package:projeto/data/task_inherited.dart';
import 'package:projeto/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  //bool opacity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 70,
        ),
        child: FutureBuilder<List<Task>>(
          future: TaskDao().findAll(),
          builder: (context, snapshot) {
            List<Task>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );

              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
              case ConnectionState.active:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Task tarefa = items[index];
                          return tarefa;
                        });
                  }
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // não implementado em vídeo por descuido meu, desculpem.
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // essa linha de layout deixa o conteudo totalmente centralizado.
                        children: const [
                          Icon(
                            Icons.error_outline,
                            size: 128,
                          ),
                          Text(
                            'Não há nenhuma Tarefa',
                            style: TextStyle(fontSize: 32),
                          ),
                        ],
                      ));
                }
                return const Text('Erro ao carregar tarefas');
            }
            return const Text('Erro desconhecido');
          }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // setState(() {
          //   opacity = !opacity;
          // });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(
                taskContext: context,
              ),
            ),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
