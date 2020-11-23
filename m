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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32790C2D0E4
	for <linux-serial@archiver.kernel.org>; Mon, 23 Nov 2020 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14DD2072C
	for <linux-serial@archiver.kernel.org>; Mon, 23 Nov 2020 19:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+UdhNf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgKWTG7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgKWTG7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Nov 2020 14:06:59 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A1C0613CF
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2020 11:06:59 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id l2so18085589qkf.0
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2020 11:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5PvnfMvYDfcN0BQQmDHZB8l5t0moTJhWRqDIZF3tEDY=;
        b=V+UdhNf9EhhMu6g4fSr8ahJ81zI/Swc71dLVXlZjjShRTJmub8MsLuK+yCMfRjZ0jA
         pa2EbbOv6GW1SX6jo2iyepeRb4mfLcFNX5Dd7Nf9wbYcMDsu41P9p8JnCS6BonK1l/xd
         74Lpqxz3L3jEMSLUGO2KcN0o0mluLF7W1GLHMBXCkq7btH1Y8gRInX6ZSxV7SSY5DzH+
         KH7MXhqYh3VpstLankofMjxndPKN1waaShBsmxk1PlveRIqtUZ2R/KxoWJDJsatV6z18
         VGX1auDaBU4UU9hQ6FrWhsVU3iDR6jw3P0LFZqH8+jiBSBhVz34k928keNn/s2J0rmTv
         WYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5PvnfMvYDfcN0BQQmDHZB8l5t0moTJhWRqDIZF3tEDY=;
        b=M6L74LafxHr82Iv5+2JjZ7RiVFK53FpzR1MThgcx4bEUIV5j6u68tQ9UXB4Gq4Duwm
         nLrNCEV3eEEEWSLirrSWaDesU/a2Ee4SwpG8pBYXgGzprxSSUXxcTllBf/MQbRctfkyo
         JimZMgIJMxd06WVhbJeVzrEdpDZjH2/YGCoCGcfyhnOeCaX1W3UAQzrx4F5srHPYeQGD
         +20VZPA+NWADa9YE/9TAtmQ+FL08Ne0f8dZktBrS52PgLkJDF+/J9REXs4ppSCI8OppW
         HoC01H18qzYHvwLHaN0WgVMjW9fGUfJxhkFp/wKZmR1qSBxt4CJH530To1QwaHznYkK2
         G9jg==
X-Gm-Message-State: AOAM531iD0vlWw6WyWK/H4RM+wVrUKwcEdvNaeLyZOnz2Kk7qMloroMx
        4ft6DvU8//Lf0G6RDXZiB4M=
X-Google-Smtp-Source: ABdhPJw1wB1PkLF34ZXwBcrUbqNO0dgqwTLWwekbf0D3ap805/5ycSJCTJg0OrMtgzGNimOfz2PihQ==
X-Received: by 2002:a37:a4c:: with SMTP id 73mr935643qkk.451.1606158418119;
        Mon, 23 Nov 2020 11:06:58 -0800 (PST)
Received: from localhost.localdomain ([177.194.72.74])
        by smtp.gmail.com with ESMTPSA id h125sm9842061qkc.36.2020.11.23.11.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 11:06:57 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: mxs-auart: Remove unneeded platform_device_id
Date:   Mon, 23 Nov 2020 16:04:38 -0300
Message-Id: <20201123190438.5636-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The mxs-auart driver is only used for DT platforms and there is no
need to use the platform_device_id structure.

Get rid the platform_device_id structure and retrieve the data via
of_device_get_match_data(), which simplifies the code.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index b784323a6a7b..8ecf622602cb 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -443,24 +443,16 @@ struct mxs_auart_port {
 	bool			ms_irq_enabled;
 };
 
-static const struct platform_device_id mxs_auart_devtype[] = {
-	{ .name = "mxs-auart-imx23", .driver_data = IMX23_AUART },
-	{ .name = "mxs-auart-imx28", .driver_data = IMX28_AUART },
-	{ .name = "as-auart-asm9260", .driver_data = ASM9260_AUART },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
-
 static const struct of_device_id mxs_auart_dt_ids[] = {
 	{
 		.compatible = "fsl,imx28-auart",
-		.data = &mxs_auart_devtype[IMX28_AUART]
+		.data = (const void *)IMX28_AUART
 	}, {
 		.compatible = "fsl,imx23-auart",
-		.data = &mxs_auart_devtype[IMX23_AUART]
+		.data = (const void *)IMX23_AUART
 	}, {
 		.compatible = "alphascale,asm9260-auart",
-		.data = &mxs_auart_devtype[ASM9260_AUART]
+		.data = (const void *)ASM9260_AUART
 	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxs_auart_dt_ids);
@@ -1639,8 +1631,6 @@ static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
 
 static int mxs_auart_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-			of_match_device(mxs_auart_dt_ids, &pdev->dev);
 	struct mxs_auart_port *s;
 	u32 version;
 	int ret, irq;
@@ -1663,10 +1653,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (of_id) {
-		pdev->id_entry = of_id->data;
-		s->devtype = pdev->id_entry->driver_data;
-	}
+	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
 
 	ret = mxs_get_clks(s, pdev);
 	if (ret)
-- 
2.17.1

