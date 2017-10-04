From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 9/9] Bluetooth: hci_bcm: Add (runtime)pm support to the serdev driver
Date: Wed,  4 Oct 2017 20:43:43 +0200
Message-ID: <20171004184343.7855-9-hdegoede@redhat.com>
References: <20171004184343.7855-1-hdegoede@redhat.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171004184343.7855-1-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Make the serdev driver use struct bcm_device as its driver data and share
all the pm / GPIO / IRQ related code paths with the platform driver.

After this commit the 2 drivers are in essence the same and the serdev
driver interface can be used for all ACPI enumerated HCI UARTs.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/bluetooth/hci_bcm.c | 118 +++++++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 50 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index e7494efb56e9..cff91930f0b1 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -52,8 +52,10 @@
 
 #define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
 
-/* platform device driver resources */
+/* device driver resources */
 struct bcm_device {
+	/* Must be the first member, hci_serdev.c expects this. */
+	struct hci_uart		serdev_hu;
 	struct list_head	list;
 
 	struct device		*dev;
@@ -76,11 +78,6 @@ struct bcm_device {
 #endif
 };
 
-/* serdev driver resources */
-struct bcm_serdev {
-	struct hci_uart hu;
-};
-
 /* generic bcm uart resources */
 struct bcm_data {
 	struct sk_buff		*rx_skb;
@@ -155,6 +152,10 @@ static bool bcm_device_exists(struct bcm_device *device)
 {
 	struct list_head *p;
 
+	/* Devices using serdev always exist */
+	if (device && device->hu && device->hu->serdev)
+		return true;
+
 	list_for_each(p, &bcm_device_list) {
 		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
 
@@ -200,7 +201,6 @@ static int bcm_request_irq(struct bcm_data *bcm)
 	struct bcm_device *bdev = bcm->dev;
 	int err;
 
-	/* If this is not a platform device, do not enable PM functionalities */
 	mutex_lock(&bcm_device_lock);
 	if (!bcm_device_exists(bdev)) {
 		err = -ENODEV;
@@ -313,18 +313,17 @@ static int bcm_open(struct hci_uart *hu)
 
 	hu->priv = bcm;
 
-	/* If this is a serdev defined device, then only use
-	 * serdev open primitive and skip the rest.
-	 */
+	mutex_lock(&bcm_device_lock);
+
 	if (hu->serdev) {
 		serdev_device_open(hu->serdev);
+		bcm->dev = serdev_device_get_drvdata(hu->serdev);
 		goto out;
 	}
 
 	if (!hu->tty->dev)
 		goto out;
 
-	mutex_lock(&bcm_device_lock);
 	list_for_each(p, &bcm_device_list) {
 		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
 
@@ -334,37 +333,45 @@ static int bcm_open(struct hci_uart *hu)
 		 */
 		if (hu->tty->dev->parent == dev->dev->parent) {
 			bcm->dev = dev;
-			hu->init_speed = dev->init_speed;
-			hu->oper_speed = dev->oper_speed;
 #ifdef CONFIG_PM
 			dev->hu = hu;
 #endif
-			bcm_gpio_set_power(bcm->dev, true);
 			break;
 		}
 	}
 
-	mutex_unlock(&bcm_device_lock);
 out:
+	if (bcm->dev) {
+		hu->init_speed = bcm->dev->init_speed;
+		hu->oper_speed = bcm->dev->oper_speed;
+		bcm_gpio_set_power(bcm->dev, true);
+	}
+
+	mutex_unlock(&bcm_device_lock);
 	return 0;
 }
 
 static int bcm_close(struct hci_uart *hu)
 {
 	struct bcm_data *bcm = hu->priv;
-	struct bcm_device *bdev = bcm->dev;
+	struct bcm_device *bdev = NULL;
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
-	/* If this is a serdev defined device, only use serdev
-	 * close primitive and then continue as usual.
-	 */
-	if (hu->serdev)
-		serdev_device_close(hu->serdev);
-
 	/* Protect bcm->dev against removal of the device or driver */
 	mutex_lock(&bcm_device_lock);
-	if (bcm_device_exists(bdev)) {
+
+	if (hu->serdev) {
+		serdev_device_close(hu->serdev);
+		bdev = serdev_device_get_drvdata(hu->serdev);
+	} else if (bcm_device_exists(bcm->dev)) {
+		bdev = bcm->dev;
+#ifdef CONFIG_PM
+		bdev->hu = NULL;
+#endif
+	}
+
+	if (bdev) {
 		bcm_gpio_set_power(bdev, false);
 #ifdef CONFIG_PM
 		pm_runtime_disable(bdev->dev);
@@ -374,8 +381,6 @@ static int bcm_close(struct hci_uart *hu)
 			devm_free_irq(bdev->dev, bdev->irq, bdev);
 			device_init_wakeup(bdev->dev, false);
 		}
-
-		bdev->hu = NULL;
 #endif
 	}
 	mutex_unlock(&bcm_device_lock);
@@ -603,7 +608,7 @@ static int bcm_resume_device(struct device *dev)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-/* Platform suspend callback */
+/* suspend callback */
 static int bcm_suspend(struct device *dev)
 {
 	struct bcm_device *bdev = dev_get_drvdata(dev);
@@ -611,8 +616,10 @@ static int bcm_suspend(struct device *dev)
 
 	bt_dev_dbg(bdev, "suspend: is_suspended %d", bdev->is_suspended);
 
-	/* bcm_suspend can be called at any time as long as platform device is
-	 * bound, so it should use bcm_device_lock to protect access to hci_uart
+	/*
+	 * When used with a device instantiated as platform_device, bcm_suspend
+	 * can be called at any time as long as the platform device is bound,
+	 * so it should use bcm_device_lock to protect access to hci_uart
 	 * and device_wake-up GPIO.
 	 */
 	mutex_lock(&bcm_device_lock);
@@ -635,15 +642,17 @@ static int bcm_suspend(struct device *dev)
 	return 0;
 }
 
-/* Platform resume callback */
+/* resume callback */
 static int bcm_resume(struct device *dev)
 {
 	struct bcm_device *bdev = dev_get_drvdata(dev);
 
 	bt_dev_dbg(bdev, "resume: is_suspended %d", bdev->is_suspended);
 
-	/* bcm_resume can be called at any time as long as platform device is
-	 * bound, so it should use bcm_device_lock to protect access to hci_uart
+	/*
+	 * When used with a device instantiated as platform_device, bcm_resume
+	 * can be called at any time as long as platform device is bound,
+	 * so it should use bcm_device_lock to protect access to hci_uart
 	 * and device_wake-up GPIO.
 	 */
 	mutex_lock(&bcm_device_lock);
@@ -785,15 +794,6 @@ static int bcm_get_resources(struct bcm_device *dev)
 	}
 
 	dev_info(dev->dev, "BCM irq: %d\n", dev->irq);
-
-	/* Make sure at-least one of the GPIO is defined and that
-	 * a name is specified for this instance
-	 */
-	if ((!dev->device_wakeup && !dev->shutdown) || !dev->name) {
-		dev_err(dev->dev, "invalid platform data\n");
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -846,6 +846,12 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 }
 #endif /* CONFIG_ACPI */
 
+static int bcm_of_probe(struct bcm_device *bdev)
+{
+	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
+	return 0;
+}
+
 static int bcm_probe(struct platform_device *pdev)
 {
 	struct bcm_device *dev;
@@ -934,7 +940,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
 #endif
 
-/* Platform suspend and resume callbacks */
+/* suspend and resume callbacks */
 static const struct dev_pm_ops bcm_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(bcm_suspend, bcm_resume)
 	SET_RUNTIME_PM_OPS(bcm_suspend_device, bcm_resume_device, NULL)
@@ -952,29 +958,39 @@ static struct platform_driver bcm_driver = {
 
 static int bcm_serdev_probe(struct serdev_device *serdev)
 {
-	struct bcm_serdev *bcmdev;
-	u32 speed;
+	struct bcm_device *bcmdev;
 	int err;
 
 	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
 	if (!bcmdev)
 		return -ENOMEM;
 
-	bcmdev->hu.serdev = serdev;
+	bcmdev->dev = &serdev->dev;
+	bcmdev->hu = &bcmdev->serdev_hu;
+	bcmdev->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, bcmdev);
 
-	err = device_property_read_u32(&serdev->dev, "max-speed", &speed);
-	if (!err)
-		bcmdev->hu.oper_speed = speed;
+	if (has_acpi_companion(&serdev->dev))
+		err = bcm_acpi_probe(bcmdev);
+	else
+		err = bcm_of_probe(bcmdev);
+	if (err)
+		return err;
 
-	return hci_uart_register_device(&bcmdev->hu, &bcm_proto);
+	err = bcm_get_resources(bcmdev);
+	if (err)
+		return err;
+
+	bcm_gpio_set_power(bcmdev, false);
+
+	return hci_uart_register_device(&bcmdev->serdev_hu, &bcm_proto);
 }
 
 static void bcm_serdev_remove(struct serdev_device *serdev)
 {
-	struct bcm_serdev *bcmdev = serdev_device_get_drvdata(serdev);
+	struct bcm_device *bcmdev = serdev_device_get_drvdata(serdev);
 
-	hci_uart_unregister_device(&bcmdev->hu);
+	hci_uart_unregister_device(&bcmdev->serdev_hu);
 }
 
 #ifdef CONFIG_OF
@@ -991,6 +1007,8 @@ static struct serdev_device_driver bcm_serdev_driver = {
 	.driver = {
 		.name = "hci_uart_bcm",
 		.of_match_table = of_match_ptr(bcm_bluetooth_of_match),
+		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
+		.pm = &bcm_pm_ops,
 	},
 };
 
-- 
2.14.2
