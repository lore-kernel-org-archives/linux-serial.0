Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16984C432BE
	for <linux-serial@archiver.kernel.org>; Fri,  6 Aug 2021 15:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E975361179
	for <linux-serial@archiver.kernel.org>; Fri,  6 Aug 2021 15:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244745AbhHFPXB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Aug 2021 11:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244568AbhHFPWR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Aug 2021 11:22:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520CEC06139E
        for <linux-serial@vger.kernel.org>; Fri,  6 Aug 2021 08:21:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p38so18723893lfa.0
        for <linux-serial@vger.kernel.org>; Fri, 06 Aug 2021 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjAidQVjPnsdyg/2uwjvZwZUIqwFqOyk06P5z8n6Pdk=;
        b=w3bhoI9TaLN9+BaimUNJdAjGiFas7439LuvvPO8mNbDlicCeKyi4nWUx/VModoGVzN
         61TIDRksKmXIdADyvk9S+YFXan+9/kjvEYf3AT1cHXjR1QwcLNnZIfdrk2gvkAntlfV0
         K6VwycLQ+HSAwMMNXhyCL8a/tsA/9BBPnetOkQUJ3KcTOOPcAaVz5dizGOtSvHyK8Djh
         qHmWrZ6bEOKg7WWM+e+yCt5InvbFG4U0tOMwUbx1BAAPc2SrzbF24cASRp1V0p0VxckO
         YMqy9bkGMPPR2828C4oShzaEi9rck++WFZT/2nXpJ2Ou+jXfmrn1XYbpwTEtaHD0ulfS
         vivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjAidQVjPnsdyg/2uwjvZwZUIqwFqOyk06P5z8n6Pdk=;
        b=qkAyJxTjg7mvacGT1pXVsSy7ZuJwNCyVE9vsexxvQWQpN8BpnyAaTkBwns01qfoR9g
         nAwjUxH2pkQ/fajTmCbTy/k4NAvBT5BiAc/SadHMVVdNFHeXL1wshTvwzbUrz0/VZ2g+
         wt1+5s+xQxKemFBRE4MFIykv1ToMN1c/R7FfimbK47e1jqmOISKh/5VlB4kUvOhnCoPr
         46GFiomf82oYLF5J2XSfoHNqj44+PkoS7w47maw3ZaCLF0uicGntXWZ2DGu7DRDXsgyg
         1ZmyTk668MF+7ijHB/YfgU7zAYC00VilwA4yrfrGqmY1s5iSbUNo+VLHRvVcVC7rKV8E
         9PWA==
X-Gm-Message-State: AOAM532khPslDL2YSqXRR2JLSf6POrW2t9N9K36L483Gm/hlpYEiApfj
        6pzUW+Wz2H4x63ow/K2hbemarw==
X-Google-Smtp-Source: ABdhPJyNqJD0uINMyeXLyFGbH4gPkm7zTB1xHT/l74cQsoPIXDTz+BX+WJCAjByqRpZnZpbWyOCjsw==
X-Received: by 2002:ac2:5087:: with SMTP id f7mr7702795lfm.43.1628263317657;
        Fri, 06 Aug 2021 08:21:57 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id j18sm861634lfg.65.2021.08.06.08.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 08:21:57 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 6/8] tty: serial: samsung: Add Exynos850 SoC data
Date:   Fri,  6 Aug 2021 18:21:44 +0300
Message-Id: <20210806152146.16107-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210806152146.16107-1-semen.protsenko@linaro.org>
References: <20210806152146.16107-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add serial driver data for Exynos850 SoC. This driver data is basically
reusing EXYNOS_COMMON_SERIAL_DRV_DATA, which is common for all Exynos
chips, but also enables USI init, which was added in previous commit:
"tty: serial: samsung: Init USI to keep clocks running".

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Fixed default fifo sizes

 drivers/tty/serial/samsung_tty.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 130bdc978e93..a069e7bb858f 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2813,11 +2813,19 @@ static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
 	.fifosize = { 64, 256, 16, 256 },
 };
 
+static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
+	EXYNOS_COMMON_SERIAL_DRV_DATA_USI(1),
+	.fifosize = { 256, 64, 64, 64 },
+};
+
 #define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos4210_serial_drv_data)
 #define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos5433_serial_drv_data)
+#define EXYNOS850_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos850_serial_drv_data)
+
 #else
 #define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
+#define EXYNOS850_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif
 
 #ifdef CONFIG_ARCH_APPLE
@@ -2873,6 +2881,9 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	}, {
 		.name		= "s5l-uart",
 		.driver_data	= S5L_SERIAL_DRV_DATA,
+	}, {
+		.name		= "exynos850-uart",
+		.driver_data	= EXYNOS850_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -2896,6 +2907,8 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 		.data = (void *)EXYNOS5433_SERIAL_DRV_DATA },
 	{ .compatible = "apple,s5l-uart",
 		.data = (void *)S5L_SERIAL_DRV_DATA },
+	{ .compatible = "samsung,exynos850-uart",
+		.data = (void *)EXYNOS850_SERIAL_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
-- 
2.30.2

