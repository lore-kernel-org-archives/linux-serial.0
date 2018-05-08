From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 1/3] leds: triggers: provide led_trigger_register_format()
Date: Tue,  8 May 2018 12:05:41 +0200
Message-ID: <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-serial@vger.kernel.org, linux-leds@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This allows one to simplify drivers that provide a trigger with a
non-constant name (e.g. one trigger per device with the trigger name
depending on the device's name).

Internally the memory the name member of struct led_trigger points to
now always allocated dynamically instead of just taken from the caller.

The function led_trigger_rename_static() must be changed accordingly and
was renamed to led_trigger_rename() for consistency, with the only user
adapted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/led-triggers.c | 84 +++++++++++++++++++++++++++----------
 drivers/net/can/led.c       |  6 +--
 include/linux/leds.h        | 30 +++++++------
 3 files changed, 81 insertions(+), 39 deletions(-)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 431123b048a2..5d8bb504b07b 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -175,18 +175,34 @@ void led_trigger_set_default(struct led_classdev *led_cdev)
 }
 EXPORT_SYMBOL_GPL(led_trigger_set_default);
 
-void led_trigger_rename_static(const char *name, struct led_trigger *trig)
+int led_trigger_rename(struct led_trigger *trig, const char *fmt, ...)
 {
-	/* new name must be on a temporary string to prevent races */
-	BUG_ON(name == trig->name);
+	const char *prevname;
+	const char *newname;
+	va_list args;
+
+	if (!trig)
+		return 0;
+
+	va_start(args, fmt);
+	newname = kvasprintf_const(GFP_KERNEL, fmt, args);
+	va_end(args);
+
+	if (!newname) {
+		pr_err("Failed to allocate new name for trigger %s\n", trig->name);
+		return -ENOMEM;
+	}
 
 	down_write(&triggers_list_lock);
-	/* this assumes that trig->name was originaly allocated to
-	 * non constant storage */
-	strcpy((char *)trig->name, name);
+	prevname = trig->name;
+	trig->name = newname;
 	up_write(&triggers_list_lock);
+
+	kfree_const(prevname);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(led_trigger_rename_static);
+EXPORT_SYMBOL_GPL(led_trigger_rename);
 
 /* LED Trigger Interface */
 
@@ -333,34 +349,56 @@ void led_trigger_blink_oneshot(struct led_trigger *trig,
 }
 EXPORT_SYMBOL_GPL(led_trigger_blink_oneshot);
 
-void led_trigger_register_simple(const char *name, struct led_trigger **tp)
+int led_trigger_register_format(struct led_trigger **tp, const char *fmt, ...)
 {
+	va_list args;
 	struct led_trigger *trig;
-	int err;
+	int err = -ENOMEM;
+	const char *name;
+
+	va_start(args, fmt);
+	name = kvasprintf_const(GFP_KERNEL, fmt, args);
+	va_end(args);
 
 	trig = kzalloc(sizeof(struct led_trigger), GFP_KERNEL);
 
-	if (trig) {
-		trig->name = name;
-		err = led_trigger_register(trig);
-		if (err < 0) {
-			kfree(trig);
-			trig = NULL;
-			pr_warn("LED trigger %s failed to register (%d)\n",
-				name, err);
-		}
-	} else {
-		pr_warn("LED trigger %s failed to register (no memory)\n",
-			name);
-	}
+	if (!name || !trig)
+		goto err;
+
+	trig->name = name;
+
+	err = led_trigger_register(trig);
+	if (err < 0)
+		goto err;
+
 	*tp = trig;
+
+	return 0;
+
+err:
+	kfree(trig);
+	kfree_const(name);
+
+	*tp = NULL;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(led_trigger_register_format);
+
+void led_trigger_register_simple(const char *name, struct led_trigger **tp)
+{
+	int ret = led_trigger_register_format(tp, "%s", name);
+	if (ret < 0)
+		pr_warn("LED trigger %s failed to register (%d)\n", name, ret);
 }
 EXPORT_SYMBOL_GPL(led_trigger_register_simple);
 
 void led_trigger_unregister_simple(struct led_trigger *trig)
 {
-	if (trig)
+	if (trig) {
 		led_trigger_unregister(trig);
+		kfree_const(trig->name);
+	}
 	kfree(trig);
 }
 EXPORT_SYMBOL_GPL(led_trigger_unregister_simple);
diff --git a/drivers/net/can/led.c b/drivers/net/can/led.c
index c1b667675fa1..2d7d1b0d20f9 100644
--- a/drivers/net/can/led.c
+++ b/drivers/net/can/led.c
@@ -115,13 +115,13 @@ static int can_led_notifier(struct notifier_block *nb, unsigned long msg,
 
 	if (msg == NETDEV_CHANGENAME) {
 		snprintf(name, sizeof(name), "%s-tx", netdev->name);
-		led_trigger_rename_static(name, priv->tx_led_trig);
+		led_trigger_rename(priv->tx_led_trig, name);
 
 		snprintf(name, sizeof(name), "%s-rx", netdev->name);
-		led_trigger_rename_static(name, priv->rx_led_trig);
+		led_trigger_rename(priv->rx_led_trig, name);
 
 		snprintf(name, sizeof(name), "%s-rxtx", netdev->name);
-		led_trigger_rename_static(name, priv->rxtx_led_trig);
+		led_trigger_rename(priv->rxtx_led_trig, name);
 	}
 
 	return NOTIFY_DONE;
diff --git a/include/linux/leds.h b/include/linux/leds.h
index b7e82550e655..e706c28bb35b 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -275,6 +275,8 @@ extern void led_trigger_unregister(struct led_trigger *trigger);
 extern int devm_led_trigger_register(struct device *dev,
 				     struct led_trigger *trigger);
 
+extern int led_trigger_register_format(struct led_trigger **trigger,
+				       const char *fmt, ...);
 extern void led_trigger_register_simple(const char *name,
 				struct led_trigger **trigger);
 extern void led_trigger_unregister_simple(struct led_trigger *trigger);
@@ -298,28 +300,25 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
 }
 
 /**
- * led_trigger_rename_static - rename a trigger
- * @name: the new trigger name
+ * led_trigger_rename - rename a trigger
  * @trig: the LED trigger to rename
+ * @fmt: format string for new name
  *
- * Change a LED trigger name by copying the string passed in
- * name into current trigger name, which MUST be large
- * enough for the new string.
- *
- * Note that name must NOT point to the same string used
- * during LED registration, as that could lead to races.
- *
- * This is meant to be used on triggers with statically
- * allocated name.
+ * rebaptize the given trigger.
  */
-extern void led_trigger_rename_static(const char *name,
-				      struct led_trigger *trig);
+extern int led_trigger_rename(struct led_trigger *trig, const char *fmt, ...);
 
 #else
 
 /* Trigger has no members */
 struct led_trigger {};
 
+static inline int led_trigger_register_format(struct led_trigger **trigger,
+					      const char *fmt, ...)
+{
+	return 0;
+}
+
 /* Trigger inline empty functions */
 static inline void led_trigger_register_simple(const char *name,
 					struct led_trigger **trigger) {}
@@ -342,6 +341,11 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
 	return NULL;
 }
 
+static inline int led_trigger_rename(struct led_trigger *trig, const char *fmt, ...)
+{
+	return 0;
+}
+
 #endif /* CONFIG_LEDS_TRIGGERS */
 
 /* Trigger specific functions */
-- 
2.17.0
