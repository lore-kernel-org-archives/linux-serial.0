Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06157C001B1
	for <linux-serial@archiver.kernel.org>; Mon,  3 Jul 2023 13:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjGCNbb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Jul 2023 09:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjGCNbX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jul 2023 09:31:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B736EE62
        for <linux-serial@vger.kernel.org>; Mon,  3 Jul 2023 06:31:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fba74870abso4347973e87.0
        for <linux-serial@vger.kernel.org>; Mon, 03 Jul 2023 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688391078; x=1690983078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=renX9kOzKpMBUHmq5hZ3jekycYbJefUYz//61Td5O/s=;
        b=GQnx9pt3XPrNTI7bDhUV9shv8jqRedMVA93nw4QPRqm1n2msFv+zYB8ujsiGCdElPC
         t8IkSGHHArjdxfc3xppEsOSWHxvr4V+ec/3/0MnXAm3trjUCNMkkfa4X1f8Md8OM2elV
         4/iAzcL+CuuTwYF2WykkblvIUycM5srNmsuyfx76DqZyonY55nLfcK4eOXiblsqqKs67
         molg5OpuT+DoI46lFWFP+ocrmrQeRv2yptgr4hifTIxn5THLeizHxJO6wDeZamAG2jc0
         3hpYTjGtZ89L93p9sNDLcL1BlKGvteqyQ5Cq7wk+XBUNRU2ADs1gfJI57SFzfpY4sbtq
         48tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688391078; x=1690983078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=renX9kOzKpMBUHmq5hZ3jekycYbJefUYz//61Td5O/s=;
        b=P+xjf09Q7QVMkVyGczIHmrrE764aLjswvek0D8slkrVWGGzdVQvnMtXWI9GxkJfOkD
         tTq7TMy2yCmCTBHoH2zJHC1ICcd+EOcb8mypr8XmvBDfseKFxCphMPXy4LC8EsPMdOLa
         P3/c/E6EHgRs9cGDAxZzmOvJVFFkopNzoXqLDkl2CFFS670w4WHuiJKqvN9mI0sgFnM/
         0KwysAZq2qjrQwnlP4H/DCMWNQpQZQ9eZWTZ2p77gBA2I3mXYcwEB4ceKtDsgzTb+QT3
         I3iWd/U1a8FK2SiALiT1SXVsiGsJ40Hal9eTd+irwuHMbw/MBCLrkgAvI3vv7VIyQsnP
         rBUg==
X-Gm-Message-State: ABy/qLZdG+PsrT/alnAbMn8PVRiANIo3+eKtsiIuqa27JKOF21S+9gSb
        BXUHDI2maETmJKpYFesp+0A2CA==
X-Google-Smtp-Source: APBJJlElhw8ALBCPCE8CXubshdOp5BOmnloAfbaU4sclsqsqMLGWGbmRZq0ThGRIh1YvTS7JSiZF5w==
X-Received: by 2002:ac2:5f77:0:b0:4f8:4255:16ca with SMTP id c23-20020ac25f77000000b004f8425516camr5813036lfc.38.1688391077959;
        Mon, 03 Jul 2023 06:31:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id ep7-20020a056512484700b004fbb1f70ceesm833417lfb.227.2023.07.03.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 06:31:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Jul 2023 15:31:12 +0200
Subject: [PATCH 3/5] dt-bindings: i2c: qcom,i2c-geni: Allow no qup-core icc
 path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230703-topic-8250_qup_icc-v1-3-fea39aa07525@linaro.org>
References: <20230703-topic-8250_qup_icc-v1-0-fea39aa07525@linaro.org>
In-Reply-To: <20230703-topic-8250_qup_icc-v1-0-fea39aa07525@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-i2c@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688391072; l=1429;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Efov7Nc3L7yYdK02wWwkMS19LIdgHhVcFqBbivRpHHg=;
 b=l/kFHoXLaDijhcPRgMraezLtExT+uw2/Dx6Ky5TCDCAYZRsOhWk4fguwnDe0BeiOpJwS8kMSZ
 UrlhHFlGtuPD0B9+mS/r23uC+zxZssYS+zHRdDknp1RU+G/ns8/x+oU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some SoCs (like SM8150 and SM8250) don't seem to provide a qup-core path.
Allow such case.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/i2c/qcom,i2c-geni-qcom.yaml           | 27 +++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
index 9f66a3bb1f80..f92b6d7fc7c5 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
@@ -108,14 +108,25 @@ allOf:
         clock-names:
           const: se
 
-        interconnects:
-          minItems: 3
-
-        interconnect-names:
-          items:
-            - const: qup-core
-            - const: qup-config
-            - const: qup-memory
+      oneOf:
+        - properties:
+            interconnects:
+              maxItems: 2
+
+            interconnect-names:
+              items:
+                - const: qup-config
+                - const: qup-memory
+
+        - properties:
+            interconnects:
+              minItems: 3
+
+            interconnect-names:
+              items:
+                - const: qup-core
+                - const: qup-config
+                - const: qup-memory
 
 unevaluatedProperties: false
 

-- 
2.41.0

