abstract class UseCase<Type, Params> {
  //type is the value that we return from repository(API response, etc)
  //Params is a value that we pass from UI to Usecase(create request etc)
  Future<Type> call({Params params});
}
