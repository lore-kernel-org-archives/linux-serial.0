From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH resend] USB: serial: fix null-pointer dereferences on disconnect
Date: Wed, 13 Feb 2013 17:53:28 +0100
Message-ID: <1360774408-29754-1-git-send-email-jhovold@gmail.com>
References: <20130213164130.GA8371@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:48337 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760009Ab3BMQzH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 11:55:07 -0500
In-Reply-To: <20130213164130.GA8371@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chris Ruehl <chris.ruehl@gtsys.com.hk>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Johan Hovold <jhovold@gmail.com>, stable@vger.kernel.org

Make sure serial-driver dtr_rts is called with disc_mutex held after
checking the disconnected flag.

Due to a bug in the tty layer, dtr_rts may get called after a device has
been disconnected and the tty-device unregistered. Some drivers have had
individual checks for disconnect to make sure the disconnected interface
was not accessed, but this should really be handled in usb-serial core
(at least until the long-standing tty-bug has been fixed).

Note that the problem has been made more acute with commit 0998d0631001
("device-core: Ensure drvdata = NULL when no driver is bound") as the
port data is now also NULL when dtr_rts is called resulting in further
oopses.

Reported-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---

Resend with missing Signed-off-by added...

 drivers/usb/serial/ftdi_sio.c   | 20 +++++++++-----------
 drivers/usb/serial/mct_u232.c   | 22 +++++++++-------------
 drivers/usb/serial/quatech2.c   | 18 ++++++++----------
 drivers/usb/serial/sierra.c     |  8 +-------
 drivers/usb/serial/ssu100.c     | 19 ++++++++-----------
 drivers/usb/serial/usb-serial.c | 14 ++++++++++++--
 drivers/usb/serial/usb_wwan.c   |  8 +++-----
 7 files changed, 50 insertions(+), 59 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 90ceef1..d07fccf 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1886,24 +1886,22 @@ static void ftdi_dtr_rts(struct usb_serial_port *port, int on)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 
-	mutex_lock(&port->serial->disc_mutex);
-	if (!port->serial->disconnected) {
-		/* Disable flow control */
-		if (!on && usb_control_msg(port->serial->dev,
+	/* Disable flow control */
+	if (!on) {
+		if (usb_control_msg(port->serial->dev,
 			    usb_sndctrlpipe(port->serial->dev, 0),
 			    FTDI_SIO_SET_FLOW_CTRL_REQUEST,
 			    FTDI_SIO_SET_FLOW_CTRL_REQUEST_TYPE,
 			    0, priv->interface, NULL, 0,
 			    WDR_TIMEOUT) < 0) {
-			    dev_err(&port->dev, "error from flowcontrol urb\n");
+			dev_err(&port->dev, "error from flowcontrol urb\n");
 		}
-		/* drop RTS and DTR */
-		if (on)
-			set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
-		else
-			clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 	}
-	mutex_unlock(&port->serial->disc_mutex);
+	/* drop RTS and DTR */
+	if (on)
+		set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+	else
+		clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 }
 
 /*
diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index b691175..d9c8651 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -499,19 +499,15 @@ static void mct_u232_dtr_rts(struct usb_serial_port *port, int on)
 	unsigned int control_state;
 	struct mct_u232_private *priv = usb_get_serial_port_data(port);
 
-	mutex_lock(&port->serial->disc_mutex);
-	if (!port->serial->disconnected) {
-		/* drop DTR and RTS */
-		spin_lock_irq(&priv->lock);
-		if (on)
-			priv->control_state |= TIOCM_DTR | TIOCM_RTS;
-		else
-			priv->control_state &= ~(TIOCM_DTR | TIOCM_RTS);
-		control_state = priv->control_state;
-		spin_unlock_irq(&priv->lock);
-		mct_u232_set_modem_ctrl(port, control_state);
-	}
-	mutex_unlock(&port->serial->disc_mutex);
+	spin_lock_irq(&priv->lock);
+	if (on)
+		priv->control_state |= TIOCM_DTR | TIOCM_RTS;
+	else
+		priv->control_state &= ~(TIOCM_DTR | TIOCM_RTS);
+	control_state = priv->control_state;
+	spin_unlock_irq(&priv->lock);
+
+	mct_u232_set_modem_ctrl(port, control_state);
 }
 
 static void mct_u232_close(struct usb_serial_port *port)
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index d152be9..a8d5110 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -945,19 +945,17 @@ static void qt2_dtr_rts(struct usb_serial_port *port, int on)
 	struct usb_device *dev = port->serial->dev;
 	struct qt2_port_private *port_priv = usb_get_serial_port_data(port);
 
-	mutex_lock(&port->serial->disc_mutex);
-	if (!port->serial->disconnected) {
-		/* Disable flow control */
-		if (!on && qt2_setregister(dev, port_priv->device_port,
+	/* Disable flow control */
+	if (!on) {
+		if (qt2_setregister(dev, port_priv->device_port,
 					   UART_MCR, 0) < 0)
 			dev_warn(&port->dev, "error from flowcontrol urb\n");
-		/* drop RTS and DTR */
-		if (on)
-			update_mctrl(port_priv, TIOCM_DTR | TIOCM_RTS, 0);
-		else
-			update_mctrl(port_priv, 0, TIOCM_DTR | TIOCM_RTS);
 	}
-	mutex_unlock(&port->serial->disc_mutex);
+	/* drop RTS and DTR */
+	if (on)
+		update_mctrl(port_priv, TIOCM_DTR | TIOCM_RTS, 0);
+	else
+		update_mctrl(port_priv, 0, TIOCM_DTR | TIOCM_RTS);
 }
 
 static void qt2_update_msr(struct usb_serial_port *port, unsigned char *ch)
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index af06f2f..d4426c0 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -861,19 +861,13 @@ static int sierra_open(struct tty_struct *tty, struct usb_serial_port *port)
 
 static void sierra_dtr_rts(struct usb_serial_port *port, int on)
 {
-	struct usb_serial *serial = port->serial;
 	struct sierra_port_private *portdata;
 
 	portdata = usb_get_serial_port_data(port);
 	portdata->rts_state = on;
 	portdata->dtr_state = on;
 
-	if (serial->dev) {
-		mutex_lock(&serial->disc_mutex);
-		if (!serial->disconnected)
-			sierra_send_setup(port);
-		mutex_unlock(&serial->disc_mutex);
-	}
+	sierra_send_setup(port);
 }
 
 static int sierra_startup(struct usb_serial *serial)
diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 4543ea3..d938396 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -506,19 +506,16 @@ static void ssu100_dtr_rts(struct usb_serial_port *port, int on)
 {
 	struct usb_device *dev = port->serial->dev;
 
-	mutex_lock(&port->serial->disc_mutex);
-	if (!port->serial->disconnected) {
-		/* Disable flow control */
-		if (!on &&
-		    ssu100_setregister(dev, 0, UART_MCR, 0) < 0)
+	/* Disable flow control */
+	if (!on) {
+		if (ssu100_setregister(dev, 0, UART_MCR, 0) < 0)
 			dev_err(&port->dev, "error from flowcontrol urb\n");
-		/* drop RTS and DTR */
-		if (on)
-			set_mctrl(dev, TIOCM_DTR | TIOCM_RTS);
-		else
-			clear_mctrl(dev, TIOCM_DTR | TIOCM_RTS);
 	}
-	mutex_unlock(&port->serial->disc_mutex);
+	/* drop RTS and DTR */
+	if (on)
+		set_mctrl(dev, TIOCM_DTR | TIOCM_RTS);
+	else
+		clear_mctrl(dev, TIOCM_DTR | TIOCM_RTS);
 }
 
 static void ssu100_update_msr(struct usb_serial_port *port, u8 msr)
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 64bda13..15af799 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -688,10 +688,20 @@ static int serial_carrier_raised(struct tty_port *port)
 static void serial_dtr_rts(struct tty_port *port, int on)
 {
 	struct usb_serial_port *p = container_of(port, struct usb_serial_port, port);
-	struct usb_serial_driver *drv = p->serial->type;
+	struct usb_serial *serial = p->serial;
+	struct usb_serial_driver *drv = serial->type;
 
-	if (drv->dtr_rts)
+	if (!drv->dtr_rts)
+		return;
+	/*
+	 * Work-around bug in the tty-layer which can result in dtr_rts
+	 * being called after a disconnect (and tty_unregister_device
+	 * has returned). Remove once bug has been squashed.
+	 */
+	mutex_lock(&serial->disc_mutex);
+	if (!serial->disconnected)
 		drv->dtr_rts(p, on);
+	mutex_unlock(&serial->disc_mutex);
 }
 
 static const struct tty_port_operations serial_port_ops = {
diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index 01c94aa..1355a6c 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -38,7 +38,6 @@
 
 void usb_wwan_dtr_rts(struct usb_serial_port *port, int on)
 {
-	struct usb_serial *serial = port->serial;
 	struct usb_wwan_port_private *portdata;
 	struct usb_wwan_intf_private *intfdata;
 
@@ -48,12 +47,11 @@ void usb_wwan_dtr_rts(struct usb_serial_port *port, int on)
 		return;
 
 	portdata = usb_get_serial_port_data(port);
-	mutex_lock(&serial->disc_mutex);
+	/* FIXME: locking */
 	portdata->rts_state = on;
 	portdata->dtr_state = on;
-	if (serial->dev)
-		intfdata->send_setup(port);
-	mutex_unlock(&serial->disc_mutex);
+
+	intfdata->send_setup(port);
 }
 EXPORT_SYMBOL(usb_wwan_dtr_rts);
 
-- 
1.8.1.1

