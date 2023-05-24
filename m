Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404C8C77B73
	for <linux-serial@archiver.kernel.org>; Wed, 24 May 2023 12:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjEXM2Q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 08:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjEXM2O (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 08:28:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05229C
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 05:28:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1nb1-00066o-Qo; Wed, 24 May 2023 14:28:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1nb1-002TyZ-4g; Wed, 24 May 2023 14:28:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1nb0-007Ydj-BH; Wed, 24 May 2023 14:28:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/3] serial: 8250-fsl: Only do the break workaround if IIR signals RLSI
Date:   Wed, 24 May 2023 14:27:54 +0200
Message-Id: <20230524122754.481816-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524122754.481816-1-u.kleine-koenig@pengutronix.de>
References: <20230524122754.481816-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GR0BkgLiO8vDx6EGlmGb0wH4sarg9LTJIHKn8RrKgNo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkbgLHMHul2Ha164bNBr9gerSORBepWrtqcBDhT 3Amn3ccYpyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG4CxwAKCRCPgPtYfRL+ Tie2B/sHwlvmIYwK9xsRZV5OyxcgquP9f//wEtuh2UDG2rCe0LfpHZcfNmccH/CTvpmhEyNGTgo uARCtt7hM71wLY0FYCXVRTMXDo111s2d/UmPwNBZ5CLsR7xI3U4Y302N0yfP343JNtj064M5N51 rGuEzZ3wzt6W2vms+eCOFMhzkI6T/lYsINkhS3FDvcWIyrImVXAoTh80ioRUMgmuCYE13YeuR3V l+jJL2kHFnIt/4VdewPLerFUiAArHGgaIJsDDC+XL/CEse0cDT0J8qIrEmBWGP6YjWhcwCQcFpA AX2CcLiBA3TyFMPQRwdYMueFrhqoaci3ZN4r8SGDgJLa7Ahi
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It can happen that while a break is received the transmitter gets empty
and IIR signals a Transmitter holding register empty (THRI) event. In
this case it's too early for the break workaround. Still doing it then
results in the THRI event not being rereported which makes the driver
miss that and e.g. for RS485 half-duplex communication it fails to
switch back to RX mode.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250_fsl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 00f46b9a8b09..c12a4b4bd0f4 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -51,7 +51,8 @@ int fsl8250_handle_irq(struct uart_port *port)
 	 * immediately and interrupt the CPU again. The hardware clears LSR.BI
 	 * when the next valid char is read.)
 	 */
-	if (unlikely(up->lsr_saved_flags & UART_LSR_BI)) {
+	if (unlikely((iir & UART_IIR_ID) == UART_IIR_RLSI &&
+		     (up->lsr_saved_flags & UART_LSR_BI))) {
 		up->lsr_saved_flags &= ~UART_LSR_BI;
 		port->serial_in(port, UART_RX);
 		spin_unlock_irqrestore(&up->port.lock, flags);
-- 
2.39.2

