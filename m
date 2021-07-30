Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F29C4320E
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 14:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F57061052
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 14:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbhG3Otx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbhG3Otl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 10:49:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1016FC061385
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 07:49:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so5910469edt.7
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ot32ht04BXO8SKhUwdTi6PwT+/ZyNLaqR53YTHmra28=;
        b=CH1XwFDMONkRoS0L/kjL/lrkowO/ss3qdcPZnBTDvs9TyvKmuerCCsIOLDQ9whEtb6
         LW4ewm6dUjJsvwEntmn+i8e6kPjj/FgSpYDhkxFjVmelJcH3ZhgN36FF0dxTD1qPnf6P
         FBXuv+h7IKzdGuw8Uyr2ElP4rMeGixDfNhev/gZamNoxmF/aIMYvjdbjO3vcgi/079cy
         07aaQRfBED4oskkILUpFNugLxcz+o6RS1BLFD4+OdlaR9aXEiIpedeZE8fE1ovYCH5R3
         lxiDVpYXFudf4biV3k/60rOdqE665ZtCoAD4SoPrQtq8xxCqsIwIZU8i9D+EL4Q9Wbl8
         KTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ot32ht04BXO8SKhUwdTi6PwT+/ZyNLaqR53YTHmra28=;
        b=YgCNyzkXbHTB2BGEHadKTxw49ASgstpYIWFyM3guprR8y5kQhyDJYK4jHyJRJSi5ct
         tGbiQOjcp3WxHfU1Ox9DqTdimblwE5KBgmh4jqJNaSWRn7pXo9TSTDL3QmeQGKYwN3nU
         lYTLyYrTu2FfXtr1df/XEUfnA+hAESbOmcEUCc2iq5U8hLpSY4H6ap7P9TZQ+hH4Bx4b
         4ws5C28N+qng/ByU3aSERyqgs/UkXXrqPzd5qwcCWXrhO33n6nFWj/rVoCKN54WWI9uW
         7C4jiMywcJ8LMhXQzD02zkH35FkqKpWqtM3j8pL/MoK5HEo5G9YPm9gU1FBPpmgq+J8H
         5EtA==
X-Gm-Message-State: AOAM532+zTPXTetnR35w91R2JbC10mBZOu3Q/IZj5jEwbWxJOLZIYVQv
        yi/ZEm8z/77qUVPMJRuskku6NA==
X-Google-Smtp-Source: ABdhPJzJHeG6sX0rfzJjBc24DJrsJii8Q6q/W+APtZpb/CrAtPhcTiGt4fyoTMLI3v8zLI+1ZAdKFA==
X-Received: by 2002:aa7:df09:: with SMTP id c9mr3446384edy.379.1627656571652;
        Fri, 30 Jul 2021 07:49:31 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id ks26sm639920ejb.58.2021.07.30.07.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:49:31 -0700 (PDT)
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
Subject: [PATCH 05/12] tty: serial: samsung: Fix driver data macros style
Date:   Fri, 30 Jul 2021 17:49:15 +0300
Message-Id: <20210730144922.29111-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730144922.29111-1-semen.protsenko@linaro.org>
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Make checkpatch happy by fixing this error:

    ERROR: Macros with complex values should be enclosed in parentheses

Although this change is made to keep macros consistent with consequent
patches (adding driver data for new SoC), it's intentionally added as a
separate patch to ease possible porting efforts in future.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 0f3cbd0b37e3..75ccbb08df4a 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2817,8 +2817,8 @@ static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
 #define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos4210_serial_drv_data)
 #define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos5433_serial_drv_data)
 #else
-#define EXYNOS4210_SERIAL_DRV_DATA (kernel_ulong_t)NULL
-#define EXYNOS5433_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
+#define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif
 
 #ifdef CONFIG_ARCH_APPLE
-- 
2.30.2

