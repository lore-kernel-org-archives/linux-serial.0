Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD1CC4332F
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7158F6121F
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 13:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhIONVm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhIONVl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Sep 2021 09:21:41 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A0C061575
        for <linux-serial@vger.kernel.org>; Wed, 15 Sep 2021 06:20:20 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id uDLH2500X4C55Sk01DLHEo; Wed, 15 Sep 2021 15:20:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQUnf-004eT9-UZ; Wed, 15 Sep 2021 15:18:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQULw-002gJr-1V; Wed, 15 Sep 2021 14:49:28 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: 8250: SERIAL_8250_EM should depend on ARCH_RENESAS
Date:   Wed, 15 Sep 2021 14:49:22 +0200
Message-Id: <7b5a4bbf2f47b2c4c127817e8b1524a650795d97.1631710085.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Emma Mobile integrated serial port hardware is only present on Emma
Mobile SoCs.  Hence add a dependency on ARCH_RENESAS, to prevent asking
the user about this driver when configuring a kernel without Renesas
ARM32 SoC support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/8250/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 71ae16de0f90e06f..808268edd2e82a45 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -376,7 +376,7 @@ config SERIAL_8250_DW
 config SERIAL_8250_EM
 	tristate "Support for Emma Mobile integrated serial port"
 	depends on SERIAL_8250 && HAVE_CLK
-	depends on ARM || COMPILE_TEST
+	depends on (ARM && ARCH_RENESAS) || COMPILE_TEST
 	help
 	  Selecting this option will add support for the integrated serial
 	  port hardware found on the Emma Mobile line of processors.
-- 
2.25.1

