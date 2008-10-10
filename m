From: Alan Cox <alan@redhat.com>
Subject: [PATCH 26/27] ftdi: A few errors are err() that should be debug which
	causes much spewage
Date: Fri, 10 Oct 2008 11:51:30 +0100
Message-ID: <20081010105127.31597.16229.stgit@localhost.localdomain>
References: <20081010103447.31597.42992.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47621 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758456AbYJJKvd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2008 06:51:33 -0400
In-Reply-To: <20081010103447.31597.42992.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Fixes #10783

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/usb/serial/ftdi_sio.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 3dc93b5..1ac7e80 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -860,7 +860,7 @@ static int update_mctrl(struct usb_serial_port *port, unsigned int set,
 
 	kfree(buf);
 	if (rv < 0) {
-		err("%s Error from MODEM_CTRL urb: DTR %s, RTS %s",
+		dbg("%s Error from MODEM_CTRL urb: DTR %s, RTS %s",
 				__func__,
 				(set & TIOCM_DTR) ? "HIGH" :
 				(clear & TIOCM_DTR) ? "LOW" : "unchanged",
@@ -2256,7 +2256,7 @@ static int ftdi_tiocmget(struct tty_struct *tty, struct file *file)
 			   0, 0,
 			   buf, 1, WDR_TIMEOUT);
 		if (ret < 0) {
-			err("%s Could not get modem status of device - err: %d", __func__,
+			dbg("%s Could not get modem status of device - err: %d", __func__,
 			    ret);
 			return ret;
 		}
@@ -2275,7 +2275,7 @@ static int ftdi_tiocmget(struct tty_struct *tty, struct file *file)
 				   0, priv->interface,
 				   buf, 2, WDR_TIMEOUT);
 		if (ret < 0) {
-			err("%s Could not get modem status of device - err: %d", __func__,
+			dbg("%s Could not get modem status of device - err: %d", __func__,
 			    ret);
 			return ret;
 		}

