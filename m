From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/2] Bluetooth: hci_bcm: Remove platform_device support
Date: Mon, 22 Jan 2018 12:53:25 +0100
Message-ID: <20180122115325.28960-3-hdegoede@redhat.com>
References: <20180122115325.28960-1-hdegoede@redhat.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180122115325.28960-1-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Now that ACPI and DT devices are both enumerated as serdevs, we can
remove platform_device support and the bcm_device_list lookup hack.

This also removes any races between suspend/resume and hci-uart binding,
also making the suspend/resume code a lot simpler.

This commit leaves manually binding to an uart using btattach supported
(without irq/gpio and thus suspend/resume support, as before).

Cc: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/bluetooth/hci_bcm.c | 258 +++++---------------------------------------
 1 file changed, 27 insertions(+), 231 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 0438a64b8185..92d6c461a7e7 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -30,7 +30,6 @@
 #include <linux/of.h>
 #include <linux/property.h>
 #include <linux/platform_data/x86/apple.h>
-#include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
 #include <linux/tty.h>
@@ -80,9 +79,6 @@
  *	set to 0 if @init_speed is already the preferred baudrate
  * @irq: interrupt triggered by HOST_WAKE_BT pin
  * @irq_active_low: whether @irq is active low
- * @hu: pointer to HCI UART controller struct,
- *	used to disable flow control during runtime suspend and system sleep
- * @is_suspended: whether flow control is currently disabled
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
@@ -107,25 +103,14 @@ struct bcm_device {
 	u32			oper_speed;
 	int			irq;
 	bool			irq_active_low;
-
-#ifdef CONFIG_PM
-	struct hci_uart		*hu;
-	bool			is_suspended;
-#endif
 };
 
 /* generic bcm uart resources */
 struct bcm_data {
 	struct sk_buff		*rx_skb;
 	struct sk_buff_head	txq;
-
-	struct bcm_device	*dev;
 };
 
-/* List of BCM BT UART devices */
-static DEFINE_MUTEX(bcm_device_lock);
-static LIST_HEAD(bcm_device_list);
-
 static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
 	if (hu->serdev)
@@ -183,27 +168,6 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	return 0;
 }
 
-/* bcm_device_exists should be protected by bcm_device_lock */
-static bool bcm_device_exists(struct bcm_device *device)
-{
-	struct list_head *p;
-
-#ifdef CONFIG_PM
-	/* Devices using serdev always exist */
-	if (device && device->hu && device->hu->serdev)
-		return true;
-#endif
-
-	list_for_each(p, &bcm_device_list) {
-		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
-
-		if (device == dev)
-			return true;
-	}
-
-	return false;
-}
-
 static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 {
 	int err;
@@ -249,21 +213,17 @@ static irqreturn_t bcm_host_wake(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int bcm_request_irq(struct bcm_data *bcm)
+static int bcm_request_irq(struct hci_uart *hu)
 {
-	struct bcm_device *bdev = bcm->dev;
+	struct bcm_device *bdev;
 	int err;
 
-	mutex_lock(&bcm_device_lock);
-	if (!bcm_device_exists(bdev)) {
-		err = -ENODEV;
-		goto unlock;
-	}
+	if (!hu->serdev)
+		return -ENODEV;
 
-	if (bdev->irq <= 0) {
-		err = -EOPNOTSUPP;
-		goto unlock;
-	}
+	bdev = serdev_device_get_drvdata(hu->serdev);
+	if (bdev->irq <= 0)
+		return -EOPNOTSUPP;
 
 	err = devm_request_irq(bdev->dev, bdev->irq, bcm_host_wake,
 			       bdev->irq_active_low ? IRQF_TRIGGER_FALLING :
@@ -271,7 +231,7 @@ static int bcm_request_irq(struct bcm_data *bcm)
 			       "host_wake", bdev);
 	if (err) {
 		bdev->irq = err;
-		goto unlock;
+		return err;
 	}
 
 	device_init_wakeup(bdev->dev, true);
@@ -282,10 +242,7 @@ static int bcm_request_irq(struct bcm_data *bcm)
 	pm_runtime_set_active(bdev->dev);
 	pm_runtime_enable(bdev->dev);
 
-unlock:
-	mutex_unlock(&bcm_device_lock);
-
-	return err;
+	return 0;
 }
 
 static const struct bcm_set_sleep_mode default_sleep_params = {
@@ -306,11 +263,11 @@ static const struct bcm_set_sleep_mode default_sleep_params = {
 
 static int bcm_setup_sleep(struct hci_uart *hu)
 {
-	struct bcm_data *bcm = hu->priv;
+	struct bcm_device *bdev = serdev_device_get_drvdata(hu->serdev);
 	struct sk_buff *skb;
 	struct bcm_set_sleep_mode sleep_params = default_sleep_params;
 
-	sleep_params.host_wake_active = !bcm->dev->irq_active_low;
+	sleep_params.host_wake_active = !bdev->irq_active_low;
 
 	skb = __hci_cmd_sync(hu->hdev, 0xfc27, sizeof(sleep_params),
 			     &sleep_params, HCI_INIT_TIMEOUT);
@@ -326,7 +283,7 @@ static int bcm_setup_sleep(struct hci_uart *hu)
 	return 0;
 }
 #else
-static inline int bcm_request_irq(struct bcm_data *bcm) { return 0; }
+static inline int bcm_request_irq(struct hci_uart *hu) { return 0; }
 static inline int bcm_setup_sleep(struct hci_uart *hu) { return 0; }
 #endif
 
@@ -356,7 +313,6 @@ static int bcm_set_diag(struct hci_dev *hdev, bool enable)
 static int bcm_open(struct hci_uart *hu)
 {
 	struct bcm_data *bcm;
-	struct list_head *p;
 	int err;
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
@@ -369,57 +325,26 @@ static int bcm_open(struct hci_uart *hu)
 
 	hu->priv = bcm;
 
-	mutex_lock(&bcm_device_lock);
-
 	if (hu->serdev) {
+		struct bcm_device *bdev = serdev_device_get_drvdata(hu->serdev);
+
 		err = serdev_device_open(hu->serdev);
 		if (err)
 			goto err_free;
 
-		bcm->dev = serdev_device_get_drvdata(hu->serdev);
-		goto out;
-	}
-
-	if (!hu->tty->dev)
-		goto out;
-
-	list_for_each(p, &bcm_device_list) {
-		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
-
-		/* Retrieve saved bcm_device based on parent of the
-		 * platform device (saved during device probe) and
-		 * parent of tty device used by hci_uart
-		 */
-		if (hu->tty->dev->parent == dev->dev->parent) {
-			bcm->dev = dev;
-#ifdef CONFIG_PM
-			dev->hu = hu;
-#endif
-			break;
-		}
-	}
-
-out:
-	if (bcm->dev) {
-		hu->init_speed = bcm->dev->init_speed;
-		hu->oper_speed = bcm->dev->oper_speed;
-		err = bcm_gpio_set_power(bcm->dev, true);
+		hu->init_speed = bdev->init_speed;
+		hu->oper_speed = bdev->oper_speed;
+		err = bcm_gpio_set_power(bdev, true);
 		if (err)
 			goto err_unset_hu;
 	}
 
-	mutex_unlock(&bcm_device_lock);
 	return 0;
 
 err_unset_hu:
 	if (hu->serdev)
 		serdev_device_close(hu->serdev);
-#ifdef CONFIG_PM
-	else
-		bcm->dev->hu = NULL;
-#endif
 err_free:
-	mutex_unlock(&bcm_device_lock);
 	hu->priv = NULL;
 	kfree(bcm);
 	return err;
@@ -433,20 +358,10 @@ static int bcm_close(struct hci_uart *hu)
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
-	/* Protect bcm->dev against removal of the device or driver */
-	mutex_lock(&bcm_device_lock);
-
 	if (hu->serdev) {
 		serdev_device_close(hu->serdev);
 		bdev = serdev_device_get_drvdata(hu->serdev);
-	} else if (bcm_device_exists(bcm->dev)) {
-		bdev = bcm->dev;
-#ifdef CONFIG_PM
-		bdev->hu = NULL;
-#endif
-	}
 
-	if (bdev) {
 		if (IS_ENABLED(CONFIG_PM) && bdev->irq > 0) {
 			devm_free_irq(bdev->dev, bdev->irq, bdev);
 			device_init_wakeup(bdev->dev, false);
@@ -459,7 +374,6 @@ static int bcm_close(struct hci_uart *hu)
 		else
 			pm_runtime_set_suspended(bdev->dev);
 	}
-	mutex_unlock(&bcm_device_lock);
 
 	skb_queue_purge(&bcm->txq);
 	kfree_skb(bcm->rx_skb);
@@ -482,7 +396,6 @@ static int bcm_flush(struct hci_uart *hu)
 
 static int bcm_setup(struct hci_uart *hu)
 {
-	struct bcm_data *bcm = hu->priv;
 	char fw_name[64];
 	const struct firmware *fw;
 	unsigned int speed;
@@ -541,7 +454,7 @@ static int bcm_setup(struct hci_uart *hu)
 	if (err)
 		return err;
 
-	if (!bcm_request_irq(bcm))
+	if (!bcm_request_irq(hu))
 		err = bcm_setup_sleep(hu);
 
 	return err;
@@ -583,12 +496,9 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
 		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
 		bcm->rx_skb = NULL;
 		return err;
-	} else if (!bcm->rx_skb) {
+	} else if (!bcm->rx_skb && hu->serdev) {
 		/* Delay auto-suspend when receiving completed packet */
-		mutex_lock(&bcm_device_lock);
-		if (bcm->dev && bcm_device_exists(bcm->dev))
-			pm_request_resume(bcm->dev->dev);
-		mutex_unlock(&bcm_device_lock);
+		pm_request_resume(&hu->serdev->dev);
 	}
 
 	return count;
@@ -613,10 +523,8 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 	struct sk_buff *skb = NULL;
 	struct bcm_device *bdev = NULL;
 
-	mutex_lock(&bcm_device_lock);
-
-	if (bcm_device_exists(bcm->dev)) {
-		bdev = bcm->dev;
+	if (hu->serdev) {
+		bdev = serdev_device_get_drvdata(hu->serdev);
 		pm_runtime_get_sync(bdev->dev);
 		/* Shall be resumed here */
 	}
@@ -628,8 +536,6 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 		pm_runtime_put_autosuspend(bdev->dev);
 	}
 
-	mutex_unlock(&bcm_device_lock);
-
 	return skb;
 }
 
@@ -641,20 +547,12 @@ static int bcm_suspend_device(struct device *dev)
 
 	bt_dev_dbg(bdev, "");
 
-	if (!bdev->is_suspended && bdev->hu) {
-		hci_uart_set_flow_control(bdev->hu, true);
-
-		/* Once this returns, driver suspends BT via GPIO */
-		bdev->is_suspended = true;
-	}
+	hci_uart_set_flow_control(&bdev->serdev_hu, true);
 
 	/* Suspend the device */
 	err = bdev->set_device_wakeup(bdev, false);
 	if (err) {
-		if (bdev->is_suspended && bdev->hu) {
-			bdev->is_suspended = false;
-			hci_uart_set_flow_control(bdev->hu, false);
-		}
+		hci_uart_set_flow_control(&bdev->serdev_hu, false);
 		return -EBUSY;
 	}
 
@@ -681,11 +579,7 @@ static int bcm_resume_device(struct device *dev)
 	msleep(15);
 
 	/* When this executes, the device has woken up already */
-	if (bdev->is_suspended && bdev->hu) {
-		bdev->is_suspended = false;
-
-		hci_uart_set_flow_control(bdev->hu, false);
-	}
+	hci_uart_set_flow_control(&bdev->serdev_hu, false);
 
 	return 0;
 }
@@ -698,18 +592,7 @@ static int bcm_suspend(struct device *dev)
 	struct bcm_device *bdev = dev_get_drvdata(dev);
 	int error;
 
-	bt_dev_dbg(bdev, "suspend: is_suspended %d", bdev->is_suspended);
-
-	/*
-	 * When used with a device instantiated as platform_device, bcm_suspend
-	 * can be called at any time as long as the platform device is bound,
-	 * so it should use bcm_device_lock to protect access to hci_uart
-	 * and device_wake-up GPIO.
-	 */
-	mutex_lock(&bcm_device_lock);
-
-	if (!bdev->hu)
-		goto unlock;
+	bt_dev_dbg(bdev, "");
 
 	if (pm_runtime_active(dev))
 		bcm_suspend_device(dev);
@@ -720,9 +603,6 @@ static int bcm_suspend(struct device *dev)
 			bt_dev_dbg(bdev, "BCM irq: enabled");
 	}
 
-unlock:
-	mutex_unlock(&bcm_device_lock);
-
 	return 0;
 }
 
@@ -732,18 +612,7 @@ static int bcm_resume(struct device *dev)
 	struct bcm_device *bdev = dev_get_drvdata(dev);
 	int err = 0;
 
-	bt_dev_dbg(bdev, "resume: is_suspended %d", bdev->is_suspended);
-
-	/*
-	 * When used with a device instantiated as platform_device, bcm_resume
-	 * can be called at any time as long as platform device is bound,
-	 * so it should use bcm_device_lock to protect access to hci_uart
-	 * and device_wake-up GPIO.
-	 */
-	mutex_lock(&bcm_device_lock);
-
-	if (!bdev->hu)
-		goto unlock;
+	bt_dev_dbg(bdev, "");
 
 	if (device_may_wakeup(dev) && bdev->irq > 0) {
 		disable_irq_wake(bdev->irq);
@@ -751,10 +620,6 @@ static int bcm_resume(struct device *dev)
 	}
 
 	err = bcm_resume_device(dev);
-
-unlock:
-	mutex_unlock(&bcm_device_lock);
-
 	if (!err) {
 		pm_runtime_disable(dev);
 		pm_runtime_set_active(dev);
@@ -1005,57 +870,6 @@ static int bcm_of_probe(struct bcm_device *bdev)
 	return 0;
 }
 
-static int bcm_probe(struct platform_device *pdev)
-{
-	struct bcm_device *dev;
-	int ret;
-
-	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
-
-	dev->dev = &pdev->dev;
-	dev->irq = platform_get_irq(pdev, 0);
-
-	if (has_acpi_companion(&pdev->dev)) {
-		ret = bcm_acpi_probe(dev);
-		if (ret)
-			return ret;
-	}
-
-	ret = bcm_get_resources(dev);
-	if (ret)
-		return ret;
-
-	platform_set_drvdata(pdev, dev);
-
-	dev_info(&pdev->dev, "%s device registered.\n", dev->name);
-
-	/* Place this instance on the device list */
-	mutex_lock(&bcm_device_lock);
-	list_add_tail(&dev->list, &bcm_device_list);
-	mutex_unlock(&bcm_device_lock);
-
-	ret = bcm_gpio_set_power(dev, false);
-	if (ret)
-		dev_err(&pdev->dev, "Failed to power down\n");
-
-	return 0;
-}
-
-static int bcm_remove(struct platform_device *pdev)
-{
-	struct bcm_device *dev = platform_get_drvdata(pdev);
-
-	mutex_lock(&bcm_device_lock);
-	list_del(&dev->list);
-	mutex_unlock(&bcm_device_lock);
-
-	dev_info(&pdev->dev, "%s device unregistered.\n", dev->name);
-
-	return 0;
-}
-
 static const struct hci_uart_proto bcm_proto = {
 	.id		= HCI_UART_BCM,
 	.name		= "Broadcom",
@@ -1103,16 +917,6 @@ static const struct dev_pm_ops bcm_pm_ops = {
 	SET_RUNTIME_PM_OPS(bcm_suspend_device, bcm_resume_device, NULL)
 };
 
-static struct platform_driver bcm_driver = {
-	.probe = bcm_probe,
-	.remove = bcm_remove,
-	.driver = {
-		.name = "hci_bcm",
-		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
-		.pm = &bcm_pm_ops,
-	},
-};
-
 static int bcm_serdev_probe(struct serdev_device *serdev)
 {
 	struct bcm_device *bcmdev;
@@ -1123,9 +927,6 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 
 	bcmdev->dev = &serdev->dev;
-#ifdef CONFIG_PM
-	bcmdev->hu = &bcmdev->serdev_hu;
-#endif
 	bcmdev->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, bcmdev);
 
@@ -1175,10 +976,6 @@ static struct serdev_device_driver bcm_serdev_driver = {
 
 int __init bcm_init(void)
 {
-	/* For now, we need to keep both platform device
-	 * driver (ACPI generated) and serdev driver (DT).
-	 */
-	platform_driver_register(&bcm_driver);
 	serdev_device_driver_register(&bcm_serdev_driver);
 
 	return hci_uart_register_proto(&bcm_proto);
@@ -1186,7 +983,6 @@ int __init bcm_init(void)
 
 int __exit bcm_deinit(void)
 {
-	platform_driver_unregister(&bcm_driver);
 	serdev_device_driver_unregister(&bcm_serdev_driver);
 
 	return hci_uart_unregister_proto(&bcm_proto);
-- 
2.14.3
