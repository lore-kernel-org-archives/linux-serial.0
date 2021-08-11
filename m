Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDDDC4320A
	for <linux-serial@archiver.kernel.org>; Wed, 11 Aug 2021 11:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2880460FD9
	for <linux-serial@archiver.kernel.org>; Wed, 11 Aug 2021 11:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhHKLtH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Aug 2021 07:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbhHKLtC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Aug 2021 07:49:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AFEC0617B1
        for <linux-serial@vger.kernel.org>; Wed, 11 Aug 2021 04:48:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o23so3720046ejc.3
        for <linux-serial@vger.kernel.org>; Wed, 11 Aug 2021 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVbMUoW3ODB/HqrQj9QMsvg4UcjoOQphLtGJOfXQLG4=;
        b=tLqQ1Q4ZmDF0GWwO+C3F55BzoRVX2dKIyhgtgjHKKcJn/PcEISO/vhg4T66jllGPyg
         TjL2SEOYBd7o3vq+4AF3hONbsZpQByl/Rk2hxzZOAGtutCcFzU52yl9J+ILf6urD6uWk
         3t5Jn8isV1aAB6i+H0GzYszNThuxbsDspjFZ3A/anNv1LF1M3h/KRpVJ3Xveg4LiBPXt
         7WP3eNNpcEqwwR0rFHbuaOYmivA4J05/89x6Bko10CbWApIzxD0+KQdxxTtG6Gab2uAA
         OCrlQrN1jcMFhV/PJcP27Mks2CN71g1Hoy/V/qTiQq+3EGsfugqpRtw2o9PGX9/IjGTl
         zzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVbMUoW3ODB/HqrQj9QMsvg4UcjoOQphLtGJOfXQLG4=;
        b=aBDt9+wKF4iHjiAlQi5Kkqy20cmcikl0pg9nnUIc+ad9Bao95vfUdw3ZKQ8lS6zCJk
         2T3nm41VZ20upRxBWlQYyBnhgTp2LJx2fl/XEu3Oevf+Bint6MtoN3jH2QvMLhqp6Fok
         IOluBrY4qhuLo/MZRyf+cCC4cR26zXm0Eg4YJsLakxH4gQIb3zGDiTh/V/PEA139Z9+U
         vcWilKXDjypoxz/EB0GDus1ENQtNFm/onfT9drPmUhlVctmCq4937kTvyQc3W5ljFKKr
         yVAdw8IM/ZGY66mRl+J3OrzMVnAqwwTSM4YhqLParVOMsUfpeaHTyDn7dilVs0hNlc8N
         EkYw==
X-Gm-Message-State: AOAM530yf08opowxe/pZPW984BhU7wQqoVO6/uyAt2+PRQeLYN3ZfyuH
        jgv6XUzEA2/6zcpBZEXHHhhLVA==
X-Google-Smtp-Source: ABdhPJxJLRHsH9CfRsfHJsy6TvmFx2W6Ic3KvGkXHyeQaKob/XnyuXcDZvw12C575KwVBsfnb1InOA==
X-Received: by 2002:a17:906:5413:: with SMTP id q19mr3265627ejo.422.1628682513955;
        Wed, 11 Aug 2021 04:48:33 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id i10sm11096232edf.12.2021.08.11.04.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 04:48:33 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
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
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v3 3/7] dt-bindings: serial: samsung: Add Exynos850 doc
Date:   Wed, 11 Aug 2021 14:48:23 +0300
Message-Id: <20210811114827.27322-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811114827.27322-1-semen.protsenko@linaro.org>
References: <20210811114827.27322-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add compatible string for Exynos850 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - None

Changes in v2:
  - None

 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index f064e5b76cf1..2940afb874b3 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -26,6 +26,7 @@ properties:
           - samsung,s3c6400-uart
           - samsung,s5pv210-uart
           - samsung,exynos4210-uart
+          - samsung,exynos850-uart
 
   reg:
     maxItems: 1
-- 
2.30.2

