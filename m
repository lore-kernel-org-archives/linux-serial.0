Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D8330F7F2;
	Wed, 24 Sep 2025 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728279; cv=none; b=deGqHMZ9Urq5Lx90pq5IoV2etNZvJD90+Zb2yXJTXjS5P9OVZTZa+vzNdi4yoCpKt+wna09b/hafkQvubWqvBMaoB/2oJ45d7nItbfm9XzXdyKAZrxpPDZsrtGwYA1Fg86DqtbUj0RuUtD0rhEL6Z0oAwbvKIQWnU26lvfefaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728279; c=relaxed/simple;
	bh=7Ha/GqIua9/ChaOBE549z8GD/x5rObpIWEV80xKeEI8=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=Y3zSVXfa8mAGMRSf44oOzyQYJSBb0ir4Rq3EBKTEya6BItT4RTtOIUES53HKKUIzndICR7IvoHq93yncTH6YYXoAQw//541ZfTyg1X10eKPrJwX53uz7PAgn43vuq6RzAzYR5xJZUa4Suq9yvKJpF15oOAiDZwwUumihzPr+LyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ztKidnXP; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ztKidnXP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=8jMeiYcJ4IAwPEnHXSKqmQcGOw+ff5KoMj+tTxq4440=; b=ztKidnXPK+awpM0kFEny8u7NPV
	UF7JJTBCCpbKN3tU7kIyqoXuZGdpDYCaL82/UWT8SznKZ0JamIGIPsuefqvgW2hbFOkfa1XVoY9cG
	vGXxN8vfxlVvp9/W2UVQnSLKTVjVLo/NhRIkZp5DNpTVVN6VMmVAMakXr/xOPb3CHzXE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RZ0-0000RT-Ka; Wed, 24 Sep 2025 11:37:51 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Sep 2025 11:37:29 -0400
Message-Id: <20250924153740.806444-5-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924153740.806444-1-hugo@hugovil.com>
References: <20250924153740.806444-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 04/15] serial: sc16is7xx: define common register access function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Rename lock/unlock functions to make it more generic and applicable to both
the Enhanced register set and the Special register set.

Use this new generic function when accessing the Special register set in
sc16is7xx_set_baud(), and when accessing the Enhanced register set in
sc16is7xx_set_termios() and sc16is7xx_probe().

This helps readability and also avoid to make future mistakes when
accessing these obfuscated registers.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 74 ++++++++++++++--------------------
 1 file changed, 31 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 26b34f23ed5fe..72e4c4f80f7f5 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -421,20 +421,24 @@ static void sc16is7xx_power(struct uart_port *port, int on)
 }
 
 /*
- * In an amazing feat of design, the Enhanced Features Register (EFR)
- * shares the address of the Interrupt Identification Register (IIR).
- * Access to EFR is switched on by writing a magic value (0xbf) to the
- * Line Control Register (LCR). Any interrupt firing during this time will
- * see the EFR where it expects the IIR to be, leading to
+ * In an amazing feat of design, the enhanced register set shares the
+ * addresses 0x02 and 0x04-0x07 with the general register set.
+ * The special register set also shares the addresses 0x00-0x01 with the
+ * general register set.
+ *
+ * Access to the enhanced or special register set is enabled by writing a magic
+ * value to the Line Control Register (LCR). When enhanced register set access
+ * is enabled, for example, any interrupt firing during this time will see the
+ * EFR where it expects the IIR to be, leading to
  * "Unexpected interrupt" messages.
  *
- * Prevent this possibility by claiming a mutex while accessing the EFR,
- * and claiming the same mutex from within the interrupt handler. This is
- * similar to disabling the interrupt, but that doesn't work because the
- * bulk of the interrupt processing is run as a workqueue job in thread
- * context.
+ * Prevent this possibility by claiming a mutex when access to the enhanced
+ * or special register set is enabled, and claiming the same mutex from within
+ * the interrupt handler. This is similar to disabling the interrupt, but that
+ * doesn't work because the bulk of the interrupt processing is run as a
+ * workqueue job in thread context.
  */
-static void sc16is7xx_efr_lock(struct uart_port *port)
+static void sc16is7xx_regs_lock(struct uart_port *port, u8 register_set)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
@@ -443,18 +447,18 @@ static void sc16is7xx_efr_lock(struct uart_port *port)
 	/* Backup content of LCR. */
 	one->old_lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
 
-	/* Enable access to Enhanced register set */
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_REG_SET_ENHANCED);
+	/* Enable access to the desired register set */
+	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, register_set);
 
-	/* Disable cache updates when writing to EFR registers */
+	/* Disable cache updates when writing to non-general registers */
 	regcache_cache_bypass(one->regmap, true);
 }
 
-static void sc16is7xx_efr_unlock(struct uart_port *port)
+static void sc16is7xx_regs_unlock(struct uart_port *port)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	/* Re-enable cache updates when writing to normal registers */
+	/* Re-enable cache updates when writing to general registers */
 	regcache_cache_bypass(one->regmap, false);
 
 	/* Restore original content of LCR */
@@ -580,8 +584,6 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
  */
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
-	u8 lcr;
 	unsigned int prescaler = 1;
 	unsigned long clk = port->uartclk, div = clk / 16 / baud;
 
@@ -595,23 +597,15 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			      SC16IS7XX_MCR_CLKSEL_BIT,
 			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
 
-	mutex_lock(&one->lock);
-
-	/* Backup LCR and access special register set (DLL/DLH) */
-	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
-			     SC16IS7XX_LCR_REG_SET_SPECIAL);
+	/* Access special register set (DLL/DLH) */
+	sc16is7xx_regs_lock(port, SC16IS7XX_LCR_REG_SET_SPECIAL);
 
 	/* Write the new divisor */
-	regcache_cache_bypass(one->regmap, true);
 	sc16is7xx_port_write(port, SC16IS7XX_DLH_REG, div / 256);
 	sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
-	regcache_cache_bypass(one->regmap, false);
 
-	/* Restore LCR and access to general register set */
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
-
-	mutex_unlock(&one->lock);
+	/* Restore access to general register set */
+	sc16is7xx_regs_unlock(port);
 
 	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
 }
@@ -1108,12 +1102,12 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
 	/* Update EFR registers */
-	sc16is7xx_efr_lock(port);
+	sc16is7xx_regs_lock(port, SC16IS7XX_LCR_REG_SET_ENHANCED);
 	sc16is7xx_port_write(port, SC16IS7XX_XON1_REG, termios->c_cc[VSTART]);
 	sc16is7xx_port_write(port, SC16IS7XX_XOFF1_REG, termios->c_cc[VSTOP]);
 	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
 			      SC16IS7XX_EFR_FLOWCTRL_BITS, flow);
-	sc16is7xx_efr_unlock(port);
+	sc16is7xx_regs_unlock(port);
 
 	/* Get baud rate generator configuration */
 	baud = uart_get_baud_rate(port, termios, old,
@@ -1631,6 +1625,9 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		if (ret)
 			goto out_ports;
 
+		/* Enable access to general register set */
+		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG, 0x00);
+
 		/* Disable all interrupts */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_IER_REG, 0);
 		/* Disable TX/RX */
@@ -1650,20 +1647,11 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 
 		port_registered[i] = true;
 
-		/* Enable EFR */
-		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
-				     SC16IS7XX_LCR_REG_SET_ENHANCED);
-
-		regcache_cache_bypass(regmaps[i], true);
-
+		sc16is7xx_regs_lock(&s->p[i].port, SC16IS7XX_LCR_REG_SET_ENHANCED);
 		/* Enable write access to enhanced features */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFR_REG,
 				     SC16IS7XX_EFR_ENABLE_BIT);
-
-		regcache_cache_bypass(regmaps[i], false);
-
-		/* Restore access to general registers */
-		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG, 0x00);
+		sc16is7xx_regs_unlock(&s->p[i].port);
 
 		/* Go to suspend mode */
 		sc16is7xx_power(&s->p[i].port, 0);
-- 
2.39.5

