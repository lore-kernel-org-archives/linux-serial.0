Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E524CDB47B
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 18:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjJKStS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjJKStR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 14:49:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1262D9
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 11:49:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3232be274a0so876703f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697050153; x=1697654953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjn+HCp9G7ZHzIyDxbnLCnTHGxIfK36bGHTjBoI+aL0=;
        b=HALuFxuctaoY5FsdXFeK6hiBeTxfgFHGMMfphvzbqafnZcRbBsQXyuuIUHtTvWAqqJ
         zmKU6AQBdyM6cJSHakwxZOQ33XTE0tWM+XWD4VqZR4EOtnymX8GG8kfYWapSYQkAmgDx
         GDAkX5YuwUBsoBIgVduhn3ahqR/0b3Y3IzOk/Kl+7Y0py5f/1V/ae53zA5mOzKGpVkfG
         fm4p4VTO9bwxJUXSzIbvAwnfk4/fY0WRwrR2tfvJ6fQkgHM8vJkY8hjghTjtLhnGSVe8
         p1oZfHRGZsAOoRxjEI773HC8A6M4v5uz7Kep0AiQEH0I0dpooDo6D30evCRMLS/tLFe1
         WDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050153; x=1697654953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjn+HCp9G7ZHzIyDxbnLCnTHGxIfK36bGHTjBoI+aL0=;
        b=a4JsiZPPajzqqvmS0fSimsvtNuH0wbFlTo3J9Ed8wXnm4HX5DNT+6N0BCCe5k9DGkH
         MRvZcp0PKukYa5nCjaUokkZCbEYYPhiTagHH5TIDO7Rf6GycSQ1H7tSVADAo68//GvNg
         p2jQEDe1oYvMG6Tjwed3F1X3O8Wve6lP7tZHsjEdtYQFS9s6JXMBq8HI63fvgEIkTO8Z
         C1UpftAnxBTRt3yyApM+Bz74Jg4WkWIOEbZC55EYC2g7CsO5wjVuq0LSR/M//JspBdlI
         PJRKrwTZKu2Pe4ezG3P2AMDXcsJGhU2UFo8hGXQef3XZbQAZZF/2Njz+ChKwQHPouVsy
         ysYw==
X-Gm-Message-State: AOJu0Yz/60s35nLf1PeoKGH4xj6JzJa+m6B91iZJzi1URS0m6xZ+7xvf
        n7KZoLZEHR2gqfHyxwnAITDrZA==
X-Google-Smtp-Source: AGHT+IFOwG6H4bUwl9oYnw/1oaFVA9Ze2qjkasIInOAk9yMIVanltuFWLRsVMEOKeF1K8mucpLtxfA==
X-Received: by 2002:adf:ab0f:0:b0:32d:8113:eda3 with SMTP id q15-20020adfab0f000000b0032d8113eda3mr3616045wrc.10.1697050153044;
        Wed, 11 Oct 2023 11:49:13 -0700 (PDT)
Received: from gpeter-l.lan (host-92-12-225-146.as13285.net. [92.12.225.146])
        by smtp.gmail.com with ESMTPSA id v6-20020adff686000000b0031980294e9fsm16003875wrp.116.2023.10.11.11.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:49:12 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org,
        cw00.choi@samsung.com
Cc:     peter.griffin@linaro.org, tudor.ambarus@linaro.org,
        andre.draszik@linaro.org, semen.protsenko@linaro.org,
        saravanak@google.com, willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Subject: [PATCH v3 01/20] dt-bindings: soc: samsung: exynos-pmu: Add gs101 compatible
Date:   Wed, 11 Oct 2023 19:48:04 +0100
Message-ID: <20231011184823.443959-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231011184823.443959-1-peter.griffin@linaro.org>
References: <20231011184823.443959-1-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add gs101-pmu compatible to the bindings documentation.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index e1d716df5dfa..9e497c310532 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -15,6 +15,7 @@ select:
     compatible:
       contains:
         enum:
+          - google,gs101-pmu
           - samsung,exynos3250-pmu
           - samsung,exynos4210-pmu
           - samsung,exynos4212-pmu
@@ -35,6 +36,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - google,gs101-pmu
               - samsung,exynos3250-pmu
               - samsung,exynos4210-pmu
               - samsung,exynos4212-pmu
-- 
2.42.0.655.g421f12c284-goog

