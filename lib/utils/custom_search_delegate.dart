import 'package:RoomMeMobile/models/user.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {

  final List<User> listUsers;

  CustomSearchDelegate({@required this.listUsers});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
  

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Hi :)"),
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<User> suggestionList = [];
    suggestionList.addAll(listUsers.where((usr){
      String searchTerm = query.toLowerCase();
      return usr.name.toLowerCase().contains(searchTerm) || usr.lastName.toLowerCase().contains(searchTerm);
    })
    );

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.perm_contact_cal),
            title: Text(suggestionList[index].name + ' ' + suggestionList[index].lastName),);
      }
    );
  }
}