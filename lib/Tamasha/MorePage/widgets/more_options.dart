import 'package:flutter/material.dart';
import 'package:tamasha_bp/Tamasha/MorePage/FurtherMore/contact_us.dart';
import 'package:tamasha_bp/Tamasha/MorePage/FurtherMore/invite_friends.dart';
import 'package:tamasha_bp/Tamasha/MorePage/FurtherMore/promo.dart';
import 'package:tamasha_bp/Tamasha/MorePage/FurtherMore/watch_history.dart';
import 'package:tamasha_bp/Tamasha/MorePage/model/more_widget.dart';
// import 'package:tamasha_bp/Tamasha/MorePage/more_helper.dart';
import 'package:tamasha_bp/Tamasha/MorePage/widgets/web_view.dart';

List<MoreOption> getOptions(BuildContext context) {
  return [
    MoreOption(
        icon: Icons.account_balance_wallet_rounded,
        text: 'Subscription Packages',
        onTap: () => debugPrint('Subscription Packages tapped'),
        routeName: ''),
    MoreOption(
        icon: Icons.history,
        text: 'Watch History',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WatchHistory()),
          );
        },
        routeName: ''),
    MoreOption(
        icon: Icons.card_giftcard,
        text: 'My Rewards',
        onTap: () => debugPrint('My Rewards tapped'),
        routeName: ''),
    MoreOption(
        icon: Icons.local_offer,
        text: 'Promo',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Promo()),
          );
        },
        routeName: ''),
    MoreOption(
        icon: Icons.person_add,
        text: 'Invite Friends',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InviteFriends()),
          );
        },
        routeName: ''),
    MoreOption(
        icon: Icons.security,
        text: 'Terms & Conditions',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const WebViewPage(
                    url: 'https://jazz.com.pk/mobile-apps/tamasha')),
          );
        },
        routeName: ''),
    MoreOption(
        icon: Icons.message_rounded,
        text: 'Contact Us',
        // onTap: () {},
        onTap: () => ExternalAppsHelper.openWhatsapp('+923003111119'),
        routeName: '',
        child: Row(
          children: [
            const SizedBox(width: 12),
            const Icon(
              Icons.call,
              size: 24,
              color: Colors.green,
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(5),
              ),
              child: const Text('0300-3111119',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 120, 241),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        )),
  ];
}
