Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850F8C001B0
	for <linux-serial@archiver.kernel.org>; Mon,  3 Jul 2023 20:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGCUPf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Jul 2023 16:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGCUPe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jul 2023 16:15:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137BDE72
        for <linux-serial@vger.kernel.org>; Mon,  3 Jul 2023 13:15:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fba03becc6so5397340e87.0
        for <linux-serial@vger.kernel.org>; Mon, 03 Jul 2023 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688415331; x=1691007331;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OmxlnwW6OlUanek5Fckd1dRfjqDIwlG3Z86p0uliLOk=;
        b=SsRnH/OMBJV2EOefcvu1Xb2yQsvdhSI2R2icQ1p/FvczfAwJVJXLbqxxVRXC/kLjpc
         o38MR5sskA7mguUVBFOcSYtw9xKDHL8hwsHxQvHbJwSn4Hd08mhlOp8hNY/yx5bivGhV
         DGAjN1eKwyVC+7XJcYpN+u+sxIG4NaGCmG5Ldm2n/Umf5ZEFn6mLZF25C9I69vCjHKqv
         Pl7Ag7jK6DfrFp2DhnKorKLfOJIw9O0fovcVYNYjBiOR9vPGdkwbBwRR1FTK7wL7rzYu
         hzJfoq1NP5km7ZR50eKzjPnUbVTEyjdcHKGz7MgaYcGpD6vpWP+6F8OnE7KRgLSqldHR
         kIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688415331; x=1691007331;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmxlnwW6OlUanek5Fckd1dRfjqDIwlG3Z86p0uliLOk=;
        b=QcvvcCU703BSEjJ9/jaTBkIzY0V4weRu1kBogDCTgXeKgOBs/5csDcZYL7/z1hKk3e
         Bz1jQOgsDY2oAy/3NltGlRTcRQBt8SisJNc6lOBzt87Dq3O1JVrChU3ND+DhOi5MgT2F
         UwhOPAQMFeruTkBv7So2759B7yCN1gVTi77HJwz8lCCl7zjRmu9icdQvFnWt3TtCrxjL
         vKI1U22tp87dbiL7dLwd6kcUJOtQwbpECYqz0cGuw2ND+tUy7lRci5wyF4XX794PtnDy
         BkAK3SgB1CfZCF5C2Llyuo4MQXfZBV5kmLGFHywwdPohCTuZGIr8kw8tqUsqj+aOVU85
         eHuw==
X-Gm-Message-State: ABy/qLY9/DCtEku9H6TiXXEvaVFVc5U0eIkSoV64Xox2JPsBsd3S+N0f
        GjtbG3ztjsG033ieJ9StaDdurw==
X-Google-Smtp-Source: APBJJlHCV6QxaUZW/HE8PKjX7YHTl04DbkAPArIbQaOyoBWA0fQG8UECxLN2PRjJhO0iwXMN6tPfxw==
X-Received: by 2002:a05:6512:4013:b0:4f9:56b8:45e5 with SMTP id br19-20020a056512401300b004f956b845e5mr4663385lfb.25.1688415331030;
        Mon, 03 Jul 2023 13:15:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id w27-20020a05651204db00b004fba7edc6cesm1991365lfq.7.2023.07.03.13.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 13:15:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/4] Add interconnects to QUPs on SM8250
Date:   Mon, 03 Jul 2023 22:15:24 +0200
Message-Id: <20230703-topic-8250_qup_icc-v2-0-9ba0a9460be2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFwso2QC/32NQQqDMBAAvyI5NyUm1die+o8ism5XXZDEJiot4
 t+b+oAeZ2CYTUQKTFHcsk0EWjmydwn0KRM4gOtJ8jOx0EobZZWRs58YZaUL1byWqWFEWea2rMB
 c0BKKFLYQSbYBHA4pdcs4JjkF6vh9nB514oHj7MPnGK/5z/59rLlUsiMwVwBlC13cR3YQ/NmHX
 tT7vn8BgyzMtsoAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688415328; l=1365;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=dPT2roZiTmdQmO/AOJA7mh/BGKezhgAf87PZ1MFFvgg=;
 b=YYNXe31KSRcf7Lk7nGQU5Xt0Jfhyz/T8zQ6WxbFjMq5eCquktEC2yJaN7vfHXBu+lgFjrcHIa
 A/Sq/fnZE+7Dfn0irrsXaCOk9Ng3RRcXVYrA2snsERBhkcvmRayf47M
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SM8250 (like SM8150 but unlike all other QUP-equipped SoCs) doesn't
provide a qup-core path. Adjust the bindings and drivers as necessary,
and then describe the icc paths in the device tree. This makes it possible
for interconnect sync_state succeed so long as you don't use UFS.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- drop everything, fix icc instead of messing with bindings
- Link to v1: https://lore.kernel.org/r/20230703-topic-8250_qup_icc-v1-0-fea39aa07525@linaro.org

---
Konrad Dybcio (4):
      dt-bindings: interconnect: qcom,rpmh: Add SM8250 QUP virt
      dt-bindings: interconnect: qcom,sm8250: Add QUP virt
      interconnect: qcom: sm8250: Fix QUP0 nodes
      arm64: dts: qcom: sm8250: Add interconnects and power-domains to QUPs

 .../bindings/interconnect/qcom,rpmh.yaml           |  18 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 286 +++++++++++++++++++++
 drivers/interconnect/qcom/sm8250.c                 |  74 +++++-
 drivers/interconnect/qcom/sm8250.h                 |   6 +
 include/dt-bindings/interconnect/qcom,sm8250.h     |   7 +
 5 files changed, 384 insertions(+), 7 deletions(-)
---
base-commit: 296d53d8f84ce50ffaee7d575487058c8d437335
change-id: 20230703-topic-8250_qup_icc-61768a34c7ec

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

