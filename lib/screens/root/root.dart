import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym_management/screens/users/users.dart';
import 'package:gym_management/theme.dart';
import 'package:gym_management/translations/locale_keys.g.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: UsersScreen(
              isActiveUsers: currentIndex == 0,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.secondary,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: currentIndex == 0
                          ? Container(
                              height: 2.0,
                              color: Theme.of(context).colorScheme.onSecondary,
                            )
                          : const SizedBox(),
                    ),
                    Expanded(
                      child: currentIndex == 1
                          ? Container(
                              height: 2.0,
                              color: Theme.of(context).colorScheme.onSecondary,
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 70.0,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              currentIndex = 0;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/users.svg',
                                colorFilter: currentIndex == 0
                                    ? ColorFilter.mode(
                                        Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        BlendMode.srcIn,
                                      )
                                    : const ColorFilter.mode(
                                        CustomColors.kLightGreyColor,
                                        BlendMode.srcIn,
                                      ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                LocaleKeys.active_users.tr(),
                                style: currentIndex == 0
                                    ? Theme.of(context).textTheme.bodyMedium
                                    : Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 70.0,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              currentIndex = 1;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/calendar.svg',
                                colorFilter: currentIndex == 1
                                    ? ColorFilter.mode(
                                        Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        BlendMode.srcIn,
                                      )
                                    : const ColorFilter.mode(
                                        CustomColors.kLightGreyColor,
                                        BlendMode.srcIn,
                                      ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                LocaleKeys.expired_users.tr(),
                                style: currentIndex == 1
                                    ? Theme.of(context).textTheme.bodyMedium
                                    : Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
