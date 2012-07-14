From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 04/12] usb: fix sillies in the metro USB driver
Date: Sat, 14 Jul 2012 15:32:30 +0100
Message-ID: <20120714143221.26945.1549.stgit@localhost.localdomain>
References: <20120714142740.26945.98609.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34138 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2GNOPh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jul 2012 10:15:37 -0400
In-Reply-To: <20120714142740.26945.98609.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Bits noticed doing the termios conversion

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/usb/serial/metro-usb.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/serial/metro-usb.c b/drivers/usb/serial/metro-usb.c
index d47eb06..7ae9af6 100644
--- a/drivers/usb/serial/metro-usb.c
+++ b/drivers/usb/serial/metro-usb.c
@@ -130,20 +130,14 @@ static void metrousb_read_int_callback(struct urb *urb)
 
 	/* Set the data read from the usb port into the serial port buffer. */
 	tty = tty_port_tty_get(&port->port);
-	if (!tty) {
-		dev_err(&port->dev, "%s - bad tty pointer - exiting\n",
-			__func__);
-		return;
-	}
-
 	if (tty && urb->actual_length) {
 		/* Loop through the data copying each byte to the tty layer. */
 		tty_insert_flip_string(tty, data, urb->actual_length);
 
 		/* Force the data to the tty layer. */
 		tty_flip_buffer_push(tty);
+		tty_kref_put(tty);
 	}
-	tty_kref_put(tty);
 
 	/* Set any port variables. */
 	spin_lock_irqsave(&metro_priv->lock, flags);

