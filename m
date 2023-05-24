Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B351C7EE2D
	for <linux-serial@archiver.kernel.org>; Wed, 24 May 2023 12:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjEXM2P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 08:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjEXM2O (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 08:28:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07E99E
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 05:28:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1nb1-00066m-Mn; Wed, 24 May 2023 14:28:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1nb0-002TyW-Q8; Wed, 24 May 2023 14:28:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1nb0-007Ydg-4o; Wed, 24 May 2023 14:28:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/3] serial: 8250: Clear IIR.RDI in serial8250_clear_fifos()
Date:   Wed, 24 May 2023 14:27:53 +0200
Message-Id: <20230524122754.481816-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524122754.481816-1-u.kleine-koenig@pengutronix.de>
References: <20230524122754.481816-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ll11huMKXy0T22NjycqBoA6IUmZKdkjpPUBE6Tr07kg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkbgLG5vh7MhdgJFNruBzHjYCSFCyxjX0RnRXe0 SYFUQsva1uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG4CxgAKCRCPgPtYfRL+ Tlh2CACTMO1kNCnWnrTijbeLLWs12MhUN9xU8p7AF6PXixfYWsUrMKUSp9nDw+d82d+qPqjeO5s NCAgcZDBoALvn5AzQmwUTYwM1lK+FYPfKGsVDps3LaZmFG8ycLLORH5ux7CVKRczjC6/RTiexpx MS4+wCOyGbNHMD56j2rDMxQogNdXzHjy4/0NwmI+uOLn0ouhnOHKblnEcMiOeiCkmb+jhIU5GcA tbblc+R72TCjThdeDJWd5LJmnGlE5niuG5gNdLwM/A+Y72BLPeglJpQ5ebVuWVc0FTTmmq19MTF zQssYU8MOlxDqP5vRYqLqUiAtkoNtRVbI3oEzcdW6op1rUNf
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

At least on MPC83xx (but I suspect also on other implementations) it can
happen that after irqs are disabled but before the FIFOs are cleared a
character is received. Resetting the FIFO throws away that character,
but doesn't clear the IIR.RDI event that signals that there is read data
available.

Read from RX to clear IIR.RDI and throw away the result.

This fixes a infinite loop after the above described race happened: The
irq handler (here: fsl8250_handle_irq()) triggers, but LSR.DR isn't set,
so RX isn't read and the irq handler returns just to be called again.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fe8d79c4ae95..8b47ec000922 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -556,6 +556,18 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
 		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
 			       UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 		serial_out(p, UART_FCR, 0);
+
+		/*
+		 * When doing rs485 on MPC8313 it can happen that in the short
+		 * window when switching from RX to TX there is a character in
+		 * the RX FIFO which isn't processed any more and then discarded
+		 * in here by clearing the FIFO. In that case IIR signals an RX
+		 * timeout once irqs are reenabled (i.e. in
+		 * serial8250_em485_stop_tx()) but LSR shows no pending event.
+		 * The RX timeout event can only be cleared by reading RX. Do
+		 * this here before reenabling the FIFO and irqs.
+		 */
+		serial_port_in(&p->port, UART_RX);
 	}
 }
 
-- 
2.39.2

