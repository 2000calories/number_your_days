import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var t = Translations("en") +
      {
        "en": "Number Your Days",
        "zh_cn": "数算你的日子",
      } +
      {
        "en": "Search",
        "zh_cn": "搜索",
      } +
      {
        "en": "List",
        "zh_cn": "列表",
      } +
      {
        "en": "Calculator",
        "zh_cn": "计算",
      } +
      {
        "en": "Calculation",
        "zh_cn": "计算",
      } +
      {
        "en": "Setting",
        "zh_cn": "设置",
      } +
      {
        "en": "Setting",
        "zh_cn": "设置",
      } +
      {
        "en": "until",
        "zh_cn": "到",
      } +
      {
        "en": "Days",
        "zh_cn": "天",
      } +
      {
        "en": " Days",
        "zh_cn": "天",
      } +
      {
        "en": "Start Date",
        "zh_cn": "开始日期",
      } +
      {
        "en": "End Date",
        "zh_cn": "到期日",
      } +
      {
        "en": "Number of Days",
        "zh_cn": "天数",
      } +
      {
        "en": " days until next anniversary",
        "zh_cn": "天到下个周年纪念日",
      };

  String get i18n => localize(this, t);
}
