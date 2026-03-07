class Project {
  String title;
  String subtitle;
  String img;
  String gitHubLink;
  String applicationLink;

  // New fields for detailed project page
  String problem;
  String solution;
  List<TechStackItem> techStack;
  String challenges;
  String lessonsLearned;
  List<String> screenshots; // Additional images/GIFs
  String? demoVideoUrl;

  /// URL-friendly slug derived from the title.
  /// e.g. "Student Attendance App" → "student-attendance-app"
  String get slug => title
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-|-$'), '');

  Project({
    required this.title,
    required this.img,
    required this.gitHubLink,
    required this.subtitle,
    required this.applicationLink,
    this.problem = '',
    this.solution = '',
    this.techStack = const [],
    this.challenges = '',
    this.lessonsLearned = '',
    this.screenshots = const [],
    this.demoVideoUrl,
  });

  /// Look up a project by its slug. Returns null if not found.
  static Project? findBySlug(List<Project> projects, String slug) {
    try {
      return projects.firstWhere((p) => p.slug == slug);
    } catch (_) {
      return null;
    }
  }
}

class TechStackItem {
  String name;
  String reason;
  String? iconPath;

  TechStackItem({
    required this.name,
    required this.reason,
    this.iconPath,
  });
}
