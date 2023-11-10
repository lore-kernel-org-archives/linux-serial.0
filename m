Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D2EC4167D
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 19:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbjKJTeQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 14:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbjKJTdt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 14:33:49 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5803A8A1
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT3-0006IC-R3; Fri, 10 Nov 2023 16:30:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT2-0083K2-DI; Fri, 10 Nov 2023 16:30:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT2-00GnwE-4E; Fri, 10 Nov 2023 16:30:44 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thierry Reding <treding@nvidia.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 22/52] serial: mcf: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:29:50 +0100
Message-ID: <20231110152927.70601-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=W4XsmYFJxgg5UoSpd5wt0+1zbZT9b59ZQ4WpnAGkUao=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxwrpnQWOST4y+GntTBg4/8PS/vtYvUYrtP8 haS4rjvUSuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5McAAKCRCPgPtYfRL+ TkXaCACRAJqMl4tLUT6BsAoU/IIZP8MYFw9Fx2NdvIuughJxa0kyGvPquGnlvxmzETYzQsbqHPE b9w3oJmKgQ9F8XbiPEYMYboNu7yahFbvTM/7hxb4ZxO0L+gGK0g5/bRIfrwilXbU7Fukm0PlQMx T7jfiS68XXmO0WynSI2/pcNQMlwXkL90kpnY/nmUvqh1ZZoEaQwHc/BxaHTDAbJoCcFm9r8+pry MinjDkWT2gTTUvFHHlIfBSBcNw/lA/00qaUDdsrYDSbMTHikZOeJ3U1xLb8dGuABUlXDqbH0Dgc XTC/x7unPrlNIpmYS3qK/XA1AiE408C2c5MWRK6vZMXR11vl
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
 drivers/tty/serial/mcf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 91b15243f6c6..8690a45239e0 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -627,7 +627,7 @@ static int mcf_probe(struct platform_device *pdev)
 
 /****************************************************************************/
 
-static int mcf_remove(struct platform_device *pdev)
+static void mcf_remove(struct platform_device *pdev)
 {
 	struct uart_port *port;
 	int i;
@@ -637,15 +637,13 @@ static int mcf_remove(struct platform_device *pdev)
 		if (port)
 			uart_remove_one_port(&mcf_driver, port);
 	}
-
-	return 0;
 }
 
 /****************************************************************************/
 
 static struct platform_driver mcf_platform_driver = {
 	.probe		= mcf_probe,
-	.remove		= mcf_remove,
+	.remove_new	= mcf_remove,
 	.driver		= {
 		.name	= "mcfuart",
 	},
-- 
2.42.0

