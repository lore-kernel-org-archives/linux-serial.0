From: Aristeu Rozanski <aris@ruivo.org>
Subject: [PATCH] usb_serial_console: fix command line parsing
Date: Mon, 12 Nov 2007 15:14:49 -0500
Message-ID: <20071112201449.GH407@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([66.92.68.119]:56941 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbXKLUmW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Nov 2007 15:42:22 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg KH <greg@kroah.com>

Currently usb serial console support ignores the device and always use
ttyUSB0.

Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>

---
 drivers/usb/serial/console.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- upstream.orig/drivers/usb/serial/console.c	2007-11-12 11:56:02.000000000 -0500
+++ upstream/drivers/usb/serial/console.c	2007-11-12 14:38:12.000000000 -0500
@@ -133,11 +133,14 @@ static int usb_console_setup(struct cons
 	}
 	co->cflag = cflag;
 
-	/* grab the first serial port that happens to be connected */
-	serial = usb_serial_get_by_index(0);
+	/*
+	 * no need to check the index here: if the index is wrong, console
+	 * code won't call us
+	 */
+	serial = usb_serial_get_by_index(co->index);
 	if (serial == NULL) {
 		/* no device is connected yet, sorry :( */
-		err ("No USB device connected to ttyUSB0");
+		err ("No USB device connected to ttyUSB%i", co->index);
 		return -ENODEV;
 	}
 
