Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50E3C433ED
	for <linux-serial@archiver.kernel.org>; Mon,  5 Apr 2021 17:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918D9613BC
	for <linux-serial@archiver.kernel.org>; Mon,  5 Apr 2021 17:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbhDERVq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:21:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60040 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbhDERVq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Apr 2021 13:21:46 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lTSuw-00017B-WB
        for linux-serial@vger.kernel.org; Mon, 05 Apr 2021 17:21:39 +0000
Received: by mail-wm1-f70.google.com with SMTP id b20-20020a7bc2540000b029010f7732a35fso6390304wmj.1
        for <linux-serial@vger.kernel.org>; Mon, 05 Apr 2021 10:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GEgD6nCwrnCCmMRnVlbIatB9AZXLMVXM2qwTWAsOSRQ=;
        b=Z4u+6TCIw46I/ylUnLJ4Sd/NdF623k4qBUauwE0RjfcWLEgw5Av7dbbQGt1SzvS75s
         LpJTlpyLgGu/WDsOioGoBB9NC2llShaO5JztT9w5QNoHDRhH/qH+JAdqLLAZQH9LTxW6
         oAI55aCMibMJPL6nl1RI5VIgsrF+XueJzFp5wrJwfhNNBjRvEcBknfMEeiLiX466wNdr
         fFRLRk3EHRFdHickNqHjtwlP18csucyQrDR/FreAx8bZLOj7NJ08jct0yujY3bbnN2b4
         875pH1LUe+14DQYckbwCxM920mjfJC0P+b6F8SyjOBpKnR3LSXYRod6OMt7fIsvEGVmu
         75cQ==
X-Gm-Message-State: AOAM531pPSk4C9ZvpQFLYAB33+SLfJQ7KqGO9vibJr2zkppRuQ/5dc+P
        ZS/cUCAVzbkIqZ01CBWek2VOwQVLwYoH3LKEwK4Du+hWsht0T2BLsJomxS/3UjS1dyD/O6G+6WQ
        yGS5UCz7Bif0/Apf4h/KNa/jLA/Pt9F2U/jhbkaCpzw==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr3368788wrw.268.1617643298798;
        Mon, 05 Apr 2021 10:21:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvw10z2SwG+zNEBknvFxeH/NAxYDl38hx+ODzviZ5wkQmgU4UelCf00bTWOqUL6fJHSWVN9g==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr3368767wrw.268.1617643298632;
        Mon, 05 Apr 2021 10:21:38 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id y12sm3736935wrs.65.2021.04.05.10.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 10:21:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: serial: samsung: include generic dtschema to match bluetooth child
Date:   Mon,  5 Apr 2021 19:21:19 +0200
Message-Id: <20210405172119.7484-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Include the generic serial.yaml dtschema so the child node like
"bluetooh" will be properly matched:

  arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml:
    serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

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

