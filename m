From: Dashi Cao <dscao999@gmail.com>
Subject: [PATCH] Add support of TI ICDI to USB simple serial device
Date: Fri, 26 Oct 2018 19:38:07 +0800
Message-ID: <20181026113807.20735-1-dscao999@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Dashi Cao <dscao999@gmail.com>
List-Id: linux-serial@vger.kernel.org

TI In-Circuit Debug Interface (ICDI) is a debugging interface for TI ARM microcontrollers. It has four USB interfaces and the first two of them are presented as standard ACM serial device. The 3rd interface is the debugging interface and it can be driven as a Linux USB simple serial device. With it, debugging sessions and firmware up/down loading are supported on Linux.

Signed-off-by: Dashi Cao <dscao999@gmail.com>
---
 drivers/usb/serial/usb-serial-simple.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 4d0273508043..ae43088b659e 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -109,6 +109,11 @@ DEVICE(suunto, SUUNTO_IDS);
 	{ USB_DEVICE(0x908, 0x0004) }
 DEVICE(siemens_mpi, SIEMENS_IDS);
 
+/* TI In-Circuit Debug Interface */
+#define ICDI_IDS()              \
+	{ USB_DEVICE_INTERFACE_CLASS(0x1cbe, 0x00fd, USB_CLASS_VENDOR_SPEC) }
+DEVICE(ti_icdi, ICDI_IDS);
+
 /* All of the above structures mushed into two lists */
 static struct usb_serial_driver * const serial_drivers[] = {
 	&carelink_device,
@@ -124,6 +129,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
 	&hp4x_device,
 	&suunto_device,
 	&siemens_mpi_device,
+	&ti_icdi_device,
 	NULL
 };
 
@@ -141,6 +147,7 @@ static const struct usb_device_id id_table[] = {
 	HP4X_IDS(),
 	SUUNTO_IDS(),
 	SIEMENS_IDS(),
+	ICDI_IDS(),
 	{ },
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.11.0
