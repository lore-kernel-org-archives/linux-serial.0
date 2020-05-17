Return-Path: <SRS0=Hdmd=67=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56860C433E1
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 21:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC84207F9
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 21:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgEQV4t (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 May 2020 17:56:49 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45122 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgEQV4e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 May 2020 17:56:34 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaRGf-0002am-CV; Sun, 17 May 2020 23:56:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v3 4/5] serial: 8250: Handle implementations not having TEMT interrupt using em485
Date:   Sun, 17 May 2020 23:56:09 +0200
Message-Id: <20200517215610.2131618-5-heiko@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517215610.2131618-1-heiko@sntech.de>
References: <20200517215610.2131618-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

Some 8250 ports have a TEMT interrupt but it's not a part of the 8250
standard, instead only available on some implementations.

The current em485 implementation does not work on ports without it.
The only chance to make it work is to loop-read on LSR register.

So add UART_CAP_TEMT to mark 8250 uarts having this interrupt,
update all current em485 users with that capability and add
a loop-reading during  __stop_tx_rs485() on uarts not having it.

As __stop_tx_rs485() can also be called from a hard-irq context the
loop-reading is split. If the fifo clears in under 100us in
__stop_tx_rs485() itself just the regular stop calls get executed.
If it takes longer, re-use the existing stop-timer infrastructure
but with only a 10us timer to again poll the LSR registers.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
[moved to use added UART_CAP_TEMT, use readx_poll_timeout]
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250.h            |  1 +
 drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
 drivers/tty/serial/8250/8250_of.c         |  2 +
 drivers/tty/serial/8250/8250_omap.c       |  2 +-
 drivers/tty/serial/8250/8250_port.c       | 51 ++++++++++++++++++++---
 5 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 0df02c055107..50c88dd3f857 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -82,6 +82,7 @@ struct serial8250_config {
 #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
 					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
 					 */
+#define UART_CAP_TEMT	(1 << 18)	/* UART has TEMT interrupt */
 
 #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 1cc0620b596c..c2226f1fd6ac 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -91,7 +91,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* initialize data */
-	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
+	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI | UART_CAP_TEMT;
 	up.port.dev = &pdev->dev;
 	up.port.regshift = 2;
 	up.port.type = PORT_16550;
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 0b89954a3781..e96abd51454c 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -223,6 +223,8 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 			&port8250.overrun_backoff_time_ms) != 0)
 		port8250.overrun_backoff_time_ms = 0;
 
+	port8250.capabilities |= UART_CAP_TEMT;
+
 	ret = serial8250_register_8250_port(&port8250);
 	if (ret < 0)
 		goto err_dispose;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 6cae3782e5fa..241d7307c38f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1144,7 +1144,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.regshift = 2;
 	up.port.fifosize = 64;
 	up.tx_loadsz = 64;
-	up.capabilities = UART_CAP_FIFO;
+	up.capabilities = UART_CAP_FIFO | UART_CAP_TEMT;
 #ifdef CONFIG_PM
 	/*
 	 * Runtime PM is mostly transparent. However to do it right we need to a
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 9e8fec85d1a3..a456e81d3e0b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -19,6 +19,7 @@
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/delay.h>
@@ -1467,11 +1468,26 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
 
+static inline int __get_lsr(struct uart_8250_port *p)
+{
+	return serial_in(p, UART_LSR);
+}
+
+static inline int __wait_for_empty(struct uart_8250_port *p, u64 timeout_us)
+{
+	int lsr;
+
+	return readx_poll_timeout(__get_lsr, p, lsr,
+				  (lsr & BOTH_EMPTY) == BOTH_EMPTY,
+				  0, timeout_us);
+}
+
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 {
 	struct uart_8250_em485 *em485;
 	struct uart_8250_port *p;
 	unsigned long flags;
+	enum hrtimer_restart restart = HRTIMER_NORESTART;
 
 	em485 = container_of(t, struct uart_8250_em485, stop_tx_timer);
 	p = em485->port;
@@ -1479,13 +1495,27 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 	serial8250_rpm_get(p);
 	spin_lock_irqsave(&p->port.lock, flags);
 	if (em485->active_timer == &em485->stop_tx_timer) {
+		/*
+		 * On 8250 without TEMT interrupt, check LSR state and
+		 * restart timer if not empty yet.
+		 */
+		if (!(p->capabilities & UART_CAP_TEMT)) {
+			int ret = __wait_for_empty(p, 100);
+
+			if (ret < 0) {
+				restart = HRTIMER_RESTART;
+				goto out;
+			}
+		}
+
 		p->rs485_stop_tx(p);
 		em485->active_timer = NULL;
 		em485->tx_stopped = true;
 	}
+out:
 	spin_unlock_irqrestore(&p->port.lock, flags);
 	serial8250_rpm_put(p);
-	return HRTIMER_NORESTART;
+	return restart;
 }
 
 static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
@@ -1509,6 +1539,13 @@ static void __stop_tx_rs485(struct uart_8250_port *p)
 		em485->active_timer = &em485->stop_tx_timer;
 		start_hrtimer_ms(&em485->stop_tx_timer,
 				   p->port.rs485.delay_rts_after_send);
+	} else if (!(p->capabilities & UART_CAP_TEMT) &&
+		   __wait_for_empty(p, 100)) {
+		/* Short timer of 1us to check for clear fifos */
+		ktime_t tim = ktime_set(0, 1000);
+
+		em485->active_timer = &em485->stop_tx_timer;
+		hrtimer_start(&em485->stop_tx_timer, tim, HRTIMER_MODE_REL);
 	} else {
 		p->rs485_stop_tx(p);
 		em485->active_timer = NULL;
@@ -1531,11 +1568,15 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		/*
 		 * To provide required timeing and allow FIFO transfer,
 		 * __stop_tx_rs485() must be called only when both FIFO and
-		 * shift register are empty. It is for device driver to enable
-		 * interrupt on TEMT.
+		 * shift register are empty. If 8250 port supports it,
+		 * it is for device driver to enable interrupt on TEMT.
+		 * Otherwise must loop-read until TEMT and THRE flags are set,
+		 * which happens in __stop_tx_rs485()
 		 */
-		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
-			return;
+		if (p->capabilities & UART_CAP_TEMT) {
+			if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
+				return;
+		}
 
 		__stop_tx_rs485(p);
 	}
-- 
2.25.1

