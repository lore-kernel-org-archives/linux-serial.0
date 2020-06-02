Return-Path: <SRS0=qx80=7P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6764EC433DF
	for <linux-serial@archiver.kernel.org>; Tue,  2 Jun 2020 14:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48FFD2068D
	for <linux-serial@archiver.kernel.org>; Tue,  2 Jun 2020 14:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBOrn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:47:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:11471 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgFBOrm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Jun 2020 10:47:42 -0400
IronPort-SDR: WF1dt7gOmu1USsZTwYbW38/7trS8zyPXoPmwhljHhfPoes8AB/mNb4xgc1w/uiVsAYyw5J9zNJ
 gOZkHoNDLUiA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 07:47:42 -0700
IronPort-SDR: e/Rwfo91H9S27zZu8e6/vsJO0rb/JUJz7QTDW5ASLjRSGdtkk6UEcj5N5sNj0EU1oT+hM1nhEo
 BrDuGMSnzu1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,464,1583222400"; 
   d="scan'208";a="268721413"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2020 07:47:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 559462D2; Tue,  2 Jun 2020 17:47:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: core: make static analyzer happy about locks
Date:   Tue,  2 Jun 2020 17:47:39 +0300
Message-Id: <20200602144739.85566-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Static analyzer can not see balanced locking if the lock is acquired and
released conditionally.

 context imbalance in 'uart_stop' - unexpected unlock
 context imbalance in 'uart_start' - different lock contexts for basic block
 context imbalance in 'uart_port_startup' - different lock contexts for basic block
 context imbalance in 'uart_shutdown' - different lock contexts for basic block
 context imbalance in 'uart_put_char' - different lock contexts for basic block
 context imbalance in 'uart_write' - different lock contexts for basic block
 context imbalance in 'uart_write_room' - different lock contexts for basic block
 context imbalance in 'uart_chars_in_buffer' - different lock contexts for basic block
 context imbalance in 'uart_flush_buffer' - different lock contexts for basic block

Get rid of macros and implement their functionality in place. This will also
help to enable runtime PM in cleaner way later on.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 106 +++++++++++++++++--------------
 1 file changed, 58 insertions(+), 48 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 57840cf90388..b566127345c2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -69,23 +69,6 @@ static inline void uart_port_deref(struct uart_port *uport)
 		wake_up(&uport->state->remove_wait);
 }
 
-#define uart_port_lock(state, flags)					\
-	({								\
-		struct uart_port *__uport = uart_port_ref(state);	\
-		if (__uport)						\
-			spin_lock_irqsave(&__uport->lock, flags);	\
-		__uport;						\
-	})
-
-#define uart_port_unlock(uport, flags)					\
-	({								\
-		struct uart_port *__uport = uport;			\
-		if (__uport) {						\
-			spin_unlock_irqrestore(&__uport->lock, flags);	\
-			uart_port_deref(__uport);			\
-		}							\
-	})
-
 static inline struct uart_port *uart_port_check(struct uart_state *state)
 {
 	lockdep_assert_held(&state->port.mutex);
@@ -113,10 +96,14 @@ static void uart_stop(struct tty_struct *tty)
 	struct uart_port *port;
 	unsigned long flags;
 
-	port = uart_port_lock(state, flags);
-	if (port)
-		port->ops->stop_tx(port);
-	uart_port_unlock(port, flags);
+	port = uart_port_ref(state);
+	if (!port)
+		return;
+
+	spin_lock_irqsave(&port->lock, flags);
+	port->ops->stop_tx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_deref(port);
 }
 
 static void __uart_start(struct tty_struct *tty)
@@ -134,9 +121,14 @@ static void uart_start(struct tty_struct *tty)
 	struct uart_port *port;
 	unsigned long flags;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref(state);
+	if (!port)
+		return;
+
+	spin_lock_irqsave(&port->lock, flags);
 	__uart_start(tty);
-	uart_port_unlock(port, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_deref(port);
 }
 
 static void
@@ -186,7 +178,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 {
 	struct uart_port *uport = uart_port_check(state);
 	unsigned long page;
-	unsigned long flags = 0;
+	unsigned long flags;
 	int retval = 0;
 
 	if (uport->type == PORT_UNKNOWN)
@@ -205,13 +197,14 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	if (!page)
 		return -ENOMEM;
 
-	uart_port_lock(state, flags);
+	spin_lock_irqsave(&uport->lock, flags);
 	if (!state->xmit.buf) {
 		state->xmit.buf = (unsigned char *) page;
 		uart_circ_clear(&state->xmit);
-		uart_port_unlock(uport, flags);
+		spin_unlock_irqrestore(&uport->lock, flags);
 	} else {
-		uart_port_unlock(uport, flags);
+		spin_unlock_irqrestore(&uport->lock, flags);
+
 		/*
 		 * Do not free() the page under the port lock, see
 		 * uart_shutdown().
@@ -276,8 +269,8 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 {
 	struct uart_port *uport = uart_port_check(state);
 	struct tty_port *port = &state->port;
-	unsigned long flags = 0;
 	char *xmit_buf = NULL;
+	unsigned long flags;
 
 	/*
 	 * Set the TTY IO error marker
@@ -311,12 +304,12 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	 * Do not free() the transmit buffer page under the port lock since
 	 * this can create various circular locking scenarios. For instance,
 	 * console driver may need to allocate/free a debug object, which
-	 * can endup in printk() recursion.
+	 * can end up in printk() recursion.
 	 */
-	uart_port_lock(state, flags);
+	spin_lock_irqsave(&uport->lock, flags);
 	xmit_buf = state->xmit.buf;
 	state->xmit.buf = NULL;
-	uart_port_unlock(uport, flags);
+	spin_unlock_irqrestore(&uport->lock, flags);
 
 	if (xmit_buf)
 		free_page((unsigned long)xmit_buf);
@@ -553,19 +546,19 @@ static int uart_put_char(struct tty_struct *tty, unsigned char c)
 	unsigned long flags;
 	int ret = 0;
 
-	circ = &state->xmit;
-	port = uart_port_lock(state, flags);
-	if (!circ->buf) {
-		uart_port_unlock(port, flags);
+	port = uart_port_ref(state);
+	if (!port)
 		return 0;
-	}
 
-	if (port && uart_circ_chars_free(circ) != 0) {
+	spin_lock_irqsave(&port->lock, flags);
+	circ = &state->xmit;
+	if (circ->buf && uart_circ_chars_free(circ) != 0) {
 		circ->buf[circ->head] = c;
 		circ->head = (circ->head + 1) & (UART_XMIT_SIZE - 1);
 		ret = 1;
 	}
-	uart_port_unlock(port, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_deref(port);
 	return ret;
 }
 
@@ -592,13 +585,17 @@ static int uart_write(struct tty_struct *tty,
 		return -EL3HLT;
 	}
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref(state);
+	if (!port)
+		return 0;
+
+	spin_lock_irqsave(&port->lock, flags);
 	circ = &state->xmit;
 	if (!circ->buf) {
-		uart_port_unlock(port, flags);
+		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_deref(port);
 		return 0;
 	}
-
 	while (port) {
 		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
 		if (count < c)
@@ -613,7 +610,8 @@ static int uart_write(struct tty_struct *tty,
 	}
 
 	__uart_start(tty);
-	uart_port_unlock(port, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_deref(port);
 	return ret;
 }
 
@@ -624,9 +622,14 @@ static int uart_write_room(struct tty_struct *tty)
 	unsigned long flags;
 	int ret;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref(state);
+	if (!port)
+		return uart_circ_chars_free(&state->xmit);
+
+	spin_lock_irqsave(&port->lock, flags);
 	ret = uart_circ_chars_free(&state->xmit);
-	uart_port_unlock(port, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_deref(port);
 	return ret;
 }
 
@@ -637,9 +640,14 @@ static int uart_chars_in_buffer(struct tty_struct *tty)
 	unsigned long flags;
 	int ret;
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref(state);
+	if (!port)
+		return uart_circ_chars_pending(&state->xmit);
+
+	spin_lock_irqsave(&port->lock, flags);
 	ret = uart_circ_chars_pending(&state->xmit);
-	uart_port_unlock(port, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_deref(port);
 	return ret;
 }
 
@@ -660,13 +668,15 @@ static void uart_flush_buffer(struct tty_struct *tty)
 
 	pr_debug("uart_flush_buffer(%d) called\n", tty->index);
 
-	port = uart_port_lock(state, flags);
+	port = uart_port_ref(state);
 	if (!port)
 		return;
+	spin_lock_irqsave(&port->lock, flags);
 	uart_circ_clear(&state->xmit);
 	if (port->ops->flush_buffer)
 		port->ops->flush_buffer(port);
-	uart_port_unlock(port, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_deref(port);
 	tty_port_tty_wakeup(&state->port);
 }
 
-- 
2.27.0.rc2

