Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F889CD98D2
	for <linux-serial@archiver.kernel.org>; Tue, 10 Oct 2023 22:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjJJWuO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Oct 2023 18:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjJJWuE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Oct 2023 18:50:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4527FE5
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 15:49:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so61321045e9.0
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696978194; x=1697582994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zurLR0/e73s9qaXsNiBj25J3OO2Gwg9apCX41yzLfwU=;
        b=vN7waHZJ1fE/CcYNyfTXYtR8ERDdtYJIeDhLqJw291GcLJFX0KecEkzom/XHOdNdti
         lh27WpfR7TENnqJEARGDk6cc0Ul8d/VcwkIzlUDWFFKtC7ic84bbBag59onJclssMUCz
         f6UE6uptuHo7a2+XNvfxbfoLP3PHIH84ejURu0oc/+SHj9edGpmQ0hw75WvkEGN7hEUK
         ACuu3C+KI5TlSKlEqg2veCSGNnOMrd/HX4/BzNfTIvOirMFxe3fUHxhGXjt8/5SNp3Yz
         t3KyHDwttKWjdISUekGBnBPlnyFECEZhwLxLmaV5rTfhNCijzR6npZY/whodkuHqkjLy
         r8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978194; x=1697582994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zurLR0/e73s9qaXsNiBj25J3OO2Gwg9apCX41yzLfwU=;
        b=q6qyRp2alx1SBCZxTm8U9auM7TTNoLGA6MbybZNGHZISYxmO9Fg/0wD6zzO976Oxfa
         gv3fHTZSFMWUvfUjc30u1vAwu5MAMyLlqP6t3jTl7KETL8fcvTj3UPfT/x/dWyvbFnfX
         TffdU297SjPkC80pKCUJBIB8Xr32BIQi01MsFD8uRZ9LLEPsU/P8fXgEgmxZuFBZFps+
         SDuFo+WF6cbrYH80JzU9cTwTubZWzVURMPu9K9Lpt9fSFht4bXszBJkdDoyK41VXO3os
         C4TViDlq0Zu4sqnN6iq4hxCvKugDgw1pdCgyiLSiuac5Mhz931ymkWMFbMoD+3ORXVWQ
         AfeQ==
X-Gm-Message-State: AOJu0Yw8xLMm1LiTqqJ6dvBx03eeFkABwwlkmHCND0EVmM/ihyZcp7oS
        OH/3D+0Y6HAN3q0htCkrNDc/Dg==
X-Google-Smtp-Source: AGHT+IEjsAdZZ2TrgAKTWEGnW3p1wMPoziKHfwDUL1AzluyyUU59YKFDtce6RDEjYzrGHYVBL9ceag==
X-Received: by 2002:adf:f40c:0:b0:324:8700:2fec with SMTP id g12-20020adff40c000000b0032487002fecmr15763212wro.64.1696978194557;
        Tue, 10 Oct 2023 15:49:54 -0700 (PDT)
Received: from gpeter-l.lan (host-92-12-225-146.as13285.net. [92.12.225.146])
        by smtp.gmail.com with ESMTPSA id j13-20020adfe50d000000b003196b1bb528sm13689547wrm.64.2023.10.10.15.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:49:54 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, cw00.choi@samsung.com
Cc:     peter.griffin@linaro.org, tudor.ambarus@linaro.org,
        andre.draszik@linaro.org, semen.protsenko@linaro.org,
        saravanak@google.com, willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Subject: [PATCH v2 06/20] dt-bindings: pinctrl: samsung: add google,gs101-pinctrl compatible
Date:   Tue, 10 Oct 2023 23:49:14 +0100
Message-ID: <20231010224928.2296997-7-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231010224928.2296997-1-peter.griffin@linaro.org>
References: <20231010224928.2296997-1-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the "google,gs101-pinctrl" compatible to the dt-schema bindings
documentation.

Add maxItems of 50 for the interrupts property as gs101 can have
multiple irqs.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../bindings/pinctrl/samsung,pinctrl.yaml     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
index 26614621774a..2464bc43aacb 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
@@ -35,6 +35,7 @@ properties:
 
   compatible:
     enum:
+      - google,gs101-pinctrl
       - samsung,s3c2412-pinctrl
       - samsung,s3c2416-pinctrl
       - samsung,s3c2440-pinctrl
@@ -134,6 +135,24 @@ allOf:
           minItems: 1
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: google,gs101-pinctrl
+    then:
+      properties:
+        interrupts:
+          description:
+            Required for external wakeup interrupts. List all external
+            wakeup interrupts supported by this bank.
+          minItems: 1
+          maxItems: 50
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.42.0.609.gbb76f46606-goog

