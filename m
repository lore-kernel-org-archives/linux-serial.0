From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 4/9] Bluetooth: hci_bcm: Move platform_get_irq call to bcm_probe
Date: Wed,  4 Oct 2017 20:43:38 +0200
Message-ID: <20171004184343.7855-4-hdegoede@redhat.com>
References: <20171004184343.7855-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171004184343.7855-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The ACPI subsys is going to move over to instantiating ACPI enumerated
HCIs as serdevs, rather then as platform devices.

Most of the code in bcm_platform_probe is actually not platform
specific and will work with any struct device passed to it, the one
platform specific call in bcm_platform_probe is platform_get_irq.

This commit moves platform_get_irq call to the platform-driver's bcm_probe
function, this is a preparation patch for adding (runtime)pm support to
the serdev path.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 00103307a776..ea530a56778d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -776,7 +776,6 @@ static int bcm_platform_probe(struct bcm_device *dev)
 		return PTR_ERR(dev->shutdown);
 
 	/* IRQ can be declared in ACPI table as Interrupt or GpioInt */
-	dev->irq = platform_get_irq(pdev, 0);
 	if (dev->irq <= 0) {
 		struct gpio_desc *gpio;
 
@@ -853,6 +852,7 @@ static int bcm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dev->pdev = pdev;
+	dev->irq = platform_get_irq(pdev, 0);
 
 	if (has_acpi_companion(&pdev->dev)) {
 		ret = bcm_acpi_probe(dev);
-- 
2.14.2

