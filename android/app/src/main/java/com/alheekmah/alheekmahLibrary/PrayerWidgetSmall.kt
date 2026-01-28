package com.salaty.salaty_app

import android.appwidget.AppWidgetManager
import com.salaty.salaty_app.R

// Small variant: إجبار التخطيط الصغير مباشرة لمنع التحول الأولي
class PrayerWidgetSmall : PrayerWidget() {
	override fun resolveLayout(manager: AppWidgetManager, appWidgetId: Int): Int {
		return R.layout.prayer_widget_layout_small
	}
}
