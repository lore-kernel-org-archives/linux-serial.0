Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9CDC433ED
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 07:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE4461261
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 07:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347387AbhERIAN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 May 2021 04:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347365AbhERIAG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 May 2021 04:00:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6145EC06175F
        for <linux-serial@vger.kernel.org>; Tue, 18 May 2021 00:58:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n2so9164021wrm.0
        for <linux-serial@vger.kernel.org>; Tue, 18 May 2021 00:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVZto4g6Wsxu+4WPtlJ/ny9aJEsfvT/s2hR41/jSqcM=;
        b=q/zVbBc8de/ZHaVlbkXtflSU9Y6r05ipflZJPEJMidMnL6VU4nk75xdR8qzzIyGvIk
         GPRztw2VRKTfvAPTWNBbUVxz1eZOAoPnhwthMU19UODq2two5XpYbaJoyRUJzDpfGyMo
         7b4DtMErwdRVN7HkifwHY8Lqg6dKGQdlZcQBkftjfCsY8Xqr1dSLa11uFelUy6eU1ew0
         g6yEy/U5syvHBNsLdJWV6gf06ICAqDUCtsrPbYouVwj9PuW5nrtabchPnhZxIx6Sq/Kh
         Gyw9T1lkBzA3/IDFB3lFrXiFqajKwsuq/HwsAf30PeGHdKvFg/s2BGDN51IT6D+QI2YP
         c3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVZto4g6Wsxu+4WPtlJ/ny9aJEsfvT/s2hR41/jSqcM=;
        b=LugaL0+OE1m5/exihwWHPUqbebnJoPxE06IKsEnOQnUZoLB7HoGZyHcBLdTaL1H/1U
         FYSI8s4VgVgLugNUVPVSxUnC7JnU6vpepg0Yj7hrbxozM99pUMtffOpyW95Cvn9O4V7M
         UZmJzf1H1WI+/ePDwXiqCM5rLQQhy4xsGk05lj7a5iEjb/QlbhjvG5zOc3Sobj+MbEkS
         3PgO/UUBh3WMqQQzftiqDJfCmi+V6hHyCPPmY/xIIT+mKow0vvjm4G4ixX120jtc+n21
         u1A8/RwYma6LdA9LioahvQMwVtRjrStOEtrK2v1Juwmg3DE5cE3aCZRhvgakMkxK5SVm
         rl7g==
X-Gm-Message-State: AOAM531BsDqLhAR7UO9+wTnan+25VnlUUC0vUQygdiFUDa1+vKFFSlLP
        nFn+dW4KGGqhx9bIOKH79aExog==
X-Google-Smtp-Source: ABdhPJwIn4TUckWjyOGKmOz5dzsQpoXw/XnPgmeXj7aq688o9TKoq0ZTOggr/wiZltQtLTx5ttg/GQ==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr5180323wrq.356.1621324726026;
        Tue, 18 May 2021 00:58:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:842:2d82:a1ae:1a91])
        by smtp.gmail.com with ESMTPSA id v16sm735448wml.6.2021.05.18.00.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 00:58:45 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] arm64: dts: meson: set 128bytes FIFO size on uart A
Date:   Tue, 18 May 2021 09:58:33 +0200
Message-Id: <20210518075833.3736038-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518075833.3736038-1-narmstrong@baylibre.com>
References: <20210518075833.3736038-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The first UART controller in "Everything-Else" power domain, usually used
for Bluetooth HCI has 128bytes FIFO depth.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 895c43c7af9f..3f5254eeb47b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1871,6 +1871,7 @@ uart_A: serial@24000 {
 				status = "disabled";
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
+				fifo-size = <128>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 793d48f72390..00c6f53290d4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2317,6 +2317,7 @@ uart_A: serial@24000 {
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
+				fifo-size = <128>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 3d00404aae0f..6b457b2c30a4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -301,6 +301,7 @@ uart_A: serial@84c0 {
 				reg = <0x0 0x84c0 0x0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
+				fifo-size = <128>;
 			};
 
 			uart_B: serial@84dc {
-- 
2.25.1

