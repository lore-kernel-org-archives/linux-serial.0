Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BB30ACFB;
	Mon, 27 Oct 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575413; cv=none; b=pD7pxp2qfLnyha3omjiVw6R7UEFd+FbmTScCJwv6rC6n0vRN17C314OELfXqa3whQjufM8BhUfE0d97e7K3mW5HVN8tced89VXU40Ys+2Grd6OjtqIabFPykBaWdMixUEkIEGTJQ2u2w2V/HeqOllVNT9+s0+D4qjTRwX0ANEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575413; c=relaxed/simple;
	bh=ToQyPN+TlA1UPUy/7j+kBOYM/xKJ643CH87sHP0DMXU=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=G/JOQ0EGXpngR1Ai2w55dzwyuO6REM/uCAAmEt33HcirP6kpYb6rFxEzlyh7QKVKfOc5Cfk7Xuvh2xkBJNVWVWMiOQseIANm2w5Tl8Lklio5lhekA385gHCbj5575vYg59QI/ZikpnhwPSkZR1b8/6JgkNe4Xdc7cXswp776ExE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=GGOMbVdl; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GGOMbVdl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=ekdaWYWzuGlTbvIE22/p4Lpz6i0MAI27A3e2yCrkMgE=; b=GGOMbVdloMuWGoqQp/tvF+WiF1
	wGG4tn9YqNX6N+kQlKsWT2QerU9eqfy9YebDFtytTrR+nJAh0lEPph4Kx/Yz/egQFRvp+s5aJDBwf
	Tzn0xwCjuzFVdBxy/Z3mbCiLoyWawu76XM73YEgsKq+PxNIasgzlqNb6HiZlR6iBOB6I=;
Received: from [70.80.174.168] (port=45472 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vDOEb-0007wg-Tl; Mon, 27 Oct 2025 10:30:10 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 27 Oct 2025 10:29:50 -0400
Message-Id: <20251027142957.1032073-9-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027142957.1032073-1-hugo@hugovil.com>
References: <20251027142957.1032073-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v3 08/14] serial: sc16is7xx: move port/channel init to separate function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The sc16is7xx_probe() function is very long. To improve readability, move
port/channel initialization to a separate function.

No functional change intended.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 127 ++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 57 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 281cbb2274e50..a7a6d613459dc 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1499,6 +1499,75 @@ static int sc16is7xx_reset(struct device *dev, struct regmap *regmap)
 	return 0;
 }
 
+static int sc16is7xx_setup_channel(struct sc16is7xx_one *one, int i,
+				   bool *port_registered)
+{
+	struct uart_port *port = &one->port;
+	int ret;
+
+	ret = ida_alloc_max(&sc16is7xx_lines, SC16IS7XX_MAX_DEVS - 1, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	port->line = ret;
+
+	/* Initialize port data */
+	port->type	= PORT_SC16IS7XX;
+	port->fifosize	= SC16IS7XX_FIFO_SIZE;
+	port->flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
+	port->iobase	= i;
+	/*
+	 * Use all ones as membase to make sure uart_configure_port() in
+	 * serial_core.c does not abort for SPI/I2C devices where the
+	 * membase address is not applicable.
+	 */
+	port->membase	= (void __iomem *)~0;
+	port->iotype	= UPIO_PORT;
+	port->rs485_config = sc16is7xx_config_rs485;
+	port->rs485_supported = sc16is7xx_rs485_supported;
+	port->ops	= &sc16is7xx_ops;
+	one->old_mctrl	= 0;
+
+	mutex_init(&one->lock);
+
+	ret = uart_get_rs485_mode(port);
+	if (ret)
+		return ret;
+
+	/* Enable access to general register set */
+	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, 0x00);
+
+	/* Disable all interrupts */
+	sc16is7xx_port_write(port, SC16IS7XX_IER_REG, 0);
+	/* Disable TX/RX */
+	sc16is7xx_port_write(port, SC16IS7XX_EFCR_REG,
+			     SC16IS7XX_EFCR_RXDISABLE_BIT |
+			     SC16IS7XX_EFCR_TXDISABLE_BIT);
+
+	/* Initialize kthread work structs */
+	kthread_init_work(&one->tx_work, sc16is7xx_tx_proc);
+	kthread_init_work(&one->reg_work, sc16is7xx_reg_proc);
+	kthread_init_delayed_work(&one->ms_work, sc16is7xx_ms_proc);
+
+	/* Register port */
+	ret = uart_add_one_port(&sc16is7xx_uart, port);
+	if (ret)
+		return ret;
+
+	*port_registered = true;
+
+	sc16is7xx_regs_lock(port, SC16IS7XX_LCR_REG_SET_ENHANCED);
+	/* Enable write access to enhanced features */
+	sc16is7xx_port_write(port, SC16IS7XX_EFR_REG,
+			     SC16IS7XX_EFR_ENABLE_BIT);
+	sc16is7xx_regs_unlock(port);
+
+	/* Go to suspend mode */
+	sc16is7xx_power(port, 0);
+
+	return 0;
+}
+
 int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		    struct regmap *regmaps[], int irq)
 {
@@ -1582,70 +1651,14 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 	}
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
-		ret = ida_alloc_max(&sc16is7xx_lines,
-				    SC16IS7XX_MAX_DEVS - 1, GFP_KERNEL);
-		if (ret < 0)
-			goto out_ports;
-
-		s->p[i].port.line = ret;
-
-		/* Initialize port data */
 		s->p[i].port.dev	= dev;
 		s->p[i].port.irq	= irq;
-		s->p[i].port.type	= PORT_SC16IS7XX;
-		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
-		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
-		s->p[i].port.iobase	= i;
-		/*
-		 * Use all ones as membase to make sure uart_configure_port() in
-		 * serial_core.c does not abort for SPI/I2C devices where the
-		 * membase address is not applicable.
-		 */
-		s->p[i].port.membase	= (void __iomem *)~0;
-		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.uartclk	= freq;
-		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
-		s->p[i].port.rs485_supported = sc16is7xx_rs485_supported;
-		s->p[i].port.ops	= &sc16is7xx_ops;
-		s->p[i].old_mctrl	= 0;
 		s->p[i].regmap		= regmaps[i];
 
-		mutex_init(&s->p[i].lock);
-
-		ret = uart_get_rs485_mode(&s->p[i].port);
+		ret = sc16is7xx_setup_channel(&s->p[i], i, &port_registered[i]);
 		if (ret)
 			goto out_ports;
-
-		/* Enable access to general register set */
-		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG, 0x00);
-
-		/* Disable all interrupts */
-		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_IER_REG, 0);
-		/* Disable TX/RX */
-		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFCR_REG,
-				     SC16IS7XX_EFCR_RXDISABLE_BIT |
-				     SC16IS7XX_EFCR_TXDISABLE_BIT);
-
-		/* Initialize kthread work structs */
-		kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
-		kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
-		kthread_init_delayed_work(&s->p[i].ms_work, sc16is7xx_ms_proc);
-
-		/* Register port */
-		ret = uart_add_one_port(&sc16is7xx_uart, &s->p[i].port);
-		if (ret)
-			goto out_ports;
-
-		port_registered[i] = true;
-
-		sc16is7xx_regs_lock(&s->p[i].port, SC16IS7XX_LCR_REG_SET_ENHANCED);
-		/* Enable write access to enhanced features */
-		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFR_REG,
-				     SC16IS7XX_EFR_ENABLE_BIT);
-		sc16is7xx_regs_unlock(&s->p[i].port);
-
-		/* Go to suspend mode */
-		sc16is7xx_power(&s->p[i].port, 0);
 	}
 
 	sc16is7xx_setup_irda_ports(s);
-- 
2.39.5

