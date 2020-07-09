Return-Path: <SRS0=9J3d=AU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FD5C433DF
	for <linux-serial@archiver.kernel.org>; Thu,  9 Jul 2020 13:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D8120708
	for <linux-serial@archiver.kernel.org>; Thu,  9 Jul 2020 13:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfE8rgv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgGIN4T (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgGIN4S (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Jul 2020 09:56:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53CFC08C5CE;
        Thu,  9 Jul 2020 06:56:18 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so1018552pgk.4;
        Thu, 09 Jul 2020 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h558bNdz+ALdoIojIxtZwctE+fRhBkDe5PAZGaAvP6U=;
        b=gfE8rgv9qIBnyKW/75JmtNyFErM6yZ/5v1BNZp17ZRVhmLS6VD6T/MsryG9qTXczSg
         LyphMEP2M7vaMSN6luQGosY5Y6sXO3rhFBUK9iJZKMygJafb8Ob+qKyTOmiW9CQgGhIx
         cKizsEU/JGEFzrxuZ2Zsg8FTM2r3O1Arhx7EwyPNQSsXeYr7c8+wzYKlV6i61VOgv7n9
         A4O2EdKUzmOtRTxMCEa6l7Bz9UWSPEPS1TShhwyr0e++5w3WK4697xaqh2Q4ae7du9Rz
         18mRIuv/+m/kwjDSupZ5ykxqyU+y5C/f3QaxcsOknGEnZ6iiTeWa7vLNFKAP7XkvU50B
         cPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h558bNdz+ALdoIojIxtZwctE+fRhBkDe5PAZGaAvP6U=;
        b=QSH3DTVqq6RuwMsHwC8mEn6Xu5uomKXtlSlIN1sxA9htjaQrta7F8WslWsSy/XqjFN
         TELAbT7AS6WTUT4gnjhh6612s66aRYUbf5YUbb6LSeUPbQteFcxc7+mEsA6jv1Co8yiz
         VFFm//RAnB7SG4aAm+eRCdvmjWxqR4uYC2Hya9n0ivQrKrx/ogy99KgKBChSOhYWHHwe
         qL6Uk/bWl5GNck3l/WH5N8KR0ltuRk/m6WZk+xbmQ7r6klNgf0B2QjNwf7cT5sVJ8Bjo
         NaxBrR2RH9AHjg8m8Qsu69/13geK7WmSIbltsYuClbQ/wkxyyziKrbGSUCGhS5gRqPHI
         kKAQ==
X-Gm-Message-State: AOAM5321ANN7feVKdeqtigkEgoSjC45OPZo2aZylvXaHZq0KuZmV6xp/
        L3GSGG78f08RwmSG0+UwJv8=
X-Google-Smtp-Source: ABdhPJx9jxxv75YnWC6v4T0SESzp6aFF4h7ok+oXm33OzoALrK0dC2u3FzFw0Oi6J/lLKcld3amVmg==
X-Received: by 2002:a62:84d5:: with SMTP id k204mr54550112pfd.66.1594302978512;
        Thu, 09 Jul 2020 06:56:18 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id o129sm2474929pfg.14.2020.07.09.06.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 06:56:17 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] serial: mxs-auart: add missed iounmap() in probe failure and remove
Date:   Thu,  9 Jul 2020 21:56:08 +0800
Message-Id: <20200709135608.68290-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This driver calls ioremap() in probe, but it misses calling iounmap() in 
probe's error handler and remove.
Add the missed calls to fix it.

Fixes: 47d37d6f94cc ("serial: Add auart driver for i.MX23/28")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Use iounmap() instead of devm_ioremap() to fix the bugs.
  - Modify the subject and the description.

 drivers/tty/serial/mxs-auart.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index b4f835e7de23..b784323a6a7b 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1698,21 +1698,21 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto out_disable_clks;
+		goto out_iounmap;
 	}
 
 	s->port.irq = irq;
 	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
 			       dev_name(&pdev->dev), s);
 	if (ret)
-		goto out_disable_clks;
+		goto out_iounmap;
 
 	platform_set_drvdata(pdev, s);
 
 	ret = mxs_auart_init_gpios(s, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize GPIOs.\n");
-		goto out_disable_clks;
+		goto out_iounmap;
 	}
 
 	/*
@@ -1720,7 +1720,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	 */
 	ret = mxs_auart_request_gpio_irq(s);
 	if (ret)
-		goto out_disable_clks;
+		goto out_iounmap;
 
 	auart_port[s->port.line] = s;
 
@@ -1746,6 +1746,9 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	mxs_auart_free_gpio_irq(s);
 	auart_port[pdev->id] = NULL;
 
+out_iounmap:
+	iounmap(s->port.membase);
+
 out_disable_clks:
 	if (is_asm9260_auart(s)) {
 		clk_disable_unprepare(s->clk);
@@ -1761,6 +1764,7 @@ static int mxs_auart_remove(struct platform_device *pdev)
 	uart_remove_one_port(&auart_driver, &s->port);
 	auart_port[pdev->id] = NULL;
 	mxs_auart_free_gpio_irq(s);
+	iounmap(s->port.membase);
 	if (is_asm9260_auart(s)) {
 		clk_disable_unprepare(s->clk);
 		clk_disable_unprepare(s->clk_ahb);
-- 
2.26.2

