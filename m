Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEC3C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 30 Mar 2022 10:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbiC3Ksv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Mar 2022 06:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245560AbiC3Ksp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Mar 2022 06:48:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A91269A65
        for <linux-serial@vger.kernel.org>; Wed, 30 Mar 2022 03:47:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZVqn-0002vE-Fb; Wed, 30 Mar 2022 12:46:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZVqi-003y62-4j; Wed, 30 Mar 2022 12:46:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZVqj-00Clkm-T3; Wed, 30 Mar 2022 12:46:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Tremblay <etremblay@distech-controls.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, kernel@pengutronix.de,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v3 1/3] serial: 8250: Handle UART without interrupt on TEMT using em485
Date:   Wed, 30 Mar 2022 12:46:40 +0200
Message-Id: <20220330104642.229507-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de>
References: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7250; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PFjDlRGga7zbixtorMEEhD5n7Xa6CQmjJp4HG7DXIxY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiRDUDvhyJIC72n5fSfF+ffbeRLqYD7NoQQh5rnEb2 pgy85RWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYkQ1AwAKCRDB/BR4rcrsCQ13CA CF1HXcoouUVI6Kmkq6CjHDUlrfmKoJdnda3z6AE4wBbVHSsEpN8H3AV7FwKakziE5Qn+v1/Pqf69wJ mqHULuG/0KN7U6TXr3Ldxlrqja9gEtG1HPtgrQ5Mllf4a6U7xLx6/3EsC7/3/m6KM2MjQoa7NzOWAU 0KWMaG6l42qLeKastAXKk8Dir1qHR515hC4NwSIm0nB6sGP3ucUEgJw1qlSnrdyJZntuK0xQosaRmG oHsb2HDApqY8wxj0clrOGzrhxHlVgCLjzrs0X5YkGMCCqF/0b3Fo813e/d4MJK6nIo49wHfy06Ul6w 5klDX8Xz6+IMt7dTORUMPwnwv0qvhr
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Eric Tremblay <etremblay@distech-controls.com>

Introduce the UART_CAP_NOTEMT capability. The capability indicates that
the UART doesn't have an interrupt available on TEMT.

In the case where the device does not support it, we calculate the
maximum time it could take for the transmitter to empty the
shift register. When we get in the situation where we get the
THRE interrupt, we check if the TEMT bit is set. If it's not, we start
the a timer and recall __stop_tx() after the delay.

The transmit sequence is a bit modified when the capability is set. The
new timer is used between the last interrupt(THRE) and a potential
stop_tx timer.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
[moved to use added UART_CAP_TEMT]
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
[moved to use added UART_CAP_NOTEMT, improve timeout]
Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
[rebased to v5.17, making use of tty_get_frame_size]
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_port.c | 76 ++++++++++++++++++++++++++++-
 include/linux/serial_8250.h         |  2 +
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index db784ace25d8..39ffeb37786f 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -83,6 +83,7 @@ struct serial8250_config {
 #define UART_CAP_MINI	BIT(17)	/* Mini UART on BCM283X family lacks:
 					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
 					 */
+#define UART_CAP_NOTEMT	BIT(18)	/* UART without interrupt on TEMT available */
 
 #define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3b12bfc1ed67..0af13b4c76a0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -563,8 +563,21 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
 	}
 }
 
+static inline void serial8250_em485_update_temt_delay(struct uart_8250_port *p,
+			unsigned int cflag, unsigned int baud)
+{
+	unsigned int bits;
+
+	if (!p->em485)
+		return;
+
+	bits = tty_get_frame_size(cflag);
+	p->em485->no_temt_delay = DIV_ROUND_UP(bits * NSEC_PER_SEC, baud);
+}
+
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
+static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrtimer *t);
 
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
 {
@@ -623,6 +636,16 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 		     HRTIMER_MODE_REL);
 	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL);
+
+	if (p->capabilities & UART_CAP_NOTEMT) {
+		struct tty_struct *tty = p->port.state->port.tty;
+
+		serial8250_em485_update_temt_delay(p, tty->termios.c_cflag,
+						   tty_get_baud_rate(tty));
+		hrtimer_init(&p->em485->no_temt_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		p->em485->no_temt_timer.function = &serial8250_em485_handle_no_temt;
+	}
+
 	p->em485->stop_tx_timer.function = &serial8250_em485_handle_stop_tx;
 	p->em485->start_tx_timer.function = &serial8250_em485_handle_start_tx;
 	p->em485->port = p;
@@ -654,6 +677,7 @@ void serial8250_em485_destroy(struct uart_8250_port *p)
 
 	hrtimer_cancel(&p->em485->start_tx_timer);
 	hrtimer_cancel(&p->em485->stop_tx_timer);
+	hrtimer_cancel(&p->em485->no_temt_timer);
 
 	kfree(p->em485);
 	p->em485 = NULL;
@@ -1496,6 +1520,11 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
 	hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
 }
 
+static void start_hrtimer_ns(struct hrtimer *hrt, unsigned long nsec)
+{
+	hrtimer_start(hrt, ns_to_ktime(nsec), HRTIMER_MODE_REL);
+}
+
 static void __stop_tx_rs485(struct uart_8250_port *p)
 {
 	struct uart_8250_em485 *em485 = p->em485;
@@ -1527,14 +1556,33 @@ static inline void __stop_tx(struct uart_8250_port *p)
 
 	if (em485) {
 		unsigned char lsr = serial_in(p, UART_LSR);
+
+		p->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+
 		/*
-		 * To provide required timeing and allow FIFO transfer,
+		 * To provide required timing and allow FIFO transfer,
 		 * __stop_tx_rs485() must be called only when both FIFO and
 		 * shift register are empty. It is for device driver to enable
 		 * interrupt on TEMT.
 		 */
-		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
+		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY) {
+			if (!(p->capabilities & UART_CAP_NOTEMT))
+				/* __stop_tx will be called again once TEMT triggers */
+				return;
+
+			if (!(lsr & UART_LSR_THRE))
+				/* __stop_tx will be called again once THRE triggers */
+				return;
+
+			/*
+			 * On devices with no TEMT interrupt available, start
+			 * a timer for a byte time. The timer will recall
+			 * __stop_tx().
+			 */
+			em485->active_timer = &em485->no_temt_timer;
+			start_hrtimer_ns(&em485->no_temt_timer, em485->no_temt_delay);
 			return;
+		}
 
 		__stop_tx_rs485(p);
 	}
@@ -1633,6 +1681,27 @@ static inline void start_tx_rs485(struct uart_port *port)
 	__start_tx(port);
 }
 
+static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrtimer *t)
+{
+	struct uart_8250_em485 *em485;
+	struct uart_8250_port *p;
+	unsigned long flags;
+
+	em485 = container_of(t, struct uart_8250_em485, no_temt_timer);
+	p = em485->port;
+
+	serial8250_rpm_get(p);
+	spin_lock_irqsave(&p->port.lock, flags);
+	if (em485->active_timer == &em485->no_temt_timer) {
+		em485->active_timer = NULL;
+		__stop_tx(p);
+	}
+
+	spin_unlock_irqrestore(&p->port.lock, flags);
+	serial8250_rpm_put(p);
+	return HRTIMER_NORESTART;
+}
+
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
 {
 	struct uart_8250_em485 *em485 = container_of(t, struct uart_8250_em485,
@@ -2851,6 +2920,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial8250_set_divisor(port, baud, quot, frac);
 
+	if (up->capabilities & UART_CAP_NOTEMT)
+		serial8250_em485_update_temt_delay(up, termios->c_cflag, baud);
+
 	/*
 	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
 	 * is written without DLAB set, this mode will be disabled.
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index ff84a3ed10ea..de135852107c 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -79,7 +79,9 @@ struct uart_8250_ops {
 struct uart_8250_em485 {
 	struct hrtimer		start_tx_timer; /* "rs485 start tx" timer */
 	struct hrtimer		stop_tx_timer;  /* "rs485 stop tx" timer */
+	struct hrtimer		no_temt_timer;  /* "rs485 no TEMT interrupt" timer */
 	struct hrtimer		*active_timer;  /* pointer to active timer */
+	unsigned long		no_temt_delay;  /* Delay for no_temt_timer */
 	struct uart_8250_port	*port;          /* for hrtimer callbacks */
 	unsigned int		tx_stopped:1;	/* tx is currently stopped */
 };
-- 
2.30.2

