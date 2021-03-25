Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C8C433EB
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 15:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754FD61A28
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 15:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhCYPYa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhCYPYV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Mar 2021 11:24:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE5AC061761
        for <linux-serial@vger.kernel.org>; Thu, 25 Mar 2021 08:24:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x13so2680429wrs.9
        for <linux-serial@vger.kernel.org>; Thu, 25 Mar 2021 08:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgzzDhp79bx35r5jKOLNYJfzzmoZjTRizxE5UOSMnpw=;
        b=ZMGw7DOul3+SQoGvgOttwL1Iac5paKrRtV2ymragAJntKtRTzgfrruwJsrw+Ty0lk+
         wNgqign0naVJIqRttat6mVH5MB14qMPBfiG/zSOvlLQlHMC5x9s/3bjNyLF8hP7lKj8k
         Z3ibFMrbX0zZqw7BBDORGwixnLuRZxuE66wrJ/lH2w6N9gjO7O8fDcDuULfZEhEM7D9W
         5w2hILsvh9ZpNZWP+PmVtX6683aAJJ20mqWEP8BMaElFMedPPqsUns0zIk8TPmt+989B
         AHphs+HFybvOfPqVyJs4BSgHYEHhAkeMYyJPxv7Zdq31hhLD5BIEEHTJs2mw/+FlAJBF
         7/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgzzDhp79bx35r5jKOLNYJfzzmoZjTRizxE5UOSMnpw=;
        b=VRRGWc4zW8G5ZtRtHhCOdo1xCItPYcto+LMeUNz0UyYHcttcwT/cUjeZUwbvnAUqrW
         xo+CUk9zzB8JHzjky/Je+mPYpem12eYXs4aZi3WYUb0sjodE9v6ArfQONgzIMBbPKm9H
         n6x/HiHs6gxwyDGVpBVLY6Q8/oV2tAkAD5UQ9o7VYHy5K9lG6X1nLrSb7ux3Q69As8l5
         Fb3avul2s94wqBRrx0GKDa+o+Hyvx1bOtvHnG6eSTl9H+zJODmSsN+nhD737FN3qnqE4
         cwmsH1KZlEx9QllCYW4ljJHCQ+i4Oogl4Yxpk7BtmjrJZ176M4P0KbNssCTfS1DHyIQu
         zsrw==
X-Gm-Message-State: AOAM531McZmPPu8aNwe9rPLnyogl1wHbr8B+WiOH1tlyA+jx6+t5w6/G
        5RWdSQSKjHW43Wro6iJ4KuzOqw==
X-Google-Smtp-Source: ABdhPJzwib9nqK77IORZQzCGahRNUu/JMVR4TWOE9ehuvIgER+dQxfV5hsZAf8zkflsy93kN7/d/kQ==
X-Received: by 2002:a5d:638f:: with SMTP id p15mr9566480wru.220.1616685859525;
        Thu, 25 Mar 2021 08:24:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:b105:9672:b0a:5820])
        by smtp.gmail.com with ESMTPSA id p18sm7395260wrs.68.2021.03.25.08.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:24:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 2/3] tty: serial: meson: retrieve port FIFO size from DT
Date:   Thu, 25 Mar 2021 16:24:09 +0100
Message-Id: <20210325152410.1795557-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152410.1795557-1-narmstrong@baylibre.com>
References: <20210325152410.1795557-1-narmstrong@baylibre.com>
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
index 69eeef9edfa5..ce4dbfb0bd24 100644
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
 
+	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
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

