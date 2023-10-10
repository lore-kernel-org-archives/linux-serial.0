Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7806ACD98CD
	for <linux-serial@archiver.kernel.org>; Tue, 10 Oct 2023 22:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbjJJWuG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Oct 2023 18:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbjJJWuC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Oct 2023 18:50:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7F0B7
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 15:49:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3248ac76acbso5508480f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 15:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696978190; x=1697582990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/2N9VEhdnqQrQEGyRgCM8Oc2C7+rGrmYFce8KXEeog=;
        b=mQG6Hrl2svn//Fh9BHCehWkSnfcO9drzRrmCY3TLZ0Czl966zNTPOTMz/ASKtpQM2U
         fOZm/3I2L3NVpOuDtdnwA2a+XFsJmb7vh58H/2njPPcsak97ZFU2FzPHO4y/20Atxf6k
         E+nCDdYXKOorZ7WB7axTYwedyx8etr271Rt20ddiyIg5K6l590C32rYLx5oB7SuSC9nw
         6mLngp4ea+ofjRb/ew9he2r8/41K20nVrusk7KwySiL5v7tkQwvQvQ0aa+oL+e3wk9r9
         jeOH2bXICaUgN/JW7xkJKlwoxIxQ7XXXKOPCk3ORSe0p3Z8UZJ/NQqKRNrcxUg8AwjE3
         qAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978190; x=1697582990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/2N9VEhdnqQrQEGyRgCM8Oc2C7+rGrmYFce8KXEeog=;
        b=RJTusB1e/421R1N5XdW4vqouVrUjyr6RLj4btlHpTuDCmHosFo96M20E9Chb03WPwU
         685qZLjHNvUQaZnV+4ZFstWk/Deoc1546LBjnPpiFEOVGDBMC5GGodoasXYZ7V9mxYxI
         Sk/gsTZ8F5+TMMMi4qzHz0x1aL6uA8YPQvTbS76nlz1Q6ZWI9yoKqQyNBOtKnSAI8ctM
         mqy6m2WEA5WGbySrsXNeAZhUyYCfx6+4JHW7CVKGlmnLaK94XOB8RxTNDIjZMRWmyZl1
         aUTT0sz/kUxUCitu4PvqBvKXGfrjTuThe14pyMqU18/BQVqUUzviyUxlNsmJht9/rHzU
         rEkg==
X-Gm-Message-State: AOJu0YxnjR68zt6R4zyWgOWW9y0I0p5dRYZ1Zk16YIAVyoeiUrdfkf4r
        LpG/W71WtNV71eQjLFMIyl8xNA==
X-Google-Smtp-Source: AGHT+IH1+og7p5DzPPNzbqtLXyKGZvyfOjkS230zHmB92OxNHH9j/4yprSuLLOFfyAZIXF/2zZl1mw==
X-Received: by 2002:adf:e383:0:b0:323:39d2:5803 with SMTP id e3-20020adfe383000000b0032339d25803mr16775641wrm.3.1696978190529;
        Tue, 10 Oct 2023 15:49:50 -0700 (PDT)
Received: from gpeter-l.lan (host-92-12-225-146.as13285.net. [92.12.225.146])
        by smtp.gmail.com with ESMTPSA id j13-20020adfe50d000000b003196b1bb528sm13689547wrm.64.2023.10.10.15.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:49:50 -0700 (PDT)
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
Subject: [PATCH v2 03/20] dt-bindings: soc: google: exynos-sysreg: add dedicated SYSREG compatibles to GS101
Date:   Tue, 10 Oct 2023 23:49:11 +0100
Message-ID: <20231010224928.2296997-4-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231010224928.2296997-1-peter.griffin@linaro.org>
References: <20231010224928.2296997-1-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

GS101 has three different SYSREG controllers, add dedicated
compatibles for them to the documentation.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../bindings/soc/samsung/samsung,exynos-sysreg.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index 163e912e9cad..dbd12a97faad 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -30,6 +30,12 @@ properties:
               - samsung,exynos5433-fsys-sysreg
           - const: samsung,exynos5433-sysreg
           - const: syscon
+      - items:
+          - enum:
+              - google,gs101-peric0-sysreg
+              - google,gs101-peric1-sysreg
+              - google,gs101-apm-sysreg
+          - const: syscon
       - items:
           - enum:
               - samsung,exynos5433-sysreg
-- 
2.42.0.609.gbb76f46606-goog

