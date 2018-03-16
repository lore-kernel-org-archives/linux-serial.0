From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/5] Bluetooth: hci_bcm: Add 6 new ACPI HIDs
Date: Fri, 16 Mar 2018 21:28:09 +0100
Message-ID: <20180316202811.5678-3-hdegoede@redhat.com>
References: <20180316202811.5678-1-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180316202811.5678-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add 6 new ACPI HIDs to enable bluetooth on devices using these HIDs,
I've tested the following HIDs / devices:

BCM2E74: Jumper ezPad mini 3
BCM2E83: Acer Iconia Tab8 w1-810
BCM2E90: Meegopad T08
BCM2EAA: Chuwi Vi8 plus (CWI519)

The reporter of Red Hat bugzilla 1554835 has tested:
BCM2E84: Lenovo Yoga2

The reporter of kernel bugzilla 274481 has tested:
BCM2E38: Toshiba Encore

Note the Lenovo Yoga2 and Toshiba Encore also needs the earlier patch to
treat all Interrupt ACPI resources as active low.

Cc: stable@vger.kernel.org
Buglink: https://bugzilla.kernel.org/attachment.cgi?id=274481
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1554835
Reported-and-tested-by: Robert R. Howell <rhowell@uwyo.edu>
Reported-and-tested-by: Christian Herzog <daduke@daduke.org>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 7acd77a53b08..18416c435b20 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1075,6 +1075,7 @@ static const struct hci_uart_proto bcm_proto = {
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E1A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E38", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E39", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E3A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E3D", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
@@ -1087,12 +1088,17 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E67", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E71", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E72", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E74", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7B", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7C", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7E", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
+	{ "BCM2E83", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
+	{ "BCM2E84", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E90", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E95", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ "BCM2E96", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ "BCM2EA4", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
+	{ "BCM2EAA", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
-- 
2.14.3
