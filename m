Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4EFC433FE
	for <linux-serial@archiver.kernel.org>; Mon,  2 May 2022 09:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384175AbiEBJ3V (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 May 2022 05:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384222AbiEBJ3L (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 May 2022 05:29:11 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61773DEF0;
        Mon,  2 May 2022 02:25:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1BF76419BC;
        Mon,  2 May 2022 09:25:37 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [PATCH] tty: serial: samsung_tty: Fix suspend/resume on S5L
Date:   Mon,  2 May 2022 18:25:05 +0900
Message-Id: <20220502092505.30934-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We were restoring the IRQ masks then clearing them again, because
ucon_mask wasn't set properly. Adding that makes suspend/resume
work as intended.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/tty/serial/samsung_tty.c | 1 +
 include/linux/serial_s3c.h       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 12bf6b18847f..88a0b01ee9ab 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2840,6 +2840,7 @@ static const struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 		.num_clks	= 1,
 		.clksel_mask	= 0,
 		.clksel_shift	= 0,
+		.ucon_mask	= APPLE_S5L_UCON_MASK,
 	},
 	.def_cfg = {
 		.ucon		= APPLE_S5L_UCON_DEFAULT,
diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index f6c3323fc4c5..dec15f5b3dec 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -256,6 +256,9 @@
 #define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE | \
 					 S3C2410_UCON_RXIRQMODE | \
 					 S3C2410_UCON_RXFIFO_TOI)
+#define APPLE_S5L_UCON_MASK		(APPLE_S5L_UCON_RXTO_ENA_MSK | \
+					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK | \
+					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
 
 #define APPLE_S5L_UTRSTAT_RXTHRESH	(1<<4)
 #define APPLE_S5L_UTRSTAT_TXTHRESH	(1<<5)
-- 
2.35.1

