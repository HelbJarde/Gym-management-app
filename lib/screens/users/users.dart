import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym_management/main.dart';
import 'package:gym_management/models/user1.dart';
import 'package:gym_management/screens/add_edit/add_edit.dart';
import 'package:gym_management/services/user.dart';
import 'package:gym_management/theme.dart';
import 'package:gym_management/translations/locale_keys.g.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({
    super.key,
    required this.isActiveUsers,
  });

  final bool isActiveUsers;

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  ValueNotifier<String> searchNotifier = ValueNotifier('');

  List<User1> getUsers() {
    List<User1> usersList = [];

    for (var element in UserService.usersList.value) {
      var jalaliDate1 = Jalali.now().toDateTime();

      int endDateYear = int.parse(element.endDate!.split('/')[0]);
      int endDateMonth = int.parse(element.endDate!.split('/')[1]);
      int endDateDay = int.parse(element.endDate!.split('/')[2]);

      var jalaliDate2 =
          Jalali(endDateYear, endDateMonth, endDateDay).toDateTime();

      if (widget.isActiveUsers) {
        if (jalaliDate2.isAfter(jalaliDate1)) {
          usersList.add(element);
        }
      } else {
        if (!jalaliDate2.isAfter(jalaliDate1)) {
          usersList.add(element);
        }
      }
    }

    return usersList;
  }

  @override
  void initState() {
    UserService.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.isActiveUsers
          ? FloatingActionButton(
              backgroundColor: CustomColors.kPrimaryColor,
              elevation: 0.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddEditScreen(
                        user: User1(),
                      );
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                color: CustomColors.kWhiteColor,
              ),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.users_gym_vesam.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (context.locale == const Locale('en')) {
                        context.setLocale(const Locale('fa'));
                      } else {
                        context.setLocale(const Locale('en'));
                      }
                    },
                    icon: context.locale == const Locale('en')
                        ? SvgPicture.asset(
                            'assets/icons/iran.svg',
                            width: 25.0,
                            height: 25.0,
                            fit: BoxFit.cover,
                          )
                        : SvgPicture.asset(
                            'assets/icons/us.svg',
                            width: 25.0,
                            height: 25.0,
                            fit: BoxFit.cover,
                          ),
                  ),
                  IconButton(
                    onPressed: () async {
                      isThemeDark.value = !isThemeDark.value;
                      await sharedPreferences.setBool(
                          'isDark', isThemeDark.value);
                    },
                    icon: isThemeDark.value
                        ? SvgPicture.asset(
                            'assets/icons/dark.svg',
                          )
                        : SvgPicture.asset(
                            'assets/icons/light.svg',
                          ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await UserService.getUsers();
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/refresh.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextField(
                onChanged: (value) {
                  if (value.isEmpty) {
                    UserService.getUsers();
                  } else {
                    UserService.getUsersByFullName(value);
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.all(14.0),
                  hintText: LocaleKeys.search_by_fullname.tr(),
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: widget.isActiveUsers
                      ? CustomColors.kGreenColor
                      : CustomColors.kRedColor,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Row(
                  children: [
                    Text(
                      widget.isActiveUsers
                          ? LocaleKeys.count_of_active_users.tr()
                          : LocaleKeys.count_of_inactive_users.tr(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: CustomColors.kWhiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    ValueListenableBuilder(
                      valueListenable: UserService.usersList,
                      builder: (context, value, child) {
                        return Text(
                          LocaleKeys.people.tr(
                            namedArgs: {
                              "count": getUsers().length.toString(),
                            },
                          ),
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: CustomColors.kWhiteColor,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: UserService.usersList,
                  builder: (context, value, child) {
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 100),
                      itemCount: getUsers().length,
                      itemBuilder: (context, index) {
                        var user = getUsers()[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12.0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 18.0,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(user.fullName!),
                              ),
                              Expanded(
                                child: Text(user.endDate!),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AddEditScreen(user: user);
                                      },
                                    ),
                                  );
                                },
                                behavior: HitTestBehavior.opaque,
                                child: SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: SvgPicture.asset(
                                    'assets/icons/edit.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.onSecondary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              GestureDetector(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          LocaleKeys.delete_user.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        content: Text(
                                          LocaleKeys.confirm_delete.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              await UserService.deleteUser(
                                                  user.id!);
                                            },
                                            child: Text(
                                              LocaleKeys.yes.tr(),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              LocaleKeys.no.tr(),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                behavior: HitTestBehavior.opaque,
                                child: SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: SvgPicture.asset(
                                    'assets/icons/delete.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.onSecondary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
