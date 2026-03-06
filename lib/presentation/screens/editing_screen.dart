import 'package:apexcify_technologys_profile_page/profile_page_core.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel profile;
  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _bioCtrl;
  late final TextEditingController _roleCtrl;
  late final TextEditingController _locationCtrl;
  late final TextEditingController _phoneCtrl;

  final _formKey = GlobalKey<FormState>();
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _nameCtrl = TextEditingController(text: p.name);
    _emailCtrl = TextEditingController(text: p.email);
    _bioCtrl = TextEditingController(text: p.bio);
    _roleCtrl = TextEditingController(text: p.role);
    _locationCtrl = TextEditingController(text: p.location);
    _phoneCtrl = TextEditingController(text: p.phone);

    for (final ctrl in [_nameCtrl, _emailCtrl, _bioCtrl, _roleCtrl, _locationCtrl, _phoneCtrl]) {
      ctrl.addListener(_onChanged);
    }
  }

  void _onChanged() => setState(() => _hasChanges = true);

  @override
  void dispose() {
    for (final ctrl in [_nameCtrl, _emailCtrl, _bioCtrl, _roleCtrl, _locationCtrl, _phoneCtrl]) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final updated = UserModel(
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        bio: _bioCtrl.text.trim(),
        role: _roleCtrl.text.trim(),
        location: _locationCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
      );
      Navigator.pop(context, updated);
    }
  }

  void _discard() {
    if (_hasChanges) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: const Color(0xFF1C1C1E),
          title: const Text('Discard changes?', style: TextStyle(color: Colors.white)),
          content: Text(
            'Your changes will not be saved.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Keep Editing', style: TextStyle(color: Color(0xFF0A84FF))),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Discard', style: TextStyle(color: Color(0xFFFF453A))),
            ),
          ],
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0F),
        elevation: 0,
        leading: TextButton(
          onPressed: _discard,
          child: Text(
            'Cancel',
            style: TextStyle(
              color: _hasChanges ? const Color(0xFFFF453A) : const Color(0xFF0A84FF),
              fontSize: 15,
            ),
          ),
        ),
        leadingWidth: 80,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _hasChanges ? _save : null,
            child: Text(
              'Save',
              style: TextStyle(
                color: _hasChanges ? const Color(0xFF0A84FF) : Colors.white.withValues(alpha: 0.25),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 0.5, color: Colors.white.withValues(alpha: 0.1)),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Avatar preview
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFF1C1C1E),
                    child: ValueListenableBuilder(
                      valueListenable: _nameCtrl,
                      builder: (_, value, _) => Text(
                        value.text.isNotEmpty ? value.text[0].toUpperCase() : 'A',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0A84FF),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A84FF),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF0D0D0F), width: 2),
                      ),
                      child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
            SectionEditor(
              title: 'PERSONAL INFO',
              children: [
                EditFields(
                  controller: _nameCtrl,
                  label: 'Full Name',
                  icon: Icons.person_outline_rounded,
                  validator: (v) => v == null || v.trim().isEmpty ? 'Name is required' : null,
                ),
                EditFields(
                  controller: _roleCtrl,
                  label: 'Job Title',
                  icon: Icons.work_outline_rounded,
                ),
                EditFields(
                  controller: _bioCtrl,
                  label: 'Bio',
                  icon: Icons.notes_rounded,
                  maxLines: 4,
                ),
              ],
            ),

            const SizedBox(height: 20),
            SectionEditor(
              title: 'CONTACT',
              children: [
                EditFields(
                  controller: _emailCtrl,
                  label: 'Email Address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Email is required';
                    if (!v.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                EditFields(
                  controller: _phoneCtrl,
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                EditFields(
                  controller: _locationCtrl,
                  label: 'Location',
                  icon: Icons.location_on_outlined,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Save Button
            AnimatedOpacity(
              opacity: _hasChanges ? 1.0 : 0.4,
              duration: const Duration(milliseconds: 200),
              child: SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: _hasChanges ? _save : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A84FF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
