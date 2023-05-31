Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05E5C77B73
	for <linux-serial@archiver.kernel.org>; Wed, 31 May 2023 08:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjEaIdG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 May 2023 04:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjEaIcl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 May 2023 04:32:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE7A107
        for <linux-serial@vger.kernel.org>; Wed, 31 May 2023 01:32:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4HFz-0001wy-G9; Wed, 31 May 2023 10:32:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4HFy-00444w-6A; Wed, 31 May 2023 10:32:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4HFx-009l0T-G9; Wed, 31 May 2023 10:32:33 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2] serial: 8250: Apply FSL workarounds also without SERIAL_8250_CONSOLE
Date:   Wed, 31 May 2023 10:32:30 +0200
Message-Id: <20230531083230.2702181-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=HotMsgaAS8RYds8I2cEQAKulJryFi6cODb48LI9j7HY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdwYdJtSLG/Jhsgx1Ro24MYA+wH2UE/NkBh63y vOuGeQUV5yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHcGHQAKCRCPgPtYfRL+ Tm02B/9A7tmSnKuA6aXBjhwV01j43WhRUatKA4W412ME/VYhWBajsNL3u3OhWsIRq8Q1SIV8WMn MuVuDqN8aG31tAERcYKbi6mcmrP78LQcxuTPZMAODrowo/C0YuRnW6m2F/gT3tKqfT4dzp6AbY+ pPYyQecD46thldnbEr2+P+RBJdv7UdGIbOtnYGFrbLlC4JsjrMQxo68ihXKgUfK/WRTtyQzDapG hVlghDQFD85sJ9531J1Mb1ovO9qi76JW/UaLvAJZH2Lv0prHpEckes91HBnmIUslrFJw2BBOkSS 6JolwMclPDKrwrHG3grBSdhIDQHvo1euQi9jgr3HNGBCwpr8
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

To cope for CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y, 8250_fsl.o
must be put in the same compilation unit as 8250_port.o because the
latter defines some functions needed in the former and so 8250_fsl.o
must not be built-in if 8250_port.o is available in a module.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

(implicit) v1 was already applied by Greg (a0807ca158e0 in tty-testing)
but that didn't handle CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y
correctly which was pointed out by the 0-day bot. (Thanks!)

That wasn't a problem before because SERIAL_8250_CONSOLE depends on
SERIAL_8250=y.

Having said that I wonder if there are a few more .o files that should
better be used with 8250_base-$(CONFIG_SERIAL_8250_XXX) instead of
obj-$(CONFIG_SERIAL_8250_XXX).

Best regards
Uwe

 drivers/tty/serial/8250/Kconfig  | 2 +-
 drivers/tty/serial/8250/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 4fc2fc1f41b6..37647ca79ec5 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
 8250_base-$(CONFIG_SERIAL_8250_PCILIB)	+= 8250_pcilib.o
+8250_base-$(CONFIG_SERIAL_8250_FSL)	+= 8250_fsl.o
 obj-$(CONFIG_SERIAL_8250_PARISC)	+= 8250_parisc.o
 obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
 obj-$(CONFIG_SERIAL_8250_EXAR)		+= 8250_exar.o
@@ -28,7 +29,6 @@ obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
 obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
 obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_PCI1XXXX)	+= 8250_pci1xxxx.o
-obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
 obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
 obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

