From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 52/75] tty: Fix the HSO termios handling a bit
Date: Fri, 02 Jan 2009 13:47:45 +0000
Message-ID: <20090102134744.13472.44859.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37633 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758417AbZABNrh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:47:37 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Init the tty structure once
Don't set ->low_latency twice in a row
Don't force bits we should be leaving to the user
Don't allocate termios arrays as these are in fact allocated by the tty layer
for you and just overwrite the ones allocated in the driver

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/net/usb/hso.c |   55 ++++++++++++++++++++++++++++---------------------
 1 files changed, 31 insertions(+), 24 deletions(-)


diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index d345a6e..7373fb6 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -362,8 +362,6 @@ static struct tty_driver *tty_drv;
 static struct hso_device *serial_table[HSO_SERIAL_TTY_MINORS];
 static struct hso_device *network_table[HSO_MAX_NET_DEVICES];
 static spinlock_t serial_table_lock;
-static struct ktermios *hso_serial_termios[HSO_SERIAL_TTY_MINORS];
-static struct ktermios *hso_serial_termios_locked[HSO_SERIAL_TTY_MINORS];
 
 static const s32 default_port_spec[] = {
 	HSO_INTF_MUX | HSO_PORT_NETWORK,
@@ -1009,23 +1007,11 @@ static void read_bulk_callback(struct urb *urb)
 
 /* Serial driver functions */
 
-static void _hso_serial_set_termios(struct tty_struct *tty,
-				    struct ktermios *old)
+static void hso_init_termios(struct ktermios *termios)
 {
-	struct hso_serial *serial = get_serial_by_tty(tty);
-	struct ktermios *termios;
-
-	if (!serial) {
-		printk(KERN_ERR "%s: no tty structures", __func__);
-		return;
-	}
-
-	D4("port %d", serial->minor);
-
 	/*
 	 * The default requirements for this device are:
 	 */
-	termios = tty->termios;
 	termios->c_iflag &=
 		~(IGNBRK	/* disable ignore break */
 		| BRKINT	/* disable break causes interrupt */
@@ -1057,15 +1043,38 @@ static void _hso_serial_set_termios(struct tty_struct *tty,
 	termios->c_cflag |= CS8;	/* character size 8 bits */
 
 	/* baud rate 115200 */
-	tty_encode_baud_rate(tty, 115200, 115200);
+	tty_termios_encode_baud_rate(termios, 115200, 115200);
+}
+
+static void _hso_serial_set_termios(struct tty_struct *tty,
+				    struct ktermios *old)
+{
+	struct hso_serial *serial = get_serial_by_tty(tty);
+	struct ktermios *termios;
+
+	if (!serial) {
+		printk(KERN_ERR "%s: no tty structures", __func__);
+		return;
+	}
+
+	D4("port %d", serial->minor);
 
 	/*
-	 * Force low_latency on; otherwise the pushes are scheduled;
-	 * this is bad as it opens up the possibility of dropping bytes
-	 * on the floor.  We don't want to drop bytes on the floor. :)
+	 *	Fix up unsupported bits
 	 */
-	tty->low_latency = 1;
-	return;
+	termios = tty->termios;
+	termios->c_iflag &= ~IXON; /* disable enable XON/XOFF flow control */
+
+	termios->c_cflag &=
+		~(CSIZE		/* no size */
+		| PARENB	/* disable parity bit */
+		| CBAUD		/* clear current baud rate */
+		| CBAUDEX);	/* clear current buad rate */
+
+	termios->c_cflag |= CS8;	/* character size 8 bits */
+
+	/* baud rate 115200 */
+	tty_encode_baud_rate(tty, 115200, 115200);
 }
 
 static void hso_resubmit_rx_bulk_urb(struct hso_serial *serial, struct urb *urb)
@@ -2969,9 +2978,7 @@ static int __init hso_init(void)
 	tty_drv->subtype = SERIAL_TYPE_NORMAL;
 	tty_drv->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	tty_drv->init_termios = tty_std_termios;
-	tty_drv->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-	tty_drv->termios = hso_serial_termios;
-	tty_drv->termios_locked = hso_serial_termios_locked;
+	hso_init_termios(&tty_drv->init_termios);
 	tty_set_operations(tty_drv, &hso_serial_ops);
 
 	/* register the tty driver */

