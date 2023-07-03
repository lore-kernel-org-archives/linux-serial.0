Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12BEEB64DD
	for <linux-serial@archiver.kernel.org>; Mon,  3 Jul 2023 13:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjGCNbT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Jul 2023 09:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjGCNbS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jul 2023 09:31:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE999E62
        for <linux-serial@vger.kernel.org>; Mon,  3 Jul 2023 06:31:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so5583992e87.0
        for <linux-serial@vger.kernel.org>; Mon, 03 Jul 2023 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688391075; x=1690983075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/gQKrgv9jl26df4nD8+qhw8ZnBWlEQchlmkvSgMYjQ=;
        b=l73yEXFOeig5qdtuMpI+ALwg4IVM0aw9hMZjHVFwaUTnXiGtujvGJewYdsk1tleRB2
         z5tITNcyfBvWbsRHjpFGGK9a0W/F52UoOdp0EWnav7IOMCgJf0zfkzpmgKx+aFVokbco
         l3jNynIeC4wwqc+g44wcjQN5AQwMi6M5kzm90uknSp01Mkpti5/bMT90w27Ts3yD+fE7
         MvtWhkjLwinbSN/UdfRchpILrNNaHLGs0aIZKmqq2h4ECaoHOUzA/QBvxsgLMOZ3jvvV
         vnIyUzgheqLU2ZkOn+8epAM/lRzIhipLWJuEU6Q3oNUjF2vCHFMYhU1FA5ilKCKscZRZ
         DmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688391075; x=1690983075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/gQKrgv9jl26df4nD8+qhw8ZnBWlEQchlmkvSgMYjQ=;
        b=eCDm+zkxKN6n3PRX7o9T5x5Ja9v3vouCoCH8YOvhPAth9NBLBwGsnkklUf3/ntTK+A
         3CjLuedS5yu3a2x0FR7QQLC9ZsuOcWfbIPakykcaP+8+zIc+LpxKUUSzey6l4rq3i/H6
         rKT6CIUjU8FOG9zmd2L1JEFVuBda/oRczaVh/GIAwr+dUEAAzX7cQ6V7iwYsOfUgcw0O
         twuwz+KTp9DFkaijMffXAYZcGU6ikzLJV/4vccIi1yX+v69Tymbcu/67f9PgC7FWRAp/
         5i+AFiJbxc/xcbJI0AdMz64O/TLSkyIOnH8Z+PmG4Xq5QXLffChKm70eLmYqn3pMvxp7
         4CZA==
X-Gm-Message-State: ABy/qLbAaw6ByYdDfhwjDoTDhkzTmj/lVRTJ7foJqxpd1Yg3RunhZm8q
        1c73fZ/9V3dhT5p0CX26GfY6OQ==
X-Google-Smtp-Source: APBJJlHpPmW37wHbYhD2VatnWDTXUi9XhtZ9muHG5jeTKYozptLFtx9Ha1cNS8EAgJxO9jLR4qBMmA==
X-Received: by 2002:a05:6512:3c87:b0:4f4:a656:2466 with SMTP id h7-20020a0565123c8700b004f4a6562466mr3914367lfv.15.1688391074973;
        Mon, 03 Jul 2023 06:31:14 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id ep7-20020a056512484700b004fbb1f70ceesm833417lfb.227.2023.07.03.06.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 06:31:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Jul 2023 15:31:10 +0200
Subject: [PATCH 1/5] dt-bindings: spi: spi-geni-qcom: Allow no qup-core icc
 path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230703-topic-8250_qup_icc-v1-1-fea39aa07525@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688391072; l=1083;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TQNTCWE+iBjVfoMqrm2paazex7hqvKkpoTz9pkEkyKc=;
 b=cStngA5XatURTQAcTPIg9usdXNHDCeFjDqHlJO5FM/ZH4iA7azJ01kuuVe06R9jsSSgwZ4aUm
 VBUl9Y1tbCiDUoxFvB6NfWRfJ1/5XpZHtnKTkXLnTdFJOWHEcbjMsUq
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some SoCs (like SM8150 and SM8250) don't seem to provide a qup-core path.
Allow such case.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.yaml       | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index 2e20ca313ec1..2890c4968c2a 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -49,11 +49,16 @@ properties:
     maxItems: 3
 
   interconnect-names:
-    minItems: 2
-    items:
-      - const: qup-core
-      - const: qup-config
-      - const: qup-memory
+    oneOf:
+      - items:
+          - const: qup-config
+          - const: qup-memory
+
+      - minItems: 2
+        items:
+          - const: qup-core
+          - const: qup-config
+          - const: qup-memory
 
   interrupts:
     maxItems: 1

-- 
2.41.0

