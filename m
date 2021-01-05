Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877A4C433E6
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 12:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E299F22ADF
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 12:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbhAEMEL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:04:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:39252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729978AbhAEMEE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 07:04:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46807AE05;
        Tue,  5 Jan 2021 12:02:42 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/12] tty_port: drop last traces of low_latency
Date:   Tue,  5 Jan 2021 13:02:38 +0100
Message-Id: <20210105120239.28031-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105120239.28031-1-jslaby@suse.cz>
References: <20210105120239.28031-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The main purpose of tty_port::low_latency was removed in commit
a9c3f68f3cd8 (tty: Fix low_latency BUG) back in 2014. It was left in
place for drivers as an optional tune knob. But only one driver has been
using it until the previous commit. So remove this misconcept
completely, given there are no users.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/networking/caif/caif.rst | 1 -
 drivers/char/pcmcia/synclink_cs.c      | 2 --
 drivers/net/caif/caif_serial.c         | 3 +--
 drivers/s390/char/con3215.c            | 1 -
 drivers/s390/char/sclp_tty.c           | 1 -
 drivers/s390/char/sclp_vt220.c         | 1 -
 drivers/s390/char/tty3270.c            | 2 --
 drivers/tty/amiserial.c                | 3 ---
 drivers/tty/hvc/hvcs.c                 | 2 +-
 drivers/tty/ipwireless/tty.c           | 1 -
 drivers/tty/mxser.c                    | 1 -
 drivers/tty/serial/ifx6x60.c           | 3 ---
 drivers/tty/serial/max3100.c           | 3 ---
 drivers/tty/serial/serial_core.c       | 3 ---
 drivers/tty/synclink_gt.c              | 1 -
 include/linux/tty.h                    | 3 +--
 16 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/Documentation/networking/caif/caif.rst b/Documentation/networking/caif/caif.rst
index a07213030ccf..81a14373d780 100644
--- a/Documentation/networking/caif/caif.rst
+++ b/Documentation/networking/caif/caif.rst
@@ -68,7 +68,6 @@ There are debugfs parameters provided for serial communication.
 * tty_status: Prints the bit-mask tty status information
 
   - 0x01 - tty->warned is on.
-  - 0x02 - tty->low_latency is on.
   - 0x04 - tty->packed is on.
   - 0x08 - tty->flow_stopped is on.
   - 0x10 - tty->hw_stopped is on.
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index e342daa73d1b..2be8d9a8eec5 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -2494,8 +2494,6 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 		printk("%s(%d):mgslpc_open(%s), old ref count = %d\n",
 			 __FILE__, __LINE__, tty->driver->name, port->count);
 
-	port->low_latency = (port->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
-
 	spin_lock_irqsave(&info->netlock, flags);
 	if (info->netcount) {
 		retval = -EBUSY;
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index bcc14c5875bf..8215cd77301f 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -89,8 +89,7 @@ static inline void update_tty_status(struct ser_device *ser)
 	ser->tty_status =
 		ser->tty->stopped << 5 |
 		ser->tty->flow_stopped << 3 |
-		ser->tty->packet << 2 |
-		ser->tty->port->low_latency << 1;
+		ser->tty->packet << 2;
 }
 static inline void debugfs_init(struct ser_device *ser, struct tty_struct *tty)
 {
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 1354c42d95aa..671efee612af 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -914,7 +914,6 @@ static int tty3215_open(struct tty_struct *tty, struct file * filp)
 
 	tty_port_tty_set(&raw->port, tty);
 
-	raw->port.low_latency = 0; /* don't use bottom half for pushing chars */
 	/*
 	 * Start up 3215 device
 	 */
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 5aff8b684eb2..013bcc331305 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -65,7 +65,6 @@ sclp_tty_open(struct tty_struct *tty, struct file *filp)
 {
 	tty_port_tty_set(&sclp_port, tty);
 	tty->driver_data = NULL;
-	sclp_port.low_latency = 0;
 	return 0;
 }
 
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 3f9a6ef650fa..047f812d1a1c 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -560,7 +560,6 @@ sclp_vt220_open(struct tty_struct *tty, struct file *filp)
 {
 	if (tty->count == 1) {
 		tty_port_tty_set(&sclp_vt220_port, tty);
-		sclp_vt220_port.low_latency = 0;
 		if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
 			tty->winsize.ws_row = 24;
 			tty->winsize.ws_col = 80;
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index aec996de44d9..15692449a1c3 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -967,7 +967,6 @@ static int tty3270_install(struct tty_driver *driver, struct tty_struct *tty)
 		tty->driver_data = tp;
 		tty->winsize.ws_row = tp->view.rows - 2;
 		tty->winsize.ws_col = tp->view.cols;
-		tp->port.low_latency = 0;
 		tp->inattr = TF_INPUT;
 		goto port_install;
 	}
@@ -996,7 +995,6 @@ static int tty3270_install(struct tty_driver *driver, struct tty_struct *tty)
 		return rc;
 	}
 
-	tp->port.low_latency = 0;
 	tty->winsize.ws_row = tp->view.rows - 2;
 	tty->winsize.ws_col = tp->view.cols;
 
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 13f63c01c589..18b78ea110ef 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -998,7 +998,6 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 	state->custom_divisor = ss->custom_divisor;
 	port->close_delay = ss->close_delay * HZ/100;
 	port->closing_wait = ss->closing_wait * HZ/100;
-	port->low_latency = (port->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 
 check_and_exit:
 	if (tty_port_initialized(port)) {
@@ -1386,8 +1385,6 @@ static int rs_open(struct tty_struct *tty, struct file * filp)
 	tty->driver_data = info;
 	tty->port = port;
 
-	port->low_latency = (port->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
-
 	retval = startup(tty, info);
 	if (retval) {
 		return retval;
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 509d1042825a..dfe02283ed23 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -605,7 +605,7 @@ static int hvcs_io(struct hvcs_struct *hvcsd)
 		hvcsd->todo_mask |= HVCS_QUICK_READ;
 
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	/* This is synch because tty->low_latency == 1 */
+	/* This is synch -- FIXME :js: it is not! */
 	if(got)
 		tty_flip_buffer_push(&hvcsd->port);
 
diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index 23584769fc29..6dacbc5e286c 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -101,7 +101,6 @@ static int ipw_open(struct tty_struct *linux_tty, struct file *filp)
 
 	tty->port.tty = linux_tty;
 	linux_tty->driver_data = tty;
-	tty->port.low_latency = 1;
 
 	if (tty->tty_type == TTYTYPE_MODEM)
 		ipwireless_ppp_open(tty->network);
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 3703987c4666..4203b64bccdb 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1273,7 +1273,6 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 				(ss->flags & ASYNC_FLAGS));
 		port->close_delay = ss->close_delay * HZ / 100;
 		port->closing_wait = ss->closing_wait * HZ / 100;
-		port->low_latency = (port->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST &&
 				(ss->baud_base != info->baud_base ||
 				ss->custom_divisor !=
diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 182e0ccd60b2..d4ef88ee22d0 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -565,9 +565,6 @@ static int ifx_port_activate(struct tty_port *port, struct tty_struct *tty)
 	/* put port data into this tty */
 	tty->driver_data = ifx_dev;
 
-	/* allows flip string push from int context */
-	port->low_latency = 1;
-
 	/* set flag to allows data transfer */
 	set_bit(IFX_SPI_STATE_IO_AVAILABLE, &ifx_dev->flags);
 
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 371569a0fd00..3c92d4e01488 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -521,9 +521,6 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
 			MAX3100_STATUS_PE | MAX3100_STATUS_FE |
 			MAX3100_STATUS_OE;
 
-	/* we are sending char from a workqueue so enable */
-	s->port.state->port.low_latency = 1;
-
 	if (s->poll_time > 0)
 		del_timer_sync(&s->timer);
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 828f9ad1be49..7dacdb6a8534 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -975,7 +975,6 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	port->closing_wait    = closing_wait;
 	if (new_info->xmit_fifo_size)
 		uport->fifosize = new_info->xmit_fifo_size;
-	port->low_latency = (uport->flags & UPF_LOW_LATENCY) ? 1 : 0;
 
  check_and_exit:
 	retval = 0;
@@ -1795,8 +1794,6 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
 	if (!uport || uport->flags & UPF_DEAD)
 		return -ENXIO;
 
-	port->low_latency = (uport->flags & UPF_LOW_LATENCY) ? 1 : 0;
-
 	/*
 	 * Start up the serial port.
 	 */
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index c0b384e3ed4d..644173786bf0 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -672,7 +672,6 @@ static int open(struct tty_struct *tty, struct file *filp)
 	DBGINFO(("%s open, old ref count = %d\n", info->device_name, info->port.count));
 
 	mutex_lock(&info->port.mutex);
-	info->port.low_latency = (info->port.flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 
 	spin_lock_irqsave(&info->netlock, flags);
 	if (info->netcount) {
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 12be8b16cdef..b57f6812b3ba 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -240,8 +240,7 @@ struct tty_port {
 	wait_queue_head_t	delta_msr_wait;	/* Modem status change */
 	unsigned long		flags;		/* User TTY flags ASYNC_ */
 	unsigned long		iflags;		/* Internal flags TTY_PORT_ */
-	unsigned char		console:1,	/* port is a console */
-				low_latency:1;	/* optional: tune for latency */
+	unsigned char		console:1;	/* port is a console */
 	struct mutex		mutex;		/* Locking */
 	struct mutex		buf_mutex;	/* Buffer alloc lock */
 	unsigned char		*xmit_buf;	/* Optional buffer */
-- 
2.30.0

