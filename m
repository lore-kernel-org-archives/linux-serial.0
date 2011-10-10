From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Subject: [Patch 1/6]drivers/usb/serial/ftdi_sio.c: Basic icount infrastructure for ftdi_sio
Date: Mon, 10 Oct 2011 17:24:08 +0200
Message-ID: <20115.3608.745590.271161@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


-- 
Uwe Bonnes                bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
>From ea100c30d21374caa4fef77d78272497751703ce Mon Sep 17 00:00:00 2001
From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Date: Sun, 9 Oct 2011 16:48:51 +0200
Subject: Basic icount infrastructure for ftdi_sio


Signed-off-by: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
---
 drivers/usb/serial/ftdi_sio.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 5fc13e7..c2b4d13 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -73,6 +73,7 @@ struct ftdi_private {
 				 */
 	int flags;		/* some ASYNC_xxxx flags are supported */
 	unsigned long last_dtr_rts;	/* saved modem control outputs */
+	struct async_icount	icount;
 	wait_queue_head_t delta_msr_wait; /* Used for TIOCMIWAIT */
 	char prev_status, diff_status;        /* Used for TIOCMIWAIT */
 	char transmit_empty;	/* If transmitter is empty or not */
@@ -885,6 +886,8 @@ static void ftdi_set_termios(struct tty_struct *tty,
 static int  ftdi_tiocmget(struct tty_struct *tty);
 static int  ftdi_tiocmset(struct tty_struct *tty,
 			unsigned int set, unsigned int clear);
+static int ftdi_get_icount(struct tty_struct *tty,
+			   struct serial_icounter_struct *icount);
 static int  ftdi_ioctl(struct tty_struct *tty,
 			unsigned int cmd, unsigned long arg);
 static void ftdi_break_ctl(struct tty_struct *tty, int break_state);
@@ -919,6 +922,7 @@ static struct usb_serial_driver ftdi_sio_device = {
 	.prepare_write_buffer =	ftdi_prepare_write_buffer,
 	.tiocmget =		ftdi_tiocmget,
 	.tiocmset =		ftdi_tiocmset,
+	.get_icount =           ftdi_get_icount,
 	.ioctl =		ftdi_ioctl,
 	.set_termios =		ftdi_set_termios,
 	.break_ctl =		ftdi_break_ctl,
@@ -1646,6 +1650,7 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 
 	kref_init(&priv->kref);
 	mutex_init(&priv->cfg_lock);
+	memset(&priv->icount, 0x00, sizeof(priv->icount));
 	init_waitqueue_head(&priv->delta_msr_wait);
 
 	priv->flags = ASYNC_LOW_LATENCY;
@@ -2277,6 +2282,27 @@ static int ftdi_tiocmset(struct tty_struct *tty,
 	return update_mctrl(port, set, clear);
 }
 
+static int ftdi_get_icount(struct tty_struct *tty,
+				struct serial_icounter_struct *icount)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct async_icount *ic = &priv->icount;
+
+	icount->cts = ic->cts;
+	icount->dsr = ic->dsr;
+	icount->rng = ic->rng;
+	icount->dcd = ic->dcd;
+	icount->tx = ic->tx;
+	icount->rx = ic->rx;
+	icount->frame = ic->frame;
+	icount->parity = ic->parity;
+	icount->overrun = ic->overrun;
+	icount->brk = ic->brk;
+	icount->buf_overrun = ic->buf_overrun;
+	return 0;
+}
+
 static int ftdi_ioctl(struct tty_struct *tty,
 					unsigned int cmd, unsigned long arg)
 {
-- 
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
