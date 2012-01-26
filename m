From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/3] ftdi_sio: Add more identifiers
Date: Thu, 26 Jan 2012 17:41:34 +0000
Message-ID: <20120126174121.16858.13827.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55310 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab2AZR2C (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Jan 2012 12:28:02 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

0x04d8, 0x000a: Hornby Elite

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/usb/serial/ftdi_sio.c     |    1 +
 drivers/usb/serial/ftdi_sio_ids.h |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)


diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 104aff5..ad654f8 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -797,6 +797,7 @@ static struct usb_device_id id_table_combined [] = {
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(ADI_VID, ADI_GNICEPLUS_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE(HORNBY_VID, HORNBY_ELITE_PID) },
 	{ USB_DEVICE(JETI_VID, JETI_SPC1201_PID) },
 	{ USB_DEVICE(MARVELL_VID, MARVELL_SHEEVAPLUG_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 09237ff..f994503 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -532,6 +532,12 @@
 #define ADI_GNICEPLUS_PID	0xF001
 
 /*
+ * Hornby Elite
+ */
+#define HORNBY_VID		0x04D8
+#define HORNBY_ELITE_PID	0x000A
+
+/*
  * RATOC REX-USB60F
  */
 #define RATOC_VENDOR_ID		0x0584

