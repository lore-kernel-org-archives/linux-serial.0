From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 5/9] Bluetooth: hci_bcm: Store device pointer instead of platform_device pointer
Date: Wed,  4 Oct 2017 20:43:39 +0200
Message-ID: <20171004184343.7855-5-hdegoede@redhat.com>
References: <20171004184343.7855-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171004184343.7855-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The ACPI subsys is going to move over to instantiating ACPI enumerated
HCIs as serdevs, rather then as platform devices.

This means that the serdev driver paths of hci_bcm.c also need to start
supporting (runtime)pm through GPIOs and a host-wake IRQ.

The hci_bcm code is already mostly independent of how the HCI gets
instantiated, but even though the code only cares about pdev->dev, it
was storing pdev itself in struct bcm_device.

This commit stores pdev->dev rather then pdev in struct bcm_device, this
is a preparation patch for adding (runtime)pm support to the serdev path.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 73 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ea530a56778d..cfc87fb5051c 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -56,7 +56,7 @@
 struct bcm_device {
 	struct list_head	list;
 
-	struct platform_device	*pdev;
+	struct device		*dev;
 
 	const char		*name;
 	struct gpio_desc	*device_wakeup;
@@ -188,9 +188,9 @@ static irqreturn_t bcm_host_wake(int irq, void *data)
 
 	bt_dev_dbg(bdev, "Host wake IRQ");
 
-	pm_runtime_get(&bdev->pdev->dev);
-	pm_runtime_mark_last_busy(&bdev->pdev->dev);
-	pm_runtime_put_autosuspend(&bdev->pdev->dev);
+	pm_runtime_get(bdev->dev);
+	pm_runtime_mark_last_busy(bdev->dev);
+	pm_runtime_put_autosuspend(bdev->dev);
 
 	return IRQ_HANDLED;
 }
@@ -212,20 +212,20 @@ static int bcm_request_irq(struct bcm_data *bcm)
 		goto unlock;
 	}
 
-	err = devm_request_irq(&bdev->pdev->dev, bdev->irq, bcm_host_wake,
+	err = devm_request_irq(bdev->dev, bdev->irq, bcm_host_wake,
 			       bdev->irq_active_low ? IRQF_TRIGGER_FALLING :
 						      IRQF_TRIGGER_RISING,
 			       "host_wake", bdev);
 	if (err)
 		goto unlock;
 
-	device_init_wakeup(&bdev->pdev->dev, true);
+	device_init_wakeup(bdev->dev, true);
 
-	pm_runtime_set_autosuspend_delay(&bdev->pdev->dev,
+	pm_runtime_set_autosuspend_delay(bdev->dev,
 					 BCM_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(&bdev->pdev->dev);
-	pm_runtime_set_active(&bdev->pdev->dev);
-	pm_runtime_enable(&bdev->pdev->dev);
+	pm_runtime_use_autosuspend(bdev->dev);
+	pm_runtime_set_active(bdev->dev);
+	pm_runtime_enable(bdev->dev);
 
 unlock:
 	mutex_unlock(&bcm_device_lock);
@@ -332,7 +332,7 @@ static int bcm_open(struct hci_uart *hu)
 		 * platform device (saved during device probe) and
 		 * parent of tty device used by hci_uart
 		 */
-		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
+		if (hu->tty->dev->parent == dev->dev->parent) {
 			bcm->dev = dev;
 			hu->init_speed = dev->init_speed;
 			hu->oper_speed = dev->oper_speed;
@@ -367,12 +367,12 @@ static int bcm_close(struct hci_uart *hu)
 	if (bcm_device_exists(bdev)) {
 		bcm_gpio_set_power(bdev, false);
 #ifdef CONFIG_PM
-		pm_runtime_disable(&bdev->pdev->dev);
-		pm_runtime_set_suspended(&bdev->pdev->dev);
+		pm_runtime_disable(bdev->dev);
+		pm_runtime_set_suspended(bdev->dev);
 
-		if (device_can_wakeup(&bdev->pdev->dev)) {
-			devm_free_irq(&bdev->pdev->dev, bdev->irq, bdev);
-			device_init_wakeup(&bdev->pdev->dev, false);
+		if (device_can_wakeup(bdev->dev)) {
+			devm_free_irq(bdev->dev, bdev->irq, bdev);
+			device_init_wakeup(bdev->dev, false);
 		}
 
 		bdev->hu = NULL;
@@ -506,9 +506,9 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
 		/* Delay auto-suspend when receiving completed packet */
 		mutex_lock(&bcm_device_lock);
 		if (bcm->dev && bcm_device_exists(bcm->dev)) {
-			pm_runtime_get(&bcm->dev->pdev->dev);
-			pm_runtime_mark_last_busy(&bcm->dev->pdev->dev);
-			pm_runtime_put_autosuspend(&bcm->dev->pdev->dev);
+			pm_runtime_get(bcm->dev->dev);
+			pm_runtime_mark_last_busy(bcm->dev->dev);
+			pm_runtime_put_autosuspend(bcm->dev->dev);
 		}
 		mutex_unlock(&bcm_device_lock);
 	}
@@ -539,15 +539,15 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 
 	if (bcm_device_exists(bcm->dev)) {
 		bdev = bcm->dev;
-		pm_runtime_get_sync(&bdev->pdev->dev);
+		pm_runtime_get_sync(bdev->dev);
 		/* Shall be resumed here */
 	}
 
 	skb = skb_dequeue(&bcm->txq);
 
 	if (bdev) {
-		pm_runtime_mark_last_busy(&bdev->pdev->dev);
-		pm_runtime_put_autosuspend(&bdev->pdev->dev);
+		pm_runtime_mark_last_busy(bdev->dev);
+		pm_runtime_put_autosuspend(bdev->dev);
 	}
 
 	mutex_unlock(&bcm_device_lock);
@@ -623,7 +623,7 @@ static int bcm_suspend(struct device *dev)
 	if (pm_runtime_active(dev))
 		bcm_suspend_device(dev);
 
-	if (device_may_wakeup(&bdev->pdev->dev)) {
+	if (device_may_wakeup(dev)) {
 		error = enable_irq_wake(bdev->irq);
 		if (!error)
 			bt_dev_dbg(bdev, "BCM irq: enabled");
@@ -651,7 +651,7 @@ static int bcm_resume(struct device *dev)
 	if (!bdev->hu)
 		goto unlock;
 
-	if (device_may_wakeup(&bdev->pdev->dev)) {
+	if (device_may_wakeup(dev)) {
 		disable_irq_wake(bdev->irq);
 		bt_dev_dbg(bdev, "BCM irq: disabled");
 	}
@@ -758,19 +758,17 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
 
 static int bcm_platform_probe(struct bcm_device *dev)
 {
-	struct platform_device *pdev = dev->pdev;
+	dev->name = dev_name(dev->dev);
 
-	dev->name = dev_name(&pdev->dev);
+	dev->clk = devm_clk_get(dev->dev, NULL);
 
-	dev->clk = devm_clk_get(&pdev->dev, NULL);
-
-	dev->device_wakeup = devm_gpiod_get_optional(&pdev->dev,
+	dev->device_wakeup = devm_gpiod_get_optional(dev->dev,
 						     "device-wakeup",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
 		return PTR_ERR(dev->device_wakeup);
 
-	dev->shutdown = devm_gpiod_get_optional(&pdev->dev, "shutdown",
+	dev->shutdown = devm_gpiod_get_optional(dev->dev, "shutdown",
 						GPIOD_OUT_LOW);
 	if (IS_ERR(dev->shutdown))
 		return PTR_ERR(dev->shutdown);
@@ -779,7 +777,7 @@ static int bcm_platform_probe(struct bcm_device *dev)
 	if (dev->irq <= 0) {
 		struct gpio_desc *gpio;
 
-		gpio = devm_gpiod_get_optional(&pdev->dev, "host-wakeup",
+		gpio = devm_gpiod_get_optional(dev->dev, "host-wakeup",
 					       GPIOD_IN);
 		if (IS_ERR(gpio))
 			return PTR_ERR(gpio);
@@ -787,13 +785,13 @@ static int bcm_platform_probe(struct bcm_device *dev)
 		dev->irq = gpiod_to_irq(gpio);
 	}
 
-	dev_info(&pdev->dev, "BCM irq: %d\n", dev->irq);
+	dev_info(dev->dev, "BCM irq: %d\n", dev->irq);
 
 	/* Make sure at-least one of the GPIO is defined and that
 	 * a name is specified for this instance
 	 */
 	if ((!dev->device_wakeup && !dev->shutdown) || !dev->name) {
-		dev_err(&pdev->dev, "invalid platform data\n");
+		dev_err(dev->dev, "invalid platform data\n");
 		return -EINVAL;
 	}
 
@@ -803,7 +801,6 @@ static int bcm_platform_probe(struct bcm_device *dev)
 #ifdef CONFIG_ACPI
 static int bcm_acpi_probe(struct bcm_device *dev)
 {
-	struct platform_device *pdev = dev->pdev;
 	LIST_HEAD(resources);
 	const struct dmi_system_id *dmi_id;
 	const struct acpi_gpio_mapping *gpio_mapping = acpi_bcm_int_last_gpios;
@@ -811,16 +808,16 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	int ret;
 
 	/* Retrieve GPIO data */
-	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
+	id = acpi_match_device(dev->dev->driver->acpi_match_table, dev->dev);
 	if (id)
 		gpio_mapping = (const struct acpi_gpio_mapping *) id->driver_data;
 
-	ret = devm_acpi_dev_add_driver_gpios(&pdev->dev, gpio_mapping);
+	ret = devm_acpi_dev_add_driver_gpios(dev->dev, gpio_mapping);
 	if (ret)
 		return ret;
 
 	/* Retrieve UART ACPI info */
-	ret = acpi_dev_get_resources(ACPI_COMPANION(&dev->pdev->dev),
+	ret = acpi_dev_get_resources(ACPI_COMPANION(dev->dev),
 				     &resources, bcm_resource, dev);
 	if (ret < 0)
 		return ret;
@@ -851,7 +848,7 @@ static int bcm_probe(struct platform_device *pdev)
 	if (!dev)
 		return -ENOMEM;
 
-	dev->pdev = pdev;
+	dev->dev = &pdev->dev;
 	dev->irq = platform_get_irq(pdev, 0);
 
 	if (has_acpi_companion(&pdev->dev)) {
-- 
2.14.2

