class ApiSetting{
 static const String _baseUrl = 'http://demo-api.mr-dev.tech/';
 static const String baseApiUrl = '${_baseUrl}api/';
 static const String indexUser = '${baseApiUrl}users';
 static const String searchUser = '${baseApiUrl}user/search';
 static const String categories = '${baseApiUrl}categories';
 static const String categoriesProducts = '${baseApiUrl}categories/1/products';
 static const String userImage = '${baseApiUrl}users/2/images';
 static const String register = '${baseApiUrl}students/auth/register';
 static const String login = '${baseApiUrl}students/auth/login';
 static const String forget = '${baseApiUrl}students/auth/forget-password';
 static const String reset = '${baseApiUrl}students/auth/reset-password';
 static const String logout = '${baseApiUrl}students/auth/logout';
 static const String image = '${baseApiUrl}student/images/{id}';
}