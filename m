Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65490356771;
	Mon, 21 Sep 2026 04:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964614; cv=none; b=gWlO6FkMx8ucR+Z0tBzv2oRXiX21LxwgI7+sUhXRRMG86Bm6lcibWG4gDJ3oaBgKssLC6YFIyVhbZeur1oHO2sGL/Ja3jHcBEa+hIlIAx0NFbBRibOdffNHZ6uwlNRh8qIjW4yxrQRO6Rk7EpB6FyWc9HOoIchK1qHMWPeRVZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964614; c=relaxed/simple;
	bh=5GFqfQIbCg2UdEeRrw8f0OXijIQlOGnsXzu/vsVQh9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q4X3Pwz6H/sKajy/oRmBUc3SNDdPS5wjwl8yo61uodDNDdOlyPH0G80xWbuyKF1OmRWe3qa3OXCKvP/imXyuuzHVBUMJZ4jftsR5gpox1csdMTe2D0OiTl+5m42ENFKApdJHDHYG1eAiMYR9RHVYsZgvpDXUexkbzhjvaBa3ozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg3xOG4G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg3xOG4G"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D4DDC4AF17;
	Mon, 21 Sep 2026 04:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789964614;
	bh=5GFqfQIbCg2UdEeRrw8f0OXijIQlOGnsXzu/vsVQh9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Qg3xOG4GIlp+dgIbRZOPp8I8kSys9o/MQieZT4I5M+5szZPFrO2LbyX6vGEbfuxS3
	 vxhL2zlh847Kfy78UH49eGIjMjLbdUwgRIBXRZpqLGBr/Gb7DGaARrIOxb5KpBYiFb
	 BcRsabuyWMF4Q+lW1Rl2ctgyuJoczrEJSOHHJ4wOIGV+FM4XK99qkZF6AhF+9md5tn
	 RpWS2CZQcwXykkE96QYk0XmaMzI1y9/ADPjUaY+ziIzmIbW07+D3yG5EYp3ZzOzjmo
	 HofdHMHy7c3iyiax2ZxvxZcGzCYyy1I/aAFLSgWzPYPndSUpurfsGUNiQhkIXHPcz2
	 t7N2rMgz32dTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2846BC982DA;
	Mon, 21 Sep 2026 04:23:34 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 21 Sep 2026 12:23:35 +0800
Subject: [PATCH v8 16/18] serial: 8250_dw: add Ambarella CV75 quirks
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260921-cv75-v5-v8-16-282ff5d98dda@ambarella.com>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
In-Reply-To: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>, 
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789964608; l=3394;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=r8t/FG9wW+i95rGWMVag4aWVspLRurIpWPfr+INLVog=;
 b=CQ2ycm49wgwpbFs89pTVhnJ24beBELoj5OXJpDsx5OH+Ig/6p77MRYZrAY3GJ4puVhb/THLb2
 FP2iDhCh2g/DvqUvGKnCKtsf2nPlYqUgrr0prxJvY/gltzsRI1pGItU
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

The Ambarella CV75 UART is Ambarella IP, not a Synopsys DesignWare
licensed block. At the register level it is close enough to DW APB UART
that a full custom UART driver is unnecessary: reuse 8250_dw with a
small platform quirk.

Quirks:
- keep IER ETOI (bit 5) set for RX timeout behaviour
- skip set_rate; baud clock is managed outside the UART block

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/tty/serial/8250/8250_dw.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 5fba913f3301..06f03e893346 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -43,6 +43,9 @@
 #define RZN1_UART_xDMACR_8_WORD_BURST	(2 << 1)
 #define RZN1_UART_xDMACR_BLK_SZ(x)	((x) << 3)
 
+/* Ambarella IER: receive timeout interrupt enable */
+#define AMBARELLA_UART_IER_ETOI		BIT(5)
+
 /* Quirks */
 #define DW_UART_QUIRK_OCTEON		BIT(0)
 #define DW_UART_QUIRK_ARMADA_38X	BIT(1)
@@ -60,6 +63,7 @@
 
 struct dw8250_platform_data {
 	u8 usr_reg;
+	u8 ier_mask;
 	u32 cpr_value;
 	unsigned int quirks;
 };
@@ -572,6 +576,25 @@ static void dw8250_prepare_rx_dma(struct uart_8250_port *p)
 	dw8250_writel_ext(up, RZN1_UART_RDMACR, val);
 }
 
+static int dw8250_ier_mask_startup(struct uart_port *p)
+{
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+	int ret;
+
+	ret = serial8250_do_startup(p);
+	if (ret)
+		return ret;
+
+	/*
+	 * Ambarella keeps variant IER bits (e.g. ETOI) set for correct RX
+	 * timeout behaviour.
+	 */
+	up->ier |= d->pdata->ier_mask;
+
+	return 0;
+}
+
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
 	unsigned int quirks = data->pdata->quirks;
@@ -606,6 +629,8 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		p->serial_in = dw8250_serial_in32;
 		data->uart_16550_compatible = true;
 	}
+	if (data->pdata->ier_mask)
+		p->startup = dw8250_ier_mask_startup;
 }
 
 static void dw8250_reset_control_assert(void *data)
@@ -879,6 +904,12 @@ static const struct dw8250_platform_data dw8250_intc10ee = {
 	.quirks = DW_UART_QUIRK_IER_KICK,
 };
 
+static const struct dw8250_platform_data dw8250_ambarella_cv75_data = {
+	.usr_reg = DW_UART_USR,
+	.ier_mask = AMBARELLA_UART_IER_ETOI,
+	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
+};
+
 static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
 	.usr_reg = DW_UART_USR,
 	.cpr_value = FIELD_PREP_CONST(DW_UART_CPR_ABP_DATA_WIDTH, 2) |
@@ -890,6 +921,7 @@ static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
 
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
+	{ .compatible = "ambarella,cv75-uart", .data = &dw8250_ambarella_cv75_data },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },

-- 
2.34.1


