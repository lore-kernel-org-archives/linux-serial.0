Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525C1C77B7A
	for <linux-serial@archiver.kernel.org>; Wed, 31 May 2023 06:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjEaGqU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 May 2023 02:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjEaGqT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 May 2023 02:46:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E476F129
        for <linux-serial@vger.kernel.org>; Tue, 30 May 2023 23:46:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4Fb1-0001G9-Rp; Wed, 31 May 2023 08:46:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4Faz-0042xO-UN; Wed, 31 May 2023 08:46:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4Faz-009jUV-Bw; Wed, 31 May 2023 08:46:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] serial: 8250: omap: mark uart_write() as maybe unused
Date:   Wed, 31 May 2023 08:46:08 +0200
Message-Id: <20230531064608.2401946-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MF89mQ2B9it9Zzg+LSLhfGleY8F6q6S7MLpI7fqtEaI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdu0v5TcBt19HwXjEbYX8NUMI/2/RG5/B3umhR EbV0hu+PvaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHbtLwAKCRCPgPtYfRL+ TjQnB/98d915gqlXUkeLR8YxmO1SeaQ7iqkKCnTvfZTNG9XotyhJydt35H83zXwJrVzSFviLkjF EDfehcsZ9PF8jxIdOrpM69F77uyAM0MZruWSJwYBuqOdCIAUJIr5rVsnohAVmyqH3LCTonLAn+1 C3d0JeAHxmmoNe+PAnbJhrrJ2E/3dyHBx1sjaEneht4fU0EtqSJ4ChvJzU3frlkeXNl2R7xkyyw jlfipOsQbpZZqIJpHCBZ3JIKQCDFEDzDH9HgaCK+2BRILWI0stFgesijINrixq1yphAYIys/LNb vCnzsIvmxwpGSUWC5Rtl7vz1sHOD6dr2Vb53dSRI+Hzt8K6S
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

uart_write() was introduced as a helper function that is for now only
used in omap8250_soft_reset(). The latter function is only defined if
CONFIG_PM is enabled. So add __maybe_unused to the defintion of the
former function to fix

	drivers/tty/serial/8250/8250_omap.c:169:13: error: ‘uart_write’ defined but not used [-Werror=unused-function]

for CONFIG_PM=n builds.

Fixes: 398cecc24846 ("serial: 8250: omap: Fix imprecise external abort for omap_8250_pm()")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

the offending commit is in tty-next.

Best regards
Uwe

 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 57981f48ae69..43a62e7d7387 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -166,7 +166,7 @@ static u32 uart_read(struct omap8250_priv *priv, u32 reg)
 	return readl(priv->membase + (reg << OMAP_UART_REGSHIFT));
 }
 
-static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
+static void __maybe_unused uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
 {
 	writel(val, priv->membase + (reg << OMAP_UART_REGSHIFT));
 }
-- 
2.39.2

