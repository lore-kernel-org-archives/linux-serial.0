Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC326C43214
	for <linux-serial@archiver.kernel.org>; Wed, 11 Aug 2021 11:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61BF6024A
	for <linux-serial@archiver.kernel.org>; Wed, 11 Aug 2021 11:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhHKLtR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Aug 2021 07:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbhHKLtE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Aug 2021 07:49:04 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46833C061765
        for <linux-serial@vger.kernel.org>; Wed, 11 Aug 2021 04:48:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d6so3277875edt.7
        for <linux-serial@vger.kernel.org>; Wed, 11 Aug 2021 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPjQiKeY/Pm3cwK5bLlcgaOU8O6PA1oY+1ashl1tZII=;
        b=IBsFx07oFf+vCulkJ+TaU4TZ8+TJY7oRmjHzjramGo3IIB07cb0AjF6zdiGjwHYAW1
         Tqpupcr9JZsUIoJFv1IAonhPLja4SYBbpCNk3GPYB/qAtLnsD0IiIE6ENOhM2pqkGIaI
         DlOftRgyt6Bms1W57ULog+ewElYtugxn1FuQZRM33zfR4PP0cjXG1gn/cJpD6Sa2FwZc
         irT8vkNxP1o74fHgkJXCSPt8ggwKVdCqyPX+/i+Ezu0Tdba8YHfaDLvUnZzFWtmzCevp
         SS4oLTSxNCSMx15LdVhMiCi6HdkCWUNefTItnCF1Y8977X4crqedED2lFf/7d3JVpwmu
         8Kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPjQiKeY/Pm3cwK5bLlcgaOU8O6PA1oY+1ashl1tZII=;
        b=X6Wf+RQWzCPyH7cvQ6l9rpnkhqB0iK3QC/Qvx2ZpUsHAH/r1KiKOhz0mcHkgkqWDQy
         Cjpm2745X/5E0Xndkt8TNJINZ/ZOsN6Ykm+IXBXvhP3SVjgLvIE5Opv07/1yQDprYGLq
         6tAjeabCgTzi+/Vp4M0Dr3dcBFHs4QXJ7wxoA6hajgpcwDWvCVItNXKo1eE6mPWJAzfK
         yUnNHBKSCZgNCUyW6Tjr8LSkzDLhuEcp2Z68oYYhykE6L63d0okFFEGImaZJ0rZhmykw
         /gj224DdYFSNUlGkGYN9nXI+U/5YVzXJyKpcVl2Iuwaj4IyTUwR+h+2rfexKV0FXFagR
         Nn6A==
X-Gm-Message-State: AOAM531SDIEKHyDenVcTqxWJCcbMlBw+4OZrW9Fg3/hUCp1yhNoMS4as
        tazyCVg2t+vesRxbxktSvYC7lA==
X-Google-Smtp-Source: ABdhPJwwQlTLXrsIYXHANtNL1PihNzfAw6ogeS76lZDqO+9edFnOzfqvWzpuGkVw7nv8oKZ34mb/SA==
X-Received: by 2002:a50:ed05:: with SMTP id j5mr11111037eds.256.1628682516768;
        Wed, 11 Aug 2021 04:48:36 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id lw15sm8073337ejb.50.2021.08.11.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 04:48:36 -0700 (PDT)
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
Subject: [PATCH v3 5/7] tty: serial: samsung: Fix driver data macros style
Date:   Wed, 11 Aug 2021 14:48:25 +0300
Message-Id: <20210811114827.27322-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811114827.27322-1-semen.protsenko@linaro.org>
References: <20210811114827.27322-1-semen.protsenko@linaro.org>
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
Changes in v3:
  - None

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

