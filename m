Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4547C4338F
	for <linux-serial@archiver.kernel.org>; Wed, 11 Aug 2021 11:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D7060C3E
	for <linux-serial@archiver.kernel.org>; Wed, 11 Aug 2021 11:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbhHKLth (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Aug 2021 07:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbhHKLtE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Aug 2021 07:49:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B29C06139E
        for <linux-serial@vger.kernel.org>; Wed, 11 Aug 2021 04:48:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z11so3244647edb.11
        for <linux-serial@vger.kernel.org>; Wed, 11 Aug 2021 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EmrLgkupVqTxc8/L9lxZYrujbcXsZpYLC0Uzd5BaWr4=;
        b=mEfotTU+4tEz1nqSr+lmns404cQ18u7hfJyZbjftAT2+YzIAkrV92eW1pwFYc+wWfb
         6imwjRL4TRfc0RKuSV6SWqnCi41hQpOWLy8gn/RzXr33PwhXmkcpMBbBjOlz3k85TEMC
         r4U31IkAXDxL/i+h/XQKsy7tVZoqfbR5hBwk9zx0uZeSh9S5rHnA91KuUlbXHxDCi1+Z
         2bCgkItJGUMVuZerKlmfupT4aKwaVHcZT8CKcrxraPpMOsCKwSVswF9xeoCrlJkj21Xx
         cLrmLzMfBo+Z8Amoro0etyM/RVS8OeYQkop58ySADJ9qPd1uXS8Jb3ZSQ8hEGMPdCrwd
         A0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EmrLgkupVqTxc8/L9lxZYrujbcXsZpYLC0Uzd5BaWr4=;
        b=t5nTkPSvHz+ZOol5+xaHiv9ojEKAo3hE/S2R1Y/2rH+h/1W2JaNz3ho9Qja+D6J3xR
         eoc9rmkM2fgNTC5UK2vqkTHzDXRjJ1S8Spej5uYk/J7rOzp7SSCxh9VTtJhmpF/zgPep
         uvdRcD45Ch7ud03JYvBmMmr1jGmgYM6JbzaDS4X65NC3mGl86ldsTmN09fBbiOKUmpeX
         P/3c1o6qMD0lOe7Ho1KUIPpM6kOwWtB9T0Q0G9qo0xfrJaJbiEKR63KEty2A2czg3Erm
         4BFXLuxwSzdJnZjyNlBBec/owQIgUQ7l8wJ3YK2cTc4QyiibrZ+Y+an4mV6tjAhi8cy/
         9qnw==
X-Gm-Message-State: AOAM533k3P6LxmzzOKtNPtxEgxivTNT/JbI2bhrlIXJ2/q1NK3j4w+zu
        FLp4yMJsOOGFOWikftyK17ar4g==
X-Google-Smtp-Source: ABdhPJzqXam1/Gn0LDYoJXt+4Sip2QlyRr/ZQ9sne5m8mRxq5wCggub4M+7avgPRrfTnLLNB5JUq7w==
X-Received: by 2002:aa7:dcd1:: with SMTP id w17mr10745160edu.322.1628682518340;
        Wed, 11 Aug 2021 04:48:38 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id x13sm8113077ejv.64.2021.08.11.04.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 04:48:37 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v3 6/7] tty: serial: samsung: Add Exynos850 SoC data
Date:   Wed, 11 Aug 2021 14:48:26 +0300
Message-Id: <20210811114827.27322-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811114827.27322-1-semen.protsenko@linaro.org>
References: <20210811114827.27322-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add serial driver data for Exynos850 SoC. This driver data is basically
reusing EXYNOS_COMMON_SERIAL_DRV_DATA, which is common for all Exynos
chips, but also enables USI init, which was added in previous commit:
"tty: serial: samsung: Init USI to keep clocks running".

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - Added Reviewed-by tag by Krzysztof

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

