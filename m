Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA003C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 30 Mar 2022 10:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245552AbiC3Ksn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Mar 2022 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245509AbiC3Ksn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Mar 2022 06:48:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4673269A65
        for <linux-serial@vger.kernel.org>; Wed, 30 Mar 2022 03:46:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZVql-0002vD-V2; Wed, 30 Mar 2022 12:46:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZVqi-003y5z-1s; Wed, 30 Mar 2022 12:46:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZVqk-00Clkp-4a; Wed, 30 Mar 2022 12:46:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Tremblay <etremblay@distech-controls.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3 2/3] serial: 8250: Add UART_CAP_NOTEMT on PORT_16550A_FSL64
Date:   Wed, 30 Mar 2022 12:46:41 +0200
Message-Id: <20220330104642.229507-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de>
References: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=K1btnBsheqqL2r+halEAL+NhFIE9UIDtaxAsqMiE4Qo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiRDUGNUYUpPMilPOBLjVneQIC7dp/wRzqMs/TEdDl CDahg/qJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYkQ1BgAKCRDB/BR4rcrsCUDNB/ 95XlG3rp+fI+CYVTBoW2M4hRO+uP9HETlojW9NPv6Xicrb4vtwOZEHo+FWwJzJ5kPSBKQMs0BqX9UI mkCCelOiIHxDJPa0enUZdPO7nadCPbK2qblbQ1BE1YkCJnWAmEF5CDhTbsEG0N3Acu6IJiGhGsXulo FLt9kHeUkFhBalT1Vn3G+6q2YlY4+hy/R5HNgr+BnyLd3DDbUhJU17GKpUm1qY6dp+U6BmcuJULdD4 fglqqArxqtSEZ+7vlrKFLLjLStwiCsY+MMyFwiN0i/uS+ed+5UdVxWgBL+2BleNFaiovTqBPj3IkFC p+P0WXZ7yutXUIl1GJKX4GS8/NV59B
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Eric Tremblay <etremblay@distech-controls.com>

The Freescale variant of the 16550A doesn't have an interrupt on TEMT
available when using the FIFO mode.

Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 0af13b4c76a0..b9f252d24207 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -263,7 +263,7 @@ static const struct serial8250_config uart_config[] = {
 		.tx_loadsz	= 63,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
 				  UART_FCR7_64BYTE,
-		.flags		= UART_CAP_FIFO,
+		.flags		= UART_CAP_FIFO | UART_CAP_NOTEMT,
 	},
 	[PORT_RT2880] = {
 		.name		= "Palmchip BK-3103",
-- 
2.30.2

