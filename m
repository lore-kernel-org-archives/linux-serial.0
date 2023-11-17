Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B732C072A2
	for <linux-serial@archiver.kernel.org>; Fri, 17 Nov 2023 10:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjKQKM5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Nov 2023 05:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKQKMz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Nov 2023 05:12:55 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C349C5
        for <linux-serial@vger.kernel.org>; Fri, 17 Nov 2023 02:12:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vqB-0003IM-KA; Fri, 17 Nov 2023 11:12:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vq9-009ejI-OR; Fri, 17 Nov 2023 11:12:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vq9-002zo1-FB; Fri, 17 Nov 2023 11:12:45 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Michal Simek <michal.simek@amd.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: xilinx_uartps: Fix kernel doc about .remove()'s return code
Date:   Fri, 17 Nov 2023 11:12:37 +0100
Message-ID: <20231117101236.878008-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IlfRtfw1bZn6P0M0eBlb7IowjX5BeTFe0EqT64Ibnds=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRwmyllTrFrwqL5lE2P3bY/NnnOrxrdVx6Lr1aybmT77 Znct3BjJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATCZrLwbBwq3SJUPC9b3p7 u98+TdzIonSul2+mnMX/oN7iU7rxyz4H5EjIsyX/3efbtJSjLK1KOmvVlcYVIc5MFy7FpMTVfMu Jzuw+ZB5tqio6T2ThtBqjc6ujtGNfZiwxc16fFM1udmSWzcLnl1b/Ou/FtXuJQMHHzzpsFpoJmx 3yXX2jdhV/Npg/6Xp0ttpp1cpPLZ3n5lmysWdyysXOkzFSW7fs1y65JG3RH4JcF0ztnbqVdVjmW LU2nToe/SFBZZ5In3L39ocy02Y1XHZJWnhP8kayvcGttqDqBqG9uWf8V++KrLoRvHqqmcSW6cz7 mZRn/UtR+2lfUuGqcifijV1K9q3kqLO3tY9K+iqJThQBAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since the driver was converted to use .remove_new() the return function
doesn't return a value any more. So remove the obsolete documentation
about the return value.

Reported-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

the patch converting to .remove_new is not yet applied, so I didn't
reference its commit id. It's available at

	https://lore.kernel.org/linux-serial/20231110152927.70601-53-u.kleine-koenig@pengutronix.de

and obviously this patch dropping the comment should get applied after
the conversion to void.

Best regards
Uwe

 drivers/tty/serial/xilinx_uartps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 6decf2b13340..920762d7b4a4 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1663,8 +1663,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 /**
  * cdns_uart_remove - called when the platform driver is unregistered
  * @pdev: Pointer to the platform device structure
- *
- * Return: 0 on success, negative errno otherwise
  */
 static void cdns_uart_remove(struct platform_device *pdev)
 {

base-commit: eff99d8edbed7918317331ebd1e365d8e955d65e
prerequisite-patch-id: 78ddb8b8246b06d5805c7dc8ad6481c7e4bc22c8
-- 
2.42.0

