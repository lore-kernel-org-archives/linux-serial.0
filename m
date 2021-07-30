Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B8CC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 14:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CC760C3F
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 14:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbhG3Ot5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239530AbhG3Otp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 10:49:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991B4C061387
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 07:49:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id n2so13502993eda.10
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WRgr1XFp9FdAsbKP4Xd28JEjGpJQHHB0Nsl4r99ndU=;
        b=Ttd3PD4SOkqmgJ56xmVxk5y/kZqfeZKwZjt5/WRIFeZZ2Yp0sjaFyhcBKhWKm4vcZx
         JUFlWZh/n8JDtgEBEz/uJasK+IBWtqo8cGLyO3/QdS+pkzySyL7TOlJIwtw+5NftG3iw
         9VAbPtSsUQBwtr2vnpoF4MQ5KDtlc/U0udCEOdKRQmgT8AJwnwo6lfCcfpwjFsNdSU5Q
         vs20Ud3GX02VX6orIcQfu507dW+vwZ1xodAQySsSlVgXDioYkSfqV65APAW/wm0TSCM4
         Sz+Bh4gLoAS9RmHv/IiNmQrOX3vw5D0UkHMisMzjRgYavzMewUkoFT33Wi/IifsWIi8z
         lyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WRgr1XFp9FdAsbKP4Xd28JEjGpJQHHB0Nsl4r99ndU=;
        b=caHiLx1ShHuAffYu05sJ4lJYh2RcTfI8QNp92W9r3LLEKdzOyDchLHotI1CLRgnYQB
         kuQz7vVEU1qfh3izGn3KYdon89CXpAtHEN4esUACqa3m+ZOi7UQi2Quhh0uSkw+jpLwk
         a3bWAXzhcfHaL9ingisrqoA/jsQgRUeMhKGwjyFn3lwK/2PxsRaYy7Hh0uE4GWVyKYWT
         vogPwXsne8tXsSdxg5lbCeqY4d/N+q3Ru37cxpMy49u/8QMZn5OJzwOTlmo5X1Pq5fND
         C2RATD7L6/LtVxxt3IwbWwuo5+OKMQmc0aNO3DP7JrtOaQqwyH/0joxkmBACFYPUcJ9e
         6T5g==
X-Gm-Message-State: AOAM531kPapEBNoQsXAXcRU4LWlLt2w0+wQBEIbTFck+OzEg/VQdBU8F
        3/peYWN4GObuis1gMAfHKoPqkA==
X-Google-Smtp-Source: ABdhPJzBSmfdN5A0qvfcANUH9LVf5OKoEj7QlJx+dWqloqv6bPK9IUvS+zWPucHVRgKRKYsQvYUV0w==
X-Received: by 2002:a05:6402:49a:: with SMTP id k26mr3292136edv.279.1627656573161;
        Fri, 30 Jul 2021 07:49:33 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id i10sm784560edf.12.2021.07.30.07.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:49:32 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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
Subject: [PATCH 06/12] tty: serial: samsung: Add Exynos850 SoC data
Date:   Fri, 30 Jul 2021 17:49:16 +0300
Message-Id: <20210730144922.29111-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730144922.29111-1-semen.protsenko@linaro.org>
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
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
 drivers/tty/serial/samsung_tty.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 75ccbb08df4a..d059b516a0f4 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2814,11 +2814,19 @@ static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
 	.fifosize = { 64, 256, 16, 256 },
 };
 
+static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
+	EXYNOS_COMMON_SERIAL_DRV_DATA_USI(1),
+	.fifosize = { 0, },
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
@@ -2874,6 +2882,9 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	}, {
 		.name		= "s5l-uart",
 		.driver_data	= S5L_SERIAL_DRV_DATA,
+	}, {
+		.name		= "exynos850-uart",
+		.driver_data	= EXYNOS850_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -2897,6 +2908,8 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
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

