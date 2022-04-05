Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DCBC43217
	for <linux-serial@archiver.kernel.org>; Tue,  5 Apr 2022 06:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiDEGh3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Apr 2022 02:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiDEGhN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Apr 2022 02:37:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B732A192B2
        for <linux-serial@vger.kernel.org>; Mon,  4 Apr 2022 23:35:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n6so10493677ejc.13
        for <linux-serial@vger.kernel.org>; Mon, 04 Apr 2022 23:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oehOK4VAqzTxqC5buHxSssXxgO+RDZMIgj7zOteyqjI=;
        b=Hy193/1AngSh5NoyrzCWhMqh1HfWhAFXyMQFGQnXsKByL+K7x9NaO8EtKKgIPFZglX
         dr61Z9qLcEB9Q9xrGub+cXEbob9EjuotHEUZgPHmsbmWYHnRuk5zWfJ/tXUCeLJnEE3d
         At4VHp02QmmXe+Ajv6QWNbk8feLGu+QNQyHrHD24/tf0lTmMcxCiKKHdeUlxPMxI0viG
         sZ4i+B2DYEL0j1rt+8DDvJMYmyC+HW1YiZf00tBwYeb8c2rVaFCVxlkcvRoAVMmk+CKE
         5anCalLk0GLFFoJwR6XEXh+D/uzrv3Oe+MovpcVCuvTOHgf9LaTwsPe//IkEYVZwIIBt
         rvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oehOK4VAqzTxqC5buHxSssXxgO+RDZMIgj7zOteyqjI=;
        b=aU+Pp6stgXi38xEQyFvXw19ZJl38CSBtClTpiqsdzt01PIMayOEH2/aIItfIFq8CXS
         bCk6TcjMsU3Cw1spuYufRtvIsic/xV7/8i8YO6PTn4S+HRCdzS2LFUPSPDCdyhROPyyE
         mTrUgvW29GIGpkZWYnuBlHnnd6GiaJ99bytYl2nbhsNKtidK1r6gFn/smVH1BxGkkV2B
         m5kboG/iN32d2EGttn44G2ZbHZo1UnGWOmC5TCfhX2Zlu8J13YLKGjM+P/Gf2NSn9Vfq
         Fmp823mYylNxAm0NtSvYDgNQB2HtIRzCvJt+te03mi0ATSZp5G1vP/vKkZQSLhr3NfOz
         ZyeA==
X-Gm-Message-State: AOAM532iSG4h7IfrDXQ5MvcsteiJA3D8af1sEBkg5naJU0XFx52jFdAZ
        brZqkYEucx22o/56wgLxWLmVtQ==
X-Google-Smtp-Source: ABdhPJx5QUnjVh8yXIsk3kKBa6+qdhCQDojbFltvtAoIpuG1MWrKxZhMXJ9aa7AJHvkiY2e8/vcWVQ==
X-Received: by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id fj2-20020a1709069c8200b006dfc5f0d456mr1929200ejc.287.1649140513236;
        Mon, 04 Apr 2022 23:35:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bs7-20020a056402304700b004197e5d2350sm6086543edb.54.2022.04.04.23.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 23:35:12 -0700 (PDT)
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
Subject: [PATCH v4 4/9] ARM: dts: qcom: ipq4019: align clocks in I2C with DT schema
Date:   Tue,  5 Apr 2022 08:34:46 +0200
Message-Id: <20220405063451.12011-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405063451.12011-1-krzysztof.kozlowski@linaro.org>
References: <20220405063451.12011-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The DT schema expects clocks core-iface order.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 1f6c4ab7f37e..897442157f5f 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -276,9 +276,9 @@ blsp1_i2c3: i2c@78b7000 { /* BLSP1 QUP3 */
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x78b7000 0x600>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				 <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>;
-			clock-names = "iface", "core";
+			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
@@ -290,9 +290,9 @@ blsp1_i2c4: i2c@78b8000 { /* BLSP1 QUP4 */
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x78b8000 0x600>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
-			clock-names = "iface", "core";
+			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
-- 
2.32.0

