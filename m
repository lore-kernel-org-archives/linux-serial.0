Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5456BC4167D
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjKJRx3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKJRwq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:46 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146073AE1D
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:31:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-0006Yc-Ry; Fri, 10 Nov 2023 16:30:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-0083Lu-5i; Fri, 10 Nov 2023 16:30:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-00GnyA-Sn; Fri, 10 Nov 2023 16:30:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Timur Tabi <timur@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: [PATCH 51/52] serial: ucc: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:19 +0100
Message-ID: <20231110152927.70601-52-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=1i8KT+sh7QtkRDn6szKY9xL97sdpwMK7Je2MNdk5bn0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQ/n+keJw9FvldhWW778kewBkupye3qT/5WqkxLxK9Zb MxYf2VHJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATuR3P/lfgSfgf1VPeWVbN scFyGyYeKHWMXT99z8xfkdW3XkZU/X28fMLnAof23gJH0825/UlGknvaKwS+hGapxKzm2fDqmJL 6/TYVxrbK+sadn/wduFy5b857FqmgEa1fuiX7/CXjeVqVEnkbbU6dDeYw8BFnC/jU4F1sO4s9ue k/z5FlkXvdm3erPRW0+7/uUMYuuYrLpzQ9m0uvfFUOv/z27tZ2Y5nzH/PkxH97qN++wXuBu7i/L 1+qYkLz4dh/C1o37pnw78JT5+eBcrNefdnxni+r8ATP0yTVfP9ZjdIcERlP196MY3jt8szfRSWy skfU5ljdXoVlk/SXNs4XvVn5pz3kxMVzPm41HIvbrDilAQ==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/ucc_uart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index ed7a6bb5596a..f9ad942c9aaf 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1459,7 +1459,7 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	return ret;
 }
 
-static int ucc_uart_remove(struct platform_device *ofdev)
+static void ucc_uart_remove(struct platform_device *ofdev)
 {
 	struct uart_qe_port *qe_port = platform_get_drvdata(ofdev);
 
@@ -1470,8 +1470,6 @@ static int ucc_uart_remove(struct platform_device *ofdev)
 	of_node_put(qe_port->np);
 
 	kfree(qe_port);
-
-	return 0;
 }
 
 static const struct of_device_id ucc_uart_match[] = {
@@ -1492,7 +1490,7 @@ static struct platform_driver ucc_uart_of_driver = {
 		.of_match_table    = ucc_uart_match,
 	},
 	.probe  	= ucc_uart_probe,
-	.remove 	= ucc_uart_remove,
+	.remove_new 	= ucc_uart_remove,
 };
 
 static int __init ucc_uart_init(void)
-- 
2.42.0

