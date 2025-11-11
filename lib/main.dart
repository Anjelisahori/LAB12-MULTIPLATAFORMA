import 'package:flutter/cupertino.dart';
import 'dart:ui'; // Necesario para ImageFilter

// ==================== MAIN ====================
void main() {
  runApp(const MyApp());
}

// ==================== PRODUCT MODEL ====================
class Product {
  final String name;
  final double price;
  final String category;
  
  // Añadido const
  const Product({
    required this.name,
    required this.price,
    required this.category,
  });
}

// Lista global de productos con categorías
List<Product> productList = [
  const Product(name: 'Balón Nike Premier League', price: 89.99, category: 'Balones'),
  const Product(name: 'Zapatillas Adidas Predator', price: 199.99, category: 'Zapatillas'),
  const Product(name: 'Guantes de Portero Puma', price: 45.50, category: 'Accesorios'),
  const Product(name: 'Camiseta Manchester United', price: 75.00, category: 'Camisetas'),
  const Product(name: 'Raqueta Wilson Pro Staff', price: 249.99, category: 'Raquetas'),
  const Product(name: 'Bicicleta Trek Mountain', price: 1299.00, category: 'Bicicletas'),
  const Product(name: 'Polo Deportivo Nike', price: 45.00, category: 'Polos'),
  const Product(name: 'Pantalón Adidas Training', price: 65.00, category: 'Pantalones'),
  const Product(name: 'Short Puma Running', price: 35.00, category: 'Pantalones'),
];

// ==================== MAIN APP (CUPERTINO) ====================
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Sports Store iOS',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
        barBackgroundColor: CupertinoColors.white,
        textTheme: CupertinoTextThemeData(
          primaryColor: CupertinoColors.black,
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const WelcomePage(),
        "/login": (context) => const LoginPage(),
        "/menu": (context) => const MenuPage(), // Mantenemos MenuPage como ruta principal
        "/home": (context) => const HomePage(),
        "/settings": (context) => const SettingsPage(),
      },
    );
  }
}

// ==================== WELCOME PAGE CON BLUR Y ANIMACIONES ====================
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _blurAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
        
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
        
    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    
    _blurAnimation = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
        
    _controller.forward();
        
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CupertinoColors.activeBlue,
              Color(0xFF0A84FF),
              Color(0xFF5E5CE6),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: _blurAnimation.value,
                    sigmaY: _blurAnimation.value,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo con efecto glassmorphism
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  CupertinoColors.white.withOpacity(0.3),
                                  CupertinoColors.white.withOpacity(0.1),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: CupertinoColors.black.withOpacity(0.1),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        CupertinoColors.white.withOpacity(0.2),
                                        CupertinoColors.white.withOpacity(0.05),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: CupertinoColors.white.withOpacity(0.2),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.sportscourt_fill,
                                    size: 80,
                                    color: CupertinoColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                                                    
                          // Texto con sombra sutil
                          Text(
                            'BIENVENIDO',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 8,
                              color: CupertinoColors.white,
                              shadows: [
                                Shadow(
                                  color: CupertinoColors.black.withOpacity(0.2),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                                                    
                          Text(
                            'SPORTS STORE',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 4,
                              color: CupertinoColors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 40),
                                                    
                          const CupertinoActivityIndicator(
                            radius: 16,
                            color: CupertinoColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== LOGIN PAGE CON GLASSMORPHISM ====================
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CupertinoColors.systemGroupedBackground,
              CupertinoColors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo con efecto de elevación
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            CupertinoColors.activeBlue,
                            Color(0xFF5E5CE6),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.activeBlue.withOpacity(0.4),
                            blurRadius: 25,
                            spreadRadius: 5,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        CupertinoIcons.bag_fill,
                        size: 60,
                        color: CupertinoColors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                                        
                    const Text(
                      'SPORTS STORE',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 4,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                    const SizedBox(height: 10),
                                        
                    Text(
                      'Inicia sesión para continuar',
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 50),
                                        
                    // Card con glassmorphism
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: CupertinoColors.systemGrey6,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: CupertinoColors.black.withOpacity(0.08),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Email field con estilo iOS moderno
                              CupertinoTextField(
                                controller: _emailController,
                                placeholder: 'Correo electrónico',
                                placeholderStyle: const TextStyle(
                                  color: CupertinoColors.systemGrey2,
                                ),
                                prefix: const Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Icon(
                                    CupertinoIcons.mail_solid,
                                    color: CupertinoColors.activeBlue,
                                    size: 22,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey6.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 18),
                                                            
                              // Password field
                              CupertinoTextField(
                                controller: _passwordController,
                                placeholder: 'Contraseña',
                                obscureText: true,
                                placeholderStyle: const TextStyle(
                                  color: CupertinoColors.systemGrey2,
                                ),
                                prefix: const Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Icon(
                                    CupertinoIcons.lock_fill,
                                    color: CupertinoColors.activeBlue,
                                    size: 22,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey6.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 35),
                                                            
                              // Login button con gradiente
                              Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      CupertinoColors.activeBlue,
                                      Color(0xFF5E5CE6),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CupertinoColors.activeBlue.withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: CupertinoButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, "/menu");
                                  },
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  borderRadius: BorderRadius.circular(15),
                                  child: const Text(
                                    'Iniciar Sesión',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: CupertinoColors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                                        
                    // Enlace "¿Olvidaste tu contraseña?"
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // Acción para recuperar contraseña
                      },
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: CupertinoColors.activeBlue,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// ==================== MENU PAGE CON CARDS ESTILO iOS (Navegación de botones) ====================
class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: null,
        middle: Text(
          'Menú Principal',
          style: TextStyle(
            color: CupertinoColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CupertinoColors.white,
              CupertinoColors.systemGroupedBackground,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                                    
                  // Logo con gradiente
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          CupertinoColors.activeBlue,
                          Color(0xFF5E5CE6),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.activeBlue.withOpacity(0.3),
                          blurRadius: 25,
                          spreadRadius: 3,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.bag_fill,
                      size: 50,
                      color: CupertinoColors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                                    
                  const Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: CupertinoColors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                                    
                  Text(
                    'Selecciona una opción',
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 40),
                                    
                  // Menu tiles con nuevo diseño
                  _buildModernMenuTile(
                    context,
                    icon: CupertinoIcons.home,
                    title: 'Inicio',
                    subtitle: 'Ver productos disponibles',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0A84FF), Color(0xFF5E5CE6)],
                    ),
                    onTap: () => Navigator.pushNamed(context, "/home"),
                  ),
                  const SizedBox(height: 15),
                                    
                  _buildModernMenuTile(
                    context,
                    icon: CupertinoIcons.person_circle_fill,
                    title: 'Perfil',
                    subtitle: 'Información de usuario',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF32D74B), Color(0xFF30B46C)],
                    ),
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text('Información'),
                          content: const Text('Perfil - Próximamente disponible'),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                                    
                  _buildModernMenuTile(
                    context,
                    icon: CupertinoIcons.add_circled_solid,
                    title: 'Agregar Producto',
                    subtitle: 'Registrar nuevos productos',
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9F0A), Color(0xFFFF6C00)],
                    ),
                    onTap: () => Navigator.pushNamed(context, "/settings"),
                  ),
                  const SizedBox(height: 15),
                                    
                  _buildModernMenuTile(
                    context,
                    icon: CupertinoIcons.arrow_right_square_fill,
                    title: 'Cerrar Sesión',
                    subtitle: 'Salir de la aplicación',
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF453A), Color(0xFFFF3B30)],
                    ),
                    onTap: () => _showLogoutDialog(context),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void _showLogoutDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Cerrar Sesión',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text('¿Estás seguro de que deseas cerrar sesión?'),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Cerrar Sesión'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, "/login");
              },
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildModernMenuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.activeBlue.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: CupertinoColors.white, size: 30),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.systemGrey3,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== HOME PAGE CON DISEÑO MEJORADO ====================
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Todos';
    
  final Map<String, IconData> categoryIcons = const {
    'Todos': CupertinoIcons.square_grid_2x2_fill,
    'Polos': CupertinoIcons.sportscourt_fill, // Corregido: usando sportscourt_fill
    'Camisetas': CupertinoIcons.sportscourt_fill,
    'Pantalones': CupertinoIcons.rectangle_3_offgrid_fill,
    'Zapatillas': CupertinoIcons.bag_fill,
    'Balones': CupertinoIcons.sportscourt_fill,
    'Accesorios': CupertinoIcons.hand_raised_fill,
    'Raquetas': CupertinoIcons.sportscourt_fill,
    'Bicicletas': CupertinoIcons.car_fill,
  };
  
  final Map<String, List<Color>> categoryColors = const {
    'Todos': [Color(0xFF0A84FF), Color(0xFF5E5CE6)],
    'Polos': [Color(0xFFFF9F0A), Color(0xFFFF6C00)],
    'Camisetas': [Color(0xFF32D74B), Color(0xFF30B46C)],
    'Pantalones': [Color(0xFFBF5AF2), Color(0xFFAF52DE)],
    'Zapatillas': [Color(0xFFFF453A), Color(0xFFFF3B30)],
    'Balones': [Color(0xFF0A84FF), Color(0xFF5AC8FA)],
    'Accesorios': [Color(0xFFFF9F0A), Color(0xFFFFCC00)],
    'Raquetas': [Color(0xFF64D2FF), Color(0xFF5AC8FA)],
    'Bicicletas': [Color(0xFF30D158), Color(0xFF32D74B)],
  };
  
  List<Product> getFilteredProducts() {
    if (selectedCategory == 'Todos') {
      return productList;
    }
    return productList.where((product) => product.category == selectedCategory).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: null,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoColors.activeBlue,
          onPressed: () => Navigator.pop(context),
        ),
        middle: const Text(
          'Productos',
          style: TextStyle(
            color: CupertinoColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      child: Container(
        color: CupertinoColors.systemGroupedBackground,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
                            
              // Título de categorías
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Categorías',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: CupertinoColors.black,
                  ),
                ),
              ),
              const SizedBox(height: 15),
                            
              // Categorías horizontales mejoradas
              SizedBox(
                height: 110,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryIcons.length,
                  itemBuilder: (context, index) {
                    String category = categoryIcons.keys.elementAt(index);
                    IconData icon = categoryIcons[category]!;
                    bool isSelected = selectedCategory == category;
                    List<Color> colors = categoryColors[category]!;
                                        
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 90,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(colors: colors)
                              : null,
                          color: isSelected ? null : CupertinoColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                   ? colors[0].withOpacity(0.3)
                                  : CupertinoColors.black.withOpacity(0.05),
                              blurRadius: isSelected ? 15 : 8,
                              offset: Offset(0, isSelected ? 6 : 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              size: 32,
                              color: isSelected
                                   ? CupertinoColors.white
                                   : colors[0],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: isSelected
                                     ? CupertinoColors.white
                                     : CupertinoColors.black,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
                            
              const SizedBox(height: 25),
                            
              // Título de productos
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Productos',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: CupertinoColors.black,
                      ),
                    ),
                    Text(
                      '${getFilteredProducts().length} items',
                      style: const TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
                            
              // Lista de productos
              Expanded(
                child: getFilteredProducts().isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey5,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                CupertinoIcons.cube_box,
                                size: 40,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'No hay productos',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: CupertinoColors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'en esta categoría',
                              style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: getFilteredProducts().length,
                        itemBuilder: (context, index) {
                          return _buildProductCard(getFilteredProducts()[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildProductCard(Product product) {
    IconData productIcon = CupertinoIcons.cube_box_fill;
    Color iconColor = CupertinoColors.activeBlue;
        
    // Lógica mejorada para asignar iconos y colores
    if (product.name.toLowerCase().contains('balón') || 
        product.name.toLowerCase().contains('balon')) {
      productIcon = CupertinoIcons.sportscourt_fill;
      iconColor = const Color(0xFF0A84FF);
    } else if (product.name.toLowerCase().contains('zapatilla')) {
      productIcon = CupertinoIcons.bag_fill;
      iconColor = const Color(0xFFFF453A);
    } else if (product.name.toLowerCase().contains('guante')) {
      productIcon = CupertinoIcons.hand_raised_fill;
      iconColor = const Color(0xFFFF9F0A);
    } else if (product.name.toLowerCase().contains('camiseta')) {
      productIcon = CupertinoIcons.sportscourt_fill;
      iconColor = const Color(0xFF32D74B);
    } else if (product.name.toLowerCase().contains('raqueta')) {
      productIcon = CupertinoIcons.sportscourt_fill;
      iconColor = const Color(0xFF64D2FF);
    } else if (product.name.toLowerCase().contains('bicicleta')) {
      productIcon = CupertinoIcons.car_fill;
      iconColor = const Color(0xFF30D158);
    } else if (product.name.toLowerCase().contains('polo')) {
      productIcon = CupertinoIcons.sportscourt_fill; // Usando icono compatible
      iconColor = const Color(0xFFFF9F0A);
    } else if (product.name.toLowerCase().contains('pantalón') ||                
               product.name.toLowerCase().contains('short')) {
      productIcon = CupertinoIcons.rectangle_3_offgrid_fill;
      iconColor = const Color(0xFFBF5AF2);
    }
        
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              productIcon,
              size: 30,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: CupertinoColors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    product.category,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            CupertinoIcons.chevron_right,
            color: CupertinoColors.systemGrey3,
            size: 20,
          ),
        ],
      ),
    );
  }
}

// ==================== SETTINGS PAGE MEJORADA ====================
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String selectedCategory = 'Polos';
    
  final List<String> categories = const [
    'Polos',
    'Camisetas',
    'Pantalones',
    'Zapatillas',
    'Balones',
    'Accesorios',
    'Raquetas',
    'Bicicletas',
  ];
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: null,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoColors.activeBlue,
          onPressed: () => Navigator.pop(context),
        ),
        middle: const Text(
          'Nuevo Producto',
          style: TextStyle(
            color: CupertinoColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      child: Container(
        color: CupertinoColors.systemGroupedBackground,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                                    
                  // Icono decorativo con gradiente
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF32D74B),
                          Color(0xFF30B46C),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF32D74B).withOpacity(0.3),
                          blurRadius: 25,
                          spreadRadius: 3,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.add_circled_solid,
                      size: 50,
                      color: CupertinoColors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                                    
                  const Text(
                    'Agregar Producto',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: CupertinoColors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                                    
                  Text(
                    'Completa la información del producto',
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 35),
                                    
                  // Formulario en card
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.black.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Nombre del producto
                        const Text(
                          'Nombre',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CupertinoTextField(
                          controller: _nameController,
                          placeholder: 'Ej: Nike Air Max',
                          placeholderStyle: const TextStyle(
                            color: CupertinoColors.systemGrey2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefix: const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              CupertinoIcons.cube_box,
                              color: CupertinoColors.activeBlue,
                              size: 22,
                            ),
                          ),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 25),
                                                
                        // Categoría
                        const Text(
                          'Categoría',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => _showCategoryPicker(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey6.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.tag_fill,
                                  color: CupertinoColors.activeBlue,
                                  size: 22,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    selectedCategory,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: CupertinoColors.black,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  CupertinoIcons.chevron_down,
                                  color: CupertinoColors.systemGrey2,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                                                
                        // Precio
                        const Text(
                          'Precio',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CupertinoTextField(
                          controller: _priceController,
                          placeholder: '0.00',
                          placeholderStyle: const TextStyle(
                            color: CupertinoColors.systemGrey2,
                          ),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefix: const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              CupertinoIcons.money_dollar_circle_fill,
                              color: CupertinoColors.activeBlue,
                              size: 22,
                            ),
                          ),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 35),
                                                
                        // Botón Guardar con gradiente
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF32D74B),
                                Color(0xFF30B46C),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF32D74B).withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: CupertinoButton(
                            onPressed: () {
                              if (_nameController.text.isNotEmpty &&
                                  _priceController.text.isNotEmpty) {
                                productList.add(
                                  Product(
                                    name: _nameController.text,
                                    price: double.tryParse(_priceController.text) ?? 0.0,
                                    category: selectedCategory,
                                  ),
                                );
                                                                
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    title: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.check_mark_circled_solid,
                                          color: Color(0xFF32D74B),
                                          size: 28,
                                        ),
                                        SizedBox(width: 10),
                                        Text('¡Éxito!'),
                                      ],
                                    ),
                                    content: const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text('Producto agregado correctamente'),
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _nameController.clear();
                                          _priceController.clear();
                                          Navigator.pushReplacementNamed(context, "/menu");
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    title: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.exclamationmark_triangle_fill,
                                          color: Color(0xFFFF453A),
                                          size: 28,
                                        ),
                                        SizedBox(width: 10),
                                        Text('Error'),
                                      ],
                                    ),
                                    content: const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text('Por favor completa todos los campos'),
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text('OK'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            borderRadius: BorderRadius.circular(15),
                            child: const Text(
                              'Guardar Producto',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: CupertinoColors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void _showCategoryPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 280,
          decoration: const BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Header del picker estilo iOS
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CupertinoColors.systemGrey5,
                      width: 0.5,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text('Cancelar'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Seleccionar Categoría',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: CupertinoColors.black,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text('Listo'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              // Picker
              Expanded(
                child: CupertinoPicker(
                  backgroundColor: CupertinoColors.white,
                  itemExtent: 45,
                  scrollController: FixedExtentScrollController(
                    initialItem: categories.indexOf(selectedCategory),
                  ),
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      selectedCategory = categories[index];
                    });
                  },
                  children: categories.map((String category) {
                    return Center(
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}