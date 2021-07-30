Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E99C19F35
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 14:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C29060C3F
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 14:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbhG3OuN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbhG3OuC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 10:50:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE65C061299
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 07:49:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id f13so13479661edq.13
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQGRmp6w/PSekRXBpdFwg0L2q55A125G3jOg4JhNBfI=;
        b=K2aZWGktsgMltZ3WLzBixgOfIHWcImbQSJya4GM1UG4HTCccAN1gtNKZdXnDZa6xs7
         Q8SkI6yYdX+gWCzQAhq9hY1d0wvUlH9k3nueLL5Hxfjtt7Cf6MZrLGDzjshOdHQhIKcb
         eVglYOajtTjQAP8vR+xbsgEYdgpMfCVbVtitIdzAI7m8eb1UO9NAuGE9jFgkXTzX47bw
         KaTKRkMRrhDZpGkLFHXOk9vPLbemW1gt41649JDo51nymBKJ/0kzYYMgU8AvXnclNOB+
         tpo22Hl7+hPbldDb4DhfGH1Ji4VRwSBYiYtptEjFhlcn/W8RRVQ6I58JDN3e60h4dQHu
         y1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQGRmp6w/PSekRXBpdFwg0L2q55A125G3jOg4JhNBfI=;
        b=FqIK317C++lop3lyLwQ+PoTaEe/bBeLlGfP7D/QokPqxRAuJsZCglXwhcLjbmFcrUH
         jCNiwjpE+zYSnP5maXx/lKnIkxjGKcQ8GoziDUlMtTkluJYSQ1F04ggNl1yDt/kiNRNf
         g4q5SD6KQdD3OT7tZigf8WaTzVosCd+/j47Fj2mCHkTtJi6qEpknOppsIXNvJLa09C9X
         Sji9/xPOtFp4a+ZsYSe4AX9vA6ZRXJIpCj11p2JNiYAXkGGIpqYr/RTaquOXDTzbTr5x
         r9M1Cd70nD81+ebYk2Wju5GyofbzBjPtLSpReLSrHWrEE3qL8w+WiNkDwl9wcB5s6FvO
         +sWQ==
X-Gm-Message-State: AOAM531zeseJS/kvJp9GTLewOFi5rw568EI0wc0jsm/VQVi2xts0RFoA
        3rXcIqR9vd+b79FlSpkdvhIhTw==
X-Google-Smtp-Source: ABdhPJxn0sgrAzc8oH2ckgTDzHk+Zg1E5gqFm4yp+FA/Rh9DceW9eF7J/ZELRVS4eClsIdsbkum/UA==
X-Received: by 2002:a05:6402:26ca:: with SMTP id x10mr3404671edd.319.1627656579080;
        Fri, 30 Jul 2021 07:49:39 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id p18sm783100edu.8.2021.07.30.07.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:49:38 -0700 (PDT)
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
Subject: [PATCH 10/12] clk: samsung: Add Exynos850 clock driver stub
Date:   Fri, 30 Jul 2021 17:49:20 +0300
Message-Id: <20210730144922.29111-11-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730144922.29111-1-semen.protsenko@linaro.org>
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For now it's just a stub driver to make serial driver work. Later it
will be implemented properly.

This driver doesn't really change clocks, only registers the UART clock
as a fixed-rate clock. Without this clock driver the UART driver won't
work, as it's trying to obtain "uart" clock and fails if it's not able
to. From drivers/tty/serial/samsung_tty.c:

8<------------------------------------------------------------------->8
    ourport->clk = clk_get(&platdev->dev, "uart");
    if (IS_ERR(ourport->clk)) {
        pr_err("%s: Controller clock not found\n",
                dev_name(&platdev->dev));
        ret = PTR_ERR(ourport->clk);
        goto err;
    }
8<------------------------------------------------------------------->8

In order to get functional serial console we have to implement that
minimal clock driver with "uart" clock. It's not necessary to actually
configure clocks, as those are already configured in bootloader, so
kernel can rely on that for now.

80 column limit is broken here to make checkpatch happy, otherwise it
swears about incorrect __initconst usage.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/Makefile        |  1 +
 drivers/clk/samsung/clk-exynos850.c | 63 +++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 drivers/clk/samsung/clk-exynos850.c

diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 028b2e27a37e..c46cf11e4d0b 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos5433.o
 obj-$(CONFIG_EXYNOS_AUDSS_CLK_CON) += clk-exynos-audss.o
 obj-$(CONFIG_EXYNOS_CLKOUT)	+= clk-exynos-clkout.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7.o
+obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos850.o
 obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
 obj-$(CONFIG_S3C2410_COMMON_DCLK)+= clk-s3c2410-dclk.o
 obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
new file mode 100644
index 000000000000..3192ec9bb90b
--- /dev/null
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ * Copyright (C) 2021 Linaro Ltd.
+ *
+ * Common Clock Framework support for Exynos850 SoC.
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <dt-bindings/clock/exynos850.h>
+
+#include "clk.h"
+
+/* Fixed rate clocks generated outside the SoC */
+static struct samsung_fixed_rate_clock exynos850_fixed_rate_ext_clks[] __initdata = {
+	FRATE(OSCCLK, "fin_pll", NULL, 0, 26000000),
+};
+
+/*
+ * Model the UART clock as a fixed-rate clock for now, to make serial driver
+ * work. This clock is already configured in the bootloader.
+ */
+static const struct samsung_fixed_rate_clock exynos850_peri_clks[] __initconst = {
+	FRATE(DOUT_UART, "DOUT_UART", NULL, 0, 200000000),
+};
+
+static const struct of_device_id ext_clk_match[] __initconst = {
+	{ .compatible = "samsung,exynos850-oscclk", .data = (void *)0 },
+	{},
+};
+
+void __init exynos850_clk_init(struct device_node *np)
+{
+	void __iomem *reg_base;
+	struct samsung_clk_provider *ctx;
+
+	if (!np)
+		panic("%s: unable to determine soc\n", __func__);
+
+	reg_base = of_iomap(np, 0);
+	if (!reg_base)
+		panic("%s: failed to map registers\n", __func__);
+
+	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
+	if (!ctx)
+		panic("%s: unable to allocate ctx\n", __func__);
+
+	samsung_clk_of_register_fixed_ext(ctx,
+			exynos850_fixed_rate_ext_clks,
+			ARRAY_SIZE(exynos850_fixed_rate_ext_clks),
+			ext_clk_match);
+
+	samsung_clk_register_fixed_rate(ctx, exynos850_peri_clks,
+			ARRAY_SIZE(exynos850_peri_clks));
+
+	samsung_clk_of_add_provider(np, ctx);
+}
+
+CLK_OF_DECLARE(exynos850_clk, "samsung,exynos850-clock", exynos850_clk_init);
-- 
2.30.2

