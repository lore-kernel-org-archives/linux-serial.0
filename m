Return-Path: <SRS0=BKBA=DN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA3BC4363D
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 22:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0993A20B1F
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 22:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgJFWYv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:24:51 -0400
Received: from fgw23-7.mail.saunalahti.fi ([62.142.5.84]:29635 "EHLO
        fgw23-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgJFWYv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Oct 2020 18:24:51 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 807b162a-0820-11eb-8ccd-005056bdfda7;
        Wed, 07 Oct 2020 01:08:45 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 2/2] serial: max310x: Use devm_clk_get_optional() to get the input clock
Date:   Wed,  7 Oct 2020 01:08:43 +0300
Message-Id: <20201006220843.582459-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006220843.582459-1-andy.shevchenko@gmail.com>
References: <20201006220843.582459-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Simplify the code which fetches the input clock by using
devm_clk_get_optional(). If no input clock is present
devm_clk_get_optional() will return NULL instead of an error
which matches the behavior of the old code.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/tty/serial/max310x.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index f25b9516109c..9795b2e8b0b2 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1273,7 +1273,6 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 			 struct regmap *regmap, int irq)
 {
 	int i, ret, fmin, fmax, freq, uartclk;
-	struct clk *clk_osc, *clk_xtal;
 	struct max310x_port *s;
 	bool xtal = false;
 
@@ -1287,23 +1286,24 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		return -ENOMEM;
 	}
 
-	clk_osc = devm_clk_get(dev, "osc");
-	clk_xtal = devm_clk_get(dev, "xtal");
-	if (!IS_ERR(clk_osc)) {
-		s->clk = clk_osc;
+	s->clk = devm_clk_get_optional(dev, "osc");
+	if (IS_ERR(s->clk))
+		return PTR_ERR(s->clk);
+	if (s->clk) {
 		fmin = 500000;
 		fmax = 35000000;
-	} else if (!IS_ERR(clk_xtal)) {
-		s->clk = clk_xtal;
-		fmin = 1000000;
-		fmax = 4000000;
-		xtal = true;
-	} else if (PTR_ERR(clk_osc) == -EPROBE_DEFER ||
-		   PTR_ERR(clk_xtal) == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
 	} else {
-		dev_err(dev, "Cannot get clock\n");
-		return -EINVAL;
+		s->clk = devm_clk_get_optional(dev, "xtal");
+		if (IS_ERR(s->clk))
+			return PTR_ERR(s->clk);
+		if (s->clk) {
+			fmin = 1000000;
+			fmax = 4000000;
+			xtal = true;
+		} else {
+			dev_err(dev, "Cannot get clock\n");
+			return -EINVAL;
+		}
 	}
 
 	ret = clk_prepare_enable(s->clk);
-- 
2.28.0

