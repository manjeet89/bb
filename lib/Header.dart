import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLogo;

  const CommonAppBar({super.key, this.title, this.showLogo = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,

      /// Title or Logo
      title: showLogo
          ? Image.asset("assest/CFBBI.png", scale: 3,height: 70,)
          : Text(title ?? "", style: const TextStyle(color: Colors.black)),

      /// Right Side Widget
      actions: const [Padding(padding: EdgeInsets.only(right: 12), child: SosBellWidget())],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// ================= COMMON SOS + BELL =================
class SosBellWidget extends StatelessWidget {
  const SosBellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigatorKey.currentState?.pushNamed('/sos');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔔 Bell
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed('/Notification');
                  },
                  child: const Icon(
                    Icons.notifications_active,
                    color: AppColors.AddButtonColor,
                    size: 22,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 8),

            /// 🖼 Image
            // CircleAvatar(
            //   radius: 14,
            //   backgroundColor: AppColors.primarycolor.withOpacity(0.1),
            //   child: Image.asset("assest/petdog.png", width: 18),
            // ),

            const SizedBox(width: 8),

            /// 🚨 SOS
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.errorRed,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: AppColors.errorRed.withOpacity(0.6), blurRadius: 12)],
              ),
              child: const Text(
                "SOS",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ).animate().scale(duration: 800.ms).then().scale(),
          ],
        ),
      ),
    );
  }
}
