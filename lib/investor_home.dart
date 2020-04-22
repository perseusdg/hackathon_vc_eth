import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/InvestorCard.dart';
import 'Investor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(
  home: InvestorList()
));

class InvestorList extends StatefulWidget {
  @override
  _InvestorListState createState() => _InvestorListState();
}

class _InvestorListState extends State<InvestorList> {

  /*
  List<Investor> investors = [
    Investor(name: 'Harshvardhan C', emailID: 'test_email@gmail.com', contact: '9876543210',
             location: 'India', companyName: 'HVC Pvt Ltd' , website: '' , geography: ['India','Dubai'],
             preferredStage: 'Pre-Seed', preferredSectors: ['Artificial Intelligence','Medical']),
    Investor(name: 'Tanishq Nandan', emailID: 'test2_email@gmail.com', contact: '0123456789',
        location: 'India', companyName: 'TN Pvt Ltd' , website: '' , geography: ['India','France'],
        preferredStage: 'Pre-Series A', preferredSectors: ['eSports','Medical'])
  ];

   //hard coded data for testing templates
  */


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: FlatButton(
          onPressed: () {
            print('Go to Profile Page');
            },
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 40.0,
          ),
        ),

        title: Text(
          'Investor List',
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: FlatButton(
              onPressed: () {},
              child: Icon(
                Icons.search,
                size: 30.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: FlatButton(
              onPressed: () {},
              child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 30.0,
        ),
            ),
          )
        ],
      ),
      body:  Column(
        children: <Widget>[
          Text(
            'Latest arrivals',
             textAlign: TextAlign.left,
             style: TextStyle(
               color:Colors.black,
               fontSize: 25.0,
               fontWeight: FontWeight.bold,
             ),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(

            stream: Firestore.instance.collection("investors").snapshots(),
            // ignore: missing_return
            builder: (BuildContext  context,AsyncSnapshot snapshot)
            {
              if (snapshot.hasData)
              {
                return Container(
                  height: 300.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      //shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                         DocumentSnapshot ds = snapshot.data.documents[index];
                        Investor inv = Investor(url: ds["url"],
                                        name: ds["name"],
                                        companyName: ds["companyName"],
                                        location: ds["location"],
                                        preferredStage: "",
                                        preferredSectors: [""]);


                        return InvestorCard(investor: inv);
                        //return Text(ds['name']);
                      }

                  ),
                );
              }
              else
                {
                  return CircularProgressIndicator();
                }
            },
          ),
        ],
      ) ,

      bottomNavigationBar: BottomNavigationBar(
      items: <BottomNavigationBarItem>[
           BottomNavigationBarItem(
             title: Text('home'),
             icon: FlatButton(
               onPressed: () {
                 print('home screen');
               },
               child: Icon(
                 Icons.home,
               )

             )

           ),
            BottomNavigationBarItem(
              title: Text('Fav'),
            icon: FlatButton(
            onPressed: () {
            print('favorites');
            },
            child: Icon(
            Icons.favorite_border,
            )

            )
            ),
           BottomNavigationBarItem(
             title: Text('Chat'),
             icon: FlatButton(
               onPressed: () {print('chat');},
               child: Icon(
                 Icons.chat,
               )
             )
           ),
      ],
      ),
    );
  }
}
