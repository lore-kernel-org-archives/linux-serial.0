Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC0C4167B
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 17:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjKJRom (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjKJRn6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 12:43:58 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7103A8AD
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSz-00065S-Bj; Fri, 10 Nov 2023 16:30:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSy-0083Ih-2G; Fri, 10 Nov 2023 16:30:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSx-00Gnun-P1; Fri, 10 Nov 2023 16:30:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Thomas Richard <thomas.richard@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 01/52] serial: 8250: omap: Don't skip resource freeing if pm_runtime_resume_and_get() failed
Date:   Fri, 10 Nov 2023 16:29:29 +0100
Message-ID: <20231110152927.70601-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jhxKH06aKU7oNg7h3QPQ9KuF9O89H8Ag15BPAaTV/K4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQ/n0iTd1dLRA8dVb/RzW+1/C/bK4/8CeK1iw1cu2yDO p/qTkvoZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiGms4GGYaqbRLvZ0z6YtL vVlu3fP1u/a8+jZZOfTGDovpQne/vHRNmiSsv8/RfMK7SOeaV7ujBXgL8iW3zVRNqU1hlZR9kVe 5afFaqT+FO/frv7ktHr3iZ0vh6/d5Dpo9/gUu3d+uaTYIsPb6cm5wvsulI2Hm3vC5JW+W69GX4Z 38Ezb3+xkXXq52WeUz8ZzSji3dD+8IGD53Z7FPNXxxrcLC/aOPw/uC+RmL2uonTNG8/EsipWeuV xEPb3nIvYmRSxl22a6uMGmYxL9iVfH/iUqX0wov9h8UqFyQKr2KTaXqp87pmfwWZgv2fMvstlzg bNHDO/cyZ9C7Sce5lVMEz+aln3G32XPpna2fhLH1p6bdAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Returning an error code from .remove() makes the driver core emit the
little helpful error message:

	remove callback returned a non-zero value. This will be ignored.

and then remove the device anyhow. So all resources that were not freed
are leaked in this case. Skipping serial8250_unregister_port() has the
potential to keep enough of the UART around to trigger a use-after-free.

So replace the error return (and with it the little helpful error
message) by a more useful error message and continue to cleanup.

Fixes: e3f0c638f428 ("serial: 8250: omap: Fix unpaired pm_runtime_put_sync() in omap8250_remove()")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 2d42f485c987..661a83dbc11b 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1592,7 +1592,7 @@ static int omap8250_remove(struct platform_device *pdev)
 
 	err = pm_runtime_resume_and_get(&pdev->dev);
 	if (err)
-		return err;
+		dev_err(&pdev->dev, "Failed to resume hardware\n");
 
 	up = serial8250_get_port(priv->line);
 	omap_8250_shutdown(&up->port);
-- 
2.42.0

