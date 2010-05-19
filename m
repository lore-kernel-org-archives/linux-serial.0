From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 01/11] tty: Fix the digi acceleport driver NULL checks
Date: Wed, 19 May 2010 13:01:56 +0100
Message-ID: <20100519120148.16717.1135.stgit@localhost.localdomain>
References: <20100519120111.16717.71992.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51078 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756041Ab0ESMoY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 May 2010 08:44:24 -0400
In-Reply-To: <20100519120111.16717.71992.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

This now refcounts but doesn't actually check the reference was obtained in
all the places it should.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/usb/serial/digi_acceleport.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)


diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 3edda3e..2d28c02 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -609,8 +609,10 @@ static void digi_wakeup_write_lock(struct work_struct *work)
 static void digi_wakeup_write(struct usb_serial_port *port)
 {
 	struct tty_struct *tty = tty_port_tty_get(&port->port);
-	tty_wakeup(tty);
-	tty_kref_put(tty);
+	if (tty) {
+		tty_wakeup(tty);
+		tty_kref_put(tty);
+	}
 }
 
 
@@ -1683,7 +1685,7 @@ static int digi_read_inb_callback(struct urb *urb)
 		priv->dp_throttle_restart = 1;
 
 	/* receive data */
-	if (opcode == DIGI_CMD_RECEIVE_DATA) {
+	if (tty && opcode == DIGI_CMD_RECEIVE_DATA) {
 		/* get flag from port_status */
 		flag = 0;
 
@@ -1764,10 +1766,12 @@ static int digi_read_oob_callback(struct urb *urb)
 			return -1;
 
 		tty = tty_port_tty_get(&port->port);
+
 		rts = 0;
-		rts = tty->termios->c_cflag & CRTSCTS;
+		if (tty)
+			rts = tty->termios->c_cflag & CRTSCTS;
 		
-		if (opcode == DIGI_CMD_READ_INPUT_SIGNALS) {
+		if (tty && opcode == DIGI_CMD_READ_INPUT_SIGNALS) {
 			spin_lock(&priv->dp_port_lock);
 			/* convert from digi flags to termiox flags */
 			if (val & DIGI_READ_INPUT_SIGNALS_CTS) {

