Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C2DCD98D0
	for <linux-serial@archiver.kernel.org>; Tue, 10 Oct 2023 22:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbjJJWuK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Oct 2023 18:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjJJWuC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Oct 2023 18:50:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB785ED
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 15:49:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40535597f01so58603955e9.3
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696978196; x=1697582996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4qKMp7WKTgYWQn4jdaHUw1RN+hYCPkZJUgFKC+LCBg=;
        b=vEg2JvS2P4cPdjf97YddAJjciyShFEruYZVqqx6QI+cM/9KqgXPUK/JX7Fsg27mijC
         +xikWtTXE/BTYifhtxw0Nraj+vpNdllf2dbFOsoXD4SG2nyMISUXry9uBV+UAgdpsd24
         1DZmSKv+d23bmNXwK8W5Bfs7AoWeGJkgrTfeGK/PmCQZeelJNCqj9LWedwPJqQnzXmXp
         rjaWm9Gy9pI4Mlc/3gHs17CT2nx8ZKmM62gS6qYHwkX23Kg3AURhDUOwXZJuDhqlTGNa
         n5GoNFEe1+SNpGCdFdfdVuS8gJmJ/NWyy5Rh5xpFeCVS9PFWnTu6B3MvWJ+oxS0Ml++k
         lnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978196; x=1697582996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4qKMp7WKTgYWQn4jdaHUw1RN+hYCPkZJUgFKC+LCBg=;
        b=fdiFDNYGIVI8rJW5btMGsiQ85TrKeIZECXr2hmdKwuJqws28vd3iaCEQ9GT/JsMTIb
         p7dySdjvNfUGMF1o+XOl7qdOx1vfRm9NvOh8DcxLSylBQwa97D0YlZvftQQQJj2/NHdW
         GiA5byvNqxdPhTSAO9EkrcuAJVp8Qwa2uYfQSA3H3PFlunxTASkUT9dpB+PVbPdyR89h
         P3tHmCYIGjasRxcdPB/shZHg6FzjUrY3A4xyXgiqxLeZWdLNqNVfmP/MqiRDon7zWiRi
         ARLB8Yr5zbjHaMnahmJh+X/xytSXwnk//RqLmEJvVK02IjTnXNSCqAwQ1Tb+UcydoEuh
         w9yA==
X-Gm-Message-State: AOJu0YwYSqIvyx1uVLTj9heUVlJC02mNhPVB2GNba+Ahom0SMrS3BrGe
        6novd9FKd5eD9ch9Kn8t1a2yDA==
X-Google-Smtp-Source: AGHT+IEloZuZCLDePUs0QPFYOcybxWTkJkyfed9V3vJNhMuLIOUj4aXik2RMdRgdMNiAXc/amo3vnw==
X-Received: by 2002:a1c:7212:0:b0:401:bdd7:499d with SMTP id n18-20020a1c7212000000b00401bdd7499dmr17694790wmc.25.1696978195874;
        Tue, 10 Oct 2023 15:49:55 -0700 (PDT)
Received: from gpeter-l.lan (host-92-12-225-146.as13285.net. [92.12.225.146])
        by smtp.gmail.com with ESMTPSA id j13-20020adfe50d000000b003196b1bb528sm13689547wrm.64.2023.10.10.15.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:49:55 -0700 (PDT)
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
Subject: [PATCH v2 07/20] dt-bindings: pinctrl: samsung: add gs101-wakeup-eint compatible
Date:   Tue, 10 Oct 2023 23:49:15 +0100
Message-ID: <20231010224928.2296997-8-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231010224928.2296997-1-peter.griffin@linaro.org>
References: <20231010224928.2296997-1-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

gs101 is similar to newer Exynos SoCs like Exynos850 and ExynosAutov9
where more than one pin controller can do external wake-up interrupt.
So add a dedicated compatible for it.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
index 1de91a51234d..7cddce761c46 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
@@ -29,6 +29,7 @@ description: |
 properties:
   compatible:
     enum:
+      - google,gs101-wakeup-eint
       - samsung,s3c2410-wakeup-eint
       - samsung,s3c2412-wakeup-eint
       - samsung,s3c64xx-wakeup-eint
@@ -99,6 +100,7 @@ allOf:
             enum:
               - samsung,exynos850-wakeup-eint
               - samsung,exynosautov9-wakeup-eint
+              - google,gs101-wakeup-eint
     then:
       properties:
         interrupts: false
-- 
2.42.0.609.gbb76f46606-goog

