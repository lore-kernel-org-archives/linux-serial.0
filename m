Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332BAC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 13:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AC261269
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 13:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhIONVm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbhIONVl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Sep 2021 09:21:41 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99E7C0613DE
        for <linux-serial@vger.kernel.org>; Wed, 15 Sep 2021 06:20:22 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id uDLH2500s4C55Sk06DLHoU; Wed, 15 Sep 2021 15:20:20 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQUnf-004eT9-TO; Wed, 15 Sep 2021 15:18:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQUT7-002gSI-H7; Wed, 15 Sep 2021 14:56:53 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Scott Wood <oss@buserror.net>
Cc:     linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: 8250: SERIAL_8250_FSL should not default to y when compile-testing
Date:   Wed, 15 Sep 2021 14:56:52 +0200
Message-Id: <c5f8aa5c081755f3c960b86fc61c2baaa33edcd9.1631710216.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit b1442c55ce8977aa ("serial: 8250: extend compile-test coverage")
added compile-test support to the Freescale 16550 driver.  However, as
SERIAL_8250_FSL is an invisible symbol, merely enabling COMPILE_TEST now
enables this driver.

Fix this by making SERIAL_8250_FSL visible.  Tighten the dependencies to
prevent asking the user about this driver when configuring a kernel
without appropriate Freescale SoC or ACPI support.

Fixes: b1442c55ce8977aa ("serial: 8250: extend compile-test coverage")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Yes, it's ugly, but I see no better solution. Do you?

 drivers/tty/serial/8250/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 808268edd2e82a45..a2978b31144e94f2 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -361,9 +361,13 @@ config SERIAL_8250_BCM2835AUX
 	  If unsure, say N.
 
 config SERIAL_8250_FSL
-	bool
+	bool "Freescale 16550-style UART support (8250 based driver)"
 	depends on SERIAL_8250_CONSOLE
-	default PPC || ARM || ARM64 || COMPILE_TEST
+	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A || (ARM64 && ACPI) || COMPILE_TEST
+	default FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A || (ARM64 && ACPI)
+	help
+	  Selecting this option will add support for the 16550-style serial
+	  port hardware found on Freescale SoCs.
 
 config SERIAL_8250_DW
 	tristate "Support for Synopsys DesignWare 8250 quirks"
-- 
2.25.1

