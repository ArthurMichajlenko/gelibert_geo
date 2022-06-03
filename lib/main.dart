import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelibert_geo/api.dart';
import 'package:gelibert_geo/models/request_data.dart';
import 'package:gelibert_geo/providers/couriers.dart';

import 'models/courier.dart';

Future<void> main() async {
  final api = Api(
    serverURL: "10.10.11.156",
    // serverURL: "188.237.114.90",
    serverPort: 1323,
    user: "admin",
  );
  var t = await api.getToken();
  api.token = t;
  runApp(const ProviderScope(child: MyApp()));
}

// final couriersProvider = FutureProvider<List<Courier>>((ref) async {
//   final api = Api();
//   final content = await http.get(Uri.parse('http://${api.serverURL}:${api.serverPort}/data/all_couriers'), headers: {
//     HttpHeaders.authorizationHeader: "Bearer ${api.token}",
//   });
//   return couriersFromJSON(content.body);
// });

final reqDataProvider = StateProvider<RequestData>((ref) => RequestData());

final counterStateProvider = StateProvider<int>((ref) => 0);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gelibert geodata',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Gelibert geodata'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reqData = ref.watch(reqDataProvider);
    final couriersAsyncValue = ref.watch(couriersProvider);

    final count = ref.watch(counterStateProvider);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   // toolbarHeight: 10,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.all(5.0),
              // padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 2,
                ),
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('Test'),
                  ],
                ),
              ),
            ),
            Text(
              'You have pushed the button this many times: $count $reqData',
            ),
            couriersAsyncValue.when(
              data: (data) {
                var dropDownValue = data.firstWhere(
                  (element) => element.macAddress == reqData.courierMac,
                  // orElse: () => data[0],
                  orElse: () {
                    data.insert(
                        0,
                        Courier(
                          "None",
                          "None",
                          "None",
                          "Select courier",
                          "None",
                          DateTime.now(),
                        ));
                    return data[0];
                  },
                );
                return DropdownButton<Courier>(
                    value: dropDownValue,
                    items: data.map<DropdownMenuItem<Courier>>((Courier value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      dropDownValue = newValue!;
                      ref.read(reqDataProvider.state).update((state) => RequestData(courierMac: newValue.macAddress));
                    });
              },
              loading: () => const CircularProgressIndicator(),
              error: (e, st) => Text('Error: $e'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => ref.read(counterStateProvider.state).state++,
        onPressed: () {
          var st = ref.read(counterStateProvider.state).state;
          ref.read(counterStateProvider.state).state = st + 3;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
