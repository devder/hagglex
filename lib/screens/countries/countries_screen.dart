import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountriesScreen extends StatefulWidget {
  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  final TextEditingController _filter = TextEditingController();
  List filteredList = [];
  String _searchText = "";
  List countries;

  _CountriesScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredList = countries;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Path 1087.png'),
                  fit: BoxFit.cover),
            ),
          ),
          SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Query(
                      options: QueryOptions(
                        document: gql(getCountriesQuery),
                      ),
                      builder: (QueryResult result,
                          {VoidCallback refetch, FetchMore fetchMore}) {
                        if (result.data != null) {
                          countries = result.data["getActiveCountries"];
                          filteredList = countries;
                        }
                        if (_searchText != "") {
                          List tempList = [];
                          if (filteredList != null && filteredList.length > 0) {
                            filteredList.forEach((country) {
                              if (country["name"]
                                  .toLowerCase()
                                  .contains(_searchText.toLowerCase())) {
                                tempList.add(country);
                              }
                              filteredList = tempList;
                            });
                          }
                        }

                        return Column(children: [
                          Row(
                            children: [
                              BackButton(
                                color: Colors.white,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20, top: 3),
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: TextField(
                                  controller: _filter,
                                  autocorrect: false,
                                  style: TextStyle(color: Colors.white),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.search),
                                      hintText: 'Search for country',
                                      hintStyle: TextStyle(
                                          color: Colors.white70, fontSize: 15),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Divider(
                            color: Colors.white,
                          ),
                          SizedBox(height: 15),
                          Expanded(
                            child: ListView.builder(
                                // itemCount: filteredList.length,
                                // itemBuilder: (context, index) {
                                //   final country = filteredList[index];

                                itemCount:
                                    countries == null ? 0 : filteredList.length,
                                itemBuilder: (context, index) {
                                  if (result.hasException) {
                                    return Text(result.exception.toString());
                                  }

                                  if (result.isLoading) {
                                    return CircularProgressIndicator.adaptive();
                                  }

                                  final country = filteredList[index];

                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop(country);
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 100,
                                            child: SvgPicture.network(
                                              "${country["flag"]}",
                                              key: Key(country["name"]),
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .copyWith(
                                                      color: Colors.white),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '(+${country["callingCode"]})  ',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(country["name"],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    .copyWith(
                                                        color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ]);
                      })))
        ],
      ),
    );
  }
}

String getCountriesQuery = """
query GetActiveCountries{
  getActiveCountries{
    name
    flag
    currencyCode
    callingCode
  }
}
""";
