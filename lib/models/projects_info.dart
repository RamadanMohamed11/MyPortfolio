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
