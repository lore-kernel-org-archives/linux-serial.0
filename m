Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEAEC433F5
	for <linux-serial@archiver.kernel.org>; Sat,  2 Apr 2022 18:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbiDBSmO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 2 Apr 2022 14:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245086AbiDBSmM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 2 Apr 2022 14:42:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E9849C88
        for <linux-serial@vger.kernel.org>; Sat,  2 Apr 2022 11:40:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c7so8715606wrd.0
        for <linux-serial@vger.kernel.org>; Sat, 02 Apr 2022 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pIzqrLEArTXL9YEy+XaJ/FROhoWjUa+sSmTt7exmUDk=;
        b=nh4Ca1Iee5A+rirbfhGt+Y4dwNTpehhABC7OArTt0hzWuUgBtCt9/jHJOhzA+ilXax
         5Y79iqh/uLd5gfQbLX0PtaugLmr+wl3WPAY13ptk9C+UYtGC7k3kHeSjJgA5AcWIqXqH
         zswiOUMOdjcw1X2gsp3Cxe8nQJQpTedfJ2HxqgcB7gLsLTBCLX9TOzRdxwcx1Ec0QJdH
         wK3KsTA9anfivP2sxJJpkbz3smHYaOXQeAWIH0K2rEng0ShBOh3xnzls4NrKMfoUCNQU
         Qh7JXCiJiqg1tLM+c0xI/kacasw7EjtQH5kHsUNhudBCsG5mfY8EOplzXAt6+hRjXrLQ
         dW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pIzqrLEArTXL9YEy+XaJ/FROhoWjUa+sSmTt7exmUDk=;
        b=Rx02jCLSORjxiKvlCopsyxnRKzFSxpVB0BQRnt1CdPEYBordWGEHNfGSop6tjXRcW2
         sY0Dr/dXzti898ldvXPlsF7mJV6/xjK+S8DRf6/hAzQGxWJ3bjRJtdj5AgIiSpc8sf/Q
         A+cIF1fhVBu0aAb2LKsecLUnKA7SjKUd/3bl/4SkatMTrQ2x+8oItkW9gYUercd/bVXD
         JAVJjHX/f+oaVkcj9NQHvj9B4QBdynGYOXzziemHI3FwY1iXXgzXKTe49uTZSmdyug7Z
         IEBoGIJzeKh1fbIWJ6jhFDQ8Wi+em3ei3JKxWYIrF79PHZexP38e4fjB/4KqO4tu8+5F
         +g2g==
X-Gm-Message-State: AOAM532sr3+IqFDBBebKElAy/CDTYtA74WWhkeBxt5PVJ2lcUTniW4yO
        YSIHDsLT/wCtQE/fj8fUWjyM6w==
X-Google-Smtp-Source: ABdhPJyJTdw6BouhQE797tO7oerVq6r0ag2oAn6kxWGfF0SWMaDv9yXd0fuK0BPj/DZDZJWure2C+Q==
X-Received: by 2002:adf:eb4d:0:b0:1ed:c1f7:a951 with SMTP id u13-20020adfeb4d000000b001edc1f7a951mr11426073wrn.454.1648924817778;
        Sat, 02 Apr 2022 11:40:17 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b0038b5162260csm6760502wmq.23.2022.04.02.11.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 11:40:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/9] arm64: dts: qcom: align dmas in I2C/SPI/UART with DT schema
Date:   Sat,  2 Apr 2022 20:40:03 +0200
Message-Id: <20220402184011.132465-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220402184011.132465-1-krzysztof.kozlowski@linaro.org>
References: <20220402184011.132465-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The DT schema expects dma channels in tx-rx order.  No functional
change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Dropped Kuldeep's ack because of changes - more properties changed.
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi |  8 +++----
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 16 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 32 +++++++++++++--------------
 arch/arm64/boot/dts/qcom/qcs404.dtsi  | 20 ++++++++---------
 4 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index aac56575e30d..87c28ffa44d3 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -322,8 +322,8 @@ i2c_0: i2c@78b6000 {
 				<&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
 			clock-names = "iface", "core";
 			clock-frequency  = <400000>;
-			dmas = <&blsp_dma 15>, <&blsp_dma 14>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -337,8 +337,8 @@ i2c_1: i2c@78b7000 { /* BLSP1 QUP2 */
 				<&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
 			clock-names = "iface", "core";
 			clock-frequency  = <400000>;
-			dmas = <&blsp_dma 17>, <&blsp_dma 16>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 16>, <&blsp_dma 17>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index d80b1cefab10..2072638006a4 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -471,8 +471,8 @@ blsp1_i2c2: i2c@78b6000 {
 				<&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
 			clock-names = "iface", "core";
 			clock-frequency = <400000>;
-			dmas = <&blsp_dma 15>, <&blsp_dma 14>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
+			dma-names = "tx", "rx";
 			pinctrl-0 = <&i2c_0_pins>;
 			pinctrl-names = "default";
 			status = "disabled";
@@ -488,8 +488,8 @@ blsp1_i2c3: i2c@78b7000 {
 				<&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
 			clock-names = "iface", "core";
 			clock-frequency = <100000>;
-			dmas = <&blsp_dma 17>, <&blsp_dma 16>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 16>, <&blsp_dma 17>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -503,8 +503,8 @@ blsp1_i2c5: i2c@78b9000 {
 				 <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>;
 			clock-names = "iface", "core";
 			clock-frequency = <400000>;
-			dmas = <&blsp_dma 21>, <&blsp_dma 20>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 20>, <&blsp_dma 21>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -518,8 +518,8 @@ blsp1_i2c6: i2c@78ba000 {
 				 <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>;
 			clock-names = "iface", "core";
 			clock-frequency = <100000>;
-			dmas = <&blsp_dma 23>, <&blsp_dma 22>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 22>, <&blsp_dma 23>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e34963505e07..384fc8738130 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1485,8 +1485,8 @@ blsp1_uart1: serial@78af000 {
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 1>, <&blsp_dma 0>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 0>, <&blsp_dma 1>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&blsp1_uart1_default>;
 			pinctrl-1 = <&blsp1_uart1_sleep>;
@@ -1499,8 +1499,8 @@ blsp1_uart2: serial@78b0000 {
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 3>, <&blsp_dma 2>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 2>, <&blsp_dma 3>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&blsp1_uart2_default>;
 			pinctrl-1 = <&blsp1_uart2_sleep>;
@@ -1529,8 +1529,8 @@ blsp_spi1: spi@78b5000 {
 			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 5>, <&blsp_dma 4>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi1_default>;
 			pinctrl-1 = <&spi1_sleep>;
@@ -1561,8 +1561,8 @@ blsp_spi2: spi@78b6000 {
 			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 7>, <&blsp_dma 6>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi2_default>;
 			pinctrl-1 = <&spi2_sleep>;
@@ -1593,8 +1593,8 @@ blsp_spi3: spi@78b7000 {
 			clocks = <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 9>, <&blsp_dma 8>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi3_default>;
 			pinctrl-1 = <&spi3_sleep>;
@@ -1625,8 +1625,8 @@ blsp_spi4: spi@78b8000 {
 			clocks = <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 11>, <&blsp_dma 10>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi4_default>;
 			pinctrl-1 = <&spi4_sleep>;
@@ -1657,8 +1657,8 @@ blsp_spi5: spi@78b9000 {
 			clocks = <&gcc GCC_BLSP1_QUP5_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 13>, <&blsp_dma 12>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi5_default>;
 			pinctrl-1 = <&spi5_sleep>;
@@ -1689,8 +1689,8 @@ blsp_spi6: spi@78ba000 {
 			clocks = <&gcc GCC_BLSP1_QUP6_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 15>, <&blsp_dma 14>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi6_default>;
 			pinctrl-1 = <&spi6_sleep>;
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 3f06f7cd3cf2..6b3a8e1006d0 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -823,8 +823,8 @@ blsp1_uart0: serial@78af000 {
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART0_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp1_dma 1>, <&blsp1_dma 0>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp1_dma 0>, <&blsp1_dma 1>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default";
 			pinctrl-0 = <&blsp1_uart0_default>;
 			status = "disabled";
@@ -836,8 +836,8 @@ blsp1_uart1: serial@78b0000 {
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp1_dma 3>, <&blsp1_dma 2>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp1_dma 2>, <&blsp1_dma 3>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default";
 			pinctrl-0 = <&blsp1_uart1_default>;
 			status = "disabled";
@@ -849,8 +849,8 @@ blsp1_uart2: serial@78b1000 {
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp1_dma 5>, <&blsp1_dma 4>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp1_dma 4>, <&blsp1_dma 5>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default";
 			pinctrl-0 = <&blsp1_uart2_default>;
 			status = "okay";
@@ -903,8 +903,8 @@ blsp1_uart3: serial@78b2000 {
 			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp1_dma 7>, <&blsp1_dma 6>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp1_dma 6>, <&blsp1_dma 7>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default";
 			pinctrl-0 = <&blsp1_uart3_default>;
 			status = "disabled";
@@ -1067,8 +1067,8 @@ blsp2_uart0: serial@7aef000 {
 			interrupts = <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_UART0_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp2_dma 1>, <&blsp2_dma 0>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp2_dma 0>, <&blsp2_dma 1>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default";
 			pinctrl-0 = <&blsp2_uart0_default>;
 			status = "disabled";
-- 
2.32.0

