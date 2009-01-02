From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 46/75] tty: USB tty devices can block in tcdrain when unplugged
Date: Fri, 02 Jan 2009 13:47:06 +0000
Message-ID: <20090102134704.13472.79836.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37607 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752315AbZABNqv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:51 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

The underlying problem is that the device methods don't all correctly
handle disconnected status and some keep reporting bytes pending which
causes tcdrain to stall.

When the cable is unplugged they are definitely gone, and as this is true
for all USB cables we can fix it in the core usb serial code.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/usb/serial/usb-serial.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index aafa684..8d51890 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -339,6 +339,10 @@ static int serial_chars_in_buffer(struct tty_struct *tty)
 	dbg("%s = port %d", __func__, port->number);
 
 	WARN_ON(!port->port.count);
+	/* if the device was unplugged then any remaining characters
+	   fell out of the connector ;) */
+	if (port->serial->disconnected)
+		return 0;
 	/* pass on to the driver specific version of this function */
 	return port->serial->type->chars_in_buffer(tty);
 }

