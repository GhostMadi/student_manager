import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/storage/storage_service.dart';

@RoutePage()
class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({super.key});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  static const _avatarUrl = 'https://picsum.photos/seed/studentprofile/400/400';

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  var _controllersReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controllersReady) return;

    final firebaseUser = FirebaseAuth.instance.currentUser;
    final storedName = StorageService.instance.userName?.trim();
    final firebaseName = firebaseUser?.displayName?.trim();
    final name = (storedName != null && storedName.isNotEmpty)
        ? storedName
        : (firebaseName != null && firebaseName.isNotEmpty)
        ? firebaseName
        : (firebaseUser?.email?.split('@').first ?? '');

    _nameController = TextEditingController(text: name);
    _emailController = TextEditingController(text: firebaseUser?.email ?? '');
    _phoneController = TextEditingController();
    _controllersReady = true;
  }

  @override
  void dispose() {
    if (_controllersReady) {
      _nameController.dispose();
      _emailController.dispose();
      _phoneController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controllersReady) {
      return const Scaffold(body: SizedBox.shrink());
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.west, color: AppColors.deepBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.l10n.profileTitle,
          style: TextStyle(color: AppColors.deepBlack, fontSize: 17, fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.l10n.doneButton,
              style: TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.surfaceWhite,
                    child: ClipOval(
                      child: Image.network(
                        _avatarUrl,
                        width: 92,
                        height: 92,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/jpg/profile.jpg',
                            width: 92,
                            height: 92,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: AppColors.primaryOrange, shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildField(context.l10n.nameLabel, _nameController, enabled: true),
            _buildField(context.l10n.email, _emailController, enabled: false),
            _buildField(context.l10n.phoneLabel, _phoneController, enabled: true),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {required bool enabled}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          TextField(
            controller: controller,
            enabled: enabled,
            cursorColor: AppColors.primaryOrange,
            style: const TextStyle(color: AppColors.deepBlack, fontSize: 15),
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.surfaceWhite)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryOrange)),
              disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.surfaceWhite)),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}
