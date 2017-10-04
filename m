From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 7/9] Bluetooth: hci_bcm: Make acpi_probe get irq from ACPI resources
Date: Wed,  4 Oct 2017 20:43:41 +0200
Message-ID: <20171004184343.7855-7-hdegoede@redhat.com>
References: <20171004184343.7855-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171004184343.7855-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The ACPI subsys is going to move over to instantiating ACPI enumerated
HCIs as serdevs, rather then as platform devices.

So we need to make bcm_acpi_probe() suitable for use on non platform-
devices too, which means that we cannot rely on platform_get_irq()
getting called.

This commit modifies bcm_acpi_probe() to directly get the irq from
the ACPI resources, this is a preparation patch for adding (runtime)pm
support to the serdev path.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Make bcm_resource return 0 so that acpi_dev_get_resources() does not
 return an empty list (Suggested-by: Frédéric Danis)
---
 drivers/bluetooth/hci_bcm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 5c8371d8aace..e577547c4acf 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -751,8 +751,7 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
 		break;
 	}
 
-	/* Always tell the ACPI core to skip this resource */
-	return 1;
+	return 0;
 }
 #endif /* CONFIG_ACPI */
 
@@ -805,6 +804,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	const struct dmi_system_id *dmi_id;
 	const struct acpi_gpio_mapping *gpio_mapping = acpi_bcm_int_last_gpios;
 	const struct acpi_device_id *id;
+	struct resource_entry *entry;
 	int ret;
 
 	/* Retrieve GPIO data */
@@ -821,6 +821,13 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 				     &resources, bcm_resource, dev);
 	if (ret < 0)
 		return ret;
+
+	resource_list_for_each_entry(entry, &resources) {
+		if (resource_type(entry->res) == IORESOURCE_IRQ) {
+			dev->irq = entry->res->start;
+			break;
+		}
+	}
 	acpi_dev_free_resource_list(&resources);
 
 	dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
-- 
2.14.2

