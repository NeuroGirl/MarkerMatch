import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
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
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
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
                    SizedBox(height: 10),
                    TextField(
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
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to main screen (replace with your logic)
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
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
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
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
      duration: Duration(milliseconds: 300),
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
        title: Text('Доброе утро!', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: _toggleMenu,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.white),
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
                          ? Column(
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
              Padding(
                padding: const EdgeInsets.all(20.0),
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
    position: Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_animationController), // Перемещаем begin значение
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
    icon: Icon(Icons.close, color: Colors.red),
    onPressed: _toggleMenu,
    ),
    ),
    TextButton(
    onPressed: () {
    // Navigate to Settings
    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
    },
    child: Text('Настройки', style: TextStyle(color: Colors.black, fontSize: 18)),
    ),
    TextButton(
    onPressed: () {
    // Navigate to Account
    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage()));
    },
    child: Text('Аккаунт', style: TextStyle(color: Colors.black, fontSize: 18)),
    ),
    TextButton(
    onPressed: () {
    // Navigate to My List
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyListPage()));
    },
    child: Text('Мой список', style: TextStyle(color: Colors.black, fontSize: 18)),
    ),
    TextButton(
    onPressed: () {
    // Navigate to Contacts
    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactsPage()));
    },
    child: Text('Контакты', style: TextStyle(color: Colors.black, fontSize: 18)),
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

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Настройки')),
      body: Center(child: Text('Страница настроек')),
    );
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Аккаунт')),
      body: Center(child: Text('Страница аккаунта')),
    );
  }
}

class MyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Мой список')),
      body: Center(child: Text('Страница "Мой список"')),
    );
  }
}

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Контакты')),
      body: Center(child: Text('Страница контактов')),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  // Добавили "return"
      backgroundColor: Colors.white,
      body: Column( // Используем Column как родительский виджет
        children: [
      Center( // Center теперь внутри Column
      child: Text(
      'Регистрация',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    Container( // Container теперь внутри Column
    decoration: BoxDecoration(
    color: Colors.grey[100],
    borderRadius: BorderRadius.circular(20),
    ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20), // SizedBox внутри children
            TextField(
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
            SizedBox(height: 10),
            TextField(
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
                // Navigate to main screen after registration (replace with your logic)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
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
