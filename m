Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BD3C433FE
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 21:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58BA23C91
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 21:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbgLIVsS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Dec 2020 16:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgLIVsI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 16:48:08 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F51C06179C
        for <linux-serial@vger.kernel.org>; Wed,  9 Dec 2020 13:47:28 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id l7so1403913qvt.4
        for <linux-serial@vger.kernel.org>; Wed, 09 Dec 2020 13:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QXz4XYGZ7MVBa0o5JVae3PaYd9AANj0sSm6oCFFci7g=;
        b=YuObmlgkmw9g1X3SYlk0035afYzulM5+4NAaFg6GUDTsMBLAf/AsNW9HR6ixqplHXL
         9AbkCN37qAYJ1Xi5wfUlKzNPhjIvCNxUrgXYXn/3fx4bKr/bUkiE4dwTbU9cIPs/l6eu
         /hp+uJdDGQd3xmGtO0Jcm//5U/sP3+mj/YF6zN7AsDfttLK2PSb3dzZirFq6OUx/WVeR
         yk8n7skOlDnLU+xI4nHG7hepwa8UqKB9MzwgVVf59egqn3nOaLkozCYhZBIFsv4EBOrl
         YsuwFKVdiTrEF49kTfKobiKMEesjhKcOVn2dZqZTURibhKJAbKP3755WfD2Vzc9Ajni+
         +TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QXz4XYGZ7MVBa0o5JVae3PaYd9AANj0sSm6oCFFci7g=;
        b=LStYpyokXzJXk1BjKL6psP1QmmXFyUAWCEXZvA0rMd2QYSVikt9VCNXUfd4aJ/1IXM
         MAaA3N+Mxw4eJjo07uO5HrW+raK3YLpttKGSuBg5jeZ3FUswblY8R4uSKE8pUcQldxOK
         dC8Dx1fQ+G4WHR1to5Hu1IJ8hwY0bbDZ4XTq0J5jv6JezKKD4exLEuzghFQcYp02vOZb
         4hdIQXvtON+8D5vPCiQmj0kyAkt9OUobtzJK/01LIZ4vl/T19RSQy+iDBcG69VLQ0d/O
         F+wHe/PPLhU0DmASR6YmTJOMSTzVr1MAwGzhyV1DxJG72vIuQPBnxEXIIon8J10coPhg
         IIPA==
X-Gm-Message-State: AOAM531+sRfCqGJ+pt+7oW+9gutZTNLIvCoeq0LGtbJvq90t2SNuVwYw
        8cIfickOBcwVgNAD70H6OFw=
X-Google-Smtp-Source: ABdhPJzcWJ4FraMnZRid9n1OCTvmd8SI4b9+fLxurmujBF9IilfYs10JVmobC30R1vDEBpfvefZWFQ==
X-Received: by 2002:a0c:e312:: with SMTP id s18mr5722694qvl.60.1607550447415;
        Wed, 09 Dec 2020 13:47:27 -0800 (PST)
Received: from localhost.localdomain ([177.194.79.136])
        by smtp.gmail.com with ESMTPSA id a35sm2065502qtk.82.2020.12.09.13.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 13:47:26 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     u.kleine-koenig@pengutronix.de, linux-serial@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: imx: Move imx_uart_probe_dt() content into probe()
Date:   Wed,  9 Dec 2020 18:47:12 -0300
Message-Id: <20201209214712.15247-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now that the driver only probes via devicetree, we can move the
content of imx_uart_probe_dt() directly into imx_uart_probe() to
make the code simpler.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/imx.c | 64 +++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 2452e57a5663..425624d794dd 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2163,44 +2163,6 @@ static struct uart_driver imx_uart_uart_driver = {
 	.cons           = IMX_CONSOLE,
 };
 
-/*
- * This function returns 0 iff it could successfully get all information
- * from dt or a negative errno.
- */
-static int imx_uart_probe_dt(struct imx_port *sport,
-			     struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	int ret;
-
-	sport->devdata = of_device_get_match_data(&pdev->dev);
-
-	ret = of_alias_get_id(np, "serial");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
-		return ret;
-	}
-	sport->port.line = ret;
-
-	if (of_get_property(np, "uart-has-rtscts", NULL) ||
-	    of_get_property(np, "fsl,uart-has-rtscts", NULL) /* deprecated */)
-		sport->have_rtscts = 1;
-
-	if (of_get_property(np, "fsl,dte-mode", NULL))
-		sport->dte_mode = 1;
-
-	if (of_get_property(np, "rts-gpios", NULL))
-		sport->have_rtsgpio = 1;
-
-	if (of_get_property(np, "fsl,inverted-tx", NULL))
-		sport->inverted_tx = 1;
-
-	if (of_get_property(np, "fsl,inverted-rx", NULL))
-		sport->inverted_rx = 1;
-
-	return 0;
-}
-
 static enum hrtimer_restart imx_trigger_start_tx(struct hrtimer *t)
 {
 	struct imx_port *sport = container_of(t, struct imx_port, trigger_start_tx);
@@ -2229,6 +2191,7 @@ static enum hrtimer_restart imx_trigger_stop_tx(struct hrtimer *t)
 
 static int imx_uart_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct imx_port *sport;
 	void __iomem *base;
 	int ret = 0;
@@ -2240,9 +2203,30 @@ static int imx_uart_probe(struct platform_device *pdev)
 	if (!sport)
 		return -ENOMEM;
 
-	ret = imx_uart_probe_dt(sport, pdev);
-	if (ret < 0)
+	sport->devdata = of_device_get_match_data(&pdev->dev);
+
+	ret = of_alias_get_id(np, "serial");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
 		return ret;
+	}
+	sport->port.line = ret;
+
+	if (of_get_property(np, "uart-has-rtscts", NULL) ||
+	    of_get_property(np, "fsl,uart-has-rtscts", NULL) /* deprecated */)
+		sport->have_rtscts = 1;
+
+	if (of_get_property(np, "fsl,dte-mode", NULL))
+		sport->dte_mode = 1;
+
+	if (of_get_property(np, "rts-gpios", NULL))
+		sport->have_rtsgpio = 1;
+
+	if (of_get_property(np, "fsl,inverted-tx", NULL))
+		sport->inverted_tx = 1;
+
+	if (of_get_property(np, "fsl,inverted-rx", NULL))
+		sport->inverted_rx = 1;
 
 	if (sport->port.line >= ARRAY_SIZE(imx_uart_ports)) {
 		dev_err(&pdev->dev, "serial%d out of range\n",
-- 
2.17.1

