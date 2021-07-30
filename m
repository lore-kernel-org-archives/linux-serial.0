Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E431CC41537
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 14:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D245360C3F
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 14:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbhG3Ote (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbhG3Otc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 10:49:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E38C061798
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 07:49:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h8so13545901ede.4
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTDgPgWodE/cSRF6bHIc6D1D5Dn1jvPwRYXuY/lAMLo=;
        b=TkueiDTdOMqYTmTxIiWclFQDmAoJQIi9pKg/pDn4T1rA2VjfILkGJNRgYCunu870MP
         qypWhzFqenbxNDZV4QPpZvTBiL0T6ZzwAkBRHMaovinMWM8mTUwcZ1jc6pskjFipGKIM
         IXhUOo6SBJYFp2Yht0rWwR6rKjHOixSLarchv5uf56EVbCILFXRb+G0Y547em6aa4I8/
         BqZr3+joyNVs85IjpkswpDcIjciP+mlO9g6EoGxO1/d3NIEJTlZbuskA5bb08gAkGtd4
         2oFBaMMAzmc1lYRJdhu9xkPqeQH6gQLUdBaAq+YpDbbvFgnFduiJnZeySi1IBccyGB81
         Sgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTDgPgWodE/cSRF6bHIc6D1D5Dn1jvPwRYXuY/lAMLo=;
        b=HZa3wBoFN7ocO84qdH3cJ7nKvaeJ60aUWTcDXJ4CpUvH53FrfPpMpoY1fZ1vo7TBFw
         u+YKjYtyGvw8xFHLA98YBzw4nXJuaLUtZNbMXgsAnbK7A0SSc8c0QW2RYUqqVtB/1b1T
         bSonDbJRVPLoDSqAQsW4HodQiRO2STLbc5LdTLtFQMmFawGlucViEZqPEha7PKo89vW2
         2FfvgRVkN5rWTQ/ss8s4o6BokZyInKDwx9MJ1Yee23eNdZSl3XFAuMBVBQF6xeqZwbdQ
         jCCtzOHbgiqs8rYQg6S/P7lalKfqlIVjBMpDpQJWESoUOzyoJl5DXYUmHKWAjSTPRDYk
         8sEQ==
X-Gm-Message-State: AOAM532nbefWOv7Yiv/d9C4bIAfJGt2J/gEv7jzqbfwSBQ0XpSKmPNG/
        ViNbFCDMm4lcuPvwFoE3rTD97Q==
X-Google-Smtp-Source: ABdhPJwQ3Vu/iMAI2TwOY1RDcotd+8kXvX1qj2ZROjO1I6ex2OtKHUvLBmtYk8c0mf//n0KTncs5Fw==
X-Received: by 2002:a05:6402:31ba:: with SMTP id dj26mr3436625edb.252.1627656565567;
        Fri, 30 Jul 2021 07:49:25 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id o17sm629581ejb.84.2021.07.30.07.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:49:25 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 01/12] pinctrl: samsung: Fix pinctrl bank pin count
Date:   Fri, 30 Jul 2021 17:49:11 +0300
Message-Id: <20210730144922.29111-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730144922.29111-1-semen.protsenko@linaro.org>
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jaehyoung Choi <jkkkkk.choi@samsung.com>

Commit 1abd18d1a51a ("pinctrl: samsung: Register pinctrl before GPIO")
changes the order of GPIO and pinctrl registration: now pinctrl is
registered before GPIO. That means gpio_chip->ngpio is not set when
samsung_pinctrl_register() called, and one cannot rely on that value
anymore. Use `pin_bank->nr_pins' instead of `pin_bank->gpio_chip.ngpio'
to fix mentioned inconsistency.

Fixes: 1abd18d1a51a ("pinctrl: samsung: Register pinctrl before GPIO")
Signed-off-by: Jaehyoung Choi <jkkkkk.choi@samsung.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 376876bd6605..2975b4369f32 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -918,7 +918,7 @@ static int samsung_pinctrl_register(struct platform_device *pdev,
 		pin_bank->grange.pin_base = drvdata->pin_base
 						+ pin_bank->pin_base;
 		pin_bank->grange.base = pin_bank->grange.pin_base;
-		pin_bank->grange.npins = pin_bank->gpio_chip.ngpio;
+		pin_bank->grange.npins = pin_bank->nr_pins;
 		pin_bank->grange.gc = &pin_bank->gpio_chip;
 		pinctrl_add_gpio_range(drvdata->pctl_dev, &pin_bank->grange);
 	}
-- 
2.30.2

