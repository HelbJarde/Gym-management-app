// ignore_for_file: must_be_immutable
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym_management/models/user1.dart';
import 'package:gym_management/services/user.dart';
import 'package:gym_management/theme.dart';
import 'package:gym_management/translations/locale_keys.g.dart';
import 'package:gym_management/utils/custom_formatter.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AddEditScreen extends StatefulWidget {
  AddEditScreen({super.key, required this.user});

  User1 user;
  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  Jalali? registerDate;
  Jalali? endDate;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController registerDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  ValueNotifier<int> registerType = ValueNotifier(1);
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.user.id != null) {
      fullNameController.text = widget.user.fullName!;
      phoneController.text = widget.user.phone!;
      priceController.text = widget.user.price!.toString();
      registerDateController.text = widget.user.registerDate!;
      endDateController.text = widget.user.endDate!;
      registerType.value = widget.user.registerType!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leading: BackButton(color: Theme.of(context).colorScheme.onSecondary),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset('assets/icons/logo.png', width: 180),
                const SizedBox(height: 12.0),
                Text(
                  LocaleKeys.vesam_gym.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/add_user.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Text(LocaleKeys.add_user.tr()),
                  ],
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.error_textfield_fullname.tr();
                    }
                    return null;
                  },
                  controller: fullNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.fullname.tr(),
                  ),
                ),
                const SizedBox(height: 18.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.error_textfield_phone.tr();
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: LocaleKeys.phone.tr()),
                ),
                const SizedBox(height: 18.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.error_textfield_price.tr();
                    }
                    return null;
                  },
                  inputFormatters: [CustomFormatter()],
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: LocaleKeys.price.tr()),
                ),
                const SizedBox(height: 18.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.error_textfield_registerDate.tr();
                    }
                    return null;
                  },
                  controller: registerDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.register_date.tr(),
                    suffixIcon: Container(
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(
                        onTap: () async {
                          registerDate = await showPersianDatePicker(
                            context: context,
                            initialDate: Jalali.now(),
                            firstDate: Jalali(1380, 1),
                            lastDate: Jalali(1420, 1),
                          );
                          registerDateController.text =
                              registerDate?.formatCompactDate() ?? '';

                          switch (registerType.value) {
                            case 1:
                              endDate = registerDate?.addDays(15);
                              break;
                            case 2:
                              endDate = registerDate?.addMonths(1);
                              break;
                            case 3:
                              endDate = registerDate?.addMonths(3);
                              break;
                            default:
                          }

                          endDateController.text =
                              endDate?.formatCompactDate() ?? '';
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          colorFilter: const ColorFilter.mode(
                            CustomColors.kLightGreyColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18.0),
                ValueListenableBuilder(
                  valueListenable: registerType,
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              value: 1,
                              groupValue: registerType.value,
                              onChanged: (value) {
                                registerType.value = 1;
                                endDate = registerDate?.addDays(15);
                                endDateController.text =
                                    endDate?.formatCompactDate() ?? '';
                              },
                            ),
                            Text(
                              LocaleKeys.days_15.tr(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              value: 2,
                              groupValue: registerType.value,
                              onChanged: (value) {
                                registerType.value = 2;
                                endDate = registerDate?.addMonths(1);
                                endDateController.text =
                                    endDate?.formatCompactDate() ?? '';
                              },
                            ),
                            Text(
                              LocaleKeys.months_1.tr(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              value: 3,
                              groupValue: registerType.value,
                              onChanged: (value) {
                                registerType.value = 3;
                                endDate = registerDate?.addMonths(3);
                                endDateController.text =
                                    endDate?.formatCompactDate() ?? '';
                              },
                            ),
                            Text(
                              LocaleKeys.months_3.tr(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 18.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.error_textfield_endDate.tr();
                    }
                    return null;
                  },
                  controller: endDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.end_date.tr(),
                    suffixIcon: Container(
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(
                        onTap: () async {
                          endDate = await showPersianDatePicker(
                            context: context,
                            initialDate: Jalali.now(),
                            firstDate: Jalali(1380, 1),
                            lastDate: Jalali(1420, 1),
                          );
                          endDateController.text =
                              endDate?.formatCompactDate() ?? '';
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          colorFilter: const ColorFilter.mode(
                            CustomColors.kLightGreyColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        widget.user.fullName = fullNameController.text;
                        widget.user.phone = phoneController.text;
                        widget.user.price = int.parse(
                          priceController.text.replaceAll(',', ''),
                        );
                        widget.user.registerDate = registerDateController.text;
                        widget.user.endDate = endDateController.text;
                        widget.user.registerType = registerType.value;

                        if (widget.user.id != null) {
                          await UserService.updateUser(
                            user: widget.user,
                            userId: widget.user.id!,
                          );
                        } else {
                          await UserService.addUser(widget.user);
                        }

                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(LocaleKeys.save.tr()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
