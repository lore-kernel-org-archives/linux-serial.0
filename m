Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89634C5B562
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjKTVV0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 16:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjKTVVT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 16:21:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B56112
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 13:21:16 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso13160785e9.0
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 13:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700515275; x=1701120075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NsnumtnbKszDWmEuPJ5XUAgIpj0ZFdzasox3xFNKr0=;
        b=t0+feOf1744F8D+mICOZXx5LZsPsEZKVlDpJqQWsiiN6tCubU5i9orU2FY6Wynm/zA
         YpDY6vFRL3I89MKxQlJ/qpaCQTTP3jHCb3U6HgSKEKuzBzmAKW01oESufxOXYAuzS5Cm
         Ns4I2HqlfxEf/XtnvGH8jGF62FTKYdxhuZTvjDMqu3Zs36pgXDKuIZhPQvoBpKo9nLe+
         1mv/skouUWTFbcZZ47ms5kNXFz+6XV2mN3Qd2FhF+hQUpxMycu8Ttl6GlTuUwkOd6aKE
         afr60q1U+dWKTq30pNIwB8CedG+oXAayANGDXjd/u8bJkCTQc4y6dqLPCvekb46qUVPn
         YoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700515275; x=1701120075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NsnumtnbKszDWmEuPJ5XUAgIpj0ZFdzasox3xFNKr0=;
        b=uqCgcEUzHrzhDzSJ0fv+jlhZi5u2cKb6v7P+kwhPCBj9amgbInSNieKoZ9XPgDIZC0
         37Y9A9h0v7lob3HkSflOBpfWpGu6mCSy7wwuhiaQ67MeMYXdxTRaMXX5nbD6ys3YKvmn
         8v+zr0OetXhtSu2uuF/9SMZ42G/WNYbXfTgux6+IGNkIOOc8NOpe3OV2hhLdpiCNjnBG
         IgxE9gVn6yeHGUuHNHyKkC2WLe3GA3UiO/XgZQGlLtyhGw+lTtbEQOIPJ4BXb3wf7Cd1
         Re9Rmja0EES5RSkEYzMqWl3N0gpozuttoP6BTPFIj1MHSpA+fLACdmBycZZSE2HUNvT5
         445g==
X-Gm-Message-State: AOJu0Yw0BtkNe0seTHdv58zNdpcTv72EMbzQjBLylcnm8i/4lvkZt5xK
        K8JVj3AAq7JyxnZulaQwBSH8Hg==
X-Google-Smtp-Source: AGHT+IG5ZwJvWcYcJc/wTZ1l5RXXLGRwNPXG44HsXn19tlQN9POBjwgDY072AatSXGa6s25Knq1luA==
X-Received: by 2002:a1c:7902:0:b0:405:3ab3:e640 with SMTP id l2-20020a1c7902000000b004053ab3e640mr518638wme.20.1700515274997;
        Mon, 20 Nov 2023 13:21:14 -0800 (PST)
Received: from gpeter-l.lan (host-92-29-24-243.as13285.net. [92.29.24.243])
        by smtp.gmail.com with ESMTPSA id je14-20020a05600c1f8e00b0040596352951sm19518451wmb.5.2023.11.20.13.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:21:14 -0800 (PST)
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
Subject: [PATCH v4 06/19] dt-bindings: pinctrl: samsung: add google,gs101-pinctrl compatible
Date:   Mon, 20 Nov 2023 21:20:24 +0000
Message-ID: <20231120212037.911774-7-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231120212037.911774-1-peter.griffin@linaro.org>
References: <20231120212037.911774-1-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the "google,gs101-pinctrl" compatible to the dt-schema bindings
documentation.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
index 9f04a0c76403..118549c25976 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
@@ -35,6 +35,7 @@ properties:
 
   compatible:
     enum:
+      - google,gs101-pinctrl
       - samsung,s3c2412-pinctrl
       - samsung,s3c2416-pinctrl
       - samsung,s3c2440-pinctrl
-- 
2.43.0.rc1.413.gea7ed67945-goog

