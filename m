Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35F4C10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 14:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A5A20773
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 14:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCRO1P (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:27:15 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37358 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgCRO1A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 10:27:00 -0400
Received: from [94.134.91.63] (helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jEZeo-0004YX-AJ; Wed, 18 Mar 2020 15:26:54 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 3/7] serial: 8250: Handle case port doesn't have TEMT interrupt using em485.
Date:   Wed, 18 Mar 2020 15:26:36 +0100
Message-Id: <20200318142640.982763-4-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318142640.982763-1-heiko@sntech.de>
References: <20200318142640.982763-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

Some 8250 ports only have TEMT interrupt, so current implementation
can't work for ports without it. The only chance to make it work is to
loop-read on LSR register.

With NO TEMT interrupt check if both TEMT and THRE are set looping on
LSR register.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250.h      |  2 +-
 drivers/tty/serial/8250/8250_of.c   |  2 +-
 drivers/tty/serial/8250/8250_omap.c |  2 +-
 drivers/tty/serial/8250/8250_port.c | 30 +++++++++++++++++++++--------
 include/linux/serial_8250.h         |  1 +
 5 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 50a4c174410d..9e049d2a039e 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -190,7 +190,7 @@ void serial8250_rpm_put(struct uart_8250_port *p);
 void serial8250_rpm_get_tx(struct uart_8250_port *p);
 void serial8250_rpm_put_tx(struct uart_8250_port *p);
 
-int serial8250_em485_init(struct uart_8250_port *p);
+int serial8250_em485_init(struct uart_8250_port *p, bool has_temt_isr);
 void serial8250_em485_destroy(struct uart_8250_port *p);
 
 /* MCR <-> TIOCM conversion */
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 92fbf46ce3bd..c77ab44a5468 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -64,7 +64,7 @@ static int of_8250_rs485_config(struct uart_port *port,
 	 * are idempotent
 	 */
 	if (rs485->flags & SER_RS485_ENABLED) {
-		int ret = serial8250_em485_init(up);
+		int ret = serial8250_em485_init(up, true);
 
 		if (ret) {
 			rs485->flags &= ~SER_RS485_ENABLED;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 836e736ae188..241322900298 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -734,7 +734,7 @@ static int omap_8250_rs485_config(struct uart_port *port,
 	 * are idempotent
 	 */
 	if (rs485->flags & SER_RS485_ENABLED) {
-		int ret = serial8250_em485_init(up);
+		int ret = serial8250_em485_init(up, true);
 
 		if (ret) {
 			rs485->flags &= ~SER_RS485_ENABLED;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 67aa3a2a9afa..3d1d8490bc42 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -605,15 +605,17 @@ EXPORT_SYMBOL_GPL(serial8250_rpm_put);
 /**
  *	serial8250_em485_init() - put uart_8250_port into rs485 emulating
  *	@p:	uart_8250_port port instance
+ *	@p:	bool specify if 8250 port has TEMT interrupt or not
  *
  *	The function is used to start rs485 software emulating on the
  *	&struct uart_8250_port* @p. Namely, RTS is switched before/after
  *	transmission. The function is idempotent, so it is safe to call it
  *	multiple times.
  *
- *	The caller MUST enable interrupt on empty shift register before
- *	calling serial8250_em485_init(). This interrupt is not a part of
- *	8250 standard, but implementation defined.
+ *	If has_temt_isr is passed as true, the caller MUST enable interrupt
+ *	on empty shift register before calling serial8250_em485_init().
+ *	This interrupt is not a part of	8250 standard, but implementation
+ *	defined.
  *
  *	The function is supposed to be called from .rs485_config callback
  *	or from any other callback protected with p->port.lock spinlock.
@@ -622,7 +624,7 @@ EXPORT_SYMBOL_GPL(serial8250_rpm_put);
  *
  *	Return 0 - success, -errno - otherwise
  */
-int serial8250_em485_init(struct uart_8250_port *p)
+int serial8250_em485_init(struct uart_8250_port *p, bool has_temt_isr)
 {
 	if (p->em485)
 		return 0;
@@ -639,6 +641,7 @@ int serial8250_em485_init(struct uart_8250_port *p)
 	p->em485->start_tx_timer.function = &serial8250_em485_handle_start_tx;
 	p->em485->port = p;
 	p->em485->active_timer = NULL;
+	p->em485->has_temt_isr = has_temt_isr;
 	serial8250_em485_rts_after_send(p);
 
 	return 0;
@@ -1475,11 +1478,22 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		/*
 		 * To provide required timeing and allow FIFO transfer,
 		 * __stop_tx_rs485() must be called only when both FIFO and
-		 * shift register are empty. It is for device driver to enable
-		 * interrupt on TEMT.
+		 * shift register are empty. If 8250 port supports it,
+		 * it is for device driver to enable interrupt on TEMT.
+		 * Otherwise must loop-read until TEMT and THRE flags are set.
 		 */
-		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
-			return;
+		if (em485->has_temt_isr) {
+			if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
+				return;
+		} else {
+			int val;
+
+			if (serial_in_poll_timeout(p, UART_LSR, val,
+					(val & BOTH_EMPTY) != BOTH_EMPTY,
+					100000) < 0)
+				pr_warn("%s: timeout waiting for fifos to empty\n",
+					p->port.name);
+		}
 
 		em485->active_timer = NULL;
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index bb2bc99388ca..c4b4469c272b 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -79,6 +79,7 @@ struct uart_8250_em485 {
 	struct hrtimer		start_tx_timer; /* "rs485 start tx" timer */
 	struct hrtimer		stop_tx_timer;  /* "rs485 stop tx" timer */
 	struct hrtimer		*active_timer;  /* pointer to active timer */
+	bool			has_temt_isr;	/* variant has TEMT interrupt */
 	struct uart_8250_port	*port;          /* for hrtimer callbacks */
 };
 
-- 
2.24.1

