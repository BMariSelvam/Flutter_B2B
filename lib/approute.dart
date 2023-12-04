import 'package:b2b/View/Cart/success.dart';
import 'package:b2b/View/InVoice/InvoicePrint/InvoicePrintScreen.dart';
import 'package:b2b/View/Support/shipping_address/shipping_address_screen.dart';
import 'package:get/get.dart';

import 'MyProfile_Screen.dart';
import 'View/AboutProuduct/aboutproductscreen.dart';
import 'View/Cart/cartscreen.dart';
import 'View/DashBoard/dashboardscreen.dart';
import 'View/Login/loginscreen.dart';
import 'View/Order/OrderInvoice/orderPrintScreen.dart';
import 'View/Order/orderscreen.dart';
import 'View/Payment/paymentInvoiceScreen.dart';
import 'View/Product/productscreen.dart';
import 'View/Support/Setting_Screen.dart';
import 'View/Support/createticket.dart';
import 'View/Support/ticketcreatesuccess.dart';
import 'View/Widget/bottomnavbar.dart';
import 'View/splashscreen.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String bottomNavBar = '/bottomNavBar';
  static const String bottomNavBar0 = '/bottomNavBar0';
  static const String bottomNavBar1 = '/bottomNavBar1';
  static const String bottomNavBar2 = '/bottomNavBar2';
  static const String bottomNavBar3 = '/bottomNavBar3';
  static const String dashboardScreen = '/dashBoardScreen';
  static const String productScreen = '/productScreen';
  static const String aboutProductScreen = '/aboutProductScreen';
  static const String orderScreen = '/orderScreen';
  static const String myProfile = '/myProfile';
  static const String cartScreen = '/cartScreen';
  static const String supportScreen = '/supportScreen';
  static const String createTicketScreen = '/createTicketScreen';
  static const String orderInvoiceScreen = '/orderInvoiceScreen';
  static const String invoicePrintScreen = '/invoicePrintScreen';
  static const String paymentInvoiceScreen = '/PaymentInvoiceScreen';
  static const String tabBarScreen = '/tabBarScreen';
  static const String loginScreen = '/loginScreen';
  static const String ticketSubmit = '/ticketSubmit';
  static const String successScreen = '/ticketSuccessScreen';
  static const String shippingAddressScreen = '/ShippingAddressScreen';
}

final pages = [
  GetPage(name: AppRoutes.splashScreen, page: () => const SplashScreen()),
  GetPage(name: AppRoutes.dashboardScreen, page: () => const DashBoardScreen()),
  GetPage(name: AppRoutes.productScreen, page: () => const ProductScreen()),
  GetPage(
      name: AppRoutes.aboutProductScreen,
      page: () => const AboutProductScreen()),
  GetPage(name: AppRoutes.orderScreen, page: () => const OrderScreen()),
  GetPage(name: AppRoutes.myProfile, page: () => const MyProfileScreen()),
  GetPage(name: AppRoutes.cartScreen, page: () => const CartScreen()),
  GetPage(name: AppRoutes.supportScreen, page: () => const SupportScreen()),
  GetPage(name: AppRoutes.createTicketScreen, page: () => const CreateTicket()),
  GetPage(
      name: AppRoutes.orderInvoiceScreen,
      page: () => const OrderInvoiceScreen()),
  GetPage(
      name: AppRoutes.invoicePrintScreen,
      page: () => const InvoicePrintScreen()),
  GetPage(
      name: AppRoutes.paymentInvoiceScreen,
      page: () => const PaymentInvoiceScreen()),
  GetPage(name: AppRoutes.loginScreen, page: () => const LoginScreen()),
  GetPage(
      name: AppRoutes.ticketSubmit,
      page: () => const TicketCreatedSuccessFully()),
  GetPage(name: AppRoutes.successScreen, page: () => const SuccessScreen()),
  GetPage(name: AppRoutes.bottomNavBar, page: () => BottomNavBar()),
  GetPage(
      name: AppRoutes.bottomNavBar0,
      page: () => BottomNavBar(
            intex: 0,
          )),
  GetPage(
      name: AppRoutes.bottomNavBar1,
      page: () => BottomNavBar(
            intex: 1,
          )),
  GetPage(
      name: AppRoutes.bottomNavBar2,
      page: () => BottomNavBar(
            intex: 2,
          )),
  GetPage(
      name: AppRoutes.bottomNavBar3,
      page: () => BottomNavBar(
            intex: 3,
          )),
  GetPage(
      name: AppRoutes.shippingAddressScreen,
      page: () => const ShippingAddressScreen()),
];
