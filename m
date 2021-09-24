Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A730EC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 24 Sep 2021 07:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C526610CB
	for <linux-serial@archiver.kernel.org>; Fri, 24 Sep 2021 07:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbhIXHON (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Sep 2021 03:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244273AbhIXHOL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Sep 2021 03:14:11 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E37C061574
        for <linux-serial@vger.kernel.org>; Fri, 24 Sep 2021 00:12:38 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:5dd8:9bc4:3752:5710])
        by michel.telenet-ops.be with bizsmtp
        id xjCa2500R2gynNa06jCbKk; Fri, 24 Sep 2021 09:12:36 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mTfNq-008Vby-Du; Fri, 24 Sep 2021 09:12:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mTfNp-007LME-W1; Fri, 24 Sep 2021 09:12:34 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Scott Wood <oss@buserror.net>
Cc:     linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] serial: 8250: SERIAL_8250_FSL should depend on Freescale platforms
Date:   Fri, 24 Sep 2021 09:12:31 +0200
Message-Id: <a6965debdb725a1684569209fd97b1a65fecd6d6.1632467477.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6421f256407262afd658ffa74ec9430581528a7d.1632467477.git.geert+renesas@glider.be>
References: <6421f256407262afd658ffa74ec9430581528a7d.1632467477.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Freescale 16550-style UART is only present on some Freescale SoCs.
Hence tighten the dependencies to prevent asking the user about this
driver, and possibly defaulting it to be enabled, when configuring a
kernel without appropriate Freescale SoC or ACPI support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Split in two parts.
---
 drivers/tty/serial/8250/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 0af96f3adab517f6..a2978b31144e94f2 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -363,7 +363,8 @@ config SERIAL_8250_BCM2835AUX
 config SERIAL_8250_FSL
 	bool "Freescale 16550-style UART support (8250 based driver)"
 	depends on SERIAL_8250_CONSOLE
-	default PPC || ARM || ARM64
+	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A || (ARM64 && ACPI) || COMPILE_TEST
+	default FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A || (ARM64 && ACPI)
 	help
 	  Selecting this option will add support for the 16550-style serial
 	  port hardware found on Freescale SoCs.
-- 
2.25.1

