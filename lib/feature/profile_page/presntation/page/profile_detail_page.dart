import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';

@RoutePage()
class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({super.key});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  final TextEditingController _nameController = TextEditingController(text: "Aruka Aruka");
  final TextEditingController _phoneController = TextEditingController(text: "+7 707 000 00 00");
  final String _userEmail = "aruka@gmail.com";

  @override
  Widget build(BuildContext context) {
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
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.surfaceWhite,
                    backgroundImage: AssetImage('assets/jpg/profile.jpg'),
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
            _buildField(context.l10n.email, TextEditingController(text: _userEmail), enabled: false),
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
