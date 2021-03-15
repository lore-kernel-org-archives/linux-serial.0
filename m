Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BFEC43381
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 08:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A3764EB2
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 08:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCOIfM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhCOIfF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 04:35:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06C8C061574
        for <linux-serial@vger.kernel.org>; Mon, 15 Mar 2021 01:35:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j18so5226752wra.2
        for <linux-serial@vger.kernel.org>; Mon, 15 Mar 2021 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BPZS3vnao73K9jUsX/fpglGU+kHtpTMPEIGEWnyDz8=;
        b=J9uOWfrfMEKrcqh0mxGSAXwSVI+6IRtLA1Ee9SL2Yecz8KhM/QA7z4AG6nM2dd1b8s
         r8iSEl10nAm1w/8dGrFgSHg7wUYfnjQeQfagGirxlXqcfHWA3SLFA7jVaPUrvYWHwOSg
         6ZGSXcnKLDYIbnq0O92AdA5vGTqNH8J9Uj2+odsqoHvXc/PxBtSlG1BFqSVLe+mhSeHK
         KN7FeDUw2u0m/VDRT8dxah0TPqHBRGpH4ttZqpBp/w5EKYppPWKgURQr2ElSU3f8AdM3
         E7RCTGE/tN+CMx+ArF6vzrjdmIk6cYtEQyYoj5jU5iyfyrGL5tKwH3ucPi2F6nANiaKR
         rlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BPZS3vnao73K9jUsX/fpglGU+kHtpTMPEIGEWnyDz8=;
        b=i9QrzCCe1kwkKuAN860Jcj3vUJCYQUjAqWdelv3LzvCr1OPW0AULYN6ppWcLL2Xlcf
         z86Uz76xTcAvLyOvoqslkcy5tGIFZ5LT6PGEEMvY8AOwI2sgOoOYNoQv9txdg8vBxqUO
         DnMKBWju5j34ZeYrBmcEuuXE7A2G5z3yV6KFciZptyb7fR6FCy9weRujRBVcsjlBMhn3
         BC68pIL+fdVK9cwKfo+qSy3J3HyuHQtvessVGXiXHNs8S/spUZzbUHXRaabQQejAeA1R
         hpKm1ElIOLTc1CWTCdmVbQyrjVt/i/K+6DM/ieOhysPXRhZMVXnG7hHT4Fs+clZp/fgm
         fNvw==
X-Gm-Message-State: AOAM530q5I3l5KrCj6YpaSTHxKzr/TUiTh40dp64HgSVi8i6sX+0KWX2
        pwfY0dP7rn6zYvUJp/Ixfa/PEw==
X-Google-Smtp-Source: ABdhPJyQqwyuDSuV0WHwVd7Shb+AlqgYBqd5R3uq6WnrB0yfoRjomq0j8TJhFdUjMTF9iMgreMZTXg==
X-Received: by 2002:adf:f0c1:: with SMTP id x1mr25674841wro.7.1615797303277;
        Mon, 15 Mar 2021 01:35:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:708f:15aa:638c:22b7])
        by smtp.gmail.com with ESMTPSA id o2sm8372028wmc.23.2021.03.15.01.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 01:35:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] arm64: dts: meson: set 128bytes FIFO size on uart A
Date:   Mon, 15 Mar 2021 09:34:59 +0100
Message-Id: <20210315083459.359773-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315083459.359773-1-narmstrong@baylibre.com>
References: <20210315083459.359773-1-narmstrong@baylibre.com>
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
index d945c84ab697..571383c12855 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1872,6 +1872,7 @@ uart_A: serial@24000 {
 				status = "disabled";
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
+				amlogic,uart-fifosize = <128>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index b858c5e43cc8..9e898479f118 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2311,6 +2311,7 @@ uart_A: serial@24000 {
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
+				amlogic,uart-fifosize = <128>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 0edd137151f8..bd0b049787fd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -295,6 +295,7 @@ uart_A: serial@84c0 {
 				reg = <0x0 0x84c0 0x0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
+				amlogic,uart-fifosize = <128>;
 			};
 
 			uart_B: serial@84dc {
-- 
2.25.1

