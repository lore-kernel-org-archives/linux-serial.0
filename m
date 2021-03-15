Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB64C43332
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 08:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C6C64EAE
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 08:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhCOIfL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 04:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhCOIfE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 04:35:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F854C061574
        for <linux-serial@vger.kernel.org>; Mon, 15 Mar 2021 01:35:03 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so1875341wma.0
        for <linux-serial@vger.kernel.org>; Mon, 15 Mar 2021 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4O/Pa9QoYF77T5Q9QdbcadRQvPAdN3INVfdUHWaUtt8=;
        b=X+QUFVzKkQbG1ViUEZ3ss5XSu9heNtdx5TJHJrU1CiqtByufNS4VrOXAvqk+I5bdR2
         em6RSTaKU9idqiQITHDzc/DtiLlLvKYg/uBLAmPPmR/IkaXePdP9iIX9HdsWNYFpEaVv
         5dGrwHCoVJMiWt0PpoSUZH8sU4eNdWw2W/IqmLN96S4abciDPztuzn4k/buBj7xHJpRS
         cSvv4WbCBojzRz3STHiTyDwHgO6NrShwOGryzZ7HaEkv8mxpKJToLcx5avhbZcla8VTD
         uSmZAaVVomd281PQ00gMbDzr9ndev8s4cn7DzY+yfjMmDHs7ZLMKm0UC6kBDHSsefrtu
         Ea0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4O/Pa9QoYF77T5Q9QdbcadRQvPAdN3INVfdUHWaUtt8=;
        b=Qu8cSjPaOmCfyQK0X2FFvyFIKwlbCodXiZiO3w+Vo0jUjLyHwmtuSsv9vWD8NAWd9r
         b60iOMjitHshsr0m9L6cJCaqT/JuCkrZrrycnwmXBlZBvjAET2Leq+7ja2dtBt4/2kW2
         40VAZNplj2WS5M7hPM03UEv50+PwTgTxvPppiAcCBqSrxxSKmtGXXbWuFPuJ18FjUHE0
         uZwQ0K/6GWC1n5tJTB/tXgJOot7oXTN3zUs/Y7ztDHdFCyhD34j6Y72j2/xsniC/u2Wu
         SdlUy7j8yAvw8N+2MwxpVw7s7U0cb68cNsJo6JeAlbQQ+5ktoD3ORuDB/FmIr3T3Yulb
         toGA==
X-Gm-Message-State: AOAM530/qBI7A3sID+/x7SvthTTgCPGCWe24M+g8wo8B1FcEwojmFuc0
        chxGEQBNq3Cj9zXDgJunlVRx2Q==
X-Google-Smtp-Source: ABdhPJy3UE503fgAhTS0RzBbZfuwhb5FPKRFm4Jpd51LGdchtrvmRVxO/iaQkDxynO+Xstf/56XjoQ==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr25166362wml.147.1615797302244;
        Mon, 15 Mar 2021 01:35:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:708f:15aa:638c:22b7])
        by smtp.gmail.com with ESMTPSA id o2sm8372028wmc.23.2021.03.15.01.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 01:35:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/3] tty: serial: meson: retrieve port FIFO size from DT
Date:   Mon, 15 Mar 2021 09:34:58 +0100
Message-Id: <20210315083459.359773-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315083459.359773-1-narmstrong@baylibre.com>
References: <20210315083459.359773-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now the DT bindings has a property to get the FIFO size for a particular port,
retrieve it and use to setup the FIFO interrupts threshold.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/tty/serial/meson_uart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 69eeef9edfa5..7244b12aefab 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -717,6 +717,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 {
 	struct resource *res_mem, *res_irq;
 	struct uart_port *port;
+	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
 	int id = -1;
 
@@ -743,6 +744,8 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!res_irq)
 		return -ENODEV;
 
+	of_property_read_u32(pdev->dev.of_node, "amlogic,uart-fifosize", &fifosize);
+
 	if (meson_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
 		return -EBUSY;
@@ -772,7 +775,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->type = PORT_MESON;
 	port->x_char = 0;
 	port->ops = &meson_uart_ops;
-	port->fifosize = 64;
+	port->fifosize = fifosize;
 
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
-- 
2.25.1

