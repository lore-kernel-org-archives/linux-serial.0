Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE54C433B4
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 07:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8B560249
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 07:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241864AbhERIAM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 May 2021 04:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbhERIAE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 May 2021 04:00:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C40C061573
        for <linux-serial@vger.kernel.org>; Tue, 18 May 2021 00:58:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso915932wmm.3
        for <linux-serial@vger.kernel.org>; Tue, 18 May 2021 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHKyhnmvKk11GFq9mc3k0CCB5T2Yy23YqL5vTU1rIHM=;
        b=TLzVMRaU60Ry1jl2TTo02UAb+xMSS4f1u7+jzg+ygsfwvJE5Bh/NW1LW0cTasWyxOb
         3XhMx0Cr3ufsX9oWrbxxqzE/UzMpnlExQuMvv+nFH91wqpXYwLRmsxos3omvkWO4ekEL
         TnxH3FwZOYqQkEboz/d2UU6zCT7aSRIFotUlfI1R3jum6CgTh9TPUXqqntnA4PYyVPYQ
         6XofKqconWPPcPgyX/jomdi0ES/9rJbLgfsij9uj3qRSOGhsjfWM51r975BGdgAGylTJ
         Sa9gxjFLMKdLV3ctIERAQ+ekJHaPW7hCS0Q1bfbGA7N+zdmllqXjfPBQ09QPWzDzduJ5
         eFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHKyhnmvKk11GFq9mc3k0CCB5T2Yy23YqL5vTU1rIHM=;
        b=AQpqLV6JrNr/vUbPiuuJZaDcZsLKv5ld3tonU+eEpwM6Q64+IKfJdguM12U7U6jRnI
         LlwGcT2DP+uPE4lK0UIyIuXyRNm0RwOdev0p2AC/swAfHS4uT4ILsQQfU8t0ImqDua3N
         E5Dy4qtGydRC2dF+YTrSsKRDGMHOP2AqD2VHiXHnowiiFznsDuQuvBdLg6wxZefMYWWF
         N3EsltatbmnMSZfEl8lA2ByJEJK/aXNTeyLwhzqfxfmnNrWWUqnZ+VDViahfgcssQYQk
         zIPUhvaAz/47ZYWfVtTWJ/hGkpytp4JeL2kIbetj0j/tjTH9lTb9ZNLhsl5dY7cA9iWu
         Imzg==
X-Gm-Message-State: AOAM530Gn0UF6+ku2P3qFpY9zscpEVt/i1mBE5WlVPqwPP+poUq9DkhX
        BWEkXG4a1Twx0zgxKDCaAobYRg==
X-Google-Smtp-Source: ABdhPJxvxIvNsm1JFAqKsBRZuZmJ3qDWkvq6GK0i82QVya6OwYocA4vbi1aiTE7jdaPnG0jVMyxHRg==
X-Received: by 2002:a05:600c:4ec9:: with SMTP id g9mr3821136wmq.173.1621324724424;
        Tue, 18 May 2021 00:58:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:842:2d82:a1ae:1a91])
        by smtp.gmail.com with ESMTPSA id v16sm735448wml.6.2021.05.18.00.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 00:58:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/3] tty: serial: meson: retrieve port FIFO size from DT
Date:   Tue, 18 May 2021 09:58:32 +0200
Message-Id: <20210518075833.3736038-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518075833.3736038-1-narmstrong@baylibre.com>
References: <20210518075833.3736038-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now the DT bindings has a property to get the FIFO size for a particular port,
retrieve it and use to setup the FIFO interrupts threshold.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/tty/serial/meson_uart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 529cd0289056..10bb29202e43 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -715,6 +715,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 {
 	struct resource *res_mem, *res_irq;
 	struct uart_port *port;
+	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
 	int id = -1;
 
@@ -741,6 +742,8 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!res_irq)
 		return -ENODEV;
 
+	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
+
 	if (meson_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
 		return -EBUSY;
@@ -770,7 +773,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->type = PORT_MESON;
 	port->x_char = 0;
 	port->ops = &meson_uart_ops;
-	port->fifosize = 64;
+	port->fifosize = fifosize;
 
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
-- 
2.25.1

