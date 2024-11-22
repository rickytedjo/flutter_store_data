import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final pwdController = TextEditingController();
  String mypass = '';
  @override
  void initState(){
    super.initState();
  }

  final storage = const FlutterSecureStorage();
  final myKey = 'myPass';

  Future writeToSecureStorage() async {
    await storage.write(key: myKey, value: pwdController.text);
  }

  Future<String> readFromSecureStorage() async {
    String secret = await storage.read(key: myKey) ?? '';
    return secret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Path provider')),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: pwdController,),
            ElevatedButton(onPressed: (){
              writeToSecureStorage();
            }, child: const Text('Save Value')),
            ElevatedButton(onPressed: (){
              readFromSecureStorage().then((value){
                setState(() {
                  mypass = value;
                });
              });
            }, child: const Text('Read Value')),
            Text(mypass)
          ],
        ),),
      ),
    );
  }

  // late File myFile;
  // String fileText = '';
  // String documentsPath = '';
  // String tempPath = '';

  // Future<bool> readFile() async {
  //   try{
  //     String fileContent = await myFile.readAsString();
  //     setState(() {
  //       fileText= fileContent;
  //     });
  //     return true;
  //   }
  //   catch (e){
  //     return false;
  //   }
  // }

  // Future<bool> writeFile() async {
  //   try {
  //     await myFile.writeAsString('Margherita, Capricciosa, Napoli');
  //     return true;
  //   } catch(e){
  //     return false;
  //   }
  // }

  // Future getPaths() async {
  //   final docDir = await getApplicationDocumentsDirectory();
  //   final tempDir = await getTemporaryDirectory();
  //   setState(() {
  //     documentsPath = docDir.path;
  //     tempPath = tempDir.path;
  //   });
  // }

  // // String pizzaString = '';
  // // List<Pizza> myPizzas = [];
  // // int appCounter= 0;

  // // Future deletePreference() async{
  // //   SharedPreferences prefs = await SharedPreferences.getInstance();
  // //   await prefs.clear();
  // //   setState(() {
  // //     appCounter = 0;
  // //   });
  // // }

  // // Future readAndWritePreference() async {
  // //   SharedPreferences prefs = await SharedPreferences.getInstance();

  // //   appCounter = prefs.getInt('appCounter') ?? 0;
  // //   appCounter++;

  // //   await prefs.setInt('appCounter', appCounter);
  // //   setState(() {
  // //     appCounter = appCounter;
  // //   });
  // // }

  // // String convertToJSON(List<Pizza> pizzas){
  // //   return jsonEncode(pizzas.map((pizza)=>jsonEncode(pizza)).toList());
  // // }

  // // Future<List<Pizza>> readJsonFile() async {
  // //   String myString = await DefaultAssetBundle.of(context)
  // //   .loadString('assets/pizzalist.json');
  // //   List pizzaMaplist = jsonDecode(myString);
  // //   List<Pizza> myPizzas = [];
  // //   for (var pizza in pizzaMaplist){
  // //     Pizza myPizza = Pizza.fromJson(pizza);
  // //     myPizzas.add(myPizza);
  // //   }

  // //   String json = convertToJSON(myPizzas);
  // //   print(json);

  // //   return myPizzas;
  // // }

  // @override
  // void initState() {
  //   getPaths().then((_){
  //     myFile = File('$documentsPath/pizza.txt');
  //     writeFile();
  //   });
  //   super.initState();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Path Provider'),),
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         Text("Doc path: $documentsPath"),
  //         Text("Temp path: $tempPath"),
  //         ElevatedButton(onPressed: () => readFile, child: const Text('Read File')),
  //         Text(fileText)
  //       ],
  //     ));
  // }
}

