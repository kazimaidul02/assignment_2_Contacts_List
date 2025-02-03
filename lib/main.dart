import 'package:flutter/material.dart';

void main(){
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts List',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _name = [];
  List<String> _number =[];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController =TextEditingController();

  _addItem(){
    if (_nameController.text.isNotEmpty && _numberController.text.isNotEmpty){
      setState(() {
        _name.add(_nameController.text);
        _number.add(_numberController.text);
      });

      _nameController.clear();
      _numberController.clear();

    }
  }


  _removeItem(int index){
    setState(() {
      _name.removeAt(index);
      _number.removeAt(index);
    });
  }

  _showAlert(int index){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Delete Contact"),
            content: Text('Are you sure you want to delete this item?'),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("Cancle"),
              ),
              TextButton(
                  onPressed: (){
                    setState(() {
                      _removeItem(index);
                    });
                    Navigator.pop(context);
                  }, child: Text("Delete"),
              ),
            ],
          );
        },
        );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade500,
        title: Center(
            child: Text("Contacts List",style: TextStyle(fontSize: 25,),)),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  label: Text("Name"),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 5),
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
              ),

            SizedBox(height: 10,),

            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Number",
                labelText: "Number",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 5),
                  borderRadius: BorderRadius.circular(8)
                ),
              ),
            ),

            SizedBox(height: 10,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade100,
              ),
                onPressed: _addItem, child: Text("Add",style: TextStyle(color: Colors.black),)),


            Expanded(
              child: ListView.builder(
                  itemCount: _name.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        title: Text(_name[index]),
                        subtitle: Text(_number[index]),
                        trailing: IconButton(onPressed:(){}, icon: Icon(Icons.phone,color: Colors.blue,)),
                        onLongPress: (){
                          _showAlert(index);
                          },
                      ),
                    );
                  }),
            )
          ],
        ),
      ) ,
    );
  }
}
