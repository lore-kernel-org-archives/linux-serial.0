Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1EAC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 17 Feb 2022 21:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiBQVTL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Feb 2022 16:19:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiBQVTK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Feb 2022 16:19:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9277EB1A
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 13:18:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nKoAq-0004BJ-7P; Thu, 17 Feb 2022 22:18:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nKoAp-00HFpX-Lv; Thu, 17 Feb 2022 22:18:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nKoAo-003qh0-5F; Thu, 17 Feb 2022 22:18:46 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH] serial: 8250: Return early in .start_tx() if there are no chars to send
Date:   Thu, 17 Feb 2022 22:18:39 +0100
Message-Id: <20220217211839.443039-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=DTFAoLO4qMGF9GtCYAnDbilENiByJeF+fO+foGcRPCU=; b=owEBbAGT/pANAwAKAcH8FHityuwJAcsmYgBiDrup9aGp1UXsd6xwMhidxsrYGWiUFi9pvMku2WFW mDdDGn6JATIEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYg67qQAKCRDB/BR4rcrsCWCfB/ iEH6PBaIr/LtbvNsEOGMwGEe5jsLyLdOX9OE7ieUaqM+Uv0TLSOoiSGgOSm3YTvEz4stAPaw8r+Qwo v1XMZQYd/zbDF5k5YnlLlXsxuW594aMiP+sVT9T3IfZDhmLlntcJl4flEHpwkjf5FOH5BrYk5WxWwS TleYyDunu+ipRVlrClW2mZ9sX7SaCXRP/INUKKwwSAbRsd1JRdr0w5HgOW/cvHJCjDyp+5uWupUBDB gHxk6o6gCU+wNjq1czhRjxVHNSGZmqJByTKnIW+lEYzkDs38jXaL2urQC0albAVRRyLA7oD6uVJUFh yG01etJJquFNIxeIfC/OdL0aL9gHU=
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Don't start the whole chain for TX if there is no data to send. This is
mostly relevant for rs485 mode as there might be rts-before-send and
rts-after-send delays involved.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

a few other drivers have such an early exit already (imx, stm32-usart).
I wonder if it applies to all UART drivers that there is nothing to do
in .start_tx() if the circ buffer is empty and there is no x_char to
send. In this case it would be more sensible to ensure in serial_core
that .start_tx() is only ever called if there is something to do.

Best regards
Uwe

 drivers/tty/serial/8250/8250_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3b12bfc1ed67..5d4668f12f71 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1657,6 +1657,9 @@ static void serial8250_start_tx(struct uart_port *port)
 
 	serial8250_rpm_get_tx(up);
 
+	if (!port->x_char && uart_circ_empty(&port->state->xmit))
+		return;
+
 	if (em485 &&
 	    em485->active_timer == &em485->start_tx_timer)
 		return;

base-commit: 754e0b0e35608ed5206d6a67a791563c631cec07
-- 
2.34.1

