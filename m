Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E57C7EE23
	for <linux-serial@archiver.kernel.org>; Wed, 24 May 2023 12:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjEXM2O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 08:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjEXM2N (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 08:28:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E68A99
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 05:28:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1nb1-00066k-VA; Wed, 24 May 2023 14:28:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1nb0-002TyR-JR; Wed, 24 May 2023 14:28:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1naz-007Ydc-TK; Wed, 24 May 2023 14:28:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/3] serial: 8250-fsl: Expand description of the MPC83xx UART's misbehaviour
Date:   Wed, 24 May 2023 14:27:52 +0200
Message-Id: <20230524122754.481816-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524122754.481816-1-u.kleine-koenig@pengutronix.de>
References: <20230524122754.481816-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NoJ+WtwJv+crXEofi5qJFQK3LCG+l2KZc5ichG+PW/k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkbgLF1HpHaCSAl9AFf6t6ljO/itJLaCXzJiDRc PBrWxBB6vGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG4CxQAKCRCPgPtYfRL+ ThKbCACduezMzNeqtN9lAm7rbD3dCWDgbRBYRIB9o1LCGEF/2jhJmoLf2OVuD17SJhgQ1lgLCUt FegeCJlZ1qoPYEG5T1xi+/FKZNxOFxqjIJkNvnVfJOx7asV8qjcle5SQxFGKkg0odQjuTZDX4cK pzJG44lrrC2m1t33bikSjMsp9Op6Zjk4mGc1RWA9xVWItTKqTkA3bM4YjzeCzHLkxq3GqfUsUf4 hHIbNaAkUhQoX+7GMtuM3CycUHNlvmJtDi2qB2rIFNvuqW9Zq76vAsjG00jNSKXvUlEIdZbZHa/ WPl9zPTgGaxYmdGdESe0+fo7lzvvNjV5KWw35kUcjutxuAAx
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After working quite a bit on erratic behaviour of the MPC83xx UART I
(think I) understood the problem. Expand the description accoringly to
conserve the knowledge for the future.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250_fsl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 8adfaa183f77..00f46b9a8b09 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -38,7 +38,19 @@ int fsl8250_handle_irq(struct uart_port *port)
 		return 0;
 	}
 
-	/* This is the WAR; if last event was BRK, then read and return */
+	/*
+	 * For a single break the hardware reports LSR.BI for each character
+	 * time. This is described in the MPC8313E chip errata as "General17".
+	 * A typical break has a duration of 0.3s, with a 115200n8 configuration
+	 * that (theoretically) corresponds to ~3500 interrupts in these 0.3s.
+	 * In practise it's less (around 500) because of hardware
+	 * and software latencies. The workaround recommended by the vendor is
+	 * to read the RX register (to clear LSR.DR and thus prevent a FIFO
+	 * aging interrupt). To prevent the irq from retriggering LSR must not be
+	 * read. (This would clear LSR.BI, hardware would reassert the BI event
+	 * immediately and interrupt the CPU again. The hardware clears LSR.BI
+	 * when the next valid char is read.)
+	 */
 	if (unlikely(up->lsr_saved_flags & UART_LSR_BI)) {
 		up->lsr_saved_flags &= ~UART_LSR_BI;
 		port->serial_in(port, UART_RX);
-- 
2.39.2

