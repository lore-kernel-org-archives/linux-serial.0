Return-Path: <SRS0=7071=4A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAECAC3B189
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 16:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FD721739
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 16:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kopismobile-com.20150623.gappssmtp.com header.i=@kopismobile-com.20150623.gappssmtp.com header.b="BWrwfjKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgBLQf4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:35:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45700 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgBLQfz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Feb 2020 11:35:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so2500093otp.12
        for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2020 08:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kopismobile-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tY7FM+YqUS7N2tNsyLMK7x5uFSGC0ioulbSnD6rcjEg=;
        b=BWrwfjKX4OmgBlSq1N2hFgW9Yy/rb0UJaINhspqVJEfz5VfaKjRNKTf3hclkA0sNph
         /0dYfmCUUfuXtYwzs/jcRLInMp6NHZChrb+5c8ZBwGb+ehHNpdRXbPFdFf97MsER/aBZ
         w9/H9WsK57gpj55vIKkxyFpaVNVmyF9ONmQSWcdFoLDVy0oHbKMgPefn3eExj5ykCR3b
         ImbIee5/wdzn8s7SswBiUYJTwh/Ag0yHtxy0InHxguKOA919MKMremkKVQPWRj02HUp+
         BhlECMOKSzGTc5nsvw5Z4yzd/Q9vNZ1O9CAaWALLSUEZON4W8LRjD9K1+Xn0rVkw5P4z
         Rn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tY7FM+YqUS7N2tNsyLMK7x5uFSGC0ioulbSnD6rcjEg=;
        b=CVa9UA6leLFlekuj03eFWSBPKo5rDMoJmSUU2CidLo1lUACI4L2PiwW44jdX7xzeju
         qOemZmOZQ9SeA+KJqIejRzc//v4j0+YWnl0K56ggYwgMR14F66iqqVlpwvkAOckBwlKI
         YczY/TPZoCGPJ8M9pdJUQBIN/nI4IfJ7JQ4xRHHbtXQ4viLqaf9ATDJZlRG5G0G+etak
         5xSldFd+GBm70wd9RvLAaLZ33o2GWDrRKHmsXRWlzwkOXav/1JQqlEhApnwLIHKR2630
         PJZcNba88Fkgbqj8WCIQuEn1yq5ll0hx6UVdduNT5QURwcda0Z+2Gl7/3YM4chdgeb1W
         fkug==
X-Gm-Message-State: APjAAAVFNpeyrQm2JG3Ck8Bugn+GlBoEX2yfrQAh/P0F5XFwlZBCUCjp
        uzQk+Lxmpv+L9PFJz4+4CZP4kA==
X-Google-Smtp-Source: APXvYqy2lwhBxBYy5tU3gd4qcznyANtPRwbQkRXqeIfmvAUYGs0MvBHz5kTUBQ3grn9T5/EGMx/Wqw==
X-Received: by 2002:a9d:5786:: with SMTP id q6mr9558964oth.164.1581525355005;
        Wed, 12 Feb 2020 08:35:55 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id q22sm321034otf.17.2020.02.12.08.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 08:35:54 -0800 (PST)
From:   George Hilliard <ghilliard@kopismobile.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     George Hilliard <ghilliard@kopismobile.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de
Subject: [PATCH v3 2/2] tty: imx serial: Implement support for reversing TX and RX polarity
Date:   Wed, 12 Feb 2020 10:35:38 -0600
Message-Id: <20200212163538.3006-3-ghilliard@kopismobile.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212163538.3006-1-ghilliard@kopismobile.com>
References: <20200212163538.3006-1-ghilliard@kopismobile.com>
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

Signed-off-by: George Hilliard <ghilliard@kopismobile.com>
---
v1..v2: Remove confidentiality spam
v2..v3: Set *and* clear register, and do it before TX enable

 drivers/tty/serial/imx.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0c6c63166250..205627bcad66 100644
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
@@ -1390,8 +1392,22 @@ static int imx_uart_startup(struct uart_port *port)
 	ucr4 = imx_uart_readl(sport, UCR4) & ~UCR4_OREN;
 	if (!sport->dma_is_enabled)
 		ucr4 |= UCR4_OREN;
+	if (sport->inverted_rx)
+		ucr4 |= UCR4_INVR;
+	else
+		ucr4 &= ~UCR4_INVR;
 	imx_uart_writel(sport, ucr4, UCR4);
 
+	/*
+	 * configure tx polarity before enabling tx
+	 */
+	ucr3 = imx_uart_readl(sport, UCR3);
+	if (sport->inverted_tx)
+		ucr3 |= UCR3_INVT;
+	else
+		ucr3 &= ~UCR3_INVT;
+	imx_uart_writel(sport, ucr3, UCR3);
+
 	ucr2 = imx_uart_readl(sport, UCR2) & ~UCR2_ATEN;
 	ucr2 |= (UCR2_RXEN | UCR2_TXEN);
 	if (!sport->have_rtscts)
@@ -1405,10 +1421,6 @@ static int imx_uart_startup(struct uart_port *port)
 	imx_uart_writel(sport, ucr2, UCR2);
 
 	if (!imx_uart_is_imx1(sport)) {
-		u32 ucr3;
-
-		ucr3 = imx_uart_readl(sport, UCR3);
-
 		ucr3 |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
 
 		if (sport->dte_mode)
@@ -2184,6 +2196,12 @@ static int imx_uart_probe_dt(struct imx_port *sport,
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

