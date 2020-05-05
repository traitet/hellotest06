class UserModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================  
  final int id;
  final String title;
  final String image;
  final String profile;
  
  //=============================================================
  // 2) CONSTRUCTURE (FOR CLASS USER)
  //============================================================= 
  UserModel({
      this.id,
      this.title,
      this.image,
      this.profile
  });

  //=============================================================
  // FACTORY: MAP DATA TO JSON
  //=============================================================  
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      profile: json['thumbnailUrl']
    );
  }

}