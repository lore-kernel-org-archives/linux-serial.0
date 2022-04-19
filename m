Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297AFC4332F
	for <linux-serial@archiver.kernel.org>; Tue, 19 Apr 2022 13:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352745AbiDSNnu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Apr 2022 09:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352769AbiDSNmo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Apr 2022 09:42:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC355B4
        for <linux-serial@vger.kernel.org>; Tue, 19 Apr 2022 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650375596; x=1681911596;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9NNh+/k9hW4lFgdL/6JMi9Hfw1sZmLJ7/xk2ZcMEs+U=;
  b=nhZmvJJTNeP2AB0jrAenH6HZYEkEgg1hpBhked6ALjczfFhSA3+cpRPW
   6N5HkGktGGCrD+aRlW/Sc6qWpydewFy67aXKU1+Mx5fjPF6vFezlLgcf0
   RBeixT8nbWzf2g+x6cmvC2toA1TFIbG9k9hYSrbGGZcNtRmJ53nbhWwQA
   2PiyXoM3ejnn4VMobulDQb6tbVTHyY5exSX4udcgKZrM0uStj3Y1o0Pgl
   qNrrlOBGtd7mwM4jEHC3MtBaRqJP7xs0HIs2XCInfG/mHwLn0EYjmElSF
   Avd3J8etLhAYEhJtGi1Hmthi4kzhDX9nGvTT8tv3I8ozAR8om7vt2wKf7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262624535"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="262624535"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 06:39:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="576103899"
Received: from dbenelli-mobl.ger.corp.intel.com ([10.252.56.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 06:39:52 -0700
Date:   Tue, 19 Apr 2022 16:39:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Lukas Wunner <lukas.wunner@intel.com>, kernel@pengutronix.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 1/1] serial: 8250: revert UART_CAP_NOTEMT changes
Message-ID: <db15ba9d-d914-53fa-23b8-870df7bb13@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-178727296-1650375594=:1610"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-178727296-1650375594=:1610
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT


This reverts UART_CAP_NOTEMT commit and driver changes depending
on it:
  f6f586102ad1 (serial: 8250: Handle UART without interrupt on TEMT
                using em485)
  296385fe1275 (serial: 8250: Add UART_CAP_NOTEMT on PORT_16550A_FSL64)
  bec1f1b66a6a (serial: 8250: add compatible for fsl,16550-FIFO64)

The UART_CAP_NOTEMT code added in f6f586102add1 (serial: 8250:
Handle UART without interrupt on TEMT using em485) containts math
overflow for 32-bit archs. In addition, the approach used in it
is unnecessarily complicated requiring a dedicated timer just for
notemt. A simpler approach for providing UART_CAP_NOTEMT already
exists (patches 1-2):
  https://lore.kernel.org/linux-serial/20220411083321.9131-3-ilpo.jarvinen@linux.intel.com/T/#u
Thus, simply revert the UART_CAP_NOTEMT changes for now.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h      |  1 -
 drivers/tty/serial/8250/8250_of.c   |  2 -
 drivers/tty/serial/8250/8250_port.c | 78 ++---------------------------
 include/linux/serial_8250.h         |  2 -
 4 files changed, 3 insertions(+), 80 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 39ffeb37786f..db784ace25d8 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -83,7 +83,6 @@ struct serial8250_config {
 #define UART_CAP_MINI	BIT(17)	/* Mini UART on BCM283X family lacks:
 					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
 					 */
-#define UART_CAP_NOTEMT	BIT(18)	/* UART without interrupt on TEMT available */
 
 #define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 5a699a1aa79c..be8626234627 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -326,8 +326,6 @@ static const struct of_device_id of_platform_serial_table[] = {
 		.data = (void *)PORT_ALTR_16550_F64, },
 	{ .compatible = "altr,16550-FIFO128",
 		.data = (void *)PORT_ALTR_16550_F128, },
-	{ .compatible = "fsl,16550-FIFO64",
-		.data = (void *)PORT_16550A_FSL64, },
 	{ .compatible = "mediatek,mtk-btif",
 		.data = (void *)PORT_MTK_BTIF, },
 	{ .compatible = "mrvl,mmp-uart",
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c1f24e88ef09..318af6f13605 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -263,7 +263,7 @@ static const struct serial8250_config uart_config[] = {
 		.tx_loadsz	= 63,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
 				  UART_FCR7_64BYTE,
-		.flags		= UART_CAP_FIFO | UART_CAP_NOTEMT,
+		.flags		= UART_CAP_FIFO,
 	},
 	[PORT_RT2880] = {
 		.name		= "Palmchip BK-3103",
@@ -571,21 +571,8 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
 	}
 }
 
-static inline void serial8250_em485_update_temt_delay(struct uart_8250_port *p,
-			unsigned int cflag, unsigned int baud)
-{
-	unsigned int bits;
-
-	if (!p->em485)
-		return;
-
-	bits = tty_get_frame_size(cflag);
-	p->em485->no_temt_delay = DIV_ROUND_UP(bits * NSEC_PER_SEC, baud);
-}
-
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
-static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrtimer *t);
 
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
 {
@@ -644,16 +631,6 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 		     HRTIMER_MODE_REL);
 	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL);
-
-	if (p->capabilities & UART_CAP_NOTEMT) {
-		struct tty_struct *tty = p->port.state->port.tty;
-
-		serial8250_em485_update_temt_delay(p, tty->termios.c_cflag,
-						   tty_get_baud_rate(tty));
-		hrtimer_init(&p->em485->no_temt_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		p->em485->no_temt_timer.function = &serial8250_em485_handle_no_temt;
-	}
-
 	p->em485->stop_tx_timer.function = &serial8250_em485_handle_stop_tx;
 	p->em485->start_tx_timer.function = &serial8250_em485_handle_start_tx;
 	p->em485->port = p;
@@ -685,7 +662,6 @@ void serial8250_em485_destroy(struct uart_8250_port *p)
 
 	hrtimer_cancel(&p->em485->start_tx_timer);
 	hrtimer_cancel(&p->em485->stop_tx_timer);
-	hrtimer_cancel(&p->em485->no_temt_timer);
 
 	kfree(p->em485);
 	p->em485 = NULL;
@@ -1528,11 +1504,6 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
 	hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
 }
 
-static void start_hrtimer_ns(struct hrtimer *hrt, unsigned long nsec)
-{
-	hrtimer_start(hrt, ns_to_ktime(nsec), HRTIMER_MODE_REL);
-}
-
 static void __stop_tx_rs485(struct uart_8250_port *p)
 {
 	struct uart_8250_em485 *em485 = p->em485;
@@ -1564,33 +1535,14 @@ static inline void __stop_tx(struct uart_8250_port *p)
 
 	if (em485) {
 		unsigned char lsr = serial_in(p, UART_LSR);
-
-		p->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
-
 		/*
-		 * To provide required timing and allow FIFO transfer,
+		 * To provide required timeing and allow FIFO transfer,
 		 * __stop_tx_rs485() must be called only when both FIFO and
 		 * shift register are empty. It is for device driver to enable
 		 * interrupt on TEMT.
 		 */
-		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY) {
-			if (!(p->capabilities & UART_CAP_NOTEMT))
-				/* __stop_tx will be called again once TEMT triggers */
-				return;
-
-			if (!(lsr & UART_LSR_THRE))
-				/* __stop_tx will be called again once THRE triggers */
-				return;
-
-			/*
-			 * On devices with no TEMT interrupt available, start
-			 * a timer for a byte time. The timer will recall
-			 * __stop_tx().
-			 */
-			em485->active_timer = &em485->no_temt_timer;
-			start_hrtimer_ns(&em485->no_temt_timer, em485->no_temt_delay);
+		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
 			return;
-		}
 
 		__stop_tx_rs485(p);
 	}
@@ -1701,27 +1653,6 @@ static inline void start_tx_rs485(struct uart_port *port)
 	__start_tx(port);
 }
 
-static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrtimer *t)
-{
-	struct uart_8250_em485 *em485;
-	struct uart_8250_port *p;
-	unsigned long flags;
-
-	em485 = container_of(t, struct uart_8250_em485, no_temt_timer);
-	p = em485->port;
-
-	serial8250_rpm_get(p);
-	spin_lock_irqsave(&p->port.lock, flags);
-	if (em485->active_timer == &em485->no_temt_timer) {
-		em485->active_timer = NULL;
-		__stop_tx(p);
-	}
-
-	spin_unlock_irqrestore(&p->port.lock, flags);
-	serial8250_rpm_put(p);
-	return HRTIMER_NORESTART;
-}
-
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
 {
 	struct uart_8250_em485 *em485 = container_of(t, struct uart_8250_em485,
@@ -2927,9 +2858,6 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial8250_set_divisor(port, baud, quot, frac);
 
-	if (up->capabilities & UART_CAP_NOTEMT)
-		serial8250_em485_update_temt_delay(up, termios->c_cflag, baud);
-
 	/*
 	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
 	 * is written without DLAB set, this mode will be disabled.
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index de135852107c..ff84a3ed10ea 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -79,9 +79,7 @@ struct uart_8250_ops {
 struct uart_8250_em485 {
 	struct hrtimer		start_tx_timer; /* "rs485 start tx" timer */
 	struct hrtimer		stop_tx_timer;  /* "rs485 stop tx" timer */
-	struct hrtimer		no_temt_timer;  /* "rs485 no TEMT interrupt" timer */
 	struct hrtimer		*active_timer;  /* pointer to active timer */
-	unsigned long		no_temt_delay;  /* Delay for no_temt_timer */
 	struct uart_8250_port	*port;          /* for hrtimer callbacks */
 	unsigned int		tx_stopped:1;	/* tx is currently stopped */
 };
-- 
2.30.2

--8323329-178727296-1650375594=:1610--
