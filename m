Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE77C433B4
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 17:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2942610CA
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 17:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhDIRUr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Apr 2021 13:20:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53871 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhDIRUp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Apr 2021 13:20:45 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lUuo3-0008D8-EZ
        for linux-serial@vger.kernel.org; Fri, 09 Apr 2021 17:20:31 +0000
Received: by mail-wr1-f72.google.com with SMTP id o11so2588638wrc.4
        for <linux-serial@vger.kernel.org>; Fri, 09 Apr 2021 10:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uyrzUrjaAi1BmA4U4HPTxMZ5ghSP8t5+bP/xEnKvPA=;
        b=qH2QvzENOi5z8o7K9aa1SlR0grX1mKcP5HLzzsgOKighl2XGdq1iCy4dFyeUM44J80
         3GOCiF3LvB3/hzsrgssjG7oFg4ZvU5nBnbQW0jU65aN35qeSMtFlagL0IpKHtS2tCi8F
         NvZXoFTH10AObdSkAK1gj+RbXyyCL+nXsnAtAK82qmng+zrXeeKosIbktYS8tFiWWM2J
         ADlzTeMi+D1+BjWkucNWofiyNz5aBE6OoMmZb4J3bL/LzHCdr3+mUTa7SgEbFylPG/9G
         gtQq3+zwoi79dxYLwnQfkux6ysVU7BDQH1iaUbffEiU+sSI2YemXo58dHt+KMZYvh4U7
         f56A==
X-Gm-Message-State: AOAM533Jhv5BsTRZckAY6ioy1q5RJL5Qrb2vQpkuYYV8xHV1Bl5+Z8pu
        +XLMnaFpjldZn2LrrxLl7/3VK1jF1Ze9iibTu0C0D44Xs4Ap5gcpjHbHatoH7dx76ER7xhVBDY/
        Dve/U0cOM6Mi+GuEYfK/VJSZVJ08MYDHBo+tZkT2Z/w==
X-Received: by 2002:a05:600c:228d:: with SMTP id 13mr15001638wmf.49.1617988831155;
        Fri, 09 Apr 2021 10:20:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+JyoKZKJpIbVuRb8NNntAEpfeqVfkIhTYqe0bAoqdpPbIiazDgM3Y6xaCNkmht2L2eOtOrw==
X-Received: by 2002:a05:600c:228d:: with SMTP id 13mr15001626wmf.49.1617988830984;
        Fri, 09 Apr 2021 10:20:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id f8sm5444428wro.29.2021.04.09.10.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 10:20:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v3] dt-bindings: serial: samsung: include generic dtschema to match bluetooth child
Date:   Fri,  9 Apr 2021 19:20:27 +0200
Message-Id: <20210409172027.11296-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Include the generic serial.yaml dtschema so the child node like
"bluetooth" will be properly matched:

  arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml:
    serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v2:
1. Fix typo in commit msg.
2. Add Rob's review.

Changes since v1:
1. Drop the new example, as Rob suggested.
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 4f98a3896b3a..97ec8a093bf3 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -79,9 +79,11 @@ required:
   - interrupts
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 allOf:
+  - $ref: /schemas/serial.yaml#
+
   - if:
       properties:
         compatible:
-- 
2.25.1

