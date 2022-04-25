Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4FAC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 25 Apr 2022 14:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbiDYOiA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Apr 2022 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiDYOh6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Apr 2022 10:37:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AF0119EC2
        for <linux-serial@vger.kernel.org>; Mon, 25 Apr 2022 07:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650897294; x=1682433294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tXbTqRELZAeyhHo9dP/WkW4MMsShDVptDNpHd/BBQKc=;
  b=gUP1/XqC56D7sNdMAuijOC0HrGwsroLS5QR5+0kHXWz9+0HRkw0w+/UC
   GzuI4Z5zQTtJpN5cN1bRSU82Aecmg2AZyA+4nSQg+GwdChU2eLI8MFr5J
   B3ROPfE7yN1pXtvxmCDRIZhr++PXSJDGRY0Gc04CPiVoaa+Q7hxmqGuVy
   d9TbVk6OpNFLBtYn2xWBrub7iDT4WVFw8bAYzsr7hygtiioc1iV9Je8l1
   Np/BT6mUCQAtXvHhk5tV28oc7ifaMZUMLlYp8Ci/8A+OwqmXxo6TRfx1T
   yziF2V0JO3YRip5x91LiYWx8s0sGoR/KWTwZwbdlvOo/NX1epf5YNlt8d
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264112909"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="264112909"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:34:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="579315682"
Received: from lpuglia-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.217.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:34:49 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vicente Bergas <vicencb@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH v4 03/13] serial: 8250: Handle UART without interrupt on TEMT
Date:   Mon, 25 Apr 2022 17:34:00 +0300
Message-Id: <20220425143410.12703-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add UART_CAP_NOTEMT for UARTs that lack interrupt on TEMT but want to
use em485. Em485 framework needs to ensure not only FIFO is empty but
also that tx shift register is empty.

This approach uses Uwe Kleine-König's suggestion on simply
using/incrementing stop_tx timer rather than adding another timer. When
UART_CAP_NOTEMT is set and THRE is present w/o TEMT, stop tx timer is
reused to wait for the emptying of the shift register.

This change does not add the UART_CAP_NOTEMT define as it already exist
but is currently no-op. See 7a107b2c6b81 (Revert "serial: 8250: Handle
UART without interrupt on TEMT using em485") for further details.

Vicente Bergas reported that RTS is deasserted roughly one bit too
early losing stop bit tx. To address this problem, stop_delay now
accounts for one extra bit using rough formula /7 (assumes worst-case
of 2+5 bits). I suspect this glitch had to do with when THRE is getting
asserted. If FIFO is emptied already during the tx of the stop bit,
perhaps it leads to HW asserting THRE early for the normal frame time
formula to work accurately.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Eric Tremblay <etremblay@distech-controls.com>
Tested-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 35 +++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 40b62126c1ca..da78a7fa763f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1504,18 +1504,19 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
 	hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
 }
 
-static void __stop_tx_rs485(struct uart_8250_port *p)
+static void __stop_tx_rs485(struct uart_8250_port *p, u64 stop_delay)
 {
 	struct uart_8250_em485 *em485 = p->em485;
 
+	stop_delay += (u64)p->port.rs485.delay_rts_after_send * NSEC_PER_MSEC;
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
@@ -1535,16 +1536,32 @@ static inline void __stop_tx(struct uart_8250_port *p)
 
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
+			/*
+			 * RTS might get deasserted too early with the normal
+			 * frame timing formula. It seems to suggest THRE might
+			 * get asserted already during tx of the stop bit
+			 * rather than after it is fully sent.
+			 * Roughly estimate 1 extra bit here with / 7.
+			 */
+			stop_delay = p->port.frame_time + DIV_ROUND_UP(p->port.frame_time, 7);
+		}
 
-		__stop_tx_rs485(p);
+		__stop_tx_rs485(p, stop_delay);
 	}
 	__do_stop_tx(p);
 }
-- 
2.30.2

