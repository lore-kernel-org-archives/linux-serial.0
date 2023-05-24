Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F2AC7EE23
	for <linux-serial@archiver.kernel.org>; Wed, 24 May 2023 08:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbjEXI6g (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 04:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbjEXI6b (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 04:58:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9E19C
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 01:58:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1kK5-0007pd-7c; Wed, 24 May 2023 10:58:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1kK4-002RgD-2B; Wed, 24 May 2023 10:58:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1kK3-007Uyv-D5; Wed, 24 May 2023 10:58:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250: Apply FSL workarounds also without SERIAL_8250_CONSOLE
Date:   Wed, 24 May 2023 10:58:16 +0200
Message-Id: <20230524085816.474223-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LCB85oBeMDcb5M2YpxazRUmWqysAk0fNBO2hMJN4IEI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkbdGnRXUkZ5wUVpIS7rSiNQn5RxdCsVIO37bdW tpVLdC5JrmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG3RpwAKCRCPgPtYfRL+ TiVPCACmNTdvkbVpewQC3MZc4vfMGvTJLtE+gtmp/OeF8JJNArf3leQ21AnHmsxhCWj00Ufoklj SFt1mbZCBkQnishAw/6UB2Ymwg90T7ahB8/CcSPTe9C89EUnXqmVrcFVdvB5U6S2QY8yhLG69Iw qbX6Tmy93YZLhmXKV+BYBFfyeopDyf950FS61RKSJk3AitTIlCLVjh6g83g6QjUw0/Bf63wHaX/ /Soj58NjnA1nNpyYsh3uLN8bHk14UxUakfOu7eIf7Vxm1RNjCL3VlQ6LqkVO5pU6Gp1kaY2rzf3 Lollv7qKVY/c01Pf8u++rEvKRqLCQ8jVMb81kKZ7mrDwU8gY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The need to handle the FSL variant of 8250 in a special way is also
present without console support. So soften the dependency for
SERIAL_8250_FSL accordingly.

This issue was identified by Dominik Andreas Schorpp.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 5313aa31930f..10c09b19c871 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -378,7 +378,7 @@ config SERIAL_8250_BCM2835AUX
 
 config SERIAL_8250_FSL
 	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
-	depends on SERIAL_8250_CONSOLE
+	depends on SERIAL_8250
 	default PPC || ARM || ARM64
 	help
 	  Selecting this option enables a workaround for a break-detection

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

