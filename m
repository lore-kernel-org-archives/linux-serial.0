Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB31BC636CD
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 14:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjBAOQ3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjBAOQ2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 09:16:28 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C48131E24
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 06:16:27 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id lu11so14505646ejb.3
        for <linux-serial@vger.kernel.org>; Wed, 01 Feb 2023 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+QI71SDLqYU1/ObAyQOpTSEtqikOAQsZZOXnStGri4=;
        b=pLD9W7EMIeyzAhYJ8VCIA4ag3xYM+szsQxVHyecdUbvei93o2CZAlIWCUrrJ1CFJ89
         4RBI7ZtQ6ygvmOTCC8s47iQgKJ8doqX7VDOMY5MSgtszWoy9/6Qjqbzs4smPvsXk7IrP
         cWwaGIERZJH611bcBn9C+gyBSH/27AmP2qgfe9ARQxW/OX7fq8y9d9ibzfuLCVEWS1NR
         sEDffUKNm2hpM2VwUVohqn8DEQdxZ9z6B5AUHWH19Uv+MSWdyBmSI3kHmOW08294qQzq
         uymMOGDylapJ9LZb3/ElPapW/r4oNnQnsdeig2uDTB3Q7CSygh/sbA2aNO2KfRF943/3
         6dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+QI71SDLqYU1/ObAyQOpTSEtqikOAQsZZOXnStGri4=;
        b=7AqzfHwac5WcQqC58UmH/7RC7IosLJ4HE/ko02aolGdzOUUhvB8ZTSB4ps3qb6eq1r
         acxQYAxzKS2kP6W+NLKKwLtfsQKncnZYroWvzYzJqmeNYB00lHRjvHAMI3dCbXIeA41d
         gSxb4AD1IkXSQoLTMJDvvTkKXL4Ad4DlyEjVOdTi655zdKahdiLq8yPKk0Unf0PXcy64
         aem3VNxoN2w/KfeQcXou32t32yVwBeD843IZ52qN6A9h/DA7HLE8UDQxMrYF8AEfx3UB
         Hsxd4q5Ag6dgab5xib3KdqeqrdcKP1GdzAWrxwzU54f9kHHKYg2JrQ7+nKMiiyzlpU8P
         Rd7w==
X-Gm-Message-State: AO0yUKWnR5hRnU2WiQl7L+8cvvdfioo8K2Pe5biwkwUFyL/eS7Q0WMdU
        rre4sCLapl5YcJ5MCQoiectDtu1HHTw=
X-Google-Smtp-Source: AK7set839G/LnYVz8SmQM0Cg+InJgI1jQOQz8bpVVNL1xT/EGxzzD/qDypvutV5D4bwyKLnZKiH4Bg==
X-Received: by 2002:a17:906:b7d7:b0:88d:fe1:1aca with SMTP id fy23-20020a170906b7d700b0088d0fe11acamr2569210ejb.34.1675260985848;
        Wed, 01 Feb 2023 06:16:25 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906b20700b0088478517830sm6500468ejz.83.2023.02.01.06.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:16:25 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
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
Subject: [PATCH RESEND] serial: imx: get rid of registers shadowing
Date:   Wed,  1 Feb 2023 17:16:03 +0300
Message-Id: <20230201141603.4205-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87bko4e65y.fsf@osv.gnss.ru>
References: <87bko4e65y.fsf@osv.gnss.ru>
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

