Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC51EC55ABD
	for <linux-serial@archiver.kernel.org>; Tue, 10 Nov 2020 21:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB0B20797
	for <linux-serial@archiver.kernel.org>; Tue, 10 Nov 2020 21:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOzPzprf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbgKJVsw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbgKJVsv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Nov 2020 16:48:51 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B84C0613D1
        for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2020 13:48:51 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id n63so9772972qte.4
        for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2020 13:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BFnE7m/0e2dpTn8Zuq9hfpxUQTwL+mvUw8y/3Xbpj6w=;
        b=LOzPzprfsWPWCRHmvVohf4YS90Qk5vEQIthkmKXe4jIPw9e4WOpF1H9aOkbYeYAanB
         yOVoj/c+XS/o+2/jdBPxErR7Qjxwwkps6eShJw6anZOz1NC+RZfbpHuCBjmv6jDVr77u
         UTW9hynKhFaFVGuoq+sJI4jCsktnh4m0mQ0t3cmanatZooBZ945VsDx8FEkhJnL939Yt
         Y4otIN+fyTl2YHV+cGTV211bF1HmdN/cWrcD7Ow6dIlM6C/q7hevMy/+fhjV/7fsL3sZ
         3lphr8TEwuBIy2oiNWY9eCS7cjUhpaFpRWQHwdg68LvAz8ElLoXQUW9Ajkg5STo7jJ75
         IyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BFnE7m/0e2dpTn8Zuq9hfpxUQTwL+mvUw8y/3Xbpj6w=;
        b=s6uXIIaectLYYlnhyXOswgtlB1TQmNv56sj4D/8S9msWyVOG7W6iQQWvR+0FWulSPV
         /cecNImlWYtRW2lX5H4QE9HRmwTiszWFxuGHoLqfIxOd9/ARE1d8/tuQrRE4annmWjne
         2m9qoLeeaStIHagbdpxWjGz+zQ+XeTrGNwuVQv7VUY6b3UZmDe3QHcWJpT+cmOA6iCLT
         9ydAi4aMkuNGC2fn22xipeE8s8vfpBUfwxaHq3GgvJwYlzLVOfriekTje9ZTgpSAdgbU
         SyS+g/7vF4XzaihrP3yTV6C/BIazgWoCFIwDxL73GpeBnSS2qkDEVJBibSajR9/rIVIm
         iPXQ==
X-Gm-Message-State: AOAM530or0Xgt/iqCLjTD9JTFN/dpIuHq9imjgCByBc30SKBKHiDJN7X
        4Hxt5lfsIAKo4NSwgR3E7YQ=
X-Google-Smtp-Source: ABdhPJzXrKcGkbRLrt7hlkkQaOg5mdGDmRYLYh/EQLLkGP47shSkUGoWwwXJNh7UpraamNRhvE0NWw==
X-Received: by 2002:ac8:53c8:: with SMTP id c8mr20492918qtq.39.1605044930652;
        Tue, 10 Nov 2020 13:48:50 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:997:69a4:dc84:4b91:560e])
        by smtp.gmail.com with ESMTPSA id a7sm171265qth.41.2020.11.10.13.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:48:49 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     s.hauer@pengutronix.de, linux-serial@vger.kernel.org,
        fugang.duan@nxp.com, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: imx: Remove unused platform data support
Date:   Tue, 10 Nov 2020 18:48:40 -0300
Message-Id: <20201110214840.16768-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since 5.10-rc1 i.MX is a devicetree-only platform and the existing
platform data support in this driver was only useful for old non-devicetree
platforms.

Get rid of the platform data support since it is no longer used.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/imx.c                 | 32 +++---------------------
 include/linux/platform_data/serial-imx.h | 15 -----------
 2 files changed, 3 insertions(+), 44 deletions(-)
 delete mode 100644 include/linux/platform_data/serial-imx.h

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1731d9728865..7ce38ade9a8e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -30,7 +30,6 @@
 #include <linux/dma-mapping.h>
 
 #include <asm/irq.h>
-#include <linux/platform_data/serial-imx.h>
 #include <linux/platform_data/dma-imx.h>
 
 #include "serial_mctrl_gpio.h"
@@ -2191,10 +2190,9 @@ static struct uart_driver imx_uart_uart_driver = {
 	.cons           = IMX_CONSOLE,
 };
 
-#ifdef CONFIG_OF
 /*
- * This function returns 1 iff pdev isn't a device instatiated by dt, 0 iff it
- * could successfully get all information from dt or a negative errno.
+ * This function returns 0 iff it could successfully get all information
+ * from dt or a negative errno.
  */
 static int imx_uart_probe_dt(struct imx_port *sport,
 			     struct platform_device *pdev)
@@ -2232,28 +2230,6 @@ static int imx_uart_probe_dt(struct imx_port *sport,
 
 	return 0;
 }
-#else
-static inline int imx_uart_probe_dt(struct imx_port *sport,
-				    struct platform_device *pdev)
-{
-	return 1;
-}
-#endif
-
-static void imx_uart_probe_pdata(struct imx_port *sport,
-				 struct platform_device *pdev)
-{
-	struct imxuart_platform_data *pdata = dev_get_platdata(&pdev->dev);
-
-	sport->port.line = pdev->id;
-	sport->devdata = (struct imx_uart_data	*) pdev->id_entry->driver_data;
-
-	if (!pdata)
-		return;
-
-	if (pdata->flags & IMXUART_HAVE_RTSCTS)
-		sport->have_rtscts = 1;
-}
 
 static enum hrtimer_restart imx_trigger_start_tx(struct hrtimer *t)
 {
@@ -2295,9 +2271,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = imx_uart_probe_dt(sport, pdev);
-	if (ret > 0)
-		imx_uart_probe_pdata(sport, pdev);
-	else if (ret < 0)
+	if (ret < 0)
 		return ret;
 
 	if (sport->port.line >= ARRAY_SIZE(imx_uart_ports)) {
diff --git a/include/linux/platform_data/serial-imx.h b/include/linux/platform_data/serial-imx.h
deleted file mode 100644
index 0844b21372c7..000000000000
--- a/include/linux/platform_data/serial-imx.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2008 by Sascha Hauer <kernel@pengutronix.de>
- */
-
-#ifndef ASMARM_ARCH_UART_H
-#define ASMARM_ARCH_UART_H
-
-#define IMXUART_HAVE_RTSCTS (1<<0)
-
-struct imxuart_platform_data {
-	unsigned int flags;
-};
-
-#endif
-- 
2.17.1

