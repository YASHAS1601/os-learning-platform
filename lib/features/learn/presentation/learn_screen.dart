import 'package:flutter/material.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_search_bar.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/neon_card.dart';
import '../../../core/widgets/neon_chip.dart';
import '../../../core/widgets/section_header.dart';
import '../data/os_topics_data.dart';
import '../models/topic_model.dart';
import 'topic_detail_screen.dart';


class LearnScreen extends StatefulWidget {
  final VoidCallback? onOpenDrawer;
  final VoidCallback? onOpenProfile;

  const LearnScreen({
    super.key,
    this.onOpenDrawer,
    this.onOpenProfile,
  });

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  String _selectedCategoryId = 'all';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<TopicModel> get _filteredTopics {
    return OsTopicsData.allTopics.where((topic) {
      final matchesCategory = _selectedCategoryId == 'all' || topic.categoryId == _selectedCategoryId;
      final matchesSearch = _searchQuery.isEmpty ||
          topic.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          topic.shortIntro.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final primaryIconColor = isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top App Bar with Hamburger Menu Icon & Avatar Popup
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu_rounded, color: primaryIconColor, size: 28),
                    onPressed: () {
                      if (widget.onOpenDrawer != null) {
                        widget.onOpenDrawer!();
                      } else {
                        Scaffold.of(context).openDrawer();
                      }
                    },
                    tooltip: 'Open Menu',
                  ),
                  PopupMenuButton<String>(
                    offset: const Offset(0, 46),
                    borderRadius: BorderRadius.circular(16),
                    color: isDark ? const Color(0xF70C1B2D) : const Color(0xF7FFFFFF),
                    elevation: 12,
                    shadowColor: isDark ? const Color(0x8000142D) : const Color(0x2E6482A0),
                    padding: EdgeInsets.zero,
                    onSelected: (value) async {
                      if (value == 'profile') {
                        if (widget.onOpenProfile != null) {
                          widget.onOpenProfile!();
                        }
                      } else if (value == 'logout') {
                        final service = SupabaseService.instance;
                        await service.signOut();
                        if (context.mounted) {
                          Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                        }
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'profile',
                        height: 42,
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_rounded,
                              size: 18,
                              color: isDark ? AppColors.neonBlue : AppColors.iconPrimaryLight,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text1(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(
                        height: 1,
                      ),
                      const PopupMenuItem<String>(
                        value: 'logout',
                        height: 42,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_rounded,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.cardGlass(context),
                        border: Border.all(color: primaryIconColor, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: primaryIconColor.withAlpha(isDark ? 80 : 30),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.person_rounded,
                        color: primaryIconColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Personalized Home Greeting
              Text(
                "Let’s jump in, ${SupabaseService.instance.userName ?? 'Yashas'}!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text1(context),
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 4),
              Text(
                "Ready to learn something new?",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.text2(context),
                ),
              ),

              const SizedBox(height: 16),

              // Search Bar
              CustomSearchBar(
                controller: _searchController,
                hintText: "Search algorithms, concepts, paging...",
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Category Filter Pills
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    NeonChip(
                      label: "All Topics (${OsTopicsData.allTopics.length})",
                      isSelected: _selectedCategoryId == 'all',
                      accentColor: primaryIconColor,
                      onTap: () {
                        setState(() {
                          _selectedCategoryId = 'all';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    ...OsTopicsData.categories.map((category) {
                      final isSelected = _selectedCategoryId == category.id;
                      final count = OsTopicsData.allTopics.where((t) => t.categoryId == category.id).length;
                      final chipAccent = isDark ? category.accentColor : AppColors.iconPrimaryLight;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: NeonChip(
                          label: "${category.title} ($count)",
                          isSelected: isSelected,
                          accentColor: chipAccent,
                          onTap: () {
                            setState(() {
                              _selectedCategoryId = category.id;
                            });
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Continue Learning Banner Card (only show if not searching)
              if (_searchQuery.isEmpty && _selectedCategoryId == 'all') ...[
                SectionHeader(
                  title: "Continue Learning",
                  subtitle: "Pick up where you left off",
                  accentColor: primaryIconColor,
                ),
                const SizedBox(height: 12),
                NeonCard(
                  accentColor: primaryIconColor,
                  onTap: () {
                    final fcfsTopic = OsTopicsData.allTopics.firstWhere(
                      (t) => t.id == 'cpu_2',
                      orElse: () => OsTopicsData.allTopics.first,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TopicDetailScreen(topic: fcfsTopic),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryIconColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: primaryIconColor, width: 1.2),
                        ),
                        child: Icon(
                          Icons.speed_rounded,
                          color: primaryIconColor,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryIconColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "CPU SCHEDULING",
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: primaryIconColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "FCFS Scheduling",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text1(context),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "First-Come, First-Served Execution",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.text2(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primaryIconColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // OS Categories Overview Grid (Only if 'all' filter and no search query)
              if (_searchQuery.isEmpty && _selectedCategoryId == 'all') ...[
                SectionHeader(
                  title: "Operating Systems Modules",
                  subtitle: "10 core categories covering 64+ topics",
                  accentColor: primaryIconColor,
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: OsTopicsData.categories.length,
                  itemBuilder: (context, index) {
                    final cat = OsTopicsData.categories[index];
                    final topicCount = OsTopicsData.allTopics.where((t) => t.categoryId == cat.id).length;
                    final catAccent = isDark ? cat.accentColor : AppColors.iconPrimaryLight;
                    return GlassContainer(
                      padding: const EdgeInsets.all(12),
                      borderColor: catAccent.withAlpha(isDark ? 50 : 30),
                      onTap: () {
                        setState(() {
                          _selectedCategoryId = cat.id;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: catAccent.withAlpha(30),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: catAccent, width: 1),
                                ),
                                child: Icon(cat.icon, color: catAccent, size: 18),
                              ),
                              Text(
                                "$topicCount Topics",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: catAccent,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cat.title,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text1(context),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                cat.description,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.text2(context),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],

              // Topic Catalog List
              SectionHeader(
                title: _selectedCategoryId == 'all'
                    ? "All Topics (${_filteredTopics.length})"
                    : "${OsTopicsData.categories.firstWhere((c) => c.id == _selectedCategoryId, orElse: () => OsTopicsData.categories.first).title} Topics (${_filteredTopics.length})",
                subtitle: "Select any topic to view visual explanations & algorithms",
                accentColor: primaryIconColor,
                trailing: _selectedCategoryId != 'all'
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedCategoryId = 'all';
                          });
                        },
                        child: Text("Reset Filter", style: TextStyle(color: primaryIconColor, fontSize: 12)),
                      )
                    : null,
              ),

              const SizedBox(height: 12),

              if (_filteredTopics.isEmpty) ...[
                GlassContainer(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.search_off_rounded, color: AppColors.iconSecondaryLight, size: 40),
                        const SizedBox(height: 8),
                        Text(
                          "No topics matched your search.",
                          style: TextStyle(color: AppColors.text2(context), fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredTopics.length,
                  itemBuilder: (context, index) {
                    final topic = _filteredTopics[index];
                    final category = OsTopicsData.categories.firstWhere(
                      (c) => c.id == topic.categoryId,
                      orElse: () => OsTopicsData.categories.first,
                    );
                    final catAccent = isDark ? category.accentColor : AppColors.iconPrimaryLight;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassContainer(
                        padding: const EdgeInsets.all(14),
                        borderColor: catAccent.withAlpha(isDark ? 40 : 30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TopicDetailScreen(topic: topic),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: catAccent.withAlpha(30),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: catAccent.withAlpha(70), width: 1),
                              ),
                              child: Icon(
                                category.icon,
                                color: catAccent,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          topic.title,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.text1(context),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (topic.isAlgorithmTopic)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          margin: const EdgeInsets.only(left: 6),
                                          decoration: BoxDecoration(
                                            color: primaryIconColor.withAlpha(30),
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: primaryIconColor, width: 0.8),
                                          ),
                                          child: Text(
                                            "ALGO",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: primaryIconColor,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    topic.shortIntro,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.text2(context),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: catAccent,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
