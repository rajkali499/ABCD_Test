import 'package:flutter/material.dart';
import 'package:newapp/ui/components/alert_widget.dart';
import 'package:newapp/ui/components/circle_icon_widget.dart';
import 'package:newapp/ui/components/app_logo_widget.dart';
import 'package:newapp/ui/components/my_track.dart';
import 'package:newapp/ui/components/notification_widget.dart';
import 'package:newapp/ui/components/profile_widget.dart';
import 'package:newapp/ui/components/search_widget.dart';

class TopHeaderWidget extends StatelessWidget {
  const TopHeaderWidget({
    super.key,
    required this.header,
    required this.isCollapsed,
  });

  final ValueNotifier<double> header;
  final ValueNotifier<bool> isCollapsed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: header,
      builder: (context, val, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: val,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ValueListenableBuilder<bool>(
              valueListenable: isCollapsed,
              builder: (context, isCollapse, _) {
                return isCollapse ? _buildCollapsedHeader() : _buildExpandedHeader();
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCollapsedHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfileWidget(),
            SizedBox(width: 20),
            Flexible(child: SearchWidget()),
            SizedBox(width: 20),
            AlertWidget(),
            SizedBox(width: 20),
            NotificationWidget(),
          ],
        ),
        _buildCashbackAndCoins(),
        const SizedBox(),
        const SizedBox(),
      ],
    );
  }

  Widget _buildExpandedHeader() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfileWidget(),
            AppLogoWidget(),
            NotificationWidget(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 16),
            Flexible(child: SearchWidget()),
            SizedBox(width: 8),
            AlertWidget(),
            SizedBox(width: 16),
          ],
        ),
        Flexible(
          child: MyTrack(),
        ),
        SizedBox(),
        SizedBox(),
      ],
    );
  }

  Widget _buildCashbackAndCoins() {
    return Container(
      height: 40,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white54,
      ),
      child: const Center(
        child: Row(
          children: [
            SizedBox(width: 20),
            SizedBox(
              height: 30,
              width: 80,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: CircleIconWidget(),
                  ),
                  Positioned(
                    left: 15,
                    top: 0,
                    child: CircleIconWidget(),
                  ),
                ],
              ),
            ),
            Text("Payment Options", textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
