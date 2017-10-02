From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC,3/3] Bluetooth: hci_bcm: Add ACPI serdev support for BCM2E39
Date: Mon, 2 Oct 2017 09:07:49 +0200
Message-ID: <be4075c9-110a-1415-3d9b-a631fe91b34f@redhat.com>
References: <1504786214-1866-4-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------12A7361867C1F6AAB1AA0D5E"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1504786214-1866-4-git-send-email-frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------12A7361867C1F6AAB1AA0D5E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

First of all Frédéric, thank you very much for working on this,
this is a very much needed patch series.

I've been testing this on a GPD pocket which has a BCM2E7E
ACPI device for the BT which is part of the BCM43562A wifi/bt
combo on this device.

2 remarks:

1) The following errors show up with this series:

[   87.059091] synth uevent: /devices/pci0000:00/8086228A:00/serial1: failed to send uevent
[   87.059097] serial serial1: uevent: failed to send synthetic uevent
[   87.059178] synth uevent: /devices/pci0000:00/8086228A:01/serial2: failed to send uevent
[   87.059180] serial serial2: uevent: failed to send synthetic uevent
[   87.062665] synth uevent: /devices/pnp0/00:01/serial0: failed to send uevent
[   87.062671] serial serial0: uevent: failed to send synthetic uevent

This needs to be fixed :)  I haven't looked into this yet.

2) As I already suspected when reading the patches, we cannot
move the ACPI ids over 1 by 1. The first 2 patches in the series
cause all BCM2E* ACPI devices to no longer get enumerated as
platform devices, instead they now get enumerated as serdevs.

So adding only the known to work ACPI ids to the acpi_match_table
for the bcm_serdev_driver has the undesirable result that it makes
sure that the other ACPI-ids will not work, as there are not
platform devices instantiated for the platform driver to bind to.

I started with simplifying your patch to this:

 From f8728f5440c85f7e5584ac1eafa1b090b2042276 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 7 Sep 2017 14:10:14 +0200
Subject: [PATCH] Bluetooth: hci_bcm: Make ACPI enumerated HCIs use serdev
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that the ACPI subsys instantiates ACPI enumerated HCIs as serdevs,
the ACPI ids for them should be part of the bcm_serdev_driver's
acpi_match_table.

Signed-off-by: Frédéric Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
[hdegoede: Move all ACPI ids over]
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
   drivers/bluetooth/hci_bcm.c | 2 +-
   1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 2285ca673ae3..4db777bb0049 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -942,7 +942,6 @@ static struct platform_driver bcm_driver = {
   	.remove = bcm_remove,
   	.driver = {
   		.name = "hci_bcm",
-		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
   		.pm = &bcm_pm_ops,
   	},
   };
@@ -988,6 +987,7 @@ static struct serdev_device_driver bcm_serdev_driver = {
   	.driver = {
   		.name = "hci_uart_bcm",
   		.of_match_table = of_match_ptr(bcm_bluetooth_of_match),
+		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
   	},
   };

-- 
2.14.2

Unfortunately that is not good enough. The platform driver code also
has (runtime) pm support using gpios and a host-wake interrupt, which
the serdev code all lacks and without driving the shutdown gpio to not
shutdown the BT device connected to the UART we not only are lacking
pm support, but BT does not work at all.

So yesterday evening I did a patch to merge all that into the serdev hci_bcm
code and throw away the platform code as I don't think any users will be left
after this. With this functionality for the BCM2E7E ACPI device is restored
again, without needing to do a btattach from userspace, which is great :)

I've attached the resulting patch. In the mean time I've realized that
this approach is going to make merging hard. So I'm going to redo the changes
so that we can have both a complete (with runtime-pm, gpios, etc.) serdev
driver and keep the platform driver for now. Then we can first merge the
hci_bcm changes to make the serdev driver side complete and once those are
merged merge the matching ACPI subsys changes without having a window in
between where things will not work.

###

On a related note this series does expose a module load ordering issue.
With this series and with the dw_dmac driver built as module I get:

[   80.239270] ttyS4 - failed to request DMA
[   80.316338] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[   80.353639] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels

Building in dw_dmac is a workaround for this, anyone has any idea how to
fix this ?

Regards,

Hans








On 07-09-17 14:10, Frédéric Danis wrote:
> Signed-off-by: Frédéric Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/bluetooth/hci_bcm.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 2e358cc..b1cf07e 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -922,7 +922,6 @@ static const struct hci_uart_proto bcm_proto = {
>   #ifdef CONFIG_ACPI
>   static const struct acpi_device_id bcm_acpi_match[] = {
>   	{ "BCM2E1A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
> -	{ "BCM2E39", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>   	{ "BCM2E3A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>   	{ "BCM2E3D", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>   	{ "BCM2E3F", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
> @@ -942,6 +941,14 @@ static const struct acpi_device_id bcm_acpi_match[] = {
>   MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
>   #endif
>   
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id bcm_serdev_acpi_match[] = {
> +	{ "BCM2E39", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, bcm_serdev_acpi_match);
> +#endif
> +
>   /* Platform suspend and resume callbacks */
>   static const struct dev_pm_ops bcm_pm_ops = {
>   	SET_SYSTEM_SLEEP_PM_OPS(bcm_suspend, bcm_resume)
> @@ -999,6 +1006,7 @@ static struct serdev_device_driver bcm_serdev_driver = {
>   	.driver = {
>   		.name = "hci_uart_bcm",
>   		.of_match_table = of_match_ptr(bcm_bluetooth_of_match),
> +		.acpi_match_table = ACPI_PTR(bcm_serdev_acpi_match),
>   	},
>   };
>   
> 


--------------12A7361867C1F6AAB1AA0D5E
Content-Type: text/x-patch;
 name="0001-Bluetooth-hci_bcm-Change-from-platform-driver-into-s.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Bluetooth-hci_bcm-Change-from-platform-driver-into-s.pa";
 filename*1="tch"

>From ce62881000fc076326220356036b65074c385a5e Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Sun, 1 Oct 2017 23:17:34 +0200
Subject: [PATCH] Bluetooth: hci_bcm: Change from platform driver into serdev
 driver

Now that the ACPI subsys instantiates ACPI enumerated HCIs as serdevs,
we no longer need a separate platform-driver and serdev-driver, but
we do need the platform-driver's gpio, irq and pm functionality in the
serdev case now.

Merge the platform and serdev driver code into a single serdev-driver.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/bluetooth/hci_bcm.c | 452 ++++++++++++++------------------------------
 1 files changed, 138 insertions(+), 316 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 2285ca673ae3..bf5f2629257a 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -29,7 +29,6 @@
 #include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/property.h>
-#include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
 #include <linux/tty.h>
@@ -54,9 +53,7 @@
 
 /* platform device driver resources */
 struct bcm_device {
-	struct list_head	list;
-
-	struct platform_device	*pdev;
+	struct hci_uart hu;
 
 	const char		*name;
 	struct gpio_desc	*device_wakeup;
@@ -69,16 +66,6 @@ struct bcm_device {
 	u32			oper_speed;
 	int			irq;
 	bool			irq_active_low;
-
-#ifdef CONFIG_PM
-	struct hci_uart		*hu;
-	bool			is_suspended; /* suspend/resume flag */
-#endif
-};
-
-/* serdev driver resources */
-struct bcm_serdev {
-	struct hci_uart hu;
 };
 
 /* generic bcm uart resources */
@@ -89,18 +76,6 @@ struct bcm_data {
 	struct bcm_device	*dev;
 };
 
-/* List of BCM BT UART devices */
-static DEFINE_MUTEX(bcm_device_lock);
-static LIST_HEAD(bcm_device_list);
-
-static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
-{
-	if (hu->serdev)
-		serdev_device_set_baudrate(hu->serdev, speed);
-	else
-		hci_uart_set_baudrate(hu, speed);
-}
-
 static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -150,21 +125,6 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	return 0;
 }
 
-/* bcm_device_exists should be protected by bcm_device_lock */
-static bool bcm_device_exists(struct bcm_device *device)
-{
-	struct list_head *p;
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
 	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
@@ -185,12 +145,13 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 static irqreturn_t bcm_host_wake(int irq, void *data)
 {
 	struct bcm_device *bdev = data;
+	struct device *dev = &bdev->hu.serdev->dev;
 
 	bt_dev_dbg(bdev, "Host wake IRQ");
 
-	pm_runtime_get(&bdev->pdev->dev);
-	pm_runtime_mark_last_busy(&bdev->pdev->dev);
-	pm_runtime_put_autosuspend(&bdev->pdev->dev);
+	pm_runtime_get(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return IRQ_HANDLED;
 }
@@ -198,39 +159,26 @@ static irqreturn_t bcm_host_wake(int irq, void *data)
 static int bcm_request_irq(struct bcm_data *bcm)
 {
 	struct bcm_device *bdev = bcm->dev;
+	struct device *dev = &bdev->hu.serdev->dev;
 	int err;
 
-	/* If this is not a platform device, do not enable PM functionalities */
-	mutex_lock(&bcm_device_lock);
-	if (!bcm_device_exists(bdev)) {
-		err = -ENODEV;
-		goto unlock;
-	}
+	if (bdev->irq <= 0)
+		return -EOPNOTSUPP;
 
-	if (bdev->irq <= 0) {
-		err = -EOPNOTSUPP;
-		goto unlock;
-	}
-
-	err = devm_request_irq(&bdev->pdev->dev, bdev->irq, bcm_host_wake,
+	err = devm_request_irq(dev, bdev->irq, bcm_host_wake,
 			       bdev->irq_active_low ? IRQF_TRIGGER_FALLING :
 						      IRQF_TRIGGER_RISING,
 			       "host_wake", bdev);
 	if (err)
-		goto unlock;
-
-	device_init_wakeup(&bdev->pdev->dev, true);
-
-	pm_runtime_set_autosuspend_delay(&bdev->pdev->dev,
-					 BCM_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(&bdev->pdev->dev);
-	pm_runtime_set_active(&bdev->pdev->dev);
-	pm_runtime_enable(&bdev->pdev->dev);
+		return err;
 
-unlock:
-	mutex_unlock(&bcm_device_lock);
+	device_init_wakeup(dev, true);
+	pm_runtime_set_autosuspend_delay(dev, BCM_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
-	return err;
+	return 0;
 }
 
 static const struct bcm_set_sleep_mode default_sleep_params = {
@@ -300,8 +248,8 @@ static int bcm_set_diag(struct hci_dev *hdev, bool enable)
 
 static int bcm_open(struct hci_uart *hu)
 {
+	struct bcm_device *bdev;
 	struct bcm_data *bcm;
-	struct list_head *p;
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
@@ -311,41 +259,15 @@ static int bcm_open(struct hci_uart *hu)
 
 	skb_queue_head_init(&bcm->txq);
 
+	bdev = serdev_device_get_drvdata(hu->serdev);
+	bcm->dev = bdev;
+	hu->init_speed = bdev->init_speed;
+	hu->oper_speed = bdev->oper_speed;
 	hu->priv = bcm;
 
-	/* If this is a serdev defined device, then only use
-	 * serdev open primitive and skip the rest.
-	 */
-	if (hu->serdev) {
-		serdev_device_open(hu->serdev);
-		goto out;
-	}
-
-	if (!hu->tty->dev)
-		goto out;
-
-	mutex_lock(&bcm_device_lock);
-	list_for_each(p, &bcm_device_list) {
-		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
-
-		/* Retrieve saved bcm_device based on parent of the
-		 * platform device (saved during device probe) and
-		 * parent of tty device used by hci_uart
-		 */
-		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
-			bcm->dev = dev;
-			hu->init_speed = dev->init_speed;
-			hu->oper_speed = dev->oper_speed;
-#ifdef CONFIG_PM
-			dev->hu = hu;
-#endif
-			bcm_gpio_set_power(bcm->dev, true);
-			break;
-		}
-	}
+	serdev_device_open(hu->serdev);
+	bcm_gpio_set_power(bdev, true);
 
-	mutex_unlock(&bcm_device_lock);
-out:
 	return 0;
 }
 
@@ -353,32 +275,22 @@ static int bcm_close(struct hci_uart *hu)
 {
 	struct bcm_data *bcm = hu->priv;
 	struct bcm_device *bdev = bcm->dev;
+	struct device *dev = &bdev->hu.serdev->dev;
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
-	/* If this is a serdev defined device, only use serdev
-	 * close primitive and then continue as usual.
-	 */
-	if (hu->serdev)
-		serdev_device_close(hu->serdev);
+	serdev_device_close(hu->serdev);
 
-	/* Protect bcm->dev against removal of the device or driver */
-	mutex_lock(&bcm_device_lock);
-	if (bcm_device_exists(bdev)) {
-		bcm_gpio_set_power(bdev, false);
+	bcm_gpio_set_power(bdev, false);
 #ifdef CONFIG_PM
-		pm_runtime_disable(&bdev->pdev->dev);
-		pm_runtime_set_suspended(&bdev->pdev->dev);
-
-		if (device_can_wakeup(&bdev->pdev->dev)) {
-			devm_free_irq(&bdev->pdev->dev, bdev->irq, bdev);
-			device_init_wakeup(&bdev->pdev->dev, false);
-		}
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 
-		bdev->hu = NULL;
-#endif
+	if (device_can_wakeup(dev)) {
+		devm_free_irq(dev, bdev->irq, bdev);
+		device_init_wakeup(dev, false);
 	}
-	mutex_unlock(&bcm_device_lock);
+#endif
 
 	skb_queue_purge(&bcm->txq);
 	kfree_skb(bcm->rx_skb);
@@ -437,7 +349,7 @@ static int bcm_setup(struct hci_uart *hu)
 		speed = 0;
 
 	if (speed)
-		host_set_baudrate(hu, speed);
+		serdev_device_set_baudrate(hu->serdev, speed);
 
 	/* Operational speed if any */
 	if (hu->oper_speed)
@@ -450,7 +362,7 @@ static int bcm_setup(struct hci_uart *hu)
 	if (speed) {
 		err = bcm_set_baudrate(hu, speed);
 		if (!err)
-			host_set_baudrate(hu, speed);
+			serdev_device_set_baudrate(hu->serdev, speed);
 	}
 
 finalize:
@@ -491,6 +403,7 @@ static const struct h4_recv_pkt bcm_recv_pkts[] = {
 static int bcm_recv(struct hci_uart *hu, const void *data, int count)
 {
 	struct bcm_data *bcm = hu->priv;
+	struct device *dev = &bcm->dev->hu.serdev->dev;
 
 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
 		return -EUNATCH;
@@ -504,13 +417,9 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
 		return err;
 	} else if (!bcm->rx_skb) {
 		/* Delay auto-suspend when receiving completed packet */
-		mutex_lock(&bcm_device_lock);
-		if (bcm->dev && bcm_device_exists(bcm->dev)) {
-			pm_runtime_get(&bcm->dev->pdev->dev);
-			pm_runtime_mark_last_busy(&bcm->dev->pdev->dev);
-			pm_runtime_put_autosuspend(&bcm->dev->pdev->dev);
-		}
-		mutex_unlock(&bcm_device_lock);
+		pm_runtime_get(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
 	}
 
 	return count;
@@ -532,25 +441,15 @@ static int bcm_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 {
 	struct bcm_data *bcm = hu->priv;
+	struct device *dev = &bcm->dev->hu.serdev->dev;
 	struct sk_buff *skb = NULL;
-	struct bcm_device *bdev = NULL;
-
-	mutex_lock(&bcm_device_lock);
 
-	if (bcm_device_exists(bcm->dev)) {
-		bdev = bcm->dev;
-		pm_runtime_get_sync(&bdev->pdev->dev);
-		/* Shall be resumed here */
-	}
+	pm_runtime_get_sync(dev);
 
 	skb = skb_dequeue(&bcm->txq);
 
-	if (bdev) {
-		pm_runtime_mark_last_busy(&bdev->pdev->dev);
-		pm_runtime_put_autosuspend(&bdev->pdev->dev);
-	}
-
-	mutex_unlock(&bcm_device_lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return skb;
 }
@@ -558,16 +457,12 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 #ifdef CONFIG_PM
 static int bcm_suspend_device(struct device *dev)
 {
-	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
+	struct bcm_device *bdev =
+		serdev_device_get_drvdata(to_serdev_device(dev));
 
 	bt_dev_dbg(bdev, "");
 
-	if (!bdev->is_suspended && bdev->hu) {
-		hci_uart_set_flow_control(bdev->hu, true);
-
-		/* Once this returns, driver suspends BT via GPIO */
-		bdev->is_suspended = true;
-	}
+	serdev_device_set_flow_control(bdev->hu.serdev, false);
 
 	/* Suspend the device */
 	if (bdev->device_wakeup) {
@@ -581,7 +476,8 @@ static int bcm_suspend_device(struct device *dev)
 
 static int bcm_resume_device(struct device *dev)
 {
-	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
+	struct bcm_device *bdev =
+		serdev_device_get_drvdata(to_serdev_device(dev));
 
 	bt_dev_dbg(bdev, "");
 
@@ -592,11 +488,7 @@ static int bcm_resume_device(struct device *dev)
 	}
 
 	/* When this executes, the device has woken up already */
-	if (bdev->is_suspended && bdev->hu) {
-		bdev->is_suspended = false;
-
-		hci_uart_set_flow_control(bdev->hu, false);
-	}
+	serdev_device_set_flow_control(bdev->hu.serdev, true);
 
 	return 0;
 }
@@ -606,61 +498,39 @@ static int bcm_resume_device(struct device *dev)
 /* Platform suspend callback */
 static int bcm_suspend(struct device *dev)
 {
-	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
+	struct bcm_device *bdev =
+		serdev_device_get_drvdata(to_serdev_device(dev));
 	int error;
 
-	bt_dev_dbg(bdev, "suspend: is_suspended %d", bdev->is_suspended);
-
-	/* bcm_suspend can be called at any time as long as platform device is
-	 * bound, so it should use bcm_device_lock to protect access to hci_uart
-	 * and device_wake-up GPIO.
-	 */
-	mutex_lock(&bcm_device_lock);
-
-	if (!bdev->hu)
-		goto unlock;
+	bt_dev_dbg(bdev, "suspend");
 
 	if (pm_runtime_active(dev))
 		bcm_suspend_device(dev);
 
-	if (device_may_wakeup(&bdev->pdev->dev)) {
+	if (device_may_wakeup(dev)) {
 		error = enable_irq_wake(bdev->irq);
 		if (!error)
 			bt_dev_dbg(bdev, "BCM irq: enabled");
 	}
 
-unlock:
-	mutex_unlock(&bcm_device_lock);
-
 	return 0;
 }
 
 /* Platform resume callback */
 static int bcm_resume(struct device *dev)
 {
-	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
-
-	bt_dev_dbg(bdev, "resume: is_suspended %d", bdev->is_suspended);
-
-	/* bcm_resume can be called at any time as long as platform device is
-	 * bound, so it should use bcm_device_lock to protect access to hci_uart
-	 * and device_wake-up GPIO.
-	 */
-	mutex_lock(&bcm_device_lock);
+	struct bcm_device *bdev =
+		serdev_device_get_drvdata(to_serdev_device(dev));
 
-	if (!bdev->hu)
-		goto unlock;
+	bt_dev_dbg(bdev, "resume");
 
-	if (device_may_wakeup(&bdev->pdev->dev)) {
+	if (device_may_wakeup(dev)) {
 		disable_irq_wake(bdev->irq);
 		bt_dev_dbg(bdev, "BCM irq: disabled");
 	}
 
 	bcm_resume_device(dev);
 
-unlock:
-	mutex_unlock(&bcm_device_lock);
-
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -756,86 +626,80 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
 }
 #endif /* CONFIG_ACPI */
 
-static int bcm_platform_probe(struct bcm_device *dev)
+static int bcm_get_resources(struct bcm_device *bdev)
 {
-	struct platform_device *pdev = dev->pdev;
-
-	dev->name = dev_name(&pdev->dev);
+	struct device *dev = &bdev->hu.serdev->dev;
 
-	dev->clk = devm_clk_get(&pdev->dev, NULL);
+	bdev->name = dev_name(dev);
+	bdev->clk = devm_clk_get(dev, NULL);
 
-	dev->device_wakeup = devm_gpiod_get_optional(&pdev->dev,
-						     "device-wakeup",
-						     GPIOD_OUT_LOW);
-	if (IS_ERR(dev->device_wakeup))
-		return PTR_ERR(dev->device_wakeup);
+	bdev->device_wakeup = devm_gpiod_get_optional(dev,
+						      "device-wakeup",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(bdev->device_wakeup))
+		return PTR_ERR(bdev->device_wakeup);
 
-	dev->shutdown = devm_gpiod_get_optional(&pdev->dev, "shutdown",
-						GPIOD_OUT_LOW);
-	if (IS_ERR(dev->shutdown))
-		return PTR_ERR(dev->shutdown);
+	bdev->shutdown = devm_gpiod_get_optional(dev, "shutdown",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(bdev->shutdown))
+		return PTR_ERR(bdev->shutdown);
 
 	/* IRQ can be declared in ACPI table as Interrupt or GpioInt */
-	dev->irq = platform_get_irq(pdev, 0);
-	if (dev->irq <= 0) {
+	if (bdev->irq == 0) {
 		struct gpio_desc *gpio;
 
-		gpio = devm_gpiod_get_optional(&pdev->dev, "host-wakeup",
+		gpio = devm_gpiod_get_optional(dev, "host-wakeup",
 					       GPIOD_IN);
 		if (IS_ERR(gpio))
 			return PTR_ERR(gpio);
 
-		dev->irq = gpiod_to_irq(gpio);
+		bdev->irq = gpiod_to_irq(gpio);
 	}
 
-	dev_info(&pdev->dev, "BCM irq: %d\n", dev->irq);
-
-	/* Make sure at-least one of the GPIO is defined and that
-	 * a name is specified for this instance
-	 */
-	if ((!dev->device_wakeup && !dev->shutdown) || !dev->name) {
-		dev_err(&pdev->dev, "invalid platform data\n");
-		return -EINVAL;
-	}
+	dev_info(dev, "BCM irq: %d\n", bdev->irq);
 
 	return 0;
 }
 
 #ifdef CONFIG_ACPI
-static int bcm_acpi_probe(struct bcm_device *dev)
+static int bcm_acpi_probe(struct bcm_device *bdev)
 {
-	struct platform_device *pdev = dev->pdev;
 	LIST_HEAD(resources);
 	const struct dmi_system_id *dmi_id;
 	const struct acpi_gpio_mapping *gpio_mapping = acpi_bcm_int_last_gpios;
+	struct device *dev = &bdev->hu.serdev->dev;
 	const struct acpi_device_id *id;
+	struct resource_entry *entry;
 	int ret;
 
 	/* Retrieve GPIO data */
-	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
+	id = acpi_match_device(dev->driver->acpi_match_table, dev);
 	if (id)
 		gpio_mapping = (const struct acpi_gpio_mapping *) id->driver_data;
 
-	ret = devm_acpi_dev_add_driver_gpios(&pdev->dev, gpio_mapping);
-	if (ret)
-		return ret;
-
-	ret = bcm_platform_probe(dev);
+	ret = devm_acpi_dev_add_driver_gpios(dev, gpio_mapping);
 	if (ret)
 		return ret;
 
 	/* Retrieve UART ACPI info */
-	ret = acpi_dev_get_resources(ACPI_COMPANION(&dev->pdev->dev),
-				     &resources, bcm_resource, dev);
+	ret = acpi_dev_get_resources(ACPI_COMPANION(dev), &resources,
+				     bcm_resource, bdev);
 	if (ret < 0)
 		return ret;
+
+	resource_list_for_each_entry(entry, &resources) {
+		if (resource_type(entry->res) == IORESOURCE_IRQ) {
+			bdev->irq = entry->res->start;
+			break;
+		}
+	}
 	acpi_dev_free_resource_list(&resources);
 
 	dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
 	if (dmi_id) {
-		bt_dev_warn(dev, "%s: Overwriting IRQ polarity to active low",
+		bt_dev_warn(bdev, "%s: Overwriting IRQ polarity to active low",
 			    dmi_id->ident);
-		dev->irq_active_low = true;
+		bdev->irq_active_low = true;
 	}
 
 	return 0;
@@ -847,48 +711,11 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 }
 #endif /* CONFIG_ACPI */
 
-static int bcm_probe(struct platform_device *pdev)
+static int bcm_of_probe(struct bcm_device *bdev)
 {
-	struct bcm_device *dev;
-	int ret;
-
-	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
-
-	dev->pdev = pdev;
-
-	if (has_acpi_companion(&pdev->dev))
-		ret = bcm_acpi_probe(dev);
-	else
-		ret = bcm_platform_probe(dev);
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
-	bcm_gpio_set_power(dev, false);
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
+	struct device *dev = &bdev->hu.serdev->dev;
 
+	device_property_read_u32(dev, "max-speed", &bdev->oper_speed);
 	return 0;
 }
 
@@ -907,6 +734,41 @@ static const struct hci_uart_proto bcm_proto = {
 	.dequeue	= bcm_dequeue,
 };
 
+static int bcm_probe(struct serdev_device *serdev)
+{
+	struct bcm_device *bdev;
+	int ret;
+
+	bdev = devm_kzalloc(&serdev->dev, sizeof(*bdev), GFP_KERNEL);
+	if (!bdev)
+		return -ENOMEM;
+
+	bdev->hu.serdev = serdev;
+	serdev_device_set_drvdata(serdev, bdev);
+
+	if (has_acpi_companion(&serdev->dev))
+		ret = bcm_acpi_probe(bdev);
+	else
+		ret = bcm_of_probe(bdev);
+	if (ret)
+		return ret;
+
+	ret = bcm_get_resources(bdev);
+	if (ret)
+		return ret;
+
+	bcm_gpio_set_power(bdev, false);
+
+	return hci_uart_register_device(&bdev->hu, &bcm_proto);
+}
+
+static void bcm_remove(struct serdev_device *serdev)
+{
+	struct bcm_device *bdev = serdev_device_get_drvdata(serdev);
+
+	hci_uart_unregister_device(&bdev->hu);
+}
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E1A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
@@ -931,72 +793,33 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id bcm_bluetooth_of_match[] = {
+	{ .compatible = "brcm,bcm43438-bt" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
+#endif
+
 /* Platform suspend and resume callbacks */
 static const struct dev_pm_ops bcm_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(bcm_suspend, bcm_resume)
 	SET_RUNTIME_PM_OPS(bcm_suspend_device, bcm_resume_device, NULL)
 };
 
-static struct platform_driver bcm_driver = {
+static struct serdev_device_driver bcm_serdev_driver = {
 	.probe = bcm_probe,
 	.remove = bcm_remove,
 	.driver = {
 		.name = "hci_bcm",
-		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
 		.pm = &bcm_pm_ops,
-	},
-};
-
-static int bcm_serdev_probe(struct serdev_device *serdev)
-{
-	struct bcm_serdev *bcmdev;
-	u32 speed;
-	int err;
-
-	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
-	if (!bcmdev)
-		return -ENOMEM;
-
-	bcmdev->hu.serdev = serdev;
-	serdev_device_set_drvdata(serdev, bcmdev);
-
-	err = device_property_read_u32(&serdev->dev, "max-speed", &speed);
-	if (!err)
-		bcmdev->hu.oper_speed = speed;
-
-	return hci_uart_register_device(&bcmdev->hu, &bcm_proto);
-}
-
-static void bcm_serdev_remove(struct serdev_device *serdev)
-{
-	struct bcm_serdev *bcmdev = serdev_device_get_drvdata(serdev);
-
-	hci_uart_unregister_device(&bcmdev->hu);
-}
-
-#ifdef CONFIG_OF
-static const struct of_device_id bcm_bluetooth_of_match[] = {
-	{ .compatible = "brcm,bcm43438-bt" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
-#endif
-
-static struct serdev_device_driver bcm_serdev_driver = {
-	.probe = bcm_serdev_probe,
-	.remove = bcm_serdev_remove,
-	.driver = {
-		.name = "hci_uart_bcm",
 		.of_match_table = of_match_ptr(bcm_bluetooth_of_match),
+		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
 	},
 };
 
 int __init bcm_init(void)
 {
-	/* For now, we need to keep both platform device
-	 * driver (ACPI generated) and serdev driver (DT).
-	 */
-	platform_driver_register(&bcm_driver);
 	serdev_device_driver_register(&bcm_serdev_driver);
 
 	return hci_uart_register_proto(&bcm_proto);
@@ -1004,7 +827,6 @@ int __init bcm_init(void)
 
 int __exit bcm_deinit(void)
 {
-	platform_driver_unregister(&bcm_driver);
 	serdev_device_driver_unregister(&bcm_serdev_driver);
 
 	return hci_uart_unregister_proto(&bcm_proto);
-- 
2.14.2


--------------12A7361867C1F6AAB1AA0D5E--
