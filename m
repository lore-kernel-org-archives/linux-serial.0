Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A52192D8A;
	Fri, 17 Apr 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437635; cv=none; b=hKyjmy97/GDyLny2kA8b5K5kl2znggw/LgijHP2/srO7MGFAmGsxZq2e7ZxgqB3zy81KDVHuj+w4LZfV4f6SG3lrP/thALeOcaxp/1j+KdhzSfdLo4+zgcUKi2Za0iwO5hUBxj8u3Kr/6VNX0ZBtg6zZVU21XrAkizazOc6zePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437635; c=relaxed/simple;
	bh=UNudewfjvyoV8ABjfnvOj20qV1TrUz1eiZ21jyqfUII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+1DcjZerePys92dgy9Bbo0oNSlnMzsQc439c2WxzANHSSwUnSzbytYxiTaPbalCdEKqVL84/fr2ikrO46roQ9epHYj0kkXoa8f9PAD0UCBlvC05Tif7gMM3nUW2D9UNYNxXhhYSTpx+XiDRLJTYoiHJqemM25P04w2MnVHEDQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=FzvQDmIX; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="FzvQDmIX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=Sx0/zlAN75BLOsrNobfWggda/c+gvNYRx6rqXR8H2mc=; b=FzvQDmIXE5yNkRpuBuioaXTgLE
	EmgCmcR0NRxLA5vrDO0hnGeizWceolia3cbuA0r8cqzLHxPcZqTwhWoaUGtu5Ff9XY2BZ0yUyd9E8
	oHUcQncpwxwSO39jKtoupsm/SOUjQ02NwhE2X2ocRrVx6CKgGZoWXY3p/29Ym4rzmRMU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDkZm-000000006G1-0TqZ;
	Fri, 17 Apr 2026 10:53:46 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Fri, 17 Apr 2026 10:53:32 -0400
Subject: [PATCH 05/10] serial: max310x: improve max310x_set_ref_clk()
 efficiency
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-max310x-2-v1-5-b424e105ecac@dimonoff.com>
References: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
In-Reply-To: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The same basic code is duplicated for each of the four PLL multiplier
values, so simplify and streamline it. Doing so allows us to avoid
some unnecessary (fdiv * factor) multiplications for some fdiv values and
replace the second "if" statement with an "else if" and avoid a useless
comparison.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 91 +++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 39 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index f689958736f71b15b7c113214cda60db4aa7c593..1cd7632831a2826ddd42127b1cde2a10dfa412f0 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -258,6 +258,17 @@
 #define MAX14830_BRGCFG_CLKDIS_BIT	(1 << 6) /* Clock Disable */
 #define MAX14830_REV_ID			(0xb0)
 
+struct max310x_clk_config_t {
+	u8 prediv; /* Predivider */
+	u8 pll_mult; /* PLL multiplier */
+	unsigned int fref; /*
+			    * Reference clock for fractional baud rate generator:
+			    *   PLL enabled:  (freq / prediv) x pll_mult
+			    *   PLL disabled: freq
+			    */
+	unsigned int err; /* Computed error for selected parameters */
+};
+
 struct max310x_if_cfg {
 	int (*extended_reg_enable)(struct device *dev, bool enable);
 	u8 rev_id_offset;
@@ -545,70 +556,72 @@ static int max310x_set_baud(struct uart_port *port, int baud)
 	return (16*port->uartclk) / (c*(16*div + frac));
 }
 
-static int max310x_update_best_err(unsigned int f, unsigned int *besterr)
+static void max310x_try_cfg(unsigned int fdiv, u8 div, u8 pll_mult,
+			    struct max310x_clk_config_t *cfg)
 {
+	unsigned int fmul = fdiv * pll_mult;
+	unsigned int err;
+
 	/* Use high-enough baudrate to calculate error */
-	unsigned int err = f % (460800 * 16);
+	err = fmul % (460800 * 16);
 
-	if (*besterr > err) {
-		*besterr = err;
-		return 0;
+	if (cfg->err > err) {
+		cfg->err = err;
+		cfg->pll_mult = pll_mult;
+		cfg->prediv = div;
+		cfg->fref = fmul;
 	}
+}
 
-	return 1;
+static u8 max310x_pll_mult_to_id(u8 pll_mult)
+{
+	switch (pll_mult) {
+	case 144:	return 3;
+	case 96:	return 2;
+	case 48:	return 1;
+	case 6:
+	default:	return 0;
+	}
 }
 
 static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 			       unsigned int freq, unsigned int *fref, bool xtal)
 {
-	unsigned int div, clksrc, pllcfg = 0;
-	unsigned int besterr = UINT_MAX;
-	unsigned int fdiv, fmul, bestfreq = freq;
+	unsigned int div, fdiv, clksrc;
+	struct max310x_clk_config_t cfg;
+
+	cfg.err = UINT_MAX;
+	cfg.prediv = 0;
+	cfg.fref = freq;
 
 	/* First, update error without PLL */
-	max310x_update_best_err(freq, &besterr);
+	max310x_try_cfg(freq, 1, 1, &cfg);
 
 	/* Try all possible PLL dividers */
-	for (div = 1; (div <= 63) && besterr; div++) {
+	for (div = 1; (div <= 63) && cfg.err; div++) {
 		fdiv = DIV_ROUND_CLOSEST(freq, div);
 
-		/* Try multiplier 6 */
-		fmul = fdiv * 6;
 		if ((fdiv >= 500000) && (fdiv <= 800000))
-			if (!max310x_update_best_err(fmul, &besterr)) {
-				pllcfg = (0 << 6) | div;
-				bestfreq = fmul;
-			}
-		/* Try multiplier 48 */
-		fmul = fdiv * 48;
-		if ((fdiv >= 850000) && (fdiv <= 1200000))
-			if (!max310x_update_best_err(fmul, &besterr)) {
-				pllcfg = (1 << 6) | div;
-				bestfreq = fmul;
-			}
-		/* Try multiplier 96 */
-		fmul = fdiv * 96;
+			max310x_try_cfg(fdiv, div, 6, &cfg);   /* PLL x6 */
+		else if ((fdiv >= 850000) && (fdiv <= 1200000))
+			max310x_try_cfg(fdiv, div, 48, &cfg);  /* PLL x48 */
+
 		if ((fdiv >= 425000) && (fdiv <= 1000000))
-			if (!max310x_update_best_err(fmul, &besterr)) {
-				pllcfg = (2 << 6) | div;
-				bestfreq = fmul;
-			}
-		/* Try multiplier 144 */
-		fmul = fdiv * 144;
+			max310x_try_cfg(fdiv, div, 96, &cfg);  /* PLL x96 */
+
 		if ((fdiv >= 390000) && (fdiv <= 667000))
-			if (!max310x_update_best_err(fmul, &besterr)) {
-				pllcfg = (3 << 6) | div;
-				bestfreq = fmul;
-			}
+			max310x_try_cfg(fdiv, div, 144, &cfg); /* PLL x144 */
 	}
 
 	/* Configure clock source */
 	clksrc = MAX310X_CLKSRC_EXTCLK_BIT | (xtal ? MAX310X_CLKSRC_CRYST_BIT : 0);
 
 	/* Configure PLL */
-	if (pllcfg) {
+	if (cfg.prediv) {
+		u8 pll_id = max310x_pll_mult_to_id(cfg.pll_mult);
+
 		clksrc |= MAX310X_CLKSRC_PLL_BIT;
-		regmap_write(s->regmap, MAX310X_PLLCFG_REG, pllcfg);
+		regmap_write(s->regmap, MAX310X_PLLCFG_REG, (pll_id << 6) | cfg.prediv);
 	} else
 		clksrc |= MAX310X_CLKSRC_PLLBYP_BIT;
 
@@ -632,7 +645,7 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 					     "clock is not stable\n");
 	}
 
-	*fref = bestfreq;
+	*fref = cfg.fref;
 
 	return 0;
 }

-- 
2.47.3

