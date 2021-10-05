Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF3C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 09:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E555761215
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 09:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhJEKAE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbhJEKAE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Oct 2021 06:00:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C186EC061745
        for <linux-serial@vger.kernel.org>; Tue,  5 Oct 2021 02:58:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n8so27960219lfk.6
        for <linux-serial@vger.kernel.org>; Tue, 05 Oct 2021 02:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rq7MKM2zrv9Ik3HYA0sfeiFO+Ud/aiQ0uN8CoLNzjP8=;
        b=q6xeJSXDEJCDu7zY5yhSM415ImPMMcJXjo5jezsYRWmGPbMU3MD9kDDhCzV8xbhh5J
         xuMucvdJ8sKJZQ9rq29tm0S7V0FTdEzd/dty+Z7IbagtQbFRaf6p5f8IOGfIk1tqbWYh
         /mGljqys/66QZoamXvHtEXjHm8AOLPxo99x26Dsrh3Kbtm9mbpx3cQcNji8t+en5PtOF
         EeTVWMIPYYeA7cU54LsXvZg/lcix3FPyEBW0m+61lAIdBBuG0TnqY0iSVxkt8tedVGEn
         rHhY+AcXYhBj4VURLrWv4Kft89rkEL7tqv2xZu1kLgdMp/cBH5dDbI0HQYCHHrtB9ecO
         AvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rq7MKM2zrv9Ik3HYA0sfeiFO+Ud/aiQ0uN8CoLNzjP8=;
        b=nlpgoYKJjpmM4GAljLtNuYSvA1KYcpnpxPlApLubl26l/eZzS+m3UE/C3tRJlDybAt
         EivEzdYO046H5eW8XUsC+FmkYqGewQfIqzT06NylGGLKNMmdZhGyTdfr/fNL7qffr1zZ
         XiPQ3OVd7YUqtQcrdZ3bluvcikF2voobBuunwWHQ+OfbUvTumYY/I1Imk9MBBUJKYq5A
         1nPHcGa2hrDVzTthl+tGg36cxMNMfBpgKO77lxQBdjPRIPLJHh24KvjLC3qUEcc1Ox99
         AlMqWbqounr+nGR14DD5utpiWo/iXX4mL0CWZ9es3jREHh538U70BTIP5r2y+ScQcGKF
         HoDQ==
X-Gm-Message-State: AOAM530D4LhE/3jHmtHFDZfRNWGcLJpmotHY0UZ/uPCwGOEWwSg8s98Y
        o20pR8RfXM3nXDyBEh0HGXzZKQ==
X-Google-Smtp-Source: ABdhPJztJNS0D67j+1Xh2JJk3ONd902XRoJ8JO2wypn685qKb8NkIEto9fs/OTRtiLIIdaA347rP9A==
X-Received: by 2002:a19:790c:: with SMTP id u12mr2535757lfc.490.1633427881861;
        Tue, 05 Oct 2021 02:58:01 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id b15sm2088546lji.126.2021.10.05.02.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 02:58:01 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: serial: samsung: Improve naming for common macro
Date:   Tue,  5 Oct 2021 12:58:00 +0300
Message-Id: <20211005095800.2165-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Having "_USI" suffix in EXYNOS_COMMON_SERIAL_DRV_DATA_USI() macro is
confusing. Rename it to just EXYNOS_COMMON_SERIAL_DRV_DATA() and provide
USI registers availability for all Exynos variants instead. While at it,
also convert .has_usi field type to bool, so its usage is more obvious.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Converted .has_usi field to boolean
  - Used true/false instead of 1/0 values in
    EXYNOS_COMMON_SERIAL_DRV_DATA() macro

 drivers/tty/serial/samsung_tty.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index e2f49863e9c2..ca084c10d0bb 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -65,7 +65,7 @@ enum s3c24xx_port_type {
 struct s3c24xx_uart_info {
 	char			*name;
 	enum s3c24xx_port_type	type;
-	unsigned int		has_usi;
+	bool			has_usi;
 	unsigned int		port_type;
 	unsigned int		fifosize;
 	unsigned long		rx_fifomask;
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
+	EXYNOS_COMMON_SERIAL_DRV_DATA(false),
 	.fifosize = { 256, 64, 16, 16 },
 };
 
 static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA,
+	EXYNOS_COMMON_SERIAL_DRV_DATA(false),
 	.fifosize = { 64, 256, 16, 256 },
 };
 
 static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA_USI(1),
+	EXYNOS_COMMON_SERIAL_DRV_DATA(true),
 	.fifosize = { 256, 64, 64, 64 },
 };
 
-- 
2.30.2

