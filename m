Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C05C433FE
	for <linux-serial@archiver.kernel.org>; Tue,  5 Apr 2022 06:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiDEGh2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Apr 2022 02:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiDEGhN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Apr 2022 02:37:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6401901E
        for <linux-serial@vger.kernel.org>; Mon,  4 Apr 2022 23:35:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ot30so14595727ejb.12
        for <linux-serial@vger.kernel.org>; Mon, 04 Apr 2022 23:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijNe1gxoWsdrm+oek0ryQTviG9eFIwp156wwm7qwtvc=;
        b=XoQd7eXmayRtgXenCj/0DqYnAREZxy5QhvyHa07LX2TmVGqPuvMWhiGZsWuEJzAaOv
         b3uh+52P1EfWWtIYWmaRsqBEPIADtdA8P830tUbhD6kfhvJKBU9Xe0TYR5f/bPddweyV
         KyJW6rl2x17jbiYl8YzD8bMHPgG9IiBwtCI+T5AO87H9n5+xefKCk/19M/q6/qEbP99j
         efPrZL1aj7Bx29kxIYC6nYLHYdRIOGuyX0TsUsErtCcoQVweIE7q1WqnUabqg3QC9yII
         d8IuI8IBnbfbJvo77L2RsrlNKbC1mJC/Wx8DCxSY+31l/jYdTLy/7ksP9yP1nmP+B9oV
         9mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijNe1gxoWsdrm+oek0ryQTviG9eFIwp156wwm7qwtvc=;
        b=F9QuKBm8UygXBIksLeeDVDgIe816/aM2higeNm+pAQAuLCipvVT9NlNh39JAr5d9fh
         SUNSxyD/PQDIl272kJcEpGcJ22YaCu3+Y7nSvdsExM26QAnm/vYbBik/24K1FLDtdVOh
         2iKgRthgH2i6MBLaRJBJnRduzl8TZzRCuULrx+8eiZ65oQ3FNb15N4DzARX8wURGwgzx
         g3NINlU7osY/M8EJQhZ2IdV1ifP5IciM+ZOe13clPMcA9gk+ddcskkGI9HxtJ64uVQ7M
         r6nI1fX1+3dDos1+KfBie5lfkWkMFTu26VfcCKTD/bS9GuuMv0fF4cBaMuC0Z8u74GYH
         9SBA==
X-Gm-Message-State: AOAM533koLPlGDB1zzrbPcQTxnmaVPLQYPJOZzhZxDD0+4PJrzqWtqez
        qC8/AhSEpZ/3oqfcK0OWH9xo5g==
X-Google-Smtp-Source: ABdhPJwg5JBDqrawA1o2xD7WCotpEUIzxo1lhvopQDFfw4uK7iSYPG7EQxrBTXwe/ersvfz+2ikRVg==
X-Received: by 2002:a17:907:6e10:b0:6e7:f672:f39b with SMTP id sd16-20020a1709076e1000b006e7f672f39bmr1966930ejc.451.1649140512065;
        Mon, 04 Apr 2022 23:35:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bs7-20020a056402304700b004197e5d2350sm6086543edb.54.2022.04.04.23.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 23:35:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/9] ARM: dts: qcom: ipq4019: align dmas in SPI/UART with DT schema
Date:   Tue,  5 Apr 2022 08:34:45 +0200
Message-Id: <20220405063451.12011-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405063451.12011-1-krzysztof.kozlowski@linaro.org>
References: <20220405063451.12011-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index a9d0566a3190..1f6c4ab7f37e 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -253,8 +253,8 @@ blsp1_spi1: spi@78b5000 { /* BLSP1 QUP1 */
 			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			dmas = <&blsp_dma 5>, <&blsp_dma 4>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -267,8 +267,8 @@ blsp1_spi2: spi@78b6000 { /* BLSP1 QUP2 */
 			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			dmas = <&blsp_dma 7>, <&blsp_dma 6>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -281,8 +281,8 @@ blsp1_i2c3: i2c@78b7000 { /* BLSP1 QUP3 */
 			clock-names = "iface", "core";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			dmas = <&blsp_dma 9>, <&blsp_dma 8>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -295,8 +295,8 @@ blsp1_i2c4: i2c@78b8000 { /* BLSP1 QUP4 */
 			clock-names = "iface", "core";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			dmas = <&blsp_dma 11>, <&blsp_dma 10>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -382,8 +382,8 @@ blsp1_uart1: serial@78af000 {
 			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
 				<&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 1>, <&blsp_dma 0>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 0>, <&blsp_dma 1>;
+			dma-names = "tx", "rx";
 		};
 
 		blsp1_uart2: serial@78b0000 {
@@ -394,8 +394,8 @@ blsp1_uart2: serial@78b0000 {
 			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
 				<&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 3>, <&blsp_dma 2>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 2>, <&blsp_dma 3>;
+			dma-names = "tx", "rx";
 		};
 
 		watchdog: watchdog@b017000 {
-- 
2.32.0

