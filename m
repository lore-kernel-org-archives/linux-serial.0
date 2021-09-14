Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C79C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 14:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FB260EFF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 14:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhINOYg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhINOYf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 10:24:35 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28737C061574
        for <linux-serial@vger.kernel.org>; Tue, 14 Sep 2021 07:23:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y6so24260960lje.2
        for <linux-serial@vger.kernel.org>; Tue, 14 Sep 2021 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JujpZaikMMevY8hhCqH/hKO/zBJYMZ/j4U4Qz2KhW34=;
        b=sbR73ETHcJ0IxzzKe6OUCJ2Hs5twwz2oM13CzLwDXbh20/HlWA0gf0Cr/MTPpi4UOH
         fR3aJBjQQuTvFplnFmUiKL641yJPmwkTsaC/4ur99YPYrXuJUtd+vqI9sDp8ZRGI6/7D
         gxP1YQkrAo+NclbHesmraGMjIICYArX4QkOG8RoaCYuJV0LSqkB5adT1OImlBK4idWBg
         FOw7uqAEWCgmtMAHkg/eQLkLNMZnFv2TOivrbAcEYSdqx91YsfawPko0yiTQHgddJ7PN
         SOgKBQ77pU35/mXcrJeuTatWu8hCqsnmEzRR7R0apmmuzr2XfxqkXdU8SJGhTmmgGBXr
         P+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JujpZaikMMevY8hhCqH/hKO/zBJYMZ/j4U4Qz2KhW34=;
        b=T9oggwAiy8gDF74NQrl0HlquM8SDYA8rMk4gyVLBWH16dTA+zcsWOhReOzjGLW+Pia
         O/xnPEjk9Q2F3SCG6yBZ5jh7ryzj7GOfp+7r3uBSAJRKIicJe5Fy2/iPyXOfCWW/4bjs
         W52r7n8YSipmn9TZEBkI8EypdSrbbFDPO6IgxG2ls4G1zFz3v0I7WJUn5VmScHLEYpPV
         fdmhoguPkUUHsyWWCmEgX6+7unZAVO94ptD6OlfhIQptNs3ocaudrUGFFEUvxYlZAy8i
         MpugI3GnQPAREWuukxFYs88UjygNInazD5T67vTvntTBWMKOybSiCou8arNt3VCLIzEZ
         YZBA==
X-Gm-Message-State: AOAM532w5apv6qadkRW++E5a/SwgWclyC7Z2Y9GCh3BnDoGbSB2VWBMA
        wKhS6wUmxPsSTPJ30JBJ/i+WBw==
X-Google-Smtp-Source: ABdhPJzAjiJ0v7ayBbIHxT4Urg/v0A5EUKeXvz4EebS/7cNeA0bHkgoDOYpKn1i1YQw9w1HnrAImTQ==
X-Received: by 2002:a2e:b894:: with SMTP id r20mr15175355ljp.291.1631629396573;
        Tue, 14 Sep 2021 07:23:16 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id k12sm1318078ljm.65.2021.09.14.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:23:16 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: samsung: Improve naming for common macro
Date:   Tue, 14 Sep 2021 17:23:15 +0300
Message-Id: <20210914142315.26596-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Having "_USI" suffix in EXYNOS_COMMON_SERIAL_DRV_DATA_USI() macro is
confusing. Rename it to just EXYNOS_COMMON_SERIAL_DRV_DATA() and provide
USI registers availability for all Exynos variants instead.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index e2f49863e9c2..542b7e2b99dc 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2780,7 +2780,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 #endif
 
 #if defined(CONFIG_ARCH_EXYNOS)
-#define EXYNOS_COMMON_SERIAL_DRV_DATA_USI(_has_usi)		\
+#define EXYNOS_COMMON_SERIAL_DRV_DATA(_has_usi)			\
 	.info = &(struct s3c24xx_uart_info) {			\
 		.name		= "Samsung Exynos UART",	\
 		.type		= TYPE_S3C6400,			\
@@ -2804,21 +2804,18 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 		.has_fracval	= 1,				\
 	}							\
 
-#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
-	EXYNOS_COMMON_SERIAL_DRV_DATA_USI(0)
-
 static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA,
+	EXYNOS_COMMON_SERIAL_DRV_DATA(0),
 	.fifosize = { 256, 64, 16, 16 },
 };
 
 static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA,
+	EXYNOS_COMMON_SERIAL_DRV_DATA(0),
 	.fifosize = { 64, 256, 16, 256 },
 };
 
 static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA_USI(1),
+	EXYNOS_COMMON_SERIAL_DRV_DATA(1),
 	.fifosize = { 256, 64, 64, 64 },
 };
 
-- 
2.30.2

