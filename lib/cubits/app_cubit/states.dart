abstract class AppStates{}
class AppInitialState extends AppStates{}

class ChangePasswordVisibilityState extends AppStates{}

class RegisterLoadingState extends AppStates{}
class RegisterSuccessState extends AppStates{}
class RegisterErrorState extends AppStates{}

class LoginLoadingState extends AppStates{}
class LoginSuccessState extends AppStates{}
class LoginErrorState extends AppStates{}

class GetProfileDataLoadingState extends AppStates{}
class GetProfileDataSuccessState extends AppStates{}
class GetProfileDataErrorState extends AppStates{}


class UpdateUserLoadingState extends AppStates{}
class UpdateUserSuccessState extends AppStates{}
class UpdateUserErrorState extends AppStates{}

class GetSeedsLoadingState extends AppStates{}
class GetSeedsSuccessState extends AppStates{}
class GetSeedsErrorState extends AppStates{}

class CategoriesInitialState extends AppStates{}
class CategoriesSuccessState extends AppStates{}
class CategoriesErrorState extends AppStates{}

class GetProductsLoadingState extends AppStates{}
class GetProductsSuccessState extends AppStates{}
class GetProductsErrorState extends AppStates{}

class GetBlogsLoadingState extends AppStates{}
class GetBlogsSuccessState extends AppStates{}
class GetBlogsErrorState extends AppStates{}

class GetProductsFiltersLoadingState extends AppStates{}
class GetProductsFiltersSuccessState extends AppStates{}
class GetProductsFiltersErrorState extends AppStates{}

class DecrementProductQuantityState extends AppStates{}
class IncrementProductQuantityState extends AppStates{}
class DeleteProductState extends AppStates{}

class BuyProductSuccessState extends AppStates{}

class SearchProductsSuccessState extends AppStates{}


class CreateDBTableSuccessState extends AppStates{}
class CreateDBTableErrorState extends AppStates{}

class ItemAddedInDBSuccessState extends AppStates{}
class ItemAddedInDBErrorState extends AppStates{}

class GotDataFromDBSuccessState extends AppStates{}
class GotDataFromDBErrorState extends AppStates{}


class ItemDeletedFromDBSuccessState extends AppStates{}
class ItemDeletedFromDBErrorState extends AppStates{}

class ItemUpdatedInDBSuccessState extends AppStates{}
class ItemUpdatedInDBErrorState extends AppStates{}

