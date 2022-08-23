abstract class BuyProductsStates{}
class BuyProductsInitialState extends BuyProductsStates{}

class DecrementProductCartQuantityState extends BuyProductsStates{}
class IncrementProductCartQuantityState extends BuyProductsStates{}

class DeleteProductState extends BuyProductsStates{}

class BuyProductSuccessState extends BuyProductsStates{}



class CreateDBTableSuccessState extends BuyProductsStates{}
class CreateDBTableErrorState extends BuyProductsStates{}

class ItemAddedInDBSuccessState extends BuyProductsStates{}
class ItemAddedInDBErrorState extends BuyProductsStates{}

class GotDataFromDBSuccessState extends BuyProductsStates{}
class GotDataFromDBErrorState extends BuyProductsStates{}


class ItemDeletedFromDBSuccessState extends BuyProductsStates{}
class ItemDeletedFromDBErrorState extends BuyProductsStates{}

class ItemUpdatedInDBSuccessState extends BuyProductsStates{}
class ItemUpdatedInDBErrorState extends BuyProductsStates{}

