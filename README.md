
# 🍏 Sports Store iOS – Aplicación de Gestión de Productos

**Sports Store iOS** es una aplicación móvil desarrollada con **Flutter**, inspirada en la estética moderna y minimalista de **iOS (Cupertino)**.  
El proyecto simula una **tienda de deportes** con autenticación, navegación por categorías, y registro de productos, todo bajo un diseño fluido y elegante.

---

## ✨ Características Destacadas

✅ **Diseño Nativo Cupertino**  
Uso exclusivo de widgets de la librería `flutter/cupertino.dart` para una experiencia 100% iOS.  

🎨 **Estética Moderna y Minimalista**  
Pantallas con gradientes dinámicos, formas suaves y el efecto **Glassmorphism** (fondo borroso).  

⚡ **Animaciones Fluidas**  
Transiciones suaves en la pantalla de bienvenida y navegación intuitiva entre secciones.  

🛍️ **Gestión de Productos**  
Catálogo interactivo con navegación por categorías y formulario para agregar nuevos artículos.  

🧩 **Estado Simplificado**  
Estructura basada en `StatefulWidget` para manejar formularios y filtros de manera eficiente.  

---

## 🚀 Instalación y Ejecución

Sigue los pasos a continuación para ejecutar el proyecto en tu entorno local:

### 1️⃣ Requisitos Previos
Asegúrate de tener instalado:

- [Flutter SDK (versión estable)](https://flutter.dev/docs/get-started/install)
- VS Code o Android Studio
- Un dispositivo o emulador configurado (Android, iOS o Web)

---

### 2️⃣ Clonar el Repositorio
*(Si ya estás dentro del directorio del proyecto, puedes omitir este paso.)*

```bash
cd C:\Users\Anjeli\LAB12-MULTIPLATAFORMA
````

---

### 3️⃣ Obtener Dependencias

Instala todas las dependencias necesarias, incluyendo las que permiten usar filtros y efectos visuales:

```bash
flutter pub get
```

---

### 4️⃣ Ejecutar la Aplicación

Ejecuta la app en el entorno de tu preferencia:

```bash
# En Chrome (Web)
flutter run -d chrome

# En Windows
flutter run -d windows

# En Android o iOS
flutter run
```

---

## 📂 Estructura del Proyecto

```
lib/
│
├── main.dart           # Punto de entrada de la aplicación
│
├── models/
│   └── product.dart    # Modelo de datos para los productos
│
├── pages/
│   ├── welcome_page.dart   # Pantalla de bienvenida animada
│   ├── login_page.dart     # Pantalla de autenticación (Glassmorphism)
│   ├── menu_page.dart      # Menú principal con navegación
│   ├── home_page.dart      # Listado de productos y filtros
│   └── settings_page.dart  # Formulario para agregar productos
│
└── widgets/
    └── common_widgets.dart # Componentes reutilizables
```

---

## 🎨 Paleta de Colores Principal

| Uso                             | Color | Código HEX | Descripción                                     |
| ------------------------------- | ----- | ---------- | ----------------------------------------------- |
| **Acento Principal (Indigo)**   | 🔵    | `#3B5998`  | Tono principal de la marca y botones            |
| **Fondo Oscuro**                | ⚫     | `#192A56`  | Gradiente base para pantallas de inicio y login |
| **Acento Éxito (Verde iOS)**    | 🟢    | `#32D74B`  | Usado para confirmaciones o acciones positivas  |
| **Fondo Agrupado (Gris Claro)** | ⚪     | `#F2F2F7`  | Color nativo de iOS para secciones agrupadas    |

---

## 🧠 Arquitectura y Diseño

* **Patrón estructural:** separación lógica por pantallas (pages) y componentes (widgets).
* **UI:** basada en el sistema Cupertino con personalización de bordes, transparencias y blur effects.
* **UX:** enfoque intuitivo, accesible y limpio, siguiendo las guías de diseño de Apple.

---

## 💡 Autor

**Desarrollado por:** Anjeli Verastigue
📱 Proyecto académico - Flutter Multiplataforma
📆 2025

---
