From: ianwmorrison@gmail.com
Subject: [PATCH] Bluetooth: hci_bcm: Remove DMI quirk for the MINIX Z83-4
Date: Tue, 27 Mar 2018 09:09:28 +1100
Message-ID: <20180326220928.2755-1-ianwmorrison@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org, hdegoede@redhat.com, ianwmorrison@gmail.com
List-Id: linux-serial@vger.kernel.org

As Interrupt resource specified IRQs are now assumed to be always
active-low the DMI quirk for the MINIX Z83-4 is no longer required.

Cc: stable@vger.kernel.org
Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 6828e485bc24..8a011267a4f6 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -804,13 +804,6 @@ static const struct dmi_system_id bcm_active_low_irq_dmi_table[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "ThinkPad 8"),
 		},
 	},
-	{
-		.ident = "MINIX Z83-4",
-		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MINIX"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
-		},
-	},
 	{ }
 };
 
-- 
2.11.0
