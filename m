Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD89CA0EE2
	for <linux-serial@archiver.kernel.org>; Mon, 11 Sep 2023 21:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348731AbjIKVaZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjIKIzB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Sep 2023 04:55:01 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8F41A2
        for <linux-serial@vger.kernel.org>; Mon, 11 Sep 2023 01:54:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfch4-00050h-5s; Mon, 11 Sep 2023 10:54:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfch3-005VP3-Dv; Mon, 11 Sep 2023 10:54:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfch2-000cay-Iq; Mon, 11 Sep 2023 10:54:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] serial: imx: Simplify compatibility handling
Date:   Mon, 11 Sep 2023 10:54:51 +0200
Message-Id: <20230911085451.628798-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3198; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=kHSzMbdejvOtgW85iIxcMRjSOopIkDykzeNq4pyMxqk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk/tXafJkAEFw7jAb/+mrTTmvTfhKx4tkOlsSaK 43IrfmMBEOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZP7V2gAKCRCPgPtYfRL+ ToBUB/9M6OTjK2kzL/F5mraWt7sgIFsC0+WPzXj163f0jJWdqnDZeBqZH1ElsRs+AU5BREkUAyu TUJ8X9sAsWqiHPZ6FmE7h8SXKHsWqTjhzaNIgjnAvf+bPaNU4WeM+BCSB3ov77nMOY6H0xYOtd7 Garc5P1oB8oSCBBcR9GbLQ6lZ8EpnJYuIIgquEZPrQt2ak2qdlFtCBswACwI6aV3XhLOOFteJh3 YQ1Detx0WcXjrvyW7S7zgfhH7FFf9+ly/DfAOTLo4H7hDTaVRnmYyru6kTrKm5f2m5KnmU/C94R BCcvDAVDGHz/RAq7tvvvc/6BANGhbgH+kyRDEOO2WVXgoS9c
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Three of the four entries of imx_uart_devdata[] use .uts_reg =
IMX21_UTS. The difference in the .devtype member isn't relevant, the
only thing that matters is if is equal to IMX1_UART.

So use an entry with .devtype = IMX21_UART on all platforms but i.MX1.
There is no need to have the dev types in an array, so split them up in
two separate variables.

The fsl,imx53-uart devinfo can go away because in the binding and also
the dts files all fsl,imx53-uart devices also are compatible to
fsl,imx21-uart. That's not the case for fsl,imx6q-uart (which is a bit
strange IMHO), so the fsl,imx6q-uart must stay around.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this diff's idea appeared already in reply to a patch by Tom Rix that
became commit 7553574900f37847a25c4d572b13c512811604ed. I just found the
discussion[1] while cleaning up my inbox. This is a slightly improved
version.

Best regards
Uwe

[1] https://lore.kernel.org/linux-serial/20230318143041.n6rymackf6p776rq@pengutronix.de

 drivers/tty/serial/imx.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 13cb78340709..3d429f6fa048 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -177,8 +177,6 @@
 enum imx_uart_type {
 	IMX1_UART,
 	IMX21_UART,
-	IMX53_UART,
-	IMX6Q_UART,
 };
 
 /* device type dependent stuff */
@@ -240,30 +238,26 @@ struct imx_port_ucrs {
 	unsigned int	ucr3;
 };
 
-static struct imx_uart_data imx_uart_devdata[] = {
-	[IMX1_UART] = {
-		.uts_reg = IMX1_UTS,
-		.devtype = IMX1_UART,
-	},
-	[IMX21_UART] = {
-		.uts_reg = IMX21_UTS,
-		.devtype = IMX21_UART,
-	},
-	[IMX53_UART] = {
-		.uts_reg = IMX21_UTS,
-		.devtype = IMX53_UART,
-	},
-	[IMX6Q_UART] = {
-		.uts_reg = IMX21_UTS,
-		.devtype = IMX6Q_UART,
-	},
+static const struct imx_uart_data imx_uart_imx1_devdata = {
+	.uts_reg = IMX1_UTS,
+	.devtype = IMX1_UART,
+};
+
+static const struct imx_uart_data imx_uart_imx21_devdata = {
+	.uts_reg = IMX21_UTS,
+	.devtype = IMX21_UART,
 };
 
 static const struct of_device_id imx_uart_dt_ids[] = {
-	{ .compatible = "fsl,imx6q-uart", .data = &imx_uart_devdata[IMX6Q_UART], },
-	{ .compatible = "fsl,imx53-uart", .data = &imx_uart_devdata[IMX53_UART], },
-	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
-	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX21_UART], },
+	/*
+	 * For reasons unknown to me, some UART devices (e.g. imx6ul's) are
+	 * compatible to fsl,imx6q-uart, but not fsl,imx21-uart, while the
+	 * original imx6q's UART is compatible to fsl,imx21-uart. This driver
+	 * doesn't make any distinction between these two variants.
+	 */
+	{ .compatible = "fsl,imx6q-uart", .data = &imx_uart_imx21_devdata, },
+	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_imx1_devdata, },
+	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_imx21_devdata, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);

base-commit: 57c2dab5596a2bd0cda64fcc208efdefe296788f
-- 
2.40.1

