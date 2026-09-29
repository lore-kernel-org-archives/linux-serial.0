Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17473A9D9D;
	Tue, 29 Sep 2026 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663692; cv=none; b=GSDxuIwg6E05gzPTsm9VEUpdloSLUXDwhfazYoklo1QZsUqjMzjicK1WFq7sdp0co4M1gFj4zXQm5f3aa4v5E8yPrGnc3RntxVFuHWfdhzT3k++gqVlzYAwfz7lXYMbWsA/mgURdPv9lwtJHQbUzehUfZVfxe0R0ErfY81oqGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663692; c=relaxed/simple;
	bh=oudDqCI8gCTEKBtLemVfZpCdX+ws/C/Gx3qJwekcyv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxbSTNI53ApMV9sa07F7+ZOB0ErKHVI1fFXwK5Sm3PTXpEo4nB3OkIZez7Uj0lzxUoO07f0239FfKLmyrwOMl2bNsq2CX1dJNtRzNHCn6WQovOGPi2kSxi+2loQO1J7ERYujqYlrsrmjlkr3sf9swRcKQfDlKbGwPAFeu1IX1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLQTXz1I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLQTXz1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F211F00893;
	Tue, 29 Sep 2026 06:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663691;
	bh=+bgvhx+iNJqLGuHfNN4D1vVvbWmzHanZN0EWQocVqr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RLQTXz1ITGYxNI9eJeEDaA971P+RD5CZ8/xv+1R2g0gtikE9xaqECWlOakkYXyghn
	 ero6A+z5tG86q6G7R47Y3U57/sFK09xCQ62oxAQINz6nnx8JHmJL73nyjx1K4fepTu
	 tWVbcGQcWmKsTTdtFzxmyPHTLkhR5pu6DkodfgexrKFY59fuyNA0WnxoACwgl3T0zb
	 koZYcdwXu+eIUDneEUj4k5qgc5OwzIdjVl3/oU4yqyJUcNcGfKU1LTYgOKTkmzxuh5
	 ykiNJyRaZRM+Wg2Tfu3PoaqfoPkB1iA+2YpjO1LSkkMASP2I9M50h2/oyWsOqh2F+a
	 IAdcUCktu7DLw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/20] i3c: dw: switch to array-based exclusive reset control
Date: Tue, 29 Sep 2026 14:14:02 +0800
Message-ID: <20260929061417.20733-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260929061417.20733-1-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Synopsys DesignWare I3C master controller can have multiple reset
lines, such as a core reset and APB reset.

Refactor the driver to use devm_reset_control_array_get_exclusive()
instead of a single named reset handle. This automatically manages all
resets allocated to the device node sequentially.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/i3c/master/dw-i3c-master.c | 24 ++++++++++++++++++------
 drivers/i3c/master/dw-i3c-master.h |  2 +-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 4563d8761ba0..1c6c870f5bb3 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1657,6 +1657,11 @@ static const struct dw_i3c_platform_ops dw_i3c_platform_ops_default = {
 	.set_dat_ibi = dw_i3c_platform_set_dat_ibi_nop,
 };
 
+static void dw_i3c_resets_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 int dw_i3c_common_probe(struct dw_i3c_master *master,
 			struct platform_device *pdev)
 {
@@ -1696,10 +1701,17 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	if (IS_ERR(master->pclk))
 		return PTR_ERR(master->pclk);
 
-	master->core_rst = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev,
-										NULL);
-	if (IS_ERR(master->core_rst))
-		return PTR_ERR(master->core_rst);
+	master->resets = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
+	if (IS_ERR(master->resets))
+		return PTR_ERR(master->resets);
+
+	ret = reset_control_deassert(master->resets);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, dw_i3c_resets_assert, master->resets);
+	if (ret)
+		return ret;
 
 	spin_lock_init(&master->xferqueue.lock);
 	INIT_LIST_HEAD(&master->xferqueue.list);
@@ -1873,7 +1885,7 @@ static int __maybe_unused dw_i3c_master_runtime_suspend(struct device *dev)
 
 	dw_i3c_master_disable(master);
 
-	reset_control_assert(master->core_rst);
+	reset_control_assert(master->resets);
 	dw_i3c_master_disable_clks(master);
 	pinctrl_pm_select_sleep_state(dev);
 	return 0;
@@ -1885,7 +1897,7 @@ static int __maybe_unused dw_i3c_master_runtime_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 	dw_i3c_master_enable_clks(master);
-	reset_control_deassert(master->core_rst);
+	reset_control_deassert(master->resets);
 
 	dw_i3c_master_set_intr_regs(master);
 	dw_i3c_master_restore_timing_regs(master);
diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
index 17ad817d1f8e..f5b4491b247a 100644
--- a/drivers/i3c/master/dw-i3c-master.h
+++ b/drivers/i3c/master/dw-i3c-master.h
@@ -36,7 +36,7 @@ struct dw_i3c_master {
 	} xferqueue;
 	struct dw_i3c_master_caps caps;
 	void __iomem *regs;
-	struct reset_control *core_rst;
+	struct reset_control *resets;
 	struct clk *core_clk;
 	struct clk *pclk;
 	char version[5];
-- 
2.53.0

