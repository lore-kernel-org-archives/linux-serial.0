Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67474C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  7 Mar 2022 08:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiCGIJx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Mar 2022 03:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiCGIJw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Mar 2022 03:09:52 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6603C1ADAA
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 00:08:57 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 448193F1C9
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 08:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646640536;
        bh=eR7Mc9vi/w7iGpwa309YiCzl9zkdxojESdgSBLZGEv4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=R81s1GPZTAEF2514u2X0xKw4b7uAGvtb3FeA0YxRCL137tF3Z0Gf1o5/4jOoq0Q2/
         BVx3nsuNdFAMHnV7Pf1QsbGqfiVkIdFnScqoFBJLo1ywoMHb5B3oR9MFmJ34gXlI1p
         OktFSkqZvDEvd6a14akeyY30zfHi7KRG94+rypn/K7bSq2R20wzEIhR+rm0HkDsbA5
         7fCOg4m2Pm+zoTt+Uu6DIBoYsAJtHXu/nlkhYDOUnBTesc0Ey4RbPqNXYAx0t30d6h
         vozDpUduxkmDXa2EWvG1d1V2eLwSvKNH//m6d/xf84S715kyrH/yd0kAV9LW2cIdDw
         s4fNouITcRNFw==
Received: by mail-ej1-f71.google.com with SMTP id hx13-20020a170906846d00b006db02e1a307so1530935ejc.2
        for <linux-serial@vger.kernel.org>; Mon, 07 Mar 2022 00:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eR7Mc9vi/w7iGpwa309YiCzl9zkdxojESdgSBLZGEv4=;
        b=mdfJTxFwxnvy9ATcNXpn056lauJyeesThxNnF2ZOtzr6uSn8xuVELnPaJlczmQj6U5
         skgwvecSoLqrTsUGUT9+op3L0YTx7EcdBUnfRSL5ZL4m2GNjAOjzzf+EdJAiY3hUbl/l
         BKokOM5eWwTdKEY9BWgT+zbMSm+gIxI7vX54Y1QU3k2xwoBV6XUC8ciBVzGakt3lWRza
         1gIub2vxXBbMqAYpTWby3XC8rfi7FTVzEQPCl6Gv+Q0aXpjS7e6EAg0r5zHQiAFIEUL+
         /dtvHMOEuwx+MJ82m2TJzACbslicI6GxB1iq6d8aBmogjcXrza0vqubB8YVoCxUqSM0i
         a1Kw==
X-Gm-Message-State: AOAM5320zT0qHNKQmgm8c1VhmZhYm5W0oCFeXInK8zah7BP7Sq9mGXNB
        jQRsskOTuQe16O/uxJtUh1oulMRDK0D76vPWF6qBoNcGF/VtJldydAfLvtnWgrlcPGH51WyEJnT
        Ri6XuyRlfIQiuMCrT/BzjrRinXDhs1NUiMhD/l5hbug==
X-Received: by 2002:a17:907:d06:b0:6da:2902:e9ad with SMTP id gn6-20020a1709070d0600b006da2902e9admr8377710ejc.566.1646640535810;
        Mon, 07 Mar 2022 00:08:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCbsSDsaeQ5A3m0lusAuFH7GkNNgJvj5FHMB6/pMQ6cGRuCsKahqtP+fbfKW0QoSgQklboFw==
X-Received: by 2002:a17:907:d06:b0:6da:2902:e9ad with SMTP id gn6-20020a1709070d0600b006da2902e9admr8377700ejc.566.1646640535645;
        Mon, 07 Mar 2022 00:08:55 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906961500b006daac87ddb0sm3698300ejx.140.2022.03.07.00.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:08:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] tty: serial: samsung: embed s3c24xx_uart_info in parent structure
Date:   Mon,  7 Mar 2022 09:08:46 +0100
Message-Id: <20220307080852.53992-1-krzysztof.kozlowski@canonical.com>
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

