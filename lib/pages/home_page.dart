import 'package:flutter/material.dart';
import 'package:pertemuan10_2306133/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  //membuat state
  @override
  State<HomePage> createState()=> _HomePageState();
  }
  // membuat class state
class _HomePageState extends State<HomePage>{
  //inisialisasi variable username
  String username = '';

  //membuat variabel utama untuk produk
  List<ProductModel> products = [];

  //membuat iniState()
  @override
  void initState() {
    super.initState();
    getUser();
    loadProducts();
  }

  //membuat method loadProducts()
  Future<void> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productList = prefs.getStringList('products') ?? [];
    setState(() {
      products =productList
                .map((item) => ProductModel.fromJson(item))
                .toList();
    });
  }

  //method saveProduct() untuk menyimpan data
  Future<void> saveProduct() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productList = products.map((item) => item.toJson()).toList();
    await prefs.setStringList('products', productList);
  }

  //method addProduct() untuk menambah data
  Future<void> addProduct(ProductModel product) async {
    setState(() {
      products.add(product);
    });
    await saveProduct();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Produk berhasil ditambahkan")),
    );
  }

  //methode mengubah data (update)
  Future<void> updateProduct(int index, ProductModel product) async {
    setState(() {
      products[index] = product; 
    });
    await saveProduct(); 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Produk berhasil diperbarui")),
    );
  }

  //method hapus data (delete)
  Future<void> deleteProduct(int index) async {
    setState(() {
      products.removeAt(index); 
    });
    await saveProduct(); 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Produk berhasil dihapus")),
    );
  }

  //methode showDialog() 
  void showForm({ProductModel? product, int? index}) {
    //controler
    TextEditingController nameController = TextEditingController(
      text: product?.name ?? "",
    );
    TextEditingController descriptionController = TextEditingController(
      text: product?.description ?? "",
    );
    TextEditingController priceController = TextEditingController(
      text: product?.price.toString() ?? "",
    );

    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Text(product == null ? "Tambah Produk" : "Edit Produk"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Deskripsi"),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: "Harga"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              final newProduct = ProductModel(
                name: nameController.text, 
                description: descriptionController.text, 
                price: int.parse(priceController.text),
              );
              
              if (product == null) {
                addProduct(newProduct);
              } else {
                if (index != null) {
                  updateProduct(index, newProduct);
                }
              } 
              Navigator.pop(context);
            }, 
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  //membuat method getUser()
  Future<void> getUser()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }
  Future<void> logout()async{
    final prefs =await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  //widget builder
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:  const Color(0xFFF5F6FA),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                    "https://fastly.picsum.photos/id/20/3670/2462.jpg?hmac=CmQ0ln-k5ZqkdtLvVO23LjVAEabZQx2wOaT4pyeG10I"
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hai, Selamat Datang!",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 20,
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(onPressed: logout, 
                child: Icon(Icons.logout, size: 28, color: Colors.red)
                ),
              ],
            ),
          ),

          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(child: ElevatedButton(
                onPressed: () => showForm(), 
                child: Text("Tambah Produk"),
              ))
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: products.isEmpty
                ? const Center(child: Text("Belum ada produk"))
                : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(15),
                        title: Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text("Rp ${product.price}"),
                            SizedBox(height: 5),
                            Text(product.description)
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => showForm(product: product, index: index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteProduct(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                )
              )
            ],
          )
        ),
      ),
    );
  }
}
