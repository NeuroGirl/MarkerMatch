import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Вход',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100], // Light grey background
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController, // Assign the controller
                      decoration: InputDecoration(
                        hintText: 'Введите свой E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none, // Remove the border
                        ),
                        filled: true, // Set to true to fill the color
                        fillColor: Colors.white, // White textfield background
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordController, // Assign the controller
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Введите пароль',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onPressed: () {
                        // Check if fields are empty
                        if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                          // Show an alert dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Ошибка'),
                                content: const Text('Пожалуйста, заполните все поля.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('ОК'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Navigate to main screen (replace with your logic)
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        }
                      },
                      child: const Text('Войти', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigate to registration screen (replace with your logic)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegistrationPage()),
                  );
                },
                child: const Text('Нет аккаунта? Зарегистрироваться', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  File? _image;
  final picker = ImagePicker();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('Image selected: ${_image!.path}');
        // Navigate to the new screen after image selection
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnalysisScreen(image: _image),
          ),
        ).then((_) {  // Add this .then() block
          setState(() {
            _image = null; // Clear the image when returning
          });
        });
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text('Доброе утро!', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: _toggleMenu,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {
              // Handle help button press
            },
          ),

        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: getImage,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.none,
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: _image == null
                          ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_outlined, size: 50, color: Colors.grey),
                          Text(
                            'Вставьте свое фото с цветом для определения сюда',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                          : Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(color: Colors.red[400]),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('История поиска', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.card_giftcard, size: 50, color: Colors.grey),
                          Text(
                            'К сожалению история пуста :(\nПроанализируйте свой первый цвет, и он будет сохранен сюда!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    SlideTransition(
    position: Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0)).animate(_animationController), // Перемещаем begin значение
    child: ClipRect( // ClipRect, чтобы обрезать выезжающий элемент
    child: Container(
    width: screenWidth * 0.8, // Adjust width as needed
    color: Colors.white, // Same background color as the screenshot
    child: Padding(
    padding: const EdgeInsets.only(top: 50.0), // Match padding
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Align(
    alignment: Alignment.topRight,
    child: IconButton(
    icon: const Icon(Icons.close, color: Colors.red),
    onPressed: _toggleMenu,
    ),
    ),
    TextButton(
    onPressed: () {
    // Navigate to Settings
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
    },
    child: const Text('Настройки', style: TextStyle(color: Colors.black, fontSize: 18)),
    ),
    TextButton(
    onPressed: () {
    // Navigate to Account
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountPage()));
    },
    child: const Text('Аккаунт', style: TextStyle(color: Colors.black, fontSize: 18)),
    ),
    TextButton(
    onPressed: () {
    // Navigate to My List
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyListPage()));
    },
    child: const Text('Мой список', style: TextStyle(color: Colors.black, fontSize: 18)),
    ),
    TextButton(
    onPressed: () {
    // Navigate to Contacts
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactsPage()));
    },
    child: const Text('Контакты', style: TextStyle(color: Colors.black, fontSize: 18)),
    ),
                  ],
                ),
              ),
            ),
          ),
    ),
      ],
    ));
  }
}
// New screen for analysis
class AnalysisScreen extends StatelessWidget {
  final File? image;

  const AnalysisScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text('Анализ завершен!', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                  style: BorderStyle.none, // Changed to none for no border
                ),
                borderRadius: BorderRadius.circular(5.0), // Optional: Add rounded corners
              ),
              child: image != null
                  ? Image.file(
                image!,
                fit: BoxFit.cover,
                height: 200,
              )
                  : const SizedBox(
                height: 200,
                child: Center(
                  child: Text('No image selected'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.red[400],
              height: 2,
            ),
            const SizedBox(height: 20),
            const Text(
              'Найденные материалы:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                  style: BorderStyle.none,  // Changed to none for no border
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFFC19A6B),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Маркер спиртовой:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('BR 116 Clay'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                  style: BorderStyle.none,  // Changed to none for no border
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFFD4A017),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Краска акриловая:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('RAL 1024 Охра желтая'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle "Добавить в список" button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red[400],
                side: BorderSide(color: Colors.red[400]!),
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('Добавить в список'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('Вернуться на главную'),
            ),
          ],
        ),
      ),
    );
  }
}
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: const Center(child: Text('Страница настроек')),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Аккаунт')),
      body: const Center(child: Text('Страница аккаунта')),
    );
  }
}

class MyListPage extends StatelessWidget {
  const MyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мой список')),
      body: const Center(child: Text('Страница "Мой список"')),
    );
  }
}

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Контакты', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red[400], // Match app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Контакты:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.red[400],
              thickness: 2.0, // Make the divider thicker
            ),
            const SizedBox(height: 20),
            const Text(
              'Техническая поддержка:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const ContactItem(label: 'Телефон:', value: '+7(926)791-12-56'),
            const ContactItem(label: 'E-mail:', value: 'Mmatch@gmail.com'),
            const ContactItem(label: 'Telegram:', value: '@mmatchbot'),
            const ContactItem(label: 'VK:', value: 'M-Match Tech Service'),
            const SizedBox(height: 20),
            const Text(
              'Обработка предложений:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const ContactItem(label: 'E-mail:', value: 'MmatchCS@gmail.com'),
            const ContactItem(label: 'Telegram:', value: '@mmatchCSbot'),
            const ContactItem(label: 'VK:', value: 'M-Match Cust, Suggest'),
            const SizedBox(height: 20), // Space for the image
          ],
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final String label;
  final String value;

  const ContactItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the top
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded( // Use Expanded to wrap the value
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            children: [
              const Center(
                child: Text(
                  'Регистрация',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Введите свой E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Введите пароль',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Повторите пароль',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onPressed: () {
                        // Check if any field is empty
                        if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty ||
                            _confirmPasswordController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Ошибка'),
                                content: const Text('Пожалуйста, заполните все поля.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('ОК'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          // Check if passwords match
                        } else if (_passwordController.text != _confirmPasswordController.text) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Ошибка'),
                                content: const Text('Пароли не совпадают.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('ОК'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        else {
                          // Navigate to main screen after registration (replace with your logic)
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        }
                      },
                      child: const Text('Зарегистрироваться', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigate back to login screen
                  Navigator.pop(context);
                },
                child: const Text('Уже есть аккаунт? Войти', style: TextStyle(color: Colors.blue)),
              ),
            ]));
  }
}

