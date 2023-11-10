Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2CAC04A95
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjKJSHM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjKJSFY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:24 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D833A8AA
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 07:30:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT0-00065v-Ai; Fri, 10 Nov 2023 16:30:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSy-0083Im-7w; Fri, 10 Nov 2023 16:30:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TSx-00Gnuq-Uv; Fri, 10 Nov 2023 16:30:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>
Cc:     Richard GENOUD <richard.genoud@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yangtao Li <frank.li@vivo.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 02/52] serial: sccnxp: Improve error message if regulator_disable() fails
Date:   Fri, 10 Nov 2023 16:29:30 +0100
Message-ID: <20231110152927.70601-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=kBg/MDlr2mx1OX55pin6DcW9PLUaM0+0RakV/R8miMU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkxaEBLfHNY+5POSOi7cywgDOncYCsmUv7Rft kqdNAtYYTiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MWgAKCRCPgPtYfRL+ TqIqB/0dhjU2coVu1IhF1huBtkAuwO5F9zMrySYwuoTPj0M3p8rv49TMmDeitt/nTK2wyqbMVN2 xA3Of+iWDZtTq7L6OKDeCJ+SszjK/CFrreCvtZQdTv7brLtxQ/0VOSWpbCWgQysZAwNx0VxarbK mIXv7w0ctDi8xHyH+HSf/RlCSq08JwmrzCUQaRv2GQgZC1vdnh0xvGwUnFjxRpnm0BU97iiOGcx JHJmnUimTLIWiGuJyb9LLAYzteJr+9uCXIYHGZTdRX1G19Sv9ioUycsnQR41GXQFKKwFhVr2cm2 CD/9K/yJn2beUp+tJkVYRHTISwFf4p2/OXmyDQKQq+3Tvbny
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

and then remove the device anyhow.

So replace the error return (and with it the little helpful error
message) by a more useful error message.

Fixes: 31815c08fc90 ("serial: sccnxp: Replace pdata.init/exit with regulator API")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/sccnxp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 2be2c1098025..8269b0fb3083 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -1036,8 +1036,11 @@ static int sccnxp_remove(struct platform_device *pdev)
 
 	uart_unregister_driver(&s->uart);
 
-	if (!IS_ERR(s->regulator))
-		return regulator_disable(s->regulator);
+	if (!IS_ERR(s->regulator)) {
+		int ret = regulator_disable(s->regulator);
+		if (ret)
+			dev_err(&pdev->dev, "Failed to disable regulator\n");
+	}
 
 	return 0;
 }
-- 
2.42.0

