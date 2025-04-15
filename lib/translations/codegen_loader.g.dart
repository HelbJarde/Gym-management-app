// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "users_gym_vesam": "Vesam Gym Users",
    "search_by_fullname": "Search by Full Name",
    "count_of_active_users": "Number of Active Users",
    "count_of_inactive_users": "Number of Inactive Users",
    "people": "{count} people",
    "active_users": "Active Users",
    "expired_users": "Inactive Users",
    "vesam_gym": "Vesam Cultural and Sports Gym",
    "add_user": "Add New User",
    "error_textfield_fullname": "Please enter full name",
    "error_textfield_phone": "Please enter phone number",
    "error_textfield_price": "Please enter price",
    "error_textfield_registerDate": "Please enter registration date",
    "error_textfield_endDate": "Please enter end date of tuition fee",
    "save": "Save",
    "days_15": "15 days",
    "months_1": "1 month",
    "months_3": "3 months",
    "fullname": "Full Name",
    "phone": "Phone Number",
    "price": "Price",
    "register_date": "Registration Date",
    "end_date": "End Date of Tuition Fee",
    "yes": "yes",
    "no": "no",
    "confirm_delete": "Are you sure you want to delete this user?",
    "delete_user": "Delete user"
  };
  static const Map<String, dynamic> fa = {
    "users_gym_vesam": "کاربران باشگاه وسام",
    "search_by_fullname": "جستجو با نام و نام خانوادگی",
    "count_of_active_users": "تعداد کاربران فعال",
    "count_of_inactive_users": "تعداد کاربران غیرفعال",
    "people": "{count} نفر",
    "active_users": "کاربران فعال",
    "expired_users": "کاربران غیرفعال",
    "vesam_gym": "باشگاه فرهنگی ورزشی وسام",
    "add_user": "افزودن کاربر جدید",
    "error_textfield_fullname": "لطفا نام و نام خانوادگی را وارد کنید",
    "error_textfield_phone": "لطفا شماره تماس را وارد کنید",
    "error_textfield_price": "لطفا قیمت را وارد کنید",
    "error_textfield_registerDate": "لطفا تاریخ ثبت نام را وارد کنید",
    "error_textfield_endDate": "لطفا تاریخ پایان شهریه را وارد کنید",
    "save": "ذخیره",
    "days_15": "15 روز",
    "months_1": "1 ماه",
    "months_3": "3 ماه",
    "fullname": "نام و نام خانوادگی",
    "phone": "شماره تماس",
    "price": "قیمت",
    "register_date": "تاریخ ثبت نام",
    "end_date": "تاریخ پایان شهریه",
    "yes": "بله",
    "no": "خیر",
    "confirm_delete": "آیا از حذف این کاربر اطمینان دارید؟",
    "delete_user": "حذف کاربر"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {"en": en, "fa": fa};
}
