import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/models/projects_info.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailPageDesktop extends StatelessWidget {
  final Project project;

  const ProjectDetailPageDesktop({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomScrollView(
          slivers: [
            // App Bar with back button
            SliverAppBar(
              pinned: true,
              expandedHeight: 300.h,
              backgroundColor: CustomColor.bgLighter1,
              leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: CustomColor.myYellow, size: 10.sp),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  project.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 8.sp,
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      project.img,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            CustomColor.bgLighter1.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 28.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Overview
                    _buildSection(
                      title: "Overview",
                      child: Text(
                        project.subtitle,
                        style: TextStyle(
                          fontSize: 6.sp,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Featured Project Image
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        constraints: BoxConstraints(
                          maxWidth: 560.w,
                          maxHeight: 360.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: CustomColor.myYellow.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            project.img,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // The Problem
                    if (project.problem.isNotEmpty)
                      _buildSection(
                        title: "The Problem",
                        icon: Icons.warning_amber_rounded,
                        child: Text(
                          project.problem,
                          style: TextStyle(
                            fontSize: 6.sp,
                            color: Colors.white70,
                            height: 1.6,
                          ),
                        ),
                      ),

                    if (project.problem.isNotEmpty) SizedBox(height: 30.h),

                    // The Solution
                    if (project.solution.isNotEmpty)
                      _buildSection(
                        title: "My Solution",
                        icon: Icons.lightbulb_outline_rounded,
                        child: Text(
                          project.solution,
                          style: TextStyle(
                            fontSize: 6.sp,
                            color: Colors.white70,
                            height: 1.6,
                          ),
                        ),
                      ),

                    if (project.solution.isNotEmpty) SizedBox(height: 30.h),

                    // Tech Stack & Justification
                    if (project.techStack.isNotEmpty)
                      _buildSection(
                        title: "Tech Stack & Justification",
                        icon: Icons.code_rounded,
                        child: Column(
                          children: project.techStack.map((tech) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 15.h),
                              padding: EdgeInsets.all(15.sp),
                              decoration: BoxDecoration(
                                color: CustomColor.bgLighter2,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: CustomColor.myYellow.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (tech.iconPath != null)
                                    Container(
                                      width: 50.w,
                                      height: 50.h,
                                      margin: EdgeInsets.only(right: 15.w),
                                      decoration: BoxDecoration(
                                        color: CustomColor.bgLighter1,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.all(8.sp),
                                      child: Image.asset(
                                        tech.iconPath!,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tech.name,
                                          style: TextStyle(
                                            fontSize: 6.5.sp,
                                            fontWeight: FontWeight.bold,
                                            color: CustomColor.myYellow,
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          tech.reason,
                                          style: TextStyle(
                                            fontSize: 5.5.sp,
                                            color: Colors.white70,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                    if (project.techStack.isNotEmpty) SizedBox(height: 30.h),

                    // Challenges & Lessons Learned
                    if (project.challenges.isNotEmpty ||
                        project.lessonsLearned.isNotEmpty)
                      _buildSection(
                        title: "Challenges & Lessons Learned",
                        icon: Icons.school_rounded,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (project.challenges.isNotEmpty) ...[
                              Text(
                                "Challenges:",
                                style: TextStyle(
                                  fontSize: 6.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColor.myYellow,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                project.challenges,
                                style: TextStyle(
                                  fontSize: 6.sp,
                                  color: Colors.white70,
                                  height: 1.6,
                                ),
                              ),
                            ],
                            if (project.challenges.isNotEmpty &&
                                project.lessonsLearned.isNotEmpty)
                              SizedBox(height: 20.h),
                            if (project.lessonsLearned.isNotEmpty) ...[
                              Text(
                                "What I Learned:",
                                style: TextStyle(
                                  fontSize: 6.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColor.myYellow,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                project.lessonsLearned,
                                style: TextStyle(
                                  fontSize: 6.sp,
                                  color: Colors.white70,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                    if (project.challenges.isNotEmpty ||
                        project.lessonsLearned.isNotEmpty)
                      SizedBox(height: 30.h),

                    // Screenshots Gallery
                    if (project.screenshots.isNotEmpty)
                      _buildSection(
                        title: "Screenshots & Demos",
                        icon: Icons.photo_library_rounded,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 15.w,
                            mainAxisSpacing: 15.h,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: project.screenshots.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                project.screenshots[index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),

                    if (project.screenshots.isNotEmpty) SizedBox(height: 30.h),

                    // Action Buttons
                    Row(
                      children: [
                        if (project.gitHubLink.isNotEmpty)
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                launchUrl(
                                  Uri.parse(project.gitHubLink),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              icon: Icon(Icons.code, size: 7.sp),
                              label: Text(
                                "View on GitHub",
                                style: TextStyle(fontSize: 6.sp),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColor.myYellow,
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        if (project.gitHubLink.isNotEmpty &&
                            project.applicationLink.isNotEmpty)
                          SizedBox(width: 15.w),
                        if (project.applicationLink.isNotEmpty)
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                launchUrl(
                                  Uri.parse(project.applicationLink),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              icon: Icon(Icons.open_in_new, size: 7.sp),
                              label: Text(
                                "Live Demo",
                                style: TextStyle(fontSize: 6.sp),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: CustomColor.myYellow,
                                side: const BorderSide(
                                    color: CustomColor.myYellow, width: 2),
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    IconData? icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: CustomColor.myYellow, size: 10.sp),
              SizedBox(width: 10.w),
            ],
            Text(
              title,
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        child,
      ],
    );
  }
}
