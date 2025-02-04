Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3572F25A624;
	Tue,  4 Feb 2025 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738644381; cv=none; b=gSTJG6YFa4WMHX8Q7WNSXIPZykh0KwPnAsmcnfDOZ81hOtRY5nTJJRoP84vPnls6whMYQo12Q3alr481gSnTggJEAnnFK/6zWmLUs9d9wh5PJ7HBY9jw8bAVY0tA+fwrqItSjvwYjBg10NK1Rre1uCRAA9HFHw6CmHjwybIhQPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738644381; c=relaxed/simple;
	bh=3zy0L8jyvmOgTgcv1niUmquwu7TF0/oDLJMYtvZPfZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=clAvEEf90k0rjFaKBZvR5PxBNYV/PyDTXa6XGqrFbRAe//oMZ+UHeXyPNp+NqdCnPhjKMLkZl3QZaHaMljrEXpH9ExA9yWu+aQ9+0SRuZfn0MYwJgxS1xQWRi5bkYYhQw88Qak1n+B4VLGiafn4PO65RwsObIy1OGNgR8fIEcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com; spf=pass smtp.mailfrom=aa.jp.fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=LAM19UO5; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="LAM19UO5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1738644378; x=1770180378;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3zy0L8jyvmOgTgcv1niUmquwu7TF0/oDLJMYtvZPfZc=;
  b=LAM19UO531eRarvtKdvfUH248qt1PqpITfkqsBtJhUBRYojdGExD0m5/
   0Hou5jTR046migdV2c6WmybR8JLceDI6UgLcf3sTNKLpyQS0TqFeo7vj7
   qLjLoRVRHy6M+ZuztBN/f2bxm0Tk93cc875QB3CRUD5BDm0wiR24AzZ1P
   P3/2dL1J39Tpwaby4FBgwKcr3t97JNcB3CV6HL2A2cvk/h2jAaOwQgQqg
   Q1vPL6rccIu936ZogWV18ahYaEgCrHAYY6+cYbxOtdXIKkbM7R8SruJ7g
   FQjqyrd9wqZdhb0OQmeu7PpHUw8pRuwKbCrZiGd6zSC8eBG9+9QEsUFSu
   g==;
X-CSE-ConnectionGUID: UvTg7nlMRti3MEVBt98JXw==
X-CSE-MsgGUID: EPWekPqRTbuuJnLsL5+RTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="177172089"
X-IronPort-AV: E=Sophos;i="6.13,257,1732546800"; 
   d="scan'208";a="177172089"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 13:45:06 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3EB54D500C;
	Tue,  4 Feb 2025 13:45:04 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 18BD3D3F29;
	Tue,  4 Feb 2025 13:45:04 +0900 (JST)
Received: from sm-x86-mem01.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by yto-om4.fujitsu.com (Postfix) with ESMTP id B920540054BEE;
	Tue,  4 Feb 2025 13:45:03 +0900 (JST)
From: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	fj6611ie@aa.jp.fujitsu.com
Subject: [PATCH v3] serial: amba-pl011: Implement nbcon console
Date: Tue,  4 Feb 2025 04:44:28 +0000
Message-Id: <20250204044428.2191983-1-fj6611ie@aa.jp.fujitsu.com>
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

Stress testing was conducted on a physical machine(A64FX).
The results are as follows:

- The output speed and volume of messages using the NBCON console were
  comparable to the legacy console (data suggests a slight improvement).

- When inducing a panic (sysrq-triggered or NMI) under heavy contention
  on the serial console output,
  the legacy console resulted in the loss of some or all crash messages.
  However, using the NBCON console, no message loss occurred.

This testing referenced the NBCON console work for 8250 [3].

[0] https://lore.kernel.org/all/ZuRRTbapH0DCj334@pathway.suse.cz/
[1] https://lore.kernel.org/all/20240913140538.221708-1-john.ogness@linutronix.de/T/
[2] https://lore.kernel.org/linux-arm-kernel/20240913-serial-imx-nbcon-v3-1-4c627302335b@geanix.com/T/
[3] https://lore.kernel.org/lkml/ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb/#t

Signed-off-by: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
---
This patch removes the legacy console code.
Please comment if you have any concerns.

Changes in v3:
- Add stress test results to patch comments.
- based on tty-next branch
  https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
v2: https://lore.kernel.org/all/20250115052749.3205675-1-fj6611ie@aa.jp.fujitsu.com/

Changes in v2:
- Remove the module parameter used to switch between legacy and NBCON.
- Remove codes for legacy console.
- Fix build errors detected by the test robot.
- based on 6.13-rc7
v1: https://lore.kernel.org/all/20250108004730.2302996-1-fj6611ie@aa.jp.fujitsu.com/

Thanks Greg for the comment.
---
 drivers/tty/serial/amba-pl011.c | 143 ++++++++++++++++++++++----------
 1 file changed, 97 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 04212c823..9a9a1d630 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -272,6 +272,7 @@ struct uart_amba_port {
 	enum pl011_rs485_tx_state	rs485_tx_state;
 	struct hrtimer		trigger_start_tx;
 	struct hrtimer		trigger_stop_tx;
+	bool			console_line_ended;
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	unsigned int		dmacr;		/* dma control reg */
@@ -2366,50 +2367,7 @@ static void pl011_console_putchar(struct uart_port *port, unsigned char ch)
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
@@ -2472,6 +2430,8 @@ static int pl011_console_setup(struct console *co, char *options)
 	if (ret)
 		return ret;
 
+	uap->console_line_ended = true;
+
 	if (dev_get_platdata(uap->port.dev)) {
 		struct amba_pl011_data *plat;
 
@@ -2555,14 +2515,105 @@ static int pl011_console_match(struct console *co, char *name, int idx,
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

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.34.1

