import 'package:apexcify_technologys_profile_page/profile_page_core.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  UserModel profile = UserModel(
    name: 'MacMaurice Osuji',
    email: 'maurice.mercer@apexcify.tech',
    bio:
        'Flutter Engineer at ApexcifyTechnologys. Passionate about crafting seamless mobile experiences and pushing the boundaries of cross-platform development. 5+ years building scalable apps.',
    role: 'Flutter Engineer',
    location: 'San Francisco, CA',
    phone: '+1 (415) 000-1234',
  );

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(duration: const Duration(milliseconds: 900), vsync: this);
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _openEditPage() async {
    final updated = await Navigator.push<UserModel>(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, _) => EditProfilePage(profile: profile),
        transitionsBuilder: (_, animation, _, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );

    if (updated != null) {
      setState(() {
        profile = updated;
      });
      // Re-run entrance animation to reflect update
      _animController.reset();
      _animController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0F),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openEditPage,
        backgroundColor: const Color(0xFF0A84FF),
        foregroundColor: Colors.white,
        elevation: 6,
        icon: const Icon(Icons.edit_rounded),
        label: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.3),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: const Color(0xFF0D0D0F),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background gradient
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF0A84FF), Color(0xFF5E5CE6), Color(0xFF0D0D0F)],
                            stops: [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                      // Decorative circles
                      Positioned(
                        top: -40,
                        right: -40,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.05),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 60,
                        left: -30,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.04),
                          ),
                        ),
                      ),
                      // Avatar + name
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 65,
                                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: const Color(0xFF1C1C1E),
                                    child: Text(
                                      profile.name.isNotEmpty ? profile.name[0].toUpperCase() : 'A',
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF0A84FF),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF30D158),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFF0D0D0F), width: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              profile.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              profile.role,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.65),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Branding title (collapsed state)
                title: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A84FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'APEX',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Content ──────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bio Card
                      SectionCard(
                        title: 'About',
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            profile.bio,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.78),
                              fontSize: 14.5,
                              height: 1.6,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Contact Info Card
                      SectionCard(
                        title: 'Contact Information',
                        child: Column(
                          children: [
                            InfoTile(
                              icon: Icons.email_outlined,
                              label: 'Email',
                              value: profile.email,
                              iconColor: const Color(0xFF0A84FF),
                            ),
                            CustomDivider(),
                            InfoTile(
                              icon: Icons.phone_outlined,
                              label: 'Phone',
                              value: profile.phone,
                              iconColor: const Color(0xFF30D158),
                            ),
                            CustomDivider(),
                            InfoTile(
                              icon: Icons.location_on_outlined,
                              label: 'Location',
                              value: profile.location,
                              iconColor: const Color(0xFFFF9F0A),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Company Card
                      SectionCard(
                        title: 'Company',
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF0A84FF), Color(0xFF5E5CE6)],
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'A',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          title: const Text(
                            'ApexcifyTechnologys',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            'Technology & Software',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 13,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Stats Row
                      Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              value: '5+',
                              label: 'Years Exp.',
                              color: const Color(0xFF0A84FF),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              value: '48',
                              label: 'Projects',
                              color: const Color(0xFF5E5CE6),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              value: '12k',
                              label: 'Commits',
                              color: const Color(0xFF30D158),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
