Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B62C433DB
	for <linux-serial@archiver.kernel.org>; Mon, 18 Jan 2021 15:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E1C22C9D
	for <linux-serial@archiver.kernel.org>; Mon, 18 Jan 2021 15:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405315AbhARPZK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Jan 2021 10:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393469AbhARPZB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Jan 2021 10:25:01 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663A1C061573
        for <linux-serial@vger.kernel.org>; Mon, 18 Jan 2021 07:24:21 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id j26so11454710qtq.8
        for <linux-serial@vger.kernel.org>; Mon, 18 Jan 2021 07:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dges+8rc9mC60Dzdsn4EOhtdZ0f0IJQqf0D6xNtM6zw=;
        b=gz6tsWjsAxvp6EbYqrezkrSOYiC8tsGAmvmCZD/wYa47kkBrxDs9JrPdukIPTdEjN1
         NBCpw8Vy8WsUhtkqii9xiWG7DD4ZFpHQ8RchtWQS06sgcKDszIaBSXoZyT5UoTzVHRYi
         s96u2j6+ONEyYZL4DD8MzmBXXVjLsNFLo8w6WaSasIP2mgdf97gjROhRiGb8polsxUS0
         REV5lQm2nucWIGEjeHJFgxCWR+qsKjPV1yAzbudSJR84U1R0OOP2xb9abwhrTW7B5dNI
         SB29qokMYPq7CKIeSPXmVbPBrcCdPFhBSdwRHBdoXYGr6rNPBUcmfVrBEewGmLSTZRZy
         6OxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dges+8rc9mC60Dzdsn4EOhtdZ0f0IJQqf0D6xNtM6zw=;
        b=A5ZACZI5ZF1QCUvnlcqSaUcQ6DrPb5ylay8nSYrMBeCyxEENLF2TdPAz7kg8J0h/XX
         2rG1WcM0cfogS8m27wzqIH0VdYlCMWv6MVWVrgiWR/31qP7qLEK4zxAX7aL2YT4KRLua
         Y2Y5lGhy/Dr8FUeDJBgNZaitSzTu+jcOGJGyL3zqfWROXdz1CTWyY2ZDA91c5ih/RKtS
         JTunajq0ZQBHDjcyBAopyPOZiy4FMt9r1zdFBPkypdN+SP39cxjJ0/BJj/gIzskANBoz
         jBC/hiMBfyn5T+0POjhaA/7YQBevAPljOLCEHzq0BW6fG4eq+IKTZ9MGfogDatRfaURh
         5TpA==
X-Gm-Message-State: AOAM530xEExPp2qlx+d3mW+GelNdViHqP2l8ReoHD0xuSfURPdrDF4l5
        S2Q3WdipbB06BzVYPQQ8/mZxghmlzYg=
X-Google-Smtp-Source: ABdhPJwXP3XBbNZfd7qnbgKQFFqR09bNMRtHfgfPVwf08Kxui+KUjryqh5lO05T/qhu0Uk06uwBMRw==
X-Received: by 2002:ac8:4e05:: with SMTP id c5mr64582qtw.359.1610983460195;
        Mon, 18 Jan 2021 07:24:20 -0800 (PST)
Received: from localhost.localdomain ([177.194.79.136])
        by smtp.gmail.com with ESMTPSA id b12sm10284404qtj.12.2021.01.18.07.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:24:19 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     u.kleine-koenig@pengutronix.de, linux-serial@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] serial: mxs-auart: Remove serial_mxs_probe_dt()
Date:   Mon, 18 Jan 2021 12:21:53 -0300
Message-Id: <20210118152154.1644569-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The mxs platform is devicetree-only, so there is no need to check
whether it was instantiated via devicetree.

Simplify the code my removing serial_mxs_probe_dt() and add its
content into the main probe function.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 43 +++++++++-------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 8ecf622602cb..01fedb41cf93 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1535,34 +1535,6 @@ static int mxs_get_clks(struct mxs_auart_port *s,
 	return err;
 }
 
-/*
- * This function returns 1 if pdev isn't a device instatiated by dt, 0 if it
- * could successfully get all information from dt or a negative errno.
- */
-static int serial_mxs_probe_dt(struct mxs_auart_port *s,
-		struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	int ret;
-
-	if (!np)
-		/* no device tree device */
-		return 1;
-
-	ret = of_alias_get_id(np, "serial");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get alias id: %d\n", ret);
-		return ret;
-	}
-	s->port.line = ret;
-
-	if (of_get_property(np, "uart-has-rtscts", NULL) ||
-	    of_get_property(np, "fsl,uart-has-rtscts", NULL) /* deprecated */)
-		set_bit(MXS_AUART_RTSCTS, &s->flags);
-
-	return 0;
-}
-
 static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
 {
 	enum mctrl_gpio_idx i;
@@ -1631,6 +1603,7 @@ static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
 
 static int mxs_auart_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct mxs_auart_port *s;
 	u32 version;
 	int ret, irq;
@@ -1643,11 +1616,17 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->port.dev = &pdev->dev;
 	s->dev = &pdev->dev;
 
-	ret = serial_mxs_probe_dt(s, pdev);
-	if (ret > 0)
-		s->port.line = pdev->id < 0 ? 0 : pdev->id;
-	else if (ret < 0)
+	ret = of_alias_get_id(np, "serial");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias id: %d\n", ret);
 		return ret;
+	}
+	s->port.line = ret;
+
+	if (of_get_property(np, "uart-has-rtscts", NULL) ||
+	    of_get_property(np, "fsl,uart-has-rtscts", NULL) /* deprecated */)
+		set_bit(MXS_AUART_RTSCTS, &s->flags);
+
 	if (s->port.line >= ARRAY_SIZE(auart_port)) {
 		dev_err(&pdev->dev, "serial%d out of range\n", s->port.line);
 		return -EINVAL;
-- 
2.17.1

