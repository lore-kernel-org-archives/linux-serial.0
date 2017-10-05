From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] Revert "Bluetooth: btusb: Add workaround for Broadcom devices without product id"
Date: Thu,  5 Oct 2017 09:42:51 +0200
Message-ID: <20171005074251.7274-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Commit 9834e586fa ("Bluetooth: btusb: Add workaround for Broadcom devices
without product id") was added to deal with the BT part of the BCM4356A2
on GPD pocket laptops having an usb vid:pid of 0000:0000.

After another commit to add support for the BCM UART connected BT ACPI-id
BCM2E7E used on the GPD win, it turns out that the BT on the GPD pocket is
connected via both USB and UART. Adding support for the BCM2E7E ACPI-id
causes it to switch to UART mode.

The Windows shipped with the device is using it in UART mode and the
presence of the BCM2E7E ACPI-id combined with the 0 USB vid:pid also
indicates that the BT part was never meant to be used in USB mode.

But not only is there no need to support the USB mode, supporting it
actually is troublesome, because with the workaround to support the all 0
USB vid:pid, BT will just work for end users, until we add support for
the ACPI-id, after which users need to have userspace doing a btattach,
which may be considered a regression.

To avoid this regression when switching things over to UART mode as
intended by the ACPI tables all along, this commit reverts the commit
adding the workaround to support the all 0 USB vid:pid.

This reverts commit 9834e586fa ("Bluetooth: btusb: Add workaround for
Broadcom devices without product id").

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btusb.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7a5c06aaa181..c054d7bce490 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -66,7 +66,6 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BCM2045		0x40000
 #define BTUSB_IFNUM_2		0x80000
 #define BTUSB_CW6622		0x100000
-#define BTUSB_BCM_NO_PRODID	0x200000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -171,10 +170,6 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0930, 0xff, 0x01, 0x01),
 	  .driver_info = BTUSB_BCM_PATCHRAM },
 
-	/* Broadcom devices with missing product id */
-	{ USB_DEVICE_AND_INTERFACE_INFO(0x0000, 0x0000, 0xff, 0x01, 0x01),
-	  .driver_info = BTUSB_BCM_PATCHRAM | BTUSB_BCM_NO_PRODID },
-
 	/* Intel Bluetooth USB Bootloader (RAM module) */
 	{ USB_DEVICE(0x8087, 0x0a5a),
 	  .driver_info = BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
@@ -2909,19 +2904,6 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info == BTUSB_IGNORE)
 		return -ENODEV;
 
-	if (id->driver_info & BTUSB_BCM_NO_PRODID) {
-		struct usb_device *udev = interface_to_usbdev(intf);
-
-		/* For the broken Broadcom devices that show 0000:0000
-		 * as USB vendor and product information, check that the
-		 * manufacturer string identifies them as Broadcom based
-		 * devices.
-		 */
-		if (!udev->manufacturer ||
-		    strcmp(udev->manufacturer, "Broadcom Corp"))
-			return -ENODEV;
-	}
-
 	if (id->driver_info & BTUSB_ATH3012) {
 		struct usb_device *udev = interface_to_usbdev(intf);
 
-- 
2.14.2

