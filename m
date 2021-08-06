Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42324C43214
	for <linux-serial@archiver.kernel.org>; Fri,  6 Aug 2021 15:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246AA611BF
	for <linux-serial@archiver.kernel.org>; Fri,  6 Aug 2021 15:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244526AbhHFPWV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Aug 2021 11:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244400AbhHFPWQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Aug 2021 11:22:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBDCC0617BD
        for <linux-serial@vger.kernel.org>; Fri,  6 Aug 2021 08:21:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c24so15321698lfi.11
        for <linux-serial@vger.kernel.org>; Fri, 06 Aug 2021 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1kCCgoXt/RH2VyRBayEiDwtnpxlIkmp9gMMzKnZ2tY=;
        b=gTKdWZTGrq0nkIjUWSQPn/d5ZzZ3QDECPUQd4NMQL76ikDODLNIB29E9+uxjHaiZaZ
         QYknqk3wRZTH9ky1MsXU76Kj1EyvNEcgNYTRNBR0D8796K9P1di9lJA4DsRcX+Wz0sE2
         +/AVYm5a+YbbL7gFe3qNVI485mAkTJGiM0ThXfA5DSdQB9d8zuLxMzz7zHG7yqIyoOBl
         6Sf6NM/uBUwsOAC2iSzEevFDDgnzXJ5jPJDYp1ke/nC4a6yEqMyVZAqa962W3cm9Kmt5
         QUIqpkShTrlGeD0Z3PH0Bq1nHCG8G2RaDuNM+IER7PX760GzZuEy0niDMIJmBT4lyJOT
         ZnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1kCCgoXt/RH2VyRBayEiDwtnpxlIkmp9gMMzKnZ2tY=;
        b=WXbuMUjhTeHQysuZ8U+zoxXD/coxQx+emqeH5UMFMyOLfwjLAD6Ef0J/kfpyV+R+lf
         FEAliuNffJ3gyjd35HZZjApau91RtfsCy/o6skO/ePatlem5KTdcd4kXMhMUngnbZ3LM
         TnzWslfWeqEQ4GL8l3OynlfDfXFeSAsWh39jzgfvgYFRtL+e6Wdm0UkfIhYgM93ntGOj
         HfzuvnE2rGG1lnY1L0fK0e+pPVvVX7fleZrEZAckzPsyGXZnioz/UeL9C9XLz00N6axU
         nFIYX24qI9mXUW+TPK2AMoN5fGw+p4ZyC17LnRtkx9lvbqwoWq9wG6zR0taH8HTbSDH5
         f0JQ==
X-Gm-Message-State: AOAM53341d2gkpeIuLDgJy3aqknu+Mi4oinu55UZ66nXXCbd+PMh4O7A
        c5WR93sipjxxTngtEnxjb/jlmQ==
X-Google-Smtp-Source: ABdhPJwYlIS3ylvtYTVOsdN67qQi0hBTMhLV3llriBHUAISYG65bfxAvCkFBB9c5J5yE88XuOqqt2w==
X-Received: by 2002:ac2:42d2:: with SMTP id n18mr3695877lfl.505.1628263316001;
        Fri, 06 Aug 2021 08:21:56 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id u9sm861444lfc.278.2021.08.06.08.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 08:21:55 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 5/8] tty: serial: samsung: Fix driver data macros style
Date:   Fri,  6 Aug 2021 18:21:43 +0300
Message-Id: <20210806152146.16107-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210806152146.16107-1-semen.protsenko@linaro.org>
References: <20210806152146.16107-1-semen.protsenko@linaro.org>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Added Reviewed-by tag by Krzysztof Kozlowski

 drivers/tty/serial/samsung_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index b8034c1168e0..130bdc978e93 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2816,8 +2816,8 @@ static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
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

