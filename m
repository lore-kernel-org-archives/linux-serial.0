From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 28/75] Add device function for USB serial console
Date: Fri, 02 Jan 2009 13:44:34 +0000
Message-ID: <20090102134432.13472.31269.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60347 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757952AbZABNoU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:44:20 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Kevin Hao <kexin.hao@windriver.com>

Add device funtion for usb serial console, so we can open /dev/console
when we use a usb serial device as console.

(Typecast removed as noted by Sergei Shtylyov)

Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/usb/serial/console.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)


diff --git a/drivers/usb/serial/console.c b/drivers/usb/serial/console.c
index 5b95009..19e2404 100644
--- a/drivers/usb/serial/console.c
+++ b/drivers/usb/serial/console.c
@@ -241,12 +241,25 @@ static void usb_console_write(struct console *co,
 	}
 }
 
+static struct tty_driver *usb_console_device(struct console *co, int *index)
+{
+	struct tty_driver **p = (struct tty_driver **)co->data;
+
+	if (!*p)
+		return NULL;
+
+	*index = co->index;
+	return *p;
+}
+
 static struct console usbcons = {
 	.name =		"ttyUSB",
 	.write =	usb_console_write,
+	.device =	usb_console_device,
 	.setup =	usb_console_setup,
 	.flags =	CON_PRINTBUFFER,
 	.index =	-1,
+	.data = 	&usb_serial_tty_driver,
 };
 
 void usb_serial_console_disconnect(struct usb_serial *serial)

