class Startup
{
  // created class for Investor to store all its details
  String url;
  String name;
  String emailID;
  String contact;
  String location;
  String companyName;
  String website;
  List<String> geography;
  String preferredStage;
  List<String> preferredSectors;

  //created constructor to initialize Investor class

  Startup({this.url, this.name , this.emailID , this.contact , this.location ,
    this.companyName , this.website , this.geography ,
    this.preferredStage , this.preferredSectors});
}
