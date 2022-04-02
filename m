Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D41C43219
	for <linux-serial@archiver.kernel.org>; Sat,  2 Apr 2022 18:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355384AbiDBSmt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 2 Apr 2022 14:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355648AbiDBSme (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 2 Apr 2022 14:42:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FABE4E3A2
        for <linux-serial@vger.kernel.org>; Sat,  2 Apr 2022 11:40:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r64so3522347wmr.4
        for <linux-serial@vger.kernel.org>; Sat, 02 Apr 2022 11:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FPva/xF5QWD9GuBZmkDF4zJMJFtPU9JUPVfss7wEgA=;
        b=ym9CBYRNlyZUQNjyGH6kpXABn67E0eal9leUt0QBhtZJdtqSMbgGeiV/CddHZXUdC0
         ID54p5tpITSPgdAblO4RlC59G3ujo3NQ0rGx5ajrOD5yJBVSa6CFTw7QFkhQWtu9hore
         4JzBqhTFPf1ER5ByfUq1LHOo8rYtIDP3e7yx9hiYbDGZSFApvo2ldzAdrBtKv/OBSobR
         5kqQuxxzDL7zPwcPVecA7KnpkrF85KdoH01R6RKK/lxZjm/dwB6Zzxqyk4v1G5uZ+YJz
         DTv3AgnB4EgDFkZQB/BjXLkZF8JuYhEScdwx1k/nNcU9S6hfvZO9P0BGTlJPmGKMwlyR
         uMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FPva/xF5QWD9GuBZmkDF4zJMJFtPU9JUPVfss7wEgA=;
        b=STc81QUxFCdJuzTPv4UlrYuMhgcxNgqaJ3yeBpFuQ32nzWuTQKWPSSad1hYtT/Rz9u
         o+3tydZW4itr9Dp3xntpD7rVJSQ0HbpbfbbisWgzmTf0yNJnaALB22ALV6iZe68s1cTj
         pRgvKMH/2PWwIaEcNKJSPvzqooav1ag/MYeTSH8noh3THs6iLvYcuIa9RzEkPLINde9/
         D9cixlyq2mP/lfzy1DMEV7IWsKXRx5m/XufTHSMCo4EqncPSKFQ5IT1aThkP7ChJbQhI
         92B/ZjvK95uZKNYlwu49h/SxpGDLosa3ub+64QDQpmCun8uFtdjDV4TgOA+INIiBolvJ
         EhHQ==
X-Gm-Message-State: AOAM532U+rXnDaviOXZHOku3Iwrb6r2ZvxFpKSkUEOKr5sx3dnXQGJaS
        S0FjxgHPtrOAeSRbxfnWFMY4ZA==
X-Google-Smtp-Source: ABdhPJx+KbBUbfRJ/ITpnVRFc2VmBD3YtSvxiiWpGf1VKRS5lRLH2IYG/4eg9+kE+v7xzJ1zuIayKg==
X-Received: by 2002:a05:600c:2244:b0:38c:a3ff:ef67 with SMTP id a4-20020a05600c224400b0038ca3ffef67mr12853149wmm.122.1648924822405;
        Sat, 02 Apr 2022 11:40:22 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b0038b5162260csm6760502wmq.23.2022.04.02.11.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 11:40:21 -0700 (PDT)
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
Subject: [PATCH v3 5/9] ARM: dts: qcom: msm8660: disable GSBI8
Date:   Sat,  2 Apr 2022 20:40:07 +0200
Message-Id: <20220402184011.132465-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220402184011.132465-1-krzysztof.kozlowski@linaro.org>
References: <20220402184011.132465-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The GSBI8 child node (I2C controller) is disabled, so as parent GSBI
node should be the same.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index a258abb23a64..47b97daecef1 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -212,6 +212,7 @@ gsbi8: gsbi@19800000 {
 			ranges;
 
 			syscon-tcsr = <&tcsr>;
+			status = "disabled";
 
 			gsbi8_i2c: i2c@19880000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
-- 
2.32.0

