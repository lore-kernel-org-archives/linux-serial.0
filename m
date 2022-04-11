Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EFBC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 08:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbiDKIgD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343851AbiDKIf5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 04:35:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD6138D85
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649666024; x=1681202024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iiViPJh7xyl0ZYx9FXtQ45zmuxrCc/q2T88su1wZEE0=;
  b=I6RzxQE/1/QzcvxFrsGJI5t0ZRJCqrxL1iWj5RyYvBarXfCG8TfNt/GN
   MQ8BBMF9MBL8j8qqnjKPaXtc3vjodQqFdGl8BfQyAU/3jxrp5+UtBPIs8
   5USVq6YIeJbsQxsOScofkLt6xN6Vd33ZOJQ4J9ZmwoIr+BoPEpmQKCKzT
   x7F6nnPJ/nvu77joFGl/+8iF/VnFFv0Z8fL3vCe0FzgnO6TPabX9EgWPo
   RGR3aiSyyxKsdGOVfK6JQnHaifJew0cqYNEZ1E82fMWLPHtZY0wcg+h/i
   ql+aKi5L/K876ivgDRf6jmxppcd0WiggxzNl2rI4x4q9VL7h8IDsDJw4l
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="322511549"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="322511549"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:33:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572028584"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:33:40 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH v3 02/12] serial: 8250: Handle UART without interrupt on TEMT
Date:   Mon, 11 Apr 2022 11:33:11 +0300
Message-Id: <20220411083321.9131-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add UART_CAP_NOTEMT for UARTs that lack interrupt on TEMT but
want to use em485. Em485 framework needs to ensure not only
FIFO is empty but also that tx shift register is empty.

This approach uses Uwe Kleine-König's suggestion on simply
using/incrementing stop_tx timer rather than adding another
timer. When UART_CAP_NOTEMT is set and THRE is present w/o
TEMT, stop tx timer is reused to wait for the emptying of
the shift register.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Eric Tremblay <etremblay@distech-controls.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_port.c | 28 +++++++++++++++++++---------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index db784ace25d8..100426cd2335 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -83,6 +83,7 @@ struct serial8250_config {
 #define UART_CAP_MINI	BIT(17)	/* Mini UART on BCM283X family lacks:
 					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
 					 */
+#define UART_CAP_NOTEMT	BIT(18) /* UART cannot interrupt on TEMT */
 
 #define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d30a6c1c4c20..276c5281aaa0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1504,18 +1504,19 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
 	hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
 }
 
-static void __stop_tx_rs485(struct uart_8250_port *p)
+static void __stop_tx_rs485(struct uart_8250_port *p, u64 stop_delay)
 {
 	struct uart_8250_em485 *em485 = p->em485;
 
+	stop_delay += (u64)p->port.rs485.delay_rts_after_send * NSEC_PER_USEC;
+
 	/*
 	 * rs485_stop_tx() is going to set RTS according to config
 	 * AND flush RX FIFO if required.
 	 */
-	if (p->port.rs485.delay_rts_after_send > 0) {
+	if (stop_delay > 0) {
 		em485->active_timer = &em485->stop_tx_timer;
-		start_hrtimer_ms(&em485->stop_tx_timer,
-				   p->port.rs485.delay_rts_after_send);
+		hrtimer_start(&em485->stop_tx_timer, ns_to_ktime(stop_delay), HRTIMER_MODE_REL);
 	} else {
 		p->rs485_stop_tx(p);
 		em485->active_timer = NULL;
@@ -1535,16 +1536,25 @@ static inline void __stop_tx(struct uart_8250_port *p)
 
 	if (em485) {
 		unsigned char lsr = serial_in(p, UART_LSR);
+		u64 stop_delay = 0;
+
+		if (!(lsr & UART_LSR_THRE))
+			return;
 		/*
 		 * To provide required timeing and allow FIFO transfer,
 		 * __stop_tx_rs485() must be called only when both FIFO and
-		 * shift register are empty. It is for device driver to enable
-		 * interrupt on TEMT.
+		 * shift register are empty. The device driver should either
+		 * enable interrupt on TEMT or set UART_CAP_NOTEMT that will
+		 * enlarge stop_tx_timer by the tx time of one frame to cover
+		 * for emptying of the shift register.
 		 */
-		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
-			return;
+		if (!(lsr & UART_LSR_TEMT)) {
+			if (!(p->capabilities & UART_CAP_NOTEMT))
+				return;
+			stop_delay = p->port.frame_time;
+		}
 
-		__stop_tx_rs485(p);
+		__stop_tx_rs485(p, stop_delay);
 	}
 	__do_stop_tx(p);
 }
-- 
2.30.2

