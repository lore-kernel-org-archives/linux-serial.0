From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] Bluetooth: hci_bcm: Add support for BCM2E72
Date: Wed, 22 Nov 2017 14:37:28 +0100
Message-ID: <20171122133728.13116-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Asus T100HA laptop uses an ACPI HID of BCM2E72 for the bluetooth
part of the SDIO bcm43340 wifi/bt combo chip.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 707c2d1b84c7..47fc58c9eb49 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -939,6 +939,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E65", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E67", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E71", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E72", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7B", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7C", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7E", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
-- 
2.14.3

