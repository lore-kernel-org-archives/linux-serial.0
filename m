From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 24/75] tty: Fix close races in USB serial
Date: Fri, 02 Jan 2009 13:44:04 +0000
Message-ID: <20090102134346.13472.85567.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60335 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756125AbZABNnt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:43:49 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

USB serial has always had races where the tty port usage count can hit zero
during a receive event. The internal locking is a mutex so we can't use
that in the IRQ handlers.

With krefs we can tackle this differently but we still need to be careful.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/usb/serial/usb-serial.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)


diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 794b5ff..aafa684 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -269,15 +269,19 @@ static void serial_close(struct tty_struct *tty, struct file *filp)
 		return;
 	}
 
-	--port->port.count;
-	if (port->port.count == 0)
+	if (port->port.count == 1)
 		/* only call the device specific close if this
-		 * port is being closed by the last owner */
+		 * port is being closed by the last owner. Ensure we do
+		 * this before we drop the port count. The call is protected
+		 * by the port mutex
+		 */
 		port->serial->type->close(tty, port, filp);
 
-	if (port->port.count == (port->console? 1 : 0)) {
+	if (port->port.count == (port->console ? 2 : 1)) {
 		struct tty_struct *tty = tty_port_tty_get(&port->port);
 		if (tty) {
+			/* We must do this before we drop the port count to
+			   zero. */
 			if (tty->driver_data)
 				tty->driver_data = NULL;
 			tty_port_tty_set(&port->port, NULL);
@@ -285,13 +289,14 @@ static void serial_close(struct tty_struct *tty, struct file *filp)
 		}
 	}
 
-	if (port->port.count == 0) {
+	if (port->port.count == 1) {
 		mutex_lock(&port->serial->disc_mutex);
 		if (!port->serial->disconnected)
 			usb_autopm_put_interface(port->serial->interface);
 		mutex_unlock(&port->serial->disc_mutex);
 		module_put(port->serial->type->driver.owner);
 	}
+	--port->port.count;
 
 	mutex_unlock(&port->mutex);
 	usb_serial_put(port->serial);

