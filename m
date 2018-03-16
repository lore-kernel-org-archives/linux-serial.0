From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/5] Bluetooth: hci_bcm: Add irq_polarity module option
Date: Fri, 16 Mar 2018 21:28:07 +0100
Message-ID: <20180316202811.5678-1-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add irq_polarity module option for easier troubleshooting of irq-polarity
issues.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 5e3aba3c3185..bb6cd1623132 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -126,6 +126,10 @@ struct bcm_data {
 static DEFINE_MUTEX(bcm_device_lock);
 static LIST_HEAD(bcm_device_list);
 
+static int irq_polarity = -1;
+module_param(irq_polarity, int, 0444);
+MODULE_PARM_DESC(irq_polarity, "IRQ polarity 0: active-high 1: active-low");
+
 static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
 	if (hu->serdev)
@@ -988,11 +992,17 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	}
 	acpi_dev_free_resource_list(&resources);
 
-	dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
-	if (dmi_id) {
-		dev_warn(dev->dev, "%s: Overwriting IRQ polarity to active low",
-			    dmi_id->ident);
-		dev->irq_active_low = true;
+	if (irq_polarity != -1) {
+		dev->irq_active_low = irq_polarity;
+		dev_warn(dev->dev, "Overwriting IRQ polarity to active %s by module-param\n",
+			 dev->irq_active_low ? "low" : "high");
+	} else {
+		dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
+		if (dmi_id) {
+			dev_warn(dev->dev, "%s: Overwriting IRQ polarity to active low",
+				 dmi_id->ident);
+			dev->irq_active_low = true;
+		}
 	}
 
 	return 0;
-- 
2.14.3
