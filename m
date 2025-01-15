Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BA422F397;
	Wed, 15 Jan 2025 05:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736918961; cv=none; b=TeXriFO0jtEkkRjC0EN6+4rgEG9rjnuCkx/oHcU6yLHV8ctnwvANFYvMP2BKlh/bzoE0GdMb55iSDSyA2wUpcAZUxPKwBxHEriyBfWtLLQ/XxZRK8RuxFONpNQX8rQS/KcS3voIh31YgJyKu7+sf9+Kgj4hm1c2XlFI7/m9FaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736918961; c=relaxed/simple;
	bh=15vISLEFmhZT5eZz3ZWj8X7kjiMs2WR2CnqANRurGpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uD894DE6BsXrG664Ne1V0RPekfHvUvPbwi24rvvr8xqwpyJ1JEz0N6X075uKRDZGd11VD6HhyZILMd7mH14Os49JT6KheHLBSAkHwGW3tNK8D69uQSuu3LOeo4Im/j6WNJBu80xid/CPtYfy03qPT3qwPs/FufAE3aRUsWUZxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com; spf=pass smtp.mailfrom=aa.jp.fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=azKe+7aO; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="azKe+7aO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736918959; x=1768454959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=15vISLEFmhZT5eZz3ZWj8X7kjiMs2WR2CnqANRurGpQ=;
  b=azKe+7aOZfXN3y/4H7FWH6FlD2ToCfTAiu69x845RCLNphfUaVyzc2bS
   RXW/XpHcJHpyxrL1/7dKRTCeM/OnNSphu9sRMIEvygcNkQ43MuR6bIDQ/
   nw+ncNyQxQ8nJ7utL3Tn2bDTAJzU8SDYZ9agFTqmr6GwNloaNtPnGqGCU
   3aJjETW1b3DNB5jXGGnsf8/uBJXnjKgbFuId98iJzRQfUcIQBaIuCdipE
   fs6yacNNkvHqrCDNmjwS45Uf8BhUt/pKC32M1ncrdMxk+4YQOkM63YgY2
   vaChfxzsAkcAZSMqr54o5hLJBXkuYBHL/OyG7G2yFXfEG3W71Z6fKAQ6b
   w==;
X-CSE-ConnectionGUID: GMqX8c9CQ7iLalE5bYSPwQ==
X-CSE-MsgGUID: iYjvzsNDQu6/c7ziBPpfnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="186614636"
X-IronPort-AV: E=Sophos;i="6.12,316,1728918000"; 
   d="scan'208";a="186614636"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 14:29:10 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7DCE1C2260;
	Wed, 15 Jan 2025 14:29:08 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5099BD7291;
	Wed, 15 Jan 2025 14:29:08 +0900 (JST)
Received: from sm-x86-mem01.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by yto-om1.fujitsu.com (Postfix) with ESMTP id D5E794005AA38;
	Wed, 15 Jan 2025 14:29:07 +0900 (JST)
From: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	fj6611ie@aa.jp.fujitsu.com
Subject: [PATCH v2] serial: amba-pl011: Implement nbcon console
Date: Wed, 15 Jan 2025 05:27:48 +0000
Message-Id: <20250115052749.3205675-1-fj6611ie@aa.jp.fujitsu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the callbacks required for an NBCON console [0] on the 
amba-pl011 console driver.

Referred to the NBCON implementation work for 8250 [1] and imx [2].

The normal-priority write_thread checks for console ownership
each time a character is printed.
write_atomic holds the console ownership until the entire string
is printed.

UART register operations are protected from other contexts by 
uart_port_lock, except for a final flush(nbcon_atomic_flush_unsafe) 
on panic.

The patch has been verified to correctly handle the output and
competition of messages with different priorities and flushing
panic message to console after nmi panic using ARM64 QEMU and
a physical machine(A64FX).

[0] https://lore.kernel.org/all/ZuRRTbapH0DCj334@pathway.suse.cz/
[1] https://lore.kernel.org/all/20240913140538.221708-1-john.ogness@linutronix.de/T/
[2] https://lore.kernel.org/linux-arm-kernel/20240913-serial-imx-nbcon-v3-1-4c627302335b@geanix.com/T/

Signed-off-by: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
---
This patch removes the legacy console code.
Please comment if you have any concerns.

I plan to try a stress test, referencing the work for 8250.
https://lore.kernel.org/lkml/ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb/#t

Changes in v2:
- Remove the module parameter used to switch between legacy and nbcon.
- Remove codes for legacy console.
- Fix build errors detected by the test robot.
- based on 6.13-rc7
v1: https://lore.kernel.org/all/20250108004730.2302996-1-fj6611ie@aa.jp.fujitsu.com/

Thanks Greg for the advice & comment.
---
 drivers/tty/serial/amba-pl011.c | 143 ++++++++++++++++++++++----------
 1 file changed, 97 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 69b7a3e1e..577fd3258 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -263,6 +263,7 @@ struct uart_amba_port {
 	char			type[12];
 	bool			rs485_tx_started;
 	unsigned int		rs485_tx_drain_interval; /* usecs */
+	bool			console_line_ended;
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	unsigned int		dmacr;		/* dma control reg */
@@ -2305,50 +2306,7 @@ static void pl011_console_putchar(struct uart_port *port, unsigned char ch)
 	while (pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
 		cpu_relax();
 	pl011_write(ch, uap, REG_DR);
-}
-
-static void
-pl011_console_write(struct console *co, const char *s, unsigned int count)
-{
-	struct uart_amba_port *uap = amba_ports[co->index];
-	unsigned int old_cr = 0, new_cr;
-	unsigned long flags;
-	int locked = 1;
-
-	clk_enable(uap->clk);
-
-	if (oops_in_progress)
-		locked = uart_port_trylock_irqsave(&uap->port, &flags);
-	else
-		uart_port_lock_irqsave(&uap->port, &flags);
-
-	/*
-	 *	First save the CR then disable the interrupts
-	 */
-	if (!uap->vendor->always_enabled) {
-		old_cr = pl011_read(uap, REG_CR);
-		new_cr = old_cr & ~UART011_CR_CTSEN;
-		new_cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
-		pl011_write(new_cr, uap, REG_CR);
-	}
-
-	uart_console_write(&uap->port, s, count, pl011_console_putchar);
-
-	/*
-	 *	Finally, wait for transmitter to become empty and restore the
-	 *	TCR. Allow feature register bits to be inverted to work around
-	 *	errata.
-	 */
-	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr)
-						& uap->vendor->fr_busy)
-		cpu_relax();
-	if (!uap->vendor->always_enabled)
-		pl011_write(old_cr, uap, REG_CR);
-
-	if (locked)
-		uart_port_unlock_irqrestore(&uap->port, flags);
-
-	clk_disable(uap->clk);
+	uap->console_line_ended = (ch == '\n');
 }
 
 static void pl011_console_get_options(struct uart_amba_port *uap, int *baud,
@@ -2411,6 +2369,8 @@ static int pl011_console_setup(struct console *co, char *options)
 	if (ret)
 		return ret;
 
+	uap->console_line_ended = true;
+
 	if (dev_get_platdata(uap->port.dev)) {
 		struct amba_pl011_data *plat;
 
@@ -2494,14 +2454,105 @@ static int pl011_console_match(struct console *co, char *name, int idx,
 	return -ENODEV;
 }
 
+static void
+pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt)
+{
+	struct uart_amba_port *uap = amba_ports[co->index];
+	unsigned int old_cr = 0;
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
+
+	clk_enable(uap->clk);
+
+	if (!uap->vendor->always_enabled) {
+		old_cr = pl011_read(uap, REG_CR);
+		pl011_write((old_cr & ~UART011_CR_CTSEN) | (UART01x_CR_UARTEN | UART011_CR_TXE),
+				uap, REG_CR);
+	}
+
+	if (!uap->console_line_ended)
+		uart_console_write(&uap->port, "\n", 1, pl011_console_putchar);
+	uart_console_write(&uap->port, wctxt->outbuf, wctxt->len, pl011_console_putchar);
+
+	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) & uap->vendor->fr_busy)
+		cpu_relax();
+
+	if (!uap->vendor->always_enabled)
+		pl011_write(old_cr, uap, REG_CR);
+
+	clk_disable(uap->clk);
+
+	nbcon_exit_unsafe(wctxt);
+}
+
+static void
+pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt)
+{
+	struct uart_amba_port *uap = amba_ports[co->index];
+	unsigned int old_cr = 0;
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
+
+	clk_enable(uap->clk);
+
+	if (!uap->vendor->always_enabled) {
+		old_cr = pl011_read(uap, REG_CR);
+		pl011_write((old_cr & ~UART011_CR_CTSEN) | (UART01x_CR_UARTEN | UART011_CR_TXE),
+				uap, REG_CR);
+	}
+
+	if (nbcon_exit_unsafe(wctxt)) {
+		int i;
+		unsigned int len = READ_ONCE(wctxt->len);
+
+		for (i = 0; i < len; i++) {
+			if (!nbcon_enter_unsafe(wctxt))
+				break;
+			uart_console_write(&uap->port, wctxt->outbuf + i, 1, pl011_console_putchar);
+			if (!nbcon_exit_unsafe(wctxt))
+				break;
+		}
+	}
+
+	while (!nbcon_enter_unsafe(wctxt))
+		nbcon_reacquire_nobuf(wctxt);
+
+	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) & uap->vendor->fr_busy)
+		cpu_relax();
+
+	if (!uap->vendor->always_enabled)
+		pl011_write(old_cr, uap, REG_CR);
+
+	clk_disable(uap->clk);
+
+	nbcon_exit_unsafe(wctxt);
+}
+
+static void
+pl011_console_device_lock(struct console *co, unsigned long *flags)
+{
+	__uart_port_lock_irqsave(&amba_ports[co->index]->port, flags);
+}
+
+static void
+pl011_console_device_unlock(struct console *co, unsigned long flags)
+{
+	__uart_port_unlock_irqrestore(&amba_ports[co->index]->port, flags);
+}
+
 static struct uart_driver amba_reg;
 static struct console amba_console = {
 	.name		= "ttyAMA",
-	.write		= pl011_console_write,
 	.device		= uart_console_device,
 	.setup		= pl011_console_setup,
 	.match		= pl011_console_match,
-	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
+	.write_atomic	= pl011_console_write_atomic,
+	.write_thread	= pl011_console_write_thread,
+	.device_lock	= pl011_console_device_lock,
+	.device_unlock	= pl011_console_device_unlock,
+	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON,
 	.index		= -1,
 	.data		= &amba_reg,
 };
-- 
2.34.1

