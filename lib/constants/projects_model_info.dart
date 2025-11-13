import 'package:my_portfolio/models/projects_info.dart';

final List<Project> myProjects = [
  Project(
    title: "Portfolio",
    img: "assets/images/projects/Portfolio.jpg",
    applicationLink: "",
    gitHubLink: "https://github.com/RamadanMohamed11/MyPortfolio",
    subtitle: "A personal portfolio showcasing my projects and skills.",
    problem: "As a developer, I needed a professional platform to showcase my work, skills, and experience to potential employers and clients. Traditional portfolios lacked the interactivity and modern design I wanted to represent my personal brand.",
    solution: "I designed and developed a fully responsive Flutter web portfolio with smooth animations, dark theme, and sections highlighting my projects, skills, experience, and contact information. The portfolio features a modern UI with custom animations and transitions, making it engaging and memorable.",
    techStack: [
      TechStackItem(
        name: "Flutter",
        reason: "Chosen for its cross-platform capabilities and beautiful UI components, allowing me to create a single codebase that works seamlessly on web, mobile, and desktop.",
        iconPath: "assets/images/flutter.png",
      ),
      TechStackItem(
        name: "Dart",
        reason: "Flutter's native language, providing strong type safety and excellent performance for building smooth animations and responsive layouts.",
        iconPath: "assets/images/dart.png",
      ),
    ],
    challenges: "One of the main challenges was creating smooth animations that performed well across different screen sizes and devices. I also struggled with optimizing images for web while maintaining quality.",
    lessonsLearned: "I learned advanced animation techniques in Flutter, responsive design principles, and how to optimize web applications for performance. This project taught me the importance of user experience and visual storytelling in portfolio presentation.",
  ),
  Project(
    title: "Student Attendance App",
    img: "assets/images/projects/Student_Attendance.jpg",
    applicationLink: "",
    gitHubLink: "https://github.com/RamadanMohamed11/Student-Attendance-V1.1",
    subtitle: "This cross-platform app streamlines attendance tracking for students and teachers, offering a modern, efficient, and user-friendly experience.",
    problem: "Traditional attendance systems in educational institutions are time-consuming, error-prone, and often involve manual paper-based processes. Teachers waste valuable class time on roll calls, and students have no easy way to track their attendance records.",
    solution: "I developed a cross-platform mobile application that digitizes the entire attendance process. Teachers can quickly mark attendance with a few taps, while students can view their attendance history in real-time. The app includes features like automatic notifications for low attendance, attendance reports, and QR code scanning for quick check-ins.",
    techStack: [
      TechStackItem(
        name: "Flutter",
        reason: "Perfect for creating a unified experience across iOS and Android with a single codebase, reducing development time by 50%.",
        iconPath: "assets/images/flutter.png",
      ),
      TechStackItem(
        name: "Firebase",
        reason: "Provides real-time database sync, user authentication, and cloud storage for attendance records with minimal backend setup.",
        iconPath: "assets/images/firebase.png",
      ),
      TechStackItem(
        name: "Dart",
        reason: "Strong typing and null safety features help prevent common errors in handling attendance data.",
        iconPath: "assets/images/dart.png",
      ),
    ],
    challenges: "The biggest challenge was handling offline scenarios where internet connectivity was poor. I also had to implement a robust role-based access control system to ensure data security and prevent unauthorized access.",
    lessonsLearned: "I gained deep knowledge of Firebase's real-time database, learned how to implement offline-first architecture, and mastered state management using Bloc pattern. This project taught me the importance of user feedback and iterative design.",
  ),
  Project(
    title: "Notes App",
    img: "assets/images/projects/Notes.jpg",
    applicationLink: "",
    gitHubLink: "https://github.com/RamadanMohamed11/Notes-App",
    subtitle: "Allows users to create, edit, search, and delete notes with a simple interface using Hive and Bloc.",
    problem: "Users needed a fast, offline-capable note-taking app that doesn't require an internet connection or cloud storage. Existing solutions were either too complex or required constant internet access.",
    solution: "I built a lightweight note-taking application with local storage using Hive. The app features color-coded notes, search functionality, and instant sync without internet dependency. Users can create, edit, and organize notes with a clean, minimalist interface.",
    techStack: [
      TechStackItem(
        name: "Flutter",
        reason: "Enables rapid development of beautiful, natively compiled applications for mobile platforms.",
        iconPath: "assets/images/flutter.png",
      ),
      TechStackItem(
        name: "Hive",
        reason: "Chosen for its blazing-fast local storage, zero-config setup, and strong encryption support. It's significantly faster than SQLite for simple key-value operations.",
      ),
      TechStackItem(
        name: "Bloc Pattern",
        reason: "Implemented for clean separation of business logic from UI, making the code more testable and maintainable.",
      ),
    ],
    challenges: "The main challenge was implementing efficient search across thousands of notes while maintaining smooth UI performance. I also had to ensure data persistence and handle edge cases like app termination during write operations.",
    lessonsLearned: "I learned how to implement local database management with Hive, master the Bloc pattern for state management, and optimize search algorithms for mobile devices. This project reinforced the importance of offline-first design.",
  ),
  Project(
      title: "Slogan",
      img: "assets/images/projects/Slogan.jpg",
      applicationLink: "",
      gitHubLink: "https://github.com/RamadanMohamed11/Slogan-App",
      subtitle: "An Islamic application for daily praise."),
  Project(
      title: "XO Game",
      img: "assets/images/projects/XO_Game.jpg",
      applicationLink: "",
      gitHubLink: "https://github.com/RamadanMohamed11/XO-Game",
      subtitle:
          "A classic Tic-Tac-Toe game (single and multiplayer) to enjoy with friends."),
  Project(
      title: "Weather",
      img: "assets/images/projects/Weather.jpg",
      applicationLink: "",
      gitHubLink: "https://github.com/RamadanMohamed11/Weather-App",
      subtitle:
          "A weather app providing forecasts and climate information from an API."),
  Project(
      title: "News",
      img: "assets/images/projects/News.jpg",
      applicationLink: "",
      gitHubLink: "https://github.com/RamadanMohamed11/News-App",
      subtitle: "A news aggregator app delivering the latest headlines."),
  Project(
      title: "Tasbih",
      img: "assets/images/projects/Tasbih.jpg",
      applicationLink: "",
      gitHubLink: "https://github.com/RamadanMohamed11/Tasbih-App",
      subtitle: "An Islamic application for daily praise."),
  Project(
      title: "Calculator",
      img: "assets/images/projects/Calculator.jpg",
      applicationLink: "",
      gitHubLink: "https://github.com/RamadanMohamed11/Calculator-App",
      subtitle: "Calculator with more than one design in one application."),
  Project(
      title: "Meal App",
      img: "assets/images/projects/Meal.jpg",
      applicationLink: "",
      gitHubLink: "https://github.com/RamadanMohamed11/Meal-App",
      subtitle:
          "A modern Flutter application that allows users to browse, filter, and favorite meals with a beautiful and responsive UI."),
];
