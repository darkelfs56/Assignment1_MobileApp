// import 'dart:html';
// import 'dart:ffi';
import 'dart:io';

class Item {
  late int id;
  late String desc;
  late double price;
  late int quantity;
  late int discount;
  Item(this.id, this.desc, this.price, this.quantity, this.discount);

  void read() {
    print(
        "\n${this.id}\t${this.desc}\t\t\t${this.price}\t\t\t${this.quantity}\t\t\t${this.discount}");
  }

  void uptquan(int input, int upquan) {}
}

String checkValue(var property, String prompt, int code) {
  bool checkFlag = true;
  do {
    try {
      checkFlag = true;
      stdout.write(prompt);
      property = stdin.readLineSync()!;
      if (code == 1 || code == 4 || code == 5) //id or price or discount
        property = int.parse(property);
      else if (code == 2) //desc
        ;
      else if (code == 3) //price
        property = double.parse(double.parse(property).toStringAsFixed(2));
    } catch (e) {
      print("\nError! Please input the correct value!");
      checkFlag = false;
    }
  } while (!checkFlag);
  return property.toString();
}

class Cart {
  late int id;
  late String desc;
  late double price;
  late int quantity;
  late int discount;
  late double total;

  List<Item> products = [];
  Cart(this.id, this.desc, this.price, this.discount, this.quantity);

  void read() {
    print(
        "\n$id\t$desc\t\t\t$price\t\t$discount\t\t$quantity\t\t${totalprice()}");
  }

  double totalprice() {
    this.total =
        (this.price - (this.price * (this.discount / 100))) * this.quantity;
    return this.total;
  }
}

void main() {
  var menu;
  bool mainmenu = true;
  //Initialize products list hakimi
  late List<Item> products = [
    Item(1, "Table", 140, 15, 10),
    Item(2, "Bread", 4, 40, 0),
    Item(3, "Iphone", 2000, 5, 15),
    Item(4, "PS5", 4000, 3, 30),
    Item(5, "Books", 35, 35, 10),
    Item(6, "Eggs", 10, 100, 0)
  ];
  late List<Cart> cart = [];

  do {
    print("\n\n\t|============ POS Prototype ============|");
    print(
        "\n\n\t\tPress 1 for Admin menu\n\n\t\tPress 2 for Customer menu\n\n\t\tPress 3 to exit system");
    print("\n\n\t|=======================================|");
    menu = stdin.readLineSync();

    // late List<Storage> rows = [];

    if (menu == "1") {
      var code;
      bool flag = true;
      do {
        print("What do you want to do?\n");
        print("Press 0 to exit this menu.");
        print("Press 1 to add item.");
        print("Press 2 to display all items.");
        print("Press 3 to remove items.");
        // print("Press 4 if you are done.");
        code = stdin.readLineSync();

        if (code == "0") {
          // String confirm = '';
          // stdout.write("\nAre you sure you want to exit? (y/n): ");
          // confirm = stdin.readLineSync()!;
          // if (confirm == 'y')
          flag = false;
        } else if (code == "1") {
          print("Insert item function...");

          var id, price, quantity, desc, discount;

          id = int.parse(checkValue(id, "Item id: ", 1));
          desc = checkValue(desc, "Item desc/name: ", 2);
          price = double.parse(checkValue(price, "Item price: ", 3));
          quantity = int.parse(checkValue(quantity, "Item quantity: ", 4));
          discount = int.parse(
              checkValue(discount, "Item discount in percentage(%):", 5));

          products.add(Item(id, desc, price, quantity, discount));
          print("Item added!\n");
        } else if (code == "2") {
          print(
              "\n======================================PRODUCT DISPLAY======================================");
          print(
              "===========================================================================================");
          print("ID\tDESCRIPTION\t\tPRICE(RM)\t\tQUANTITY\t\tDISCOUNT(%)");
          products.forEach((element) {
            element.read();
          });
          print(
              "===========================================================================================\n");
          // Amirul
        } else if (code == "3") {
          print(
              "\n======================================PRODUCT DISPLAY======================================");
          print(
              "===========================================================================================");
          print("ID\tDESCRIPTION\t\tPRICE(RM)\t\tQUANTITY\t\tDISCOUNT(%)");
          products.forEach((element) {
            element.read();
          });
          print(
              "===========================================================================================\n");

          print("\nInput Id of item that you want to remove...\n");
          var id;

          id = int.parse(checkValue(id, "Item id: ", 1));
          products.removeWhere((item) => item.id == id);
          print("\nItem Removed!\n\n");
        }
        // } else if (code == "4") {
        //   rows.add(Storage(counter, products));
        //   products = [];
        //   counter++;
        //   print("====================\n");
        //   print("Next customer!");
        // }
      } while (flag);

      // for (int i = 1; i < counter; i++) {
      //   print("Customer #$i items are:\n");
      //   rows[i - 1].products.forEach((element) {
      //     element.read();
      //   });
      // }
    } else if (menu == "2") {
      // int counter = 1;
      var shop;
      bool flag = true;

      do {
        print("\nWelcome, to our Store!");
        print("Press 0 to exit this menu.");
        print("Press 1 to add item to cart.");
        print("Press 2 to display cart.");
        print("Press 3 to remove items from cart.");
        print("Press 4 to proceed to checkout.");
        shop = stdin.readLineSync();

        if (shop == '0') {
          flag = false;
        } else if (shop == '1') {
          print("Add Item to cart");

          print(
              "\n======================================PRODUCT DISPLAY======================================");
          print(
              "===========================================================================================");
          print("ID\tDESCRIPTION\t\tPRICE(RM)\t\tQUANTITY\t\tDISCOUNT(%)");
          products.forEach((element) {
            element.read();
          });
          print(
              "===========================================================================================\n");

          addCart(products, cart);
        } else if (shop == '2') {
          //Amirul
          print(
              "\n======================================CART DISPLAY============================================================");
          print(
              "==============================================================================================================");
          print(
              "ID\tDESCRIPTION\t\tPRICE(RM)\tDISCOUNT(%)\tQUANTITY\tTotal Price(RM)");
          cart.forEach((element) {
            element.read();
          });
          print(
              "==============================================================================================================\n");
        } else if (shop == '3') {
          //Ammar Arif
          print("Remove Item from cart");

          print(
              "\n======================================CART DISPLAY============================================================");
          print(
              "==============================================================================================================");
          print(
              "ID\tDESCRIPTION\t\tPRICE(RM)\tDISCOUNT(%)\tQUANTITY\tTotal Price(RM)");
          cart.forEach((element) {
            element.read();
          });
          print(
              "==============================================================================================================\n");

          removeCart(products, cart);
        } else if (shop == '4') {
          chkout(products, cart);
        }
      } while (flag);
    } else if (menu == "3") {
      mainmenu = false;
    }
  } while (mainmenu);
}

void addCart(List<Item> products, List<Cart> cart) {
  var id, desc, price, disc, pquan;
  int quan;

  stdout.write("Enter the item ID: ");
  int input = int.parse(stdin.readLineSync()!);
  stdout.write("Enter quantity: ");
  quan = int.parse(stdin.readLineSync()!);

  var exist = false;
  products.forEach((Item item) {
    if (item.id == input) {
      id = item.id;
      desc = item.desc;
      price = item.price;
      pquan = item.quantity;
      disc = item.discount;
      exist = true;
    }
  });

  if (exist && (pquan > quan)) {
    //Amirul (avoid redundant item in cart)
    var existed = false;
    cart.forEach((Cart item) {
      if (item.id == id) {
        item.quantity += quan;
        existed = true;
      }
    });
    if (!existed) {
      //ERSYAD
      cart.add(Cart(id, desc, price, disc, quan));
    }
  } else {
    print('Your Item Id was invalid or stock unavailable');
    return;
  }
}
//Ammar Arif
void removeCart(List<Item> products, List<Cart> cart){
  var id;
  bool valid=false;
  int quan; 
  late int cquan, rmncart; //do not want assign var early

  stdout.write("Enter the item ID: ");
  int input = int.parse(stdin.readLineSync()!);
  stdout.write("Enter quantity: ");
  quan = int.parse(stdin.readLineSync()!);

  cart.forEach((Cart icart) {
    if (icart.id == input) {
      id = icart.id;
      cquan = icart.quantity;
      rmncart = cquan-quan;
      valid = true; //filter out input from user
      }
    });

    if(valid && rmncart > 0){
      //minus item quantity in cart
      cart.forEach((Cart icart) {
        if (icart.id == input) {
          id = icart.id;
          icart.quantity = rmncart;  
          }
        });
     
      print("\nItem reduced from Cart!\n\n");
    } 
      
}

//ERSYAD
void chkout(List<Item> products, List<Cart> cart) {
  DateTime today = new DateTime.now();
  String dateSlug =
      "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
  String hourSlug =
      "${today.hour.toString()}:${today.minute.toString().padLeft(2, '0')}:${today.second.toString().padLeft(2, '0')}";

  double sum = 0;

  print(
      "\n======================================CHECKOUT======================================");
  print("\nReceipt ID:\t");
  print("C123");
  print("\nDate:\t");
  print(dateSlug);
  print("\nTime:\t");
  print(hourSlug);
  print(
      "\n======================================INVOICE======================================");
  print(
      "===========================================================================================");
  print("ID\tDESCRIPTION\t\tPRICE(RM)\t\tDISCOUNT(%)\t\tQUANTITY\t\tTOTAL");
  cart.forEach((element) {
    element.read();
  });
  cart.forEach((Cart cart) {
    sum += cart.total;
  });
  print("\nTOTAL PAYMENT\t\t\t");
  print(sum);

  print(
      "===========================================================================================\n");
}
