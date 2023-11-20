Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2610BC5AE5B
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 21:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjKTVVe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 16:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjKTVVW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 16:21:22 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36125123
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 13:21:17 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4083f613272so23316115e9.1
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 13:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700515276; x=1701120076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK3+J+uq1zdoJ4AWa77B+gNqjCRYeG1aCZZpF63aTJ0=;
        b=OvM3uzsk0Fy7QzOWF3X7F2CCQADhUQWKlU5551umnL541EWd1DpENmcWTWjpQEhrMo
         q4oM5UKNfCBbR4XfRAFdvB58QrWcRBgVMm5T0AxvaIutUASMGqtKbE8rOcEWsd0i7Aou
         pPoeoZ4fMfrspHE1AZzOg8GYEGSR216L4JF6rMNKyhi3a1hONV672fEngvQz6IMqk/N1
         ufrUX/GG0o/T17lwB4OXnz0fAZj7hzQ5fbmMvIKTxdQYpMvoz+8bdfk7xQ4xfTjkd/4/
         DzBU73nchL3BURGuX3DpOKUOQ+72ernVA54rdEO5uHNr8DG3ApBeQUWPEERoe5FB4x3+
         mN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700515276; x=1701120076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK3+J+uq1zdoJ4AWa77B+gNqjCRYeG1aCZZpF63aTJ0=;
        b=i1UG35w20AZCW0jBg+AdfIpibU6/BillWzEqroEKURdgkeJjUlF3XUgrYVhpYqWNfK
         YMdqV5KSybSPmoneyR5YX2H03R84JIaZ6F9mn5PpWs0PG+o8xtx84M+mc7jn9/aBOZ5M
         8FWPIRi6Sg4jwQ3MkKEKH8aNSit/Hfo6AGEF5E2UU1Ajeh/jGPTHyJb1V1a/9Y4txQEZ
         YXt+1mDqXouxPY7jaoOUTpLy68U0ECrSavT5j1lTcRWy3yqSTdS5UC0ECduTJf1SAa+2
         iELMkji8gyzYb01QeH810B4UFTDKT/ldTJC3pu1hKau3iIOGE1AurO/MVaRTG40i3LTh
         qLSQ==
X-Gm-Message-State: AOJu0YypUEKhOVTs/yo3kDNxoe4EleKyMnwip+58L71sC2rojFU3Y3tL
        H1CpA9FZBh++prZdC4eV4hUzGw==
X-Google-Smtp-Source: AGHT+IHRXdtnlZRBClLJAt3XTWnDX/mD73i3sd95M4tx/4bmM+eSRXliXrhZDPcmIFMdPyRbkhup5A==
X-Received: by 2002:a05:600c:4f84:b0:404:4b6f:d705 with SMTP id n4-20020a05600c4f8400b004044b6fd705mr7792272wmq.17.1700515276465;
        Mon, 20 Nov 2023 13:21:16 -0800 (PST)
Received: from gpeter-l.lan (host-92-29-24-243.as13285.net. [92.29.24.243])
        by smtp.gmail.com with ESMTPSA id je14-20020a05600c1f8e00b0040596352951sm19518451wmb.5.2023.11.20.13.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:21:15 -0800 (PST)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, cw00.choi@samsung.com,
        alim.akhtar@samsung.com
Cc:     peter.griffin@linaro.org, tudor.ambarus@linaro.org,
        andre.draszik@linaro.org, semen.protsenko@linaro.org,
        saravanak@google.com, willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Subject: [PATCH v4 07/19] dt-bindings: pinctrl: samsung: add gs101-wakeup-eint compatible
Date:   Mon, 20 Nov 2023 21:20:25 +0000
Message-ID: <20231120212037.911774-8-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231120212037.911774-1-peter.griffin@linaro.org>
References: <20231120212037.911774-1-peter.griffin@linaro.org>
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
index 1b75abebb953..41f3a2f2992e 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
@@ -30,6 +30,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - google,gs101-wakeup-eint
           - samsung,s3c2410-wakeup-eint
           - samsung,s3c2412-wakeup-eint
           - samsung,s3c64xx-wakeup-eint
@@ -104,6 +105,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - google,gs101-wakeup-eint
               - samsung,exynos850-wakeup-eint
               - samsung,exynosautov9-wakeup-eint
               - samsung,exynosautov920-wakeup-eint
-- 
2.43.0.rc1.413.gea7ed67945-goog

