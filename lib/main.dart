import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
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

  // Color palette dictionary
  static Map<Color, String> colorPalette = {
    const Color.fromRGBO(255, 0, 0, 1.0): "Red",
    const Color.fromRGBO(0, 255, 0, 1.0): "Green",
    const Color.fromRGBO(0, 0, 255, 1.0): "Blue",
    const Color.fromRGBO(255, 255, 0, 1.0): "Yellow",
    const Color.fromRGBO(255, 0, 255, 1.0): "Magenta",
    const Color.fromRGBO(0, 255, 255, 1.0): "Cyan",
    const Color.fromRGBO(255, 255, 255, 1.0): "White",
    const Color.fromRGBO(0, 0, 0, 1.0): "Black",
    const Color.fromRGBO(192, 192, 192, 1.0): "Silver",
    const Color.fromRGBO(128, 128, 128, 1.0): "Gray",
    const Color.fromRGBO(128, 0, 0, 1.0): "Maroon",
    const Color.fromRGBO(128, 128, 0, 1.0): "Olive",
    const Color.fromRGBO(0, 128, 0, 1.0): "Dark Green",
    const Color.fromRGBO(128, 0, 128, 1.0): "Purple",
    const Color.fromRGBO(0, 128, 128, 1.0): "Teal",
    const Color.fromRGBO(0, 0, 128, 1.0): "Navy",
    const Color.fromRGBO(240, 128, 128, 1.0): "Light Coral",
    const Color.fromRGBO(255, 160, 122, 1.0): "Light Salmon",
    const Color.fromRGBO(255, 215, 0, 1.0): "Gold",
    const Color.fromRGBO(255, 182, 193, 1.0): "Light Pink",
    const Color.fromRGBO(160, 82, 45, 1.0): "Sienna",
    const Color.fromRGBO(210, 105, 30, 1.0): "Chocolate",
    // Add more colors as needed
  };

  static String getColorName(Color color) {
    String closestColorName = "Unknown";
    double smallestDistance = double.infinity;

    colorPalette.forEach((paletteColor, colorName) {
      final distance = colorDistance(color, paletteColor);
      if (distance < smallestDistance) {
        smallestDistance = distance;
        closestColorName = colorName;
      }
    });

    return closestColorName;
  }

  static double colorDistance(Color c1, Color c2) {
    final r1 = c1.r;
    final g1 = c1.g;
    final b1 = c1.b;

    final r2 = c2.r;
    final g2 = c2.g;
    final b2 = c2.b;

    return sqrt(pow(r1 - r2, 2) + pow(g1 - g2, 2) + pow(b1 - b2, 2));
  }

  Future calculateAverageColorName(File imageFile) async {
    try {
      // Read the image file into memory
      Uint8List bytes = await imageFile.readAsBytes();

      // Decode the image using the image package
      img.Image? image = img.decodeImage(bytes);

      if (image == null) {
        return "Unknown";
      }

      // Initialize variables to store the sum of RGB values
      int redSum = 0;
      int greenSum = 0;
      int blueSum = 0;

      // Iterate through each pixel in the image
      for (int x = 0; x < image.width; x++) {
        for (int y = 0; y < image.height; y++) {
          // Get the pixel color
          img.Color pixel = image.getPixel(x, y);

          // Extract the RGB values
          int red = pixel.r.toInt();
          int green = pixel.g.toInt();
          int blue = pixel.b.toInt();


          // Add the RGB values to the sum
          redSum += red;
          greenSum += green;
          blueSum += blue;
        }
      }

      // Calculate the average RGB values
      int numPixels = image.width * image.height;
      double redAvg = redSum / numPixels;
      double greenAvg = greenSum / numPixels;
      double blueAvg = blueSum / numPixels;

      // Create a Color object from the average RGB values
      Color averageColor = Color.fromRGBO(redAvg.round(), greenAvg.round(), blueAvg.round(), 1.0);

      // Find the closest color in the palette
      return _HomeScreenState.getColorName(averageColor);

    } catch (e) {
      return "Unknown";
    }
  }


  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        // Calculate the average color
        Future<dynamic> averageColorData = calculateAverageColorName(_image!);

        averageColorData.then((averageColorResult) {

          String averageColorName;
          Color averageColor;

          if(averageColorResult is String) {
            averageColorName = averageColorResult;
            averageColor = const Color.fromRGBO(0, 0, 0, 1.0); //Установите любой цвет по умолчанию
            colorPalette.forEach((paletteColor, colorName) {
              if (colorName == averageColorName) {
                averageColor = paletteColor;
              }
            });
          } else {
            averageColorName = _HomeScreenState.getColorName(averageColorResult);
            averageColor = averageColorResult;
          }

          // Navigate to the new screen after image selection
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnalysisScreen(
                image: _image,
                averageColorName: averageColorName,
                averageColor: averageColor, // Передаем averageColor
              ),
            ),
          ).then((_) {
            setState(() {
              _image = null;
            });
          });
        });
      } else {
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

class AnalysisScreen extends StatelessWidget {
  final File? image;
  final String? averageColorName;
  final Color? averageColor; // Добавляем averageColor

  const AnalysisScreen({super.key, required this.image, required this.averageColorName, this.averageColor});
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
              child: Row(
                children: [
                  SizedBox( //Remove it to disapear box
                     width: 40,
                     height: 40,
                     child: DecoratedBox(
                       decoration: BoxDecoration(
                         color: averageColor ?? Colors.red,  // Use averageColor
                       ),
                     ),
                   ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Маркер спиртовой:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(averageColorName ?? 'Unknown'), // Display color name
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

