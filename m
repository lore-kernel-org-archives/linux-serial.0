Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA70C2594AF;
	Wed,  8 Jan 2025 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297432; cv=none; b=ihqXwAnecjqAfpheB68E4w7UxP5Yq81CDOPHgMZzfxUNamLfc8ZTXiITasCPJ4mwwK2eiVoODuJWg8eC+FTUzcPq0LFarO18OI9wa5FgDLUVaRruCDNdZ5EGgrUpFUD4Aw8Tq6bRaDBQoEIFIOXucyzbpK1Iw1xsMkE7XVbKU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297432; c=relaxed/simple;
	bh=3pepWCQ/w0pYqD518g7xPAZwkgW7P/rUAva7kIPw9e8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YC//bbznG/WG+M4RSXlnfcp5bpdYcBNkFOS3JRQJmF2Ml9N6z0URyl1slxSwqxW8WoWjjh+3eA9t74OPSF6YQgfGWc8RdAprQlc9VXYfKGXX8WkLOmJdJ/L9RiZAlOm20hvDkPzGOb/1r8tE994Q0KTfrIuz1c4ioNJb3b7s2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com; spf=pass smtp.mailfrom=aa.jp.fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PudVFZ5n; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PudVFZ5n"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736297431; x=1767833431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3pepWCQ/w0pYqD518g7xPAZwkgW7P/rUAva7kIPw9e8=;
  b=PudVFZ5nvyGZbfjT2mCIHf4Af+BlGHfHdtb+CVdOg5rZlC/z9FvyaaW8
   fJT4FxioJlWmETq4FBNZj/CnSytm6Op9iyEfpV5pI7eec5uuBIzQB0AEL
   LYSlZMsmlVSMN/5ODn5tTYracxM/Kmok3/3ppQA0pXdKS9TgIVHsK8ie8
   eT1P8HlOhZ+CU5CvHRgenpPp1ElniuleaLbOy8QFHoQ5rKcCt39Eyfccj
   D3Bxuue5AnN6hDXn0VuX7o70BB3LI7at5LRifhWvevVatCea31yzOA0d+
   WkGf8cGXx6NkgKKAHWGl94S65WljJAbNjTrmNRSPv8umOmKQgDeFMEmaV
   g==;
X-CSE-ConnectionGUID: 6UaIuO7nSamWYkCFjfKWQg==
X-CSE-MsgGUID: Fc82oHRxRFyPNTJlHvV5qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="185053898"
X-IronPort-AV: E=Sophos;i="6.12,296,1728918000"; 
   d="scan'208";a="185053898"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:50:27 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id DF5B3DBBCB;
	Wed,  8 Jan 2025 09:50:24 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id B1B28D50B1;
	Wed,  8 Jan 2025 09:50:24 +0900 (JST)
Received: from sm-x86-mem01.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by yto-om4.fujitsu.com (Postfix) with ESMTP id 6FCDC40054C45;
	Wed,  8 Jan 2025 09:50:24 +0900 (JST)
From: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	fj6611ie@aa.jp.fujitsu.com
Subject: [PATCH] serial: amba-pl011: Implement nbcon console
Date: Wed,  8 Jan 2025 00:47:30 +0000
Message-Id: <20250108004730.2302996-1-fj6611ie@aa.jp.fujitsu.com>
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
The codes for legacy console are retained, and the module
parameter (use_nbcon) allows switching between legacy and NBCON.
The default is off (use legacy console) for now.

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
 drivers/tty/serial/amba-pl011.c | 113 ++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 69b7a3e1e..52fab3170 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -41,6 +41,7 @@
 #include <linux/sizes.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
+#include <linux/moduleparam.h>
 
 #define UART_NR			14
 
@@ -263,6 +264,7 @@ struct uart_amba_port {
 	char			type[12];
 	bool			rs485_tx_started;
 	unsigned int		rs485_tx_drain_interval; /* usecs */
+	bool			console_line_ended;
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	unsigned int		dmacr;		/* dma control reg */
@@ -274,6 +276,10 @@ struct uart_amba_port {
 #endif
 };
 
+/* if non-zero, the console is nbcon. */
+static int use_nbcon;
+module_param(use_nbcon, int, 0444);
+
 static unsigned int pl011_tx_empty(struct uart_port *port);
 
 static unsigned int pl011_reg_to_offset(const struct uart_amba_port *uap,
@@ -2305,6 +2311,7 @@ static void pl011_console_putchar(struct uart_port *port, unsigned char ch)
 	while (pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
 		cpu_relax();
 	pl011_write(ch, uap, REG_DR);
+	uap->console_line_ended = (ch == '\n');
 }
 
 static void
@@ -2411,6 +2418,8 @@ static int pl011_console_setup(struct console *co, char *options)
 	if (ret)
 		return ret;
 
+	uap->console_line_ended = true;
+
 	if (dev_get_platdata(uap->port.dev)) {
 		struct amba_pl011_data *plat;
 
@@ -2494,6 +2503,106 @@ static int pl011_console_match(struct console *co, char *name, int idx,
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
+static void
+pl011_console_switch_to_nbcon(struct console *co)
+{
+	co->write = NULL;
+	co->write_atomic = pl011_console_write_atomic;
+	co->write_thread = pl011_console_write_thread;
+	co->device_lock = pl011_console_device_lock;
+	co->device_unlock = pl011_console_device_unlock;
+	co->flags = CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON;
+	pr_info("Serial: switched to nbcon\n");
+}
+
 static struct uart_driver amba_reg;
 static struct console amba_console = {
 	.name		= "ttyAMA",
@@ -2737,6 +2846,10 @@ static int pl011_register_port(struct uart_amba_port *uap)
 	pl011_write(0xffff, uap, REG_ICR);
 
 	if (!amba_reg.state) {
+		/* Replaces the console descriptor if NBCON is selected. */
+		if (amba_reg.cons && use_nbcon)
+			pl011_console_switch_to_nbcon(amba_reg.cons);
+
 		ret = uart_register_driver(&amba_reg);
 		if (ret < 0) {
 			dev_err(uap->port.dev,
-- 
2.34.1

