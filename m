Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2180ACD98CD
	for <linux-serial@archiver.kernel.org>; Tue, 10 Oct 2023 22:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbjJJWuM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Oct 2023 18:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjJJWuE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Oct 2023 18:50:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6EDA
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 15:49:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40666aa674fso58841295e9.0
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 15:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696978193; x=1697582993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJ74cedc8GAeBZmTMzF3JIrX0TJ1DJCXAuIkw6TmlM0=;
        b=yBdR59ceuFX+07FjC7A+0Akkg75cSdzxwTfAk6suBwRvZkc9jfKLXzO6lM/6RvJULI
         d0oLxTYKYq/Yva7k1Yf65kox5ByBjEjTWP5YwKaSnCGkUHZVG8RTq71YqFDBiccuw6+9
         oFTlpAjEwzkPX8Lqqls+WRQoC8fFXo/ODfH7ahoYCi+NIFREoLifyGQSwhJ70z0j1MEG
         gJdrDHctdUzmuTGaksrVCVXr0Wy2V+6LZoY4x1CuphdFojaLQk4aijp9Ee7bPVmW501R
         FRElxjnpZG+vmm3OjA2nCxaDDGl+jkeJSbcTrYBPUeSK9duEkYttsM84DKt8ORz9LRY2
         ERUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978193; x=1697582993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJ74cedc8GAeBZmTMzF3JIrX0TJ1DJCXAuIkw6TmlM0=;
        b=Coby5AJ4e5bTnXTCYqqAMyZbaTtPmvRu56v8YiGKD+E8TT5OwgQikfquQ3DO59OzYH
         dDLGdQYoGBbR62vqgGLGcIvWaFNA2rKtf0i88nM1JXk/GzzA+Xvz2STCXzLx8UhC5jRF
         +MXy3CrHjA4ROdzF1WP/MUbqcagYvQ5QdskM1F/U47QcH+I0LyhM/rxpeRg4Hhy9T1Oq
         vwsvNr7TYz4MhhTAt12Y+o7N11vE0C19QrP81iWuTYmjWBcqJA2fDOJPH9v+E8VlMRYc
         /ZkfYWyFsUIc14T6VFYj0prV94eYh5XnAbuw4nrWBl6D68yjJtFtLENh7s+t5Yjw7bSz
         X6OQ==
X-Gm-Message-State: AOJu0YzU0hLZn2yFkdH9WiBqI+PhNpYuotycUhJEFqWvxmlSnoEWWbiL
        cNGhD1vP6wetZ3VJA3lhPkcBIQ==
X-Google-Smtp-Source: AGHT+IHFt44IvIgGbFix0PK/p+OZEdJuoaRo0Ks4rXQWEu9pD0qfPoVh/wjSuvtPwm9PDp+J2Wwexw==
X-Received: by 2002:a5d:4cc1:0:b0:324:885f:f7fd with SMTP id c1-20020a5d4cc1000000b00324885ff7fdmr17262662wrt.15.1696978193218;
        Tue, 10 Oct 2023 15:49:53 -0700 (PDT)
Received: from gpeter-l.lan (host-92-12-225-146.as13285.net. [92.12.225.146])
        by smtp.gmail.com with ESMTPSA id j13-20020adfe50d000000b003196b1bb528sm13689547wrm.64.2023.10.10.15.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:49:52 -0700 (PDT)
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
        kernel-team@android.com, linux-serial@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 05/20] dt-bindings: arm: google: Add bindings for Google ARM platforms
Date:   Tue, 10 Oct 2023 23:49:13 +0100
Message-ID: <20231010224928.2296997-6-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231010224928.2296997-1-peter.griffin@linaro.org>
References: <20231010224928.2296997-1-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This introduces bindings and dt-schema for the Google tensor SoCs.
Currently just gs101 and pixel 6 are supported.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/google.yaml       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/google.yaml

diff --git a/Documentation/devicetree/bindings/arm/google.yaml b/Documentation/devicetree/bindings/arm/google.yaml
new file mode 100644
index 000000000000..167945e4d5ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/google.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/google.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Tensor platforms
+
+maintainers:
+  - Peter Griffin <peter.griffin@linaro.org>
+
+description: |
+  ARM platforms using SoCs designed by Google branded "Tensor" used in Pixel
+  devices.
+
+  Currently upstream this is devices using "gs101" SoC which is found in Pixel
+  6, Pixel 6 Pro and Pixel 6a.
+
+  Google have a few different names for the SoC.
+  - Marketing name ("Tensor")
+  - Codename ("Whitechapel")
+  - SoC ID ("gs101")
+  - Die ID ("S5P9845");
+
+  Likewise there are a couple of names for the actual device
+  - Marketing name ("Pixel 6")
+  - Codename ("Oriole")
+
+  Devicetrees should use the lowercased SoC ID and lowercased board codename.
+  e.g. gs101 and gs101-oriole
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: Google Pixel 6 / Oriole
+        items:
+          - enum:
+              - google,gs101-oriole
+          - const: google,gs101
+
+additionalProperties: true
+
+...
-- 
2.42.0.609.gbb76f46606-goog

