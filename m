Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BA4C4321E
	for <linux-serial@archiver.kernel.org>; Sat, 29 Jan 2022 17:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352943AbiA2Rxq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Jan 2022 12:53:46 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36196
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352729AbiA2Rxm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Jan 2022 12:53:42 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 34F3E3FFD0
        for <linux-serial@vger.kernel.org>; Sat, 29 Jan 2022 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643478819;
        bh=91aS3XOwWU5WTC4z2AKsnFVg6zaKlD32D1AoEn9HL0o=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=E21VNXUt524h0sbVwI4fgzz/YBSyybn5SY8Im7+UN2sXYdWxO/os+LcA2X6ccf55n
         DM+yYRs3Ot6KVWm00PXxnYs2X0i2TG02C76T8b7hCfeWSep/pcqoYhmbpOMriIy2cV
         q8vJ9Si7pqIWgmQwwimrjnxZg345PIO6gawwk5zEBSD5v/6PWI9UvwjBaPS0xO3gTa
         DW+8OpDDjI+E3APGTppf/Pik2j8r8s4S7FyLWVy8fvgEiGn1pMx85buqVwKgqe0KqV
         1bfp1GIIadGa4Bm8We3pBD0bBLlcBv9iH/8i8S0ZERdYGT9BeP7o2/PILyVNt8vpEx
         MaoKMIll97FWg==
Received: by mail-ed1-f70.google.com with SMTP id w3-20020a50c443000000b0040696821132so4665992edf.22
        for <linux-serial@vger.kernel.org>; Sat, 29 Jan 2022 09:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91aS3XOwWU5WTC4z2AKsnFVg6zaKlD32D1AoEn9HL0o=;
        b=y/Y3YbmPysU7XbD9sW86FEKaWTN9JMXCtk9pqJYkMlNa5ysG2XuYdf69HZGbeGHoFq
         EoY36KXP7/D2747UUwJ18+KuMmAdV63BxgpJUX/obhno/yZgipm6jC0/fGvnIetZW13e
         KCBLvwTIeWhIDTjqL7sjN0XwvPE6JKd3RLKFu5lIWjfOKIb9VZxLA7COYcE6nCPNCISm
         SnwGZvI9FzvKaYlWBW/FGsjcDjAC4GTxItP+UXZvlpbWzUkf32A5rAymgL/XVP3MSvz5
         0YQT+bYoIt56fXGnUGh5ZfKAMU0rFA8acdxOusAPMpycZx38mipbVC1XcgnwywsT9jGl
         v5Iw==
X-Gm-Message-State: AOAM5327+6aZOzOk4xidtW7kiixf5k0CgIAzKvaPJr5LbfwyZyjXGoXg
        dnqOnye5CzdarcMIAfybWnVcnNDSaPG8GUY0KSgSaCB33/nGhogPpOt52D4N6WCk8Zk3KgCph+H
        oJNfojas5cIHUCgBV1G3cPF6pZZcCA0lj6PLiSfA1Jw==
X-Received: by 2002:a17:907:a421:: with SMTP id sg33mr11650259ejc.108.1643478817849;
        Sat, 29 Jan 2022 09:53:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVNBn0kTfD4ogoNz392MYFzdBWozh3HfQi6t0ug4M8C7NNR8mOzvuDFSeROfurwcbyoSTatw==
X-Received: by 2002:a17:907:a421:: with SMTP id sg33mr11650253ejc.108.1643478817711;
        Sat, 29 Jan 2022 09:53:37 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s12sm11236266ejx.184.2022.01.29.09.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:53:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 3/5] mfd: exynos-lpass: Drop unneeded syscon.h include
Date:   Sat, 29 Jan 2022 18:53:30 +0100
Message-Id: <20220129175332.298666-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

syscon regmap is not used since commit addebf1588ab ("mfd: exynos-lpass:
Remove pad retention control").

Fixes: addebf1588ab ("mfd: exynos-lpass: Remove pad retention control")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/exynos-lpass.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 99bd0e73c19c..166cd21088cd 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-- 
2.32.0

