Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33411C43603
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB05613F5
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhEEJUj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:41480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232360AbhEEJUa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C481B158;
        Wed,  5 May 2021 09:19:33 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 12/35] tty: cumulate and document tty_struct::flow* members
Date:   Wed,  5 May 2021 11:19:05 +0200
Message-Id: <20210505091928.22010-13-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Group the flow flags under a single struct called flow. The new struct
contains 'stopped' and 'tco_stopped' bools which used to be bits in a
bitfield. The struct also contains the lock protecting them to
potentially share the same cache line.

Note that commit c545b66c6922b (tty: Serialize tcflow() with other tty
flow control changes) added a padding to the original bitfield. It was
for the bitfield to occupy a whole 64b word to avoid interferring stores
on Alpha (cannot we evaporate this arch with weird implications to C
code yet?). But it doesn't work as expected as the padding
(tty_struct::unused) is aligned to a 8B boundary too and occupies some
bytes from the next word.

So make it reliable by:
1) setting __aligned of the struct -- that aligns the start, and
2) making 'unsigned long unused[0]' as the last member of the struct --
   pads the end.

This is also the perfect time to start the documentation of tty_struct
where all this lives. So we start by documenting what these bools
actually serve for. And why we do all the alignment dances. Only the few
up-to-date information from the Theodore's comment made it into this new
Kerneldoc comment.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
---
 Documentation/networking/caif/caif.rst |  4 +--
 drivers/char/pcmcia/synclink_cs.c      |  8 +++---
 drivers/mmc/core/sdio_uart.c           |  2 +-
 drivers/net/caif/caif_serial.c         |  4 +--
 drivers/s390/char/tty3270.c            |  2 +-
 drivers/staging/fwserial/fwserial.c    |  2 +-
 drivers/tty/amiserial.c                |  8 +++---
 drivers/tty/moxa.c                     |  4 +--
 drivers/tty/mxser.c                    | 12 ++++----
 drivers/tty/n_tty.c                    |  8 +++---
 drivers/tty/pty.c                      |  4 +--
 drivers/tty/serial/arc_uart.c          |  2 +-
 drivers/tty/serial/dz.c                |  2 +-
 drivers/tty/synclink_gt.c              |  6 ++--
 drivers/tty/tty_io.c                   | 24 ++++++++--------
 drivers/tty/tty_ioctl.c                | 16 +++++------
 drivers/tty/tty_port.c                 |  2 +-
 drivers/tty/vt/keyboard.c              |  2 +-
 drivers/tty/vt/vt.c                    |  4 +--
 include/linux/serial_core.h            |  2 +-
 include/linux/tty.h                    | 38 +++++++++++++++-----------
 include/linux/tty_driver.h             |  4 +--
 22 files changed, 83 insertions(+), 77 deletions(-)

diff --git a/Documentation/networking/caif/caif.rst b/Documentation/networking/caif/caif.rst
index 81a14373d780..d922d419c513 100644
--- a/Documentation/networking/caif/caif.rst
+++ b/Documentation/networking/caif/caif.rst
@@ -69,9 +69,9 @@ There are debugfs parameters provided for serial communication.
 
   - 0x01 - tty->warned is on.
   - 0x04 - tty->packed is on.
-  - 0x08 - tty->flow_stopped is on.
+  - 0x08 - tty->flow.tco_stopped is on.
   - 0x10 - tty->hw_stopped is on.
-  - 0x20 - tty->stopped is on.
+  - 0x20 - tty->flow.stopped is on.
 
 * last_tx_msg: Binary blob Prints the last transmitted frame.
 
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 3287a7627ed0..b4707bc3aee8 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -985,7 +985,7 @@ static void tx_done(MGSLPC_INFO *info, struct tty_struct *tty)
 	else
 #endif
 	{
-		if (tty && (tty->stopped || tty->hw_stopped)) {
+		if (tty && (tty->flow.stopped || tty->hw_stopped)) {
 			tx_stop(info);
 			return;
 		}
@@ -1005,7 +1005,7 @@ static void tx_ready(MGSLPC_INFO *info, struct tty_struct *tty)
 		if (!info->tx_active)
 			return;
 	} else {
-		if (tty && (tty->stopped || tty->hw_stopped)) {
+		if (tty && (tty->flow.stopped || tty->hw_stopped)) {
 			tx_stop(info);
 			return;
 		}
@@ -1525,7 +1525,7 @@ static void mgslpc_flush_chars(struct tty_struct *tty)
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_flush_chars"))
 		return;
 
-	if (info->tx_count <= 0 || tty->stopped ||
+	if (info->tx_count <= 0 || tty->flow.stopped ||
 	    tty->hw_stopped || !info->tx_buf)
 		return;
 
@@ -1594,7 +1594,7 @@ static int mgslpc_write(struct tty_struct * tty,
 		ret += c;
 	}
 start:
-	if (info->tx_count && !tty->stopped && !tty->hw_stopped) {
+	if (info->tx_count && !tty->flow.stopped && !tty->hw_stopped) {
 		spin_lock_irqsave(&info->lock, flags);
 		if (!info->tx_active)
 			tx_start(info, tty);
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index be4067281caa..dbcac2b7f2fe 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -439,7 +439,7 @@ static void sdio_uart_transmit_chars(struct sdio_uart_port *port)
 	tty = tty_port_tty_get(&port->port);
 
 	if (tty == NULL || !kfifo_len(xmit) ||
-				tty->stopped || tty->hw_stopped) {
+				tty->flow.stopped || tty->hw_stopped) {
 		sdio_uart_stop_tx(port);
 		tty_kref_put(tty);
 		return;
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index fb3ca4e11fe5..3996cf7dc9ba 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -87,8 +87,8 @@ static void ldisc_tx_wakeup(struct tty_struct *tty);
 static inline void update_tty_status(struct ser_device *ser)
 {
 	ser->tty_status =
-		ser->tty->stopped << 5 |
-		ser->tty->flow_stopped << 3 |
+		ser->tty->flow.stopped << 5 |
+		ser->tty->flow.tco_stopped << 3 |
 		ser->tty->packet << 2;
 }
 static inline void debugfs_init(struct ser_device *ser, struct tty_struct *tty)
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 307a80f85c07..1b68564799fa 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1640,7 +1640,7 @@ tty3270_do_write(struct tty3270 *tp, struct tty_struct *tty,
 	int i_msg, i;
 
 	spin_lock_bh(&tp->view.lock);
-	for (i_msg = 0; !tty->stopped && i_msg < count; i_msg++) {
+	for (i_msg = 0; !tty->flow.stopped && i_msg < count; i_msg++) {
 		if (tp->esc_state != 0) {
 			/* Continue escape sequence. */
 			tty3270_escape_sequence(tp, buf[i_msg]);
diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index 1ee6382cafc4..4245532d2fe0 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -722,7 +722,7 @@ static int fwtty_tx(struct fwtty_port *port, bool drain)
 
 	/* try to write as many dma transactions out as possible */
 	n = -EAGAIN;
-	while (!tty->stopped && !tty->hw_stopped &&
+	while (!tty->flow.stopped && !tty->hw_stopped &&
 	       !test_bit(STOP_TX, &port->flags)) {
 		txn = kmem_cache_alloc(fwtty_txn_cache, GFP_ATOMIC);
 		if (!txn) {
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index ca48ce5a0862..a4b8876091d2 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -148,7 +148,7 @@ static __inline__ void rtsdtr_ctrl(int bits)
  * ------------------------------------------------------------
  * rs_stop() and rs_start()
  *
- * This routines are called before setting or resetting tty->stopped.
+ * This routines are called before setting or resetting tty->flow.stopped.
  * They enable or disable transmitter interrupts, as necessary.
  * ------------------------------------------------------------
  */
@@ -309,7 +309,7 @@ static void transmit_chars(struct serial_state *info)
 		return;
 	}
 	if (info->xmit.head == info->xmit.tail
-	    || info->tport.tty->stopped
+	    || info->tport.tty->flow.stopped
 	    || info->tport.tty->hw_stopped) {
 		info->IER &= ~UART_IER_THRI;
 	        custom.intena = IF_TBE;
@@ -768,7 +768,7 @@ static void rs_flush_chars(struct tty_struct *tty)
 	unsigned long flags;
 
 	if (info->xmit.head == info->xmit.tail
-	    || tty->stopped
+	    || tty->flow.stopped
 	    || tty->hw_stopped
 	    || !info->xmit.buf)
 		return;
@@ -812,7 +812,7 @@ static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count
 	local_irq_restore(flags);
 
 	if (info->xmit.head != info->xmit.tail
-	    && !tty->stopped
+	    && !tty->flow.stopped
 	    && !tty->hw_stopped
 	    && !(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 4d4f15b5cd29..847ad3dac107 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1221,7 +1221,7 @@ static int moxa_write_room(struct tty_struct *tty)
 {
 	struct moxa_port *ch;
 
-	if (tty->stopped)
+	if (tty->flow.stopped)
 		return 0;
 	ch = tty->driver_data;
 	if (ch == NULL)
@@ -1374,7 +1374,7 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
 			clear_bit(EMPTYWAIT, &p->statusflags);
 			tty_wakeup(tty);
 		}
-		if (test_bit(LOWWAIT, &p->statusflags) && !tty->stopped &&
+		if (test_bit(LOWWAIT, &p->statusflags) && !tty->flow.stopped &&
 				MoxaPortTxQueue(p) <= WAKEUP_CHARS) {
 			clear_bit(LOWWAIT, &p->statusflags);
 			tty_wakeup(tty);
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 16a852ecbe8a..85271e109014 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1118,7 +1118,7 @@ static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int cou
 		total += c;
 	}
 
-	if (info->xmit_cnt && !tty->stopped) {
+	if (info->xmit_cnt && !tty->flow.stopped) {
 		if (!tty->hw_stopped ||
 				(info->type == PORT_16550A) ||
 				(info->board->chip_flag)) {
@@ -1149,7 +1149,7 @@ static int mxser_put_char(struct tty_struct *tty, unsigned char ch)
 	info->xmit_head &= SERIAL_XMIT_SIZE - 1;
 	info->xmit_cnt++;
 	spin_unlock_irqrestore(&info->slock, flags);
-	if (!tty->stopped) {
+	if (!tty->flow.stopped) {
 		if (!tty->hw_stopped ||
 				(info->type == PORT_16550A) ||
 				info->board->chip_flag) {
@@ -1169,7 +1169,7 @@ static void mxser_flush_chars(struct tty_struct *tty)
 	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
-	if (info->xmit_cnt <= 0 || tty->stopped || !info->port.xmit_buf ||
+	if (info->xmit_cnt <= 0 || tty->flow.stopped || !info->port.xmit_buf ||
 			(tty->hw_stopped && info->type != PORT_16550A &&
 			 !info->board->chip_flag))
 		return;
@@ -1917,7 +1917,7 @@ static void mxser_unthrottle(struct tty_struct *tty)
 /*
  * mxser_stop() and mxser_start()
  *
- * This routines are called before setting or resetting tty->stopped.
+ * This routines are called before setting or resetting tty->flow.stopped.
  * They enable or disable transmitter interrupts, as necessary.
  */
 static void mxser_stop(struct tty_struct *tty)
@@ -1963,7 +1963,7 @@ static void mxser_set_termios(struct tty_struct *tty, struct ktermios *old_termi
 
 	/* Handle sw stopped */
 	if ((old_termios->c_iflag & IXON) && !I_IXON(tty)) {
-		tty->stopped = 0;
+		tty->flow.stopped = 0;
 
 		if (info->board->chip_flag) {
 			spin_lock_irqsave(&info->slock, flags);
@@ -2175,7 +2175,7 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 	if (port->port.xmit_buf == NULL)
 		return;
 
-	if (port->xmit_cnt <= 0 || tty->stopped ||
+	if (port->xmit_cnt <= 0 || tty->flow.stopped ||
 			(tty->hw_stopped &&
 			(port->type != PORT_16550A) &&
 			(!port->board->chip_flag))) {
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index c32318da5190..3566bb577eb0 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1289,7 +1289,7 @@ static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 		}
 	}
 
-	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) && I_IXANY(tty)) {
+	if (tty->flow.stopped && !tty->flow.tco_stopped && I_IXON(tty) && I_IXANY(tty)) {
 		start_tty(tty);
 		process_echoes(tty);
 	}
@@ -1398,7 +1398,7 @@ static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) && I_IXANY(tty)) {
+	if (tty->flow.stopped && !tty->flow.tco_stopped && I_IXON(tty) && I_IXANY(tty)) {
 		start_tty(tty);
 		process_echoes(tty);
 	}
@@ -1427,7 +1427,7 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 		if (c == STOP_CHAR(tty))
 			stop_tty(tty);
 		else if (c == START_CHAR(tty) ||
-			 (tty->stopped && !tty->flow_stopped && I_IXANY(tty) &&
+			 (tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
 			  c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
 			  c != SUSP_CHAR(tty))) {
 			start_tty(tty);
@@ -1797,7 +1797,7 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	 * Fix tty hang when I_IXON(tty) is cleared, but the tty
 	 * been stopped by STOP_CHAR(tty) before it.
 	 */
-	if (!I_IXON(tty) && old && (old->c_iflag & IXON) && !tty->flow_stopped) {
+	if (!I_IXON(tty) && old && (old->c_iflag & IXON) && !tty->flow.tco_stopped) {
 		start_tty(tty);
 		process_echoes(tty);
 	}
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 9b5d4ae5d8f2..017f28150a32 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -113,7 +113,7 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 	struct tty_struct *to = tty->link;
 	unsigned long flags;
 
-	if (tty->stopped)
+	if (tty->flow.stopped)
 		return 0;
 
 	if (c > 0) {
@@ -138,7 +138,7 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 
 static int pty_write_room(struct tty_struct *tty)
 {
-	if (tty->stopped)
+	if (tty->flow.stopped)
 		return 0;
 	return tty_buffer_space_avail(tty->link->port);
 }
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 1a9444b6b57e..596217d10d5c 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -149,7 +149,7 @@ static unsigned int arc_serial_tx_empty(struct uart_port *port)
 /*
  * Driver internal routine, used by both tty(serial core) as well as tx-isr
  *  -Called under spinlock in either cases
- *  -also tty->stopped has already been checked
+ *  -also tty->flow.stopped has already been checked
  *     = by uart_start( ) before calling us
  *     = tx_ist checks that too before calling
  */
diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 4552742c3859..6d91e9b6284d 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -115,7 +115,7 @@ static void dz_out(struct dz_port *dport, unsigned offset, u16 value)
  * rs_stop () and rs_start ()
  *
  * These routines are called before setting or resetting
- * tty->stopped. They enable or disable transmitter interrupts,
+ * tty->flow.stopped. They enable or disable transmitter interrupts,
  * as necessary.
  * ------------------------------------------------------------
  */
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 5523cf7bd1c2..1555dccc28af 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -768,7 +768,7 @@ static int write(struct tty_struct *tty,
 	if (!info->tx_buf || (count > info->max_frame_size))
 		return -EIO;
 
-	if (!count || tty->stopped || tty->hw_stopped)
+	if (!count || tty->flow.stopped || tty->hw_stopped)
 		return 0;
 
 	spin_lock_irqsave(&info->lock, flags);
@@ -889,7 +889,7 @@ static void flush_chars(struct tty_struct *tty)
 		return;
 	DBGINFO(("%s flush_chars entry tx_count=%d\n", info->device_name, info->tx_count));
 
-	if (info->tx_count <= 0 || tty->stopped ||
+	if (info->tx_count <= 0 || tty->flow.stopped ||
 	    tty->hw_stopped || !info->tx_buf)
 		return;
 
@@ -2241,7 +2241,7 @@ static void isr_txeom(struct slgt_info *info, unsigned short status)
 		else
 #endif
 		{
-			if (info->port.tty && (info->port.tty->stopped || info->port.tty->hw_stopped)) {
+			if (info->port.tty && (info->port.tty->flow.stopped || info->port.tty->hw_stopped)) {
 				tx_stop(info);
 				return;
 			}
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 5b5e99604989..9734be2eb00e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -778,14 +778,14 @@ EXPORT_SYMBOL(tty_hung_up_p);
  *	but not always.
  *
  *	Locking:
- *		flow_lock
+ *		flow.lock
  */
 
 void __stop_tty(struct tty_struct *tty)
 {
-	if (tty->stopped)
+	if (tty->flow.stopped)
 		return;
-	tty->stopped = 1;
+	tty->flow.stopped = true;
 	if (tty->ops->stop)
 		tty->ops->stop(tty);
 }
@@ -794,9 +794,9 @@ void stop_tty(struct tty_struct *tty)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&tty->flow_lock, flags);
+	spin_lock_irqsave(&tty->flow.lock, flags);
 	__stop_tty(tty);
-	spin_unlock_irqrestore(&tty->flow_lock, flags);
+	spin_unlock_irqrestore(&tty->flow.lock, flags);
 }
 EXPORT_SYMBOL(stop_tty);
 
@@ -809,14 +809,14 @@ EXPORT_SYMBOL(stop_tty);
  *	start method is invoked and the line discipline woken.
  *
  *	Locking:
- *		flow_lock
+ *		flow.lock
  */
 
 void __start_tty(struct tty_struct *tty)
 {
-	if (!tty->stopped || tty->flow_stopped)
+	if (!tty->flow.stopped || tty->flow.tco_stopped)
 		return;
-	tty->stopped = 0;
+	tty->flow.stopped = false;
 	if (tty->ops->start)
 		tty->ops->start(tty);
 	tty_wakeup(tty);
@@ -826,9 +826,9 @@ void start_tty(struct tty_struct *tty)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&tty->flow_lock, flags);
+	spin_lock_irqsave(&tty->flow.lock, flags);
 	__start_tty(tty);
-	spin_unlock_irqrestore(&tty->flow_lock, flags);
+	spin_unlock_irqrestore(&tty->flow.lock, flags);
 }
 EXPORT_SYMBOL(start_tty);
 
@@ -1172,7 +1172,7 @@ ssize_t redirected_tty_write(struct kiocb *iocb, struct iov_iter *iter)
 
 int tty_send_xchar(struct tty_struct *tty, char ch)
 {
-	int	was_stopped = tty->stopped;
+	bool was_stopped = tty->flow.stopped;
 
 	if (tty->ops->send_xchar) {
 		down_read(&tty->termios_rwsem);
@@ -3141,7 +3141,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 	INIT_WORK(&tty->hangup_work, do_tty_hangup);
 	mutex_init(&tty->atomic_write_lock);
 	spin_lock_init(&tty->ctrl_lock);
-	spin_lock_init(&tty->flow_lock);
+	spin_lock_init(&tty->flow.lock);
 	spin_lock_init(&tty->files_lock);
 	INIT_LIST_HEAD(&tty->tty_files);
 	INIT_WORK(&tty->SAK_work, do_SAK_work);
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 41f7449d0464..07c88ccfb17a 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -846,20 +846,20 @@ int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 			return retval;
 		switch (arg) {
 		case TCOOFF:
-			spin_lock_irq(&tty->flow_lock);
-			if (!tty->flow_stopped) {
-				tty->flow_stopped = 1;
+			spin_lock_irq(&tty->flow.lock);
+			if (!tty->flow.tco_stopped) {
+				tty->flow.tco_stopped = true;
 				__stop_tty(tty);
 			}
-			spin_unlock_irq(&tty->flow_lock);
+			spin_unlock_irq(&tty->flow.lock);
 			break;
 		case TCOON:
-			spin_lock_irq(&tty->flow_lock);
-			if (tty->flow_stopped) {
-				tty->flow_stopped = 0;
+			spin_lock_irq(&tty->flow.lock);
+			if (tty->flow.tco_stopped) {
+				tty->flow.tco_stopped = false;
 				__start_tty(tty);
 			}
-			spin_unlock_irq(&tty->flow_lock);
+			spin_unlock_irq(&tty->flow.lock);
 			break;
 		case TCIOFF:
 			if (STOP_CHAR(tty) != __DISABLED_CHAR)
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 303c198fbf5c..0eb523207828 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -587,7 +587,7 @@ int tty_port_close_start(struct tty_port *port,
 
 	if (tty_port_initialized(port)) {
 		/* Don't block on a stalled port, just pull the chain */
-		if (tty->flow_stopped)
+		if (tty->flow.tco_stopped)
 			tty_driver_flush_buffer(tty);
 		if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 			tty_wait_until_sent(tty, port->closing_wait);
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 5d2309742718..4b0d69042ceb 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -515,7 +515,7 @@ static void fn_hold(struct vc_data *vc)
 	 * these routines are also activated by ^S/^Q.
 	 * (And SCROLLOCK can also be set by the ioctl KDSKBLED.)
 	 */
-	if (tty->stopped)
+	if (tty->flow.stopped)
 		start_tty(tty);
 	else
 		stop_tty(tty);
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e5040bdadcd6..38c677fb6505 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2888,7 +2888,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 
 	param.vc = vc;
 
-	while (!tty->stopped && count) {
+	while (!tty->flow.stopped && count) {
 		int orig = *buf;
 		buf++;
 		n++;
@@ -3265,7 +3265,7 @@ static int con_put_char(struct tty_struct *tty, unsigned char ch)
 
 static int con_write_room(struct tty_struct *tty)
 {
-	if (tty->stopped)
+	if (tty->flow.stopped)
 		return 0;
 	return 32768;		/* No limit, really; we're not buffering */
 }
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d7ed00f1594e..7445c8fd88c0 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -428,7 +428,7 @@ int uart_resume_port(struct uart_driver *reg, struct uart_port *port);
 static inline int uart_tx_stopped(struct uart_port *port)
 {
 	struct tty_struct *tty = port->state->port.tty;
-	if ((tty && tty->stopped) || port->hw_stopped)
+	if ((tty && tty->flow.stopped) || port->hw_stopped)
 		return 1;
 	return 0;
 }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 5aad2220266c..df3a69b2e1ea 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -243,20 +243,22 @@ struct tty_port {
 #define TTY_PORT_KOPENED	5	/* device exclusively opened by
 					   kernel */
 
-/*
- * Where all of the state associated with a tty is kept while the tty
- * is open.  Since the termios state should be kept even if the tty
- * has been closed --- for things like the baud rate, etc --- it is
- * not stored here, but rather a pointer to the real state is stored
- * here.  Possible the winsize structure should have the same
- * treatment, but (1) the default 80x24 is usually right and (2) it's
- * most often used by a windowing system, which will set the correct
- * size each time the window is created or resized anyway.
- * 						- TYT, 9/14/92
- */
-
 struct tty_operations;
 
+/**
+ * struct tty_struct - state associated with a tty while open
+ *
+ * @flow.lock: lock for flow members
+ * @flow.stopped: tty stopped/started by tty_stop/tty_start
+ * @flow.tco_stopped: tty stopped/started by TCOOFF/TCOON ioctls (it has
+ *		      precedense over @flow.stopped)
+ * @flow.unused: alignment for Alpha, so that no members other than @flow.* are
+ *		 modified by the same 64b word store. The @flow's __aligned is
+ *		 there for the very same reason.
+ *
+ * All of the state associated with a tty while the tty is open. Persistent
+ * storage for tty devices is referenced here as @port in struct tty_port.
+ */
 struct tty_struct {
 	int	magic;
 	struct kref kref;
@@ -275,7 +277,6 @@ struct tty_struct {
 	struct rw_semaphore termios_rwsem;
 	struct mutex winsize_mutex;
 	spinlock_t ctrl_lock;
-	spinlock_t flow_lock;
 	/* Termios values are protected by the termios rwsem */
 	struct ktermios termios, termios_locked;
 	char name[64];
@@ -288,9 +289,14 @@ struct tty_struct {
 	unsigned long flags;
 	int count;
 	struct winsize winsize;		/* winsize_mutex */
-	unsigned long stopped:1,	/* flow_lock */
-		      flow_stopped:1,
-		      unused:BITS_PER_LONG - 2;
+
+	struct {
+		spinlock_t lock;
+		bool stopped;
+		bool tco_stopped;
+		unsigned long unused[0];
+	} __aligned(sizeof(unsigned long)) flow;
+
 	int hw_stopped;
 	unsigned long ctrl_status:8,	/* ctrl_lock */
 		      packet:1,
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 2f719b471d52..653fa5af3a22 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -153,7 +153,7 @@
  * 	This routine notifies the tty driver that it should stop
  * 	outputting characters to the tty device.  
  *
- *	Called with ->flow_lock held. Serialized with start() method.
+ *	Called with ->flow.lock held. Serialized with start() method.
  *
  *	Optional:
  *
@@ -164,7 +164,7 @@
  * 	This routine notifies the tty driver that it resume sending
  *	characters to the tty device.
  *
- *	Called with ->flow_lock held. Serialized with stop() method.
+ *	Called with ->flow.lock held. Serialized with stop() method.
  *
  *	Optional:
  *
-- 
2.31.1

