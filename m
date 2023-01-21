Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F3AC54E94
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 21:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjAUVbj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 16:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUVbi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 16:31:38 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28175233EA
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 13:31:37 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v10so10499653edi.8
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 13:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+QI71SDLqYU1/ObAyQOpTSEtqikOAQsZZOXnStGri4=;
        b=Eawxr8Z3/Pnsn63vEEHJN3W33dvb7DcKmINAll3LAKomsZT3LwFyBtk57L7Jbta/fl
         0mqHruCX0oQlroWQdyK0B+gajbNF5wacgb7TkeknuiZ4DGY5KbgLhK0cE0qy0/zW2aYz
         NUx08X9rNg1ZXKh/wvN7MxTNH3SQTL/nzJyN/DzHwArZI1VFS4G5HKLqBe8NAQ5aRAr4
         ne4kbQ+mZ70ciIp8cP2U7P4mbJE6NjsZBhGd8sryxLz/+xRJdeR4FKyDePg5lgflSjH3
         EULhQhegqSsgyk4IitRfMNu4/5OeGaKXXC90nhxVZUnUM//8a87oX6VljMd1uQL5NzGS
         YDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+QI71SDLqYU1/ObAyQOpTSEtqikOAQsZZOXnStGri4=;
        b=AQFtKJXftQbth8Z8jXo1yERhkf6rVI4wflrbhkaZMJvpvjELbE/jqDDB/pf5t8VA+W
         XF+3W6wkxOtBBqzJ3hfa1XiW48pHkGI22kYeJ/L6tbT8dzo485TkqjxAX3hl7jeiL+em
         353eONl1VOZKtv+MpRxbdC+U9jRXIDN1LUI/9dYSli157b76ZNjsr77ncoxXzKuo8uxc
         7nSnsqdXWhNmrod1skXSPHADGu9QuRrigc8ZUL+z0COjo3M3SX7F3djJOhdf0Z2/PL6o
         g1vMw7dGKL/Kk20KGtBwY6msOw792eXwUfyZWdSKSM7vay5Ybn/Z3qThyIct3FAqKKX8
         Oa6g==
X-Gm-Message-State: AFqh2ko4KdlkuZBKNNpW6xoujp2Y/TOEOhcD9b+r0D/WHRBk3MFUn2ID
        HPKwaKH+Pp/ufyT8gWc9f1CV39hd66s=
X-Google-Smtp-Source: AMrXdXtH/nBGJKdjfpfX208LFVYXldFkuCkgrnbQsaW6RAsPoId1R+iXy7dX8yLQytuVLG8/Wxv7nQ==
X-Received: by 2002:aa7:cd69:0:b0:499:bffb:7e58 with SMTP id ca9-20020aa7cd69000000b00499bffb7e58mr32782283edb.20.1674336695396;
        Sat, 21 Jan 2023 13:31:35 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w1-20020aa7dcc1000000b0047a3a407b49sm19217515edu.43.2023.01.21.13.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:31:34 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] serial: imx: get rid of registers shadowing
Date:   Sun, 22 Jan 2023 00:30:43 +0300
Message-Id: <20230121213043.16314-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Neither registers shadowing is functionally needed as all the registers are
read-write, nor the shadowing makes much sense for speed-up, as most speed
critical reads/writes (of data Rx/Tx registers) are not shadowed anyway.
Moreover, the shadowing code is obviously pure overhead on the write path.

Get rid of the shadowing code and variables due to above considerations.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---

NOTE: This patch is extracted from patch series "[PATCH 0/8] serial: imx:
work-around for hardware RX flood, and then isr improvements" due to
objection of Uwe Kleine-König <u.kleine-koenig@pengutronix.de>. I still
believe this is an improvement, so I re-submit the patch separately.

 drivers/tty/serial/imx.c | 65 ++--------------------------------------
 1 file changed, 3 insertions(+), 62 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 757825edb0cd..f4e2db21d0fe 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -210,13 +210,6 @@ struct imx_port {
 
 	struct mctrl_gpios *gpios;
 
-	/* shadow registers */
-	unsigned int ucr1;
-	unsigned int ucr2;
-	unsigned int ucr3;
-	unsigned int ucr4;
-	unsigned int ufcr;
-
 	/* DMA fields */
 	unsigned int		dma_is_enabled:1;
 	unsigned int		dma_is_rxing:1;
@@ -273,59 +266,14 @@ static const struct of_device_id imx_uart_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);
 
-static void imx_uart_writel(struct imx_port *sport, u32 val, u32 offset)
+static inline void imx_uart_writel(struct imx_port *sport, u32 val, u32 offset)
 {
-	switch (offset) {
-	case UCR1:
-		sport->ucr1 = val;
-		break;
-	case UCR2:
-		sport->ucr2 = val;
-		break;
-	case UCR3:
-		sport->ucr3 = val;
-		break;
-	case UCR4:
-		sport->ucr4 = val;
-		break;
-	case UFCR:
-		sport->ufcr = val;
-		break;
-	default:
-		break;
-	}
 	writel(val, sport->port.membase + offset);
 }
 
-static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
+static inline u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 {
-	switch (offset) {
-	case UCR1:
-		return sport->ucr1;
-		break;
-	case UCR2:
-		/*
-		 * UCR2_SRST is the only bit in the cached registers that might
-		 * differ from the value that was last written. As it only
-		 * automatically becomes one after being cleared, reread
-		 * conditionally.
-		 */
-		if (!(sport->ucr2 & UCR2_SRST))
-			sport->ucr2 = readl(sport->port.membase + offset);
-		return sport->ucr2;
-		break;
-	case UCR3:
-		return sport->ucr3;
-		break;
-	case UCR4:
-		return sport->ucr4;
-		break;
-	case UFCR:
-		return sport->ufcr;
-		break;
-	default:
-		return readl(sport->port.membase + offset);
-	}
+	return readl(sport->port.membase + offset);
 }
 
 static inline unsigned imx_uart_uts_reg(struct imx_port *sport)
@@ -2340,13 +2288,6 @@ static int imx_uart_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* initialize shadow register values */
-	sport->ucr1 = readl(sport->port.membase + UCR1);
-	sport->ucr2 = readl(sport->port.membase + UCR2);
-	sport->ucr3 = readl(sport->port.membase + UCR3);
-	sport->ucr4 = readl(sport->port.membase + UCR4);
-	sport->ufcr = readl(sport->port.membase + UFCR);
-
 	ret = uart_get_rs485_mode(&sport->port);
 	if (ret) {
 		clk_disable_unprepare(sport->clk_ipg);

base-commit: 40c18f363a0806d4f566e8a9a9bd2d7766a72cf5
-- 
2.30.1

