Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFBDC433FE
	for <linux-serial@archiver.kernel.org>; Mon,  7 Mar 2022 08:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiCGIJR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Mar 2022 03:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiCGIJQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Mar 2022 03:09:16 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BEE193C1
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 00:08:22 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 50A263F222
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 08:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646640501;
        bh=eR7Mc9vi/w7iGpwa309YiCzl9zkdxojESdgSBLZGEv4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GQu7LJDK2krr29AH+bK//llfgxyqSmq6XMk4JYubDMCfDeFxwMRRxJt1H1wfyQQjO
         XYFus14KNCwtiAruo3qUl0VoOJwtZ7Qw7Dd9fmtCSmSPBrXPGzUotGTbEU7yjuL6Tx
         ONGnaaESCXN9huK/lL5hm44LYUDyD3lYdiSmNeythvj0OwIiDRquzFVyqZhHe5fcLf
         xffQq/hYLke6HHU0iEERafEUwWngCJkqBZC3zhskQ5VFwL9BI6G5YNTCHkgUb0FjYt
         SwoHDB+EpUOqMylQPCtPDVB3g4MPhzaDNDOz9HpXiHTysfonAAypynDYFJnKF2dLYX
         QMOts8zQfKjMg==
Received: by mail-ej1-f70.google.com with SMTP id hq34-20020a1709073f2200b006d677c94909so6634114ejc.8
        for <linux-serial@vger.kernel.org>; Mon, 07 Mar 2022 00:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eR7Mc9vi/w7iGpwa309YiCzl9zkdxojESdgSBLZGEv4=;
        b=bItPHM6/1i6DIWAi1C3JTCvDoitJVRIc7h7wHSdKamFT6ZSdFjnv/XcbQBZDQ5B5jR
         CgBaoTKBkkMZCfYic9UGbpqjbOTqaYITkm9/ThjClTgxV/p0g2Mx+CQSLe9KClvqUQQj
         pITBunmfpT7XTQ2TYKlm3xPWdk6Yh4tS8sezPYtG2Ldw0ffrYFPvEMCIC33kH2DeSW90
         /ue3jpHgp9qV7qbeFtPulqwZNA7sD216HilVJVy23Q0DMigo/0BBeD4ZtuHDJQi2h654
         4AIDaYJYEJBB5WqgX5OBY1ArefHcMIIYnaYtLWsQv/eR249RXltH/X5+CMp86h/m/MdJ
         LWQg==
X-Gm-Message-State: AOAM530VQQohQVtZFmtNNkOinbKuFvZypM+QC/39yaLPJvWdzqCipkyr
        jx9mJQ7bdMNLHPRk9f+70YLqwJh2zapWmhBPI8YGDqWu51bAJTUvpaskwPcd3P7lXUKk82dMHI1
        dlGG7C9C1RYQq88yJLFMZcDTqCReqHFubt3VSrFJ0Ig==
X-Received: by 2002:a05:6402:239b:b0:415:a36e:99c0 with SMTP id j27-20020a056402239b00b00415a36e99c0mr9870071eda.283.1646640500563;
        Mon, 07 Mar 2022 00:08:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpUqnQcFhltzbiTgvk4iIo+PNlDFJdT98Fxk5y0pBKW8l18KW8SAiAS4UDqIaBE1SiIT6jnQ==
X-Received: by 2002:a05:6402:239b:b0:415:a36e:99c0 with SMTP id j27-20020a056402239b00b00415a36e99c0mr9870056eda.283.1646640500396;
        Mon, 07 Mar 2022 00:08:20 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fs6-20020a170907600600b006da8ec6e4a6sm4444584ejc.26.2022.03.07.00.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:08:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] tty: serial: samsung: embed s3c24xx_uart_info in parent structure
Date:   Mon,  7 Mar 2022 09:08:04 +0100
Message-Id: <20220307080810.53847-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Embed "struct s3c24xx_uart_info" directly as a member of "struct
s3c24xx_serial_drv_data" instead of keeping it as a pointer.  This makes
the code clearer (obvious ownership of "struct s3c24xx_serial_drv_data")
and saves one pointer.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d002a4e48ed9..aa5678d03704 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -85,7 +85,7 @@ struct s3c24xx_uart_info {
 };
 
 struct s3c24xx_serial_drv_data {
-	struct s3c24xx_uart_info	*info;
+	struct s3c24xx_uart_info	info;
 	struct s3c2410_uartcfg		*def_cfg;
 	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
 };
@@ -2197,7 +2197,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	}
 
 	ourport->baudclk = ERR_PTR(-EINVAL);
-	ourport->info = ourport->drv_data->info;
+	ourport->info = &ourport->drv_data->info;
 	ourport->cfg = (dev_get_platdata(&pdev->dev)) ?
 			dev_get_platdata(&pdev->dev) :
 			ourport->drv_data->def_cfg;
@@ -2616,7 +2616,7 @@ static struct console s3c24xx_serial_console = {
 
 #ifdef CONFIG_CPU_S3C2410
 static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
+	.info = {
 		.name		= "Samsung S3C2410 UART",
 		.type		= TYPE_S3C24XX,
 		.port_type	= PORT_S3C2410,
@@ -2644,7 +2644,7 @@ static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
 
 #ifdef CONFIG_CPU_S3C2412
 static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
+	.info = {
 		.name		= "Samsung S3C2412 UART",
 		.type		= TYPE_S3C24XX,
 		.port_type	= PORT_S3C2412,
@@ -2674,7 +2674,7 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2416) || \
 	defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2442)
 static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
+	.info = {
 		.name		= "Samsung S3C2440 UART",
 		.type		= TYPE_S3C24XX,
 		.port_type	= PORT_S3C2440,
@@ -2704,7 +2704,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 
 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
 static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
+	.info = {
 		.name		= "Samsung S3C6400 UART",
 		.type		= TYPE_S3C6400,
 		.port_type	= PORT_S3C6400,
@@ -2733,7 +2733,7 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 
 #ifdef CONFIG_CPU_S5PV210
 static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
+	.info = {
 		.name		= "Samsung S5PV210 UART",
 		.type		= TYPE_S3C6400,
 		.port_type	= PORT_S3C6400,
@@ -2762,7 +2762,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 
 #if defined(CONFIG_ARCH_EXYNOS)
 #define EXYNOS_COMMON_SERIAL_DRV_DATA()				\
-	.info = &(struct s3c24xx_uart_info) {			\
+	.info = {						\
 		.name		= "Samsung Exynos UART",	\
 		.type		= TYPE_S3C6400,			\
 		.port_type	= PORT_S3C6400,			\
@@ -2811,7 +2811,7 @@ static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
 
 #ifdef CONFIG_ARCH_APPLE
 static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
+	.info = {
 		.name		= "Apple S5L UART",
 		.type		= TYPE_APPLE_S5L,
 		.port_type	= PORT_8250,
-- 
2.32.0

