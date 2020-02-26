Return-Path: <SRS0=ccOi=4O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90103C4BA2E
	for <linux-serial@archiver.kernel.org>; Wed, 26 Feb 2020 22:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6582524672
	for <linux-serial@archiver.kernel.org>; Wed, 26 Feb 2020 22:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kopismobile-com.20150623.gappssmtp.com header.i=@kopismobile-com.20150623.gappssmtp.com header.b="uVeg5G1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgBZWXg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:23:36 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37735 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgBZWXf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Feb 2020 17:23:35 -0500
Received: by mail-oi1-f195.google.com with SMTP id q84so1243934oic.4
        for <linux-serial@vger.kernel.org>; Wed, 26 Feb 2020 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kopismobile-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RPLfgfdP5zDOulU8s7N5lsoQDkFKIGOev+f922eUscI=;
        b=uVeg5G1oZk8D+V3xTFMCuz0ISw7HSSPLIO9RnG0sxM5HfLO1nPXP46ax+z/+FI7qXl
         bTBQbT+cYD1ne0Wbp142uSnJwocWbS/j0WNuSwlpAes0dQFpsjnUR+wEPlzw5bUH1Kyr
         /UcS1dG3UxfpKzaGAA3asPOj5d3lvLDUZ+i0IECC9ejPxVxbu79lJfakZUPI3c5zCnS1
         55/5t9b8YO1LZDrGc/3hhy/Mm/iEWvVArkD7IpwrDTeS76P69/71McudmB2afGXOVz/o
         1uJGqD7XoxbSh341c04Eb/q5me1MgpMPvtjD57SbCtrqJIil2DG6W23xo2792Ac1rvKJ
         q95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RPLfgfdP5zDOulU8s7N5lsoQDkFKIGOev+f922eUscI=;
        b=J9RHG8HmrqQLfuEAicRhICd7sMrKV1Xgwf8/GOoz2kvWUVpCXg0c2D4TjYFlKcu98W
         0bJpiK5I552FPg7Kt9eCPTdlHDH2jlsCH5uR/RZy2B09l9Su7wgCy31KbkzX/gFpl1D4
         TJ5go7Ju66HPzei1rZ2G7OGUWqKbxN4rPwELa129AaSd2kDxv+STvdnXwr3mdM2k97j/
         C+ZPV3ZIGE9DejwLJxrrbSKbJxZZtPvODRoKssLq7aa+Rgi+7ho0RreenCKFxasgFCbU
         A5F0GGcfY8azMQ7uwtjFpEMeCcwevMDYZ1psSB1Pa1mNYOT0z5hkhPuPITnTodL0HWkA
         bM0g==
X-Gm-Message-State: APjAAAWGDZ41zYzx6siEYEVypLH5ixm4fBtrs1yylhq76SB9RXzthbBZ
        vyfPr/Hc/WOdDNJmoF6RXKnxUQ==
X-Google-Smtp-Source: APXvYqzlndpuMjmqMjgCbmm5ty+ZIZelNp+YfcHV5dOWWBU2XRmTDq8hpb+DH6jAcKC1fLxAe/BpqA==
X-Received: by 2002:aca:55cc:: with SMTP id j195mr1049707oib.22.1582755814597;
        Wed, 26 Feb 2020 14:23:34 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id z21sm1237614oto.52.2020.02.26.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:23:34 -0800 (PST)
From:   George Hilliard <ghilliard@kopismobile.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     George Hilliard <ghilliard@kopismobile.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de
Subject: [PATCH v4 2/2] tty: imx serial: Implement support for reversing TX and RX polarity
Date:   Wed, 26 Feb 2020 16:23:19 -0600
Message-Id: <20200226222319.18383-3-ghilliard@kopismobile.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226222319.18383-1-ghilliard@kopismobile.com>
References: <20200226222319.18383-1-ghilliard@kopismobile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The peripheral has support for inverting its input and/or output
signals.  This is useful if the hardware flips polarity of the
peripheral's signal, such as swapped +/- pins on an RS-422 transceiver,
or an inverting level shifter.  Add support for these control registers
via the device tree binding.

As part of this change, make the writes of the various registers more
uniform by moving the UCR3 block up near the other registers' blocks,
since the INVT bit must be set before enabling the peripheral.

Signed-off-by: George Hilliard <ghilliard@kopismobile.com>
---
v1..v2: Remove confidentiality spam
v2..v3: Set *and* clear register, and do it before TX enable
v3..v4: Clean up bit manipulation; move UCR3 block so it's written once

 drivers/tty/serial/imx.c | 44 +++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0c6c63166250..81a981849a4b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -195,6 +195,8 @@ struct imx_port {
 	unsigned int		have_rtscts:1;
 	unsigned int		have_rtsgpio:1;
 	unsigned int		dte_mode:1;
+	unsigned int		inverted_tx:1;
+	unsigned int		inverted_rx:1;
 	struct clk		*clk_ipg;
 	struct clk		*clk_per;
 	const struct imx_uart_data *devdata;
@@ -1335,7 +1337,7 @@ static int imx_uart_startup(struct uart_port *port)
 	int retval, i;
 	unsigned long flags;
 	int dma_is_inited = 0;
-	u32 ucr1, ucr2, ucr4;
+	u32 ucr1, ucr2, ucr3, ucr4;
 
 	retval = clk_prepare_enable(sport->clk_per);
 	if (retval)
@@ -1387,11 +1389,29 @@ static int imx_uart_startup(struct uart_port *port)
 
 	imx_uart_writel(sport, ucr1, UCR1);
 
-	ucr4 = imx_uart_readl(sport, UCR4) & ~UCR4_OREN;
+	ucr4 = imx_uart_readl(sport, UCR4) & ~(UCR4_OREN | UCR4_INVR);
 	if (!sport->dma_is_enabled)
 		ucr4 |= UCR4_OREN;
+	if (sport->inverted_rx)
+		ucr4 |= UCR4_INVR;
 	imx_uart_writel(sport, ucr4, UCR4);
 
+	ucr3 = imx_uart_readl(sport, UCR3) & ~UCR3_INVT;
+	/*
+	 * configure tx polarity before enabling tx
+	 */
+	if (sport->inverted_tx)
+		ucr3 |= UCR3_INVT;
+
+	if (!imx_uart_is_imx1(sport)) {
+		ucr3 |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
+
+		if (sport->dte_mode)
+			/* disable broken interrupts */
+			ucr3 &= ~(UCR3_RI | UCR3_DCD);
+	}
+	imx_uart_writel(sport, ucr3, UCR3);
+
 	ucr2 = imx_uart_readl(sport, UCR2) & ~UCR2_ATEN;
 	ucr2 |= (UCR2_RXEN | UCR2_TXEN);
 	if (!sport->have_rtscts)
@@ -1404,20 +1424,6 @@ static int imx_uart_startup(struct uart_port *port)
 		ucr2 &= ~UCR2_RTSEN;
 	imx_uart_writel(sport, ucr2, UCR2);
 
-	if (!imx_uart_is_imx1(sport)) {
-		u32 ucr3;
-
-		ucr3 = imx_uart_readl(sport, UCR3);
-
-		ucr3 |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
-
-		if (sport->dte_mode)
-			/* disable broken interrupts */
-			ucr3 &= ~(UCR3_RI | UCR3_DCD);
-
-		imx_uart_writel(sport, ucr3, UCR3);
-	}
-
 	/*
 	 * Enable modem status interrupts
 	 */
@@ -2184,6 +2190,12 @@ static int imx_uart_probe_dt(struct imx_port *sport,
 	if (of_get_property(np, "rts-gpios", NULL))
 		sport->have_rtsgpio = 1;
 
+	if (of_get_property(np, "fsl,inverted-tx", NULL))
+		sport->inverted_tx = 1;
+
+	if (of_get_property(np, "fsl,inverted-rx", NULL))
+		sport->inverted_rx = 1;
+
 	return 0;
 }
 #else
-- 
2.25.0

