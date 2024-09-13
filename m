Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A7F188A21;
	Fri, 13 Sep 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217547; cv=none; b=hZ1o3kZC1ROp+W/Dz2fwzocMJzmnU+vz1qYOAcTe4tk9j+hjhU/pAHbNCnS14SPvfRX/UFZXnKzPjLHOclDSEfKcdxo2PHy3qWd0NYY5/n5bvmv/+L3pqtSJ9TpyebDkq/PpRs6ptROt0VVQKlRLYCJnGXOpGiCDBVHow75vyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217547; c=relaxed/simple;
	bh=BV246ObWi9nh2lKEuPpmuyNRlDkYmnW6Hfc4HO8X8mA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ocWQjsSK0RbjgONpMhkoyKrUACskaKIBUh3OakJVuLLJ0a+ibZMVXB7bn2AyIxnmyUnRF1wFj4RQD7NBcGtq5LqpCJ5d3yTIrrtIKV21bxrA6GAn0ejEJx2hYJvPLMDR5CzVdewEtKsZpIMAQZqpKFZmIgMtVbxdPaeHGJe2riU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=uBTZe1sz; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="uBTZe1sz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=8fPtszLx5YXcXZRLXTlBT9KYalg3KhBwObue5cmzP+s=; b=uB
	TZe1szVFaBNHgqAs9Nzsq/zg1yQbCFAoWwgXQxb5vhGF+aIDSR8Z236o1BMoSKayFg69/q6B6Jhnc
	Gj38hCbGxedRUHjn0Yg1GtLHFCPj564QTZ76AE6r36CchsrKx+NQunrpnmL0SgJq0J8ku1/C9TiP6
	qM+Tp3DKk2lCgNmVGScxK23vMTJHADDgQMiJiiXwmnrtpuCR0rDO5VvgAS77H8DM+NNj5835OjpmS
	eRdt0QtkJLtd9ItO1UGN1kWUU9ibCh6/6JQIeyHmbTLfImKno0EsdnsZ1OlQl4IDUST0aEpz0NRBb
	a0nTL9y2lGhwPo8Z4YJs86i9W+8rifNg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sp22Q-000GDC-OY; Fri, 13 Sep 2024 10:52:22 +0200
Received: from [80.62.117.18] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sp22P-000PqN-2w;
	Fri, 13 Sep 2024 10:52:22 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Fri, 13 Sep 2024 10:52:19 +0200
Subject: [PATCH v3] serial: imx: Switch to nbcon console
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-serial-imx-nbcon-v3-1-4c627302335b@geanix.com>
X-B4-Tracking: v=1; b=H4sIAEL942YC/x3MSwrDIBSF4a2EO67iq9h01H2UDoy9mguNFg1BC
 Nl7bYYfnPPvULEQVrgPOxTcqFJOHfoygJ9disjo3Q1KKCNGqdh/7z6MlsbS5HNiRhhnR+ulCR7
 67VswUDuTz1d3KHlh61zQnSGfNyxcWqm00Pp645FWjnXC9IjoEjXu8wLH8QPyne09mgAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726217541; l=10439;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=BV246ObWi9nh2lKEuPpmuyNRlDkYmnW6Hfc4HO8X8mA=;
 b=cSbkgCWUV/BNxNGHXwqa92oFV3hPUh8Qi09uGq/ROTn30WTDVPVUt/WnO7/4YqbG2g0yuN18g
 SJ/TOgc1w9tBOisd+8iFaTt4i7AdI509RbEoF7G1MjOWMAQt+3aLIzQ
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27396/Thu Sep 12 10:46:40 2024)

Implements the necessary callbacks to switch the imx console driver to
perform as an nbcon console.

Add implementations for the nbcon consoles (write_atomic, write_thread,
driver_enter, driver_exit) and add CON_NBCON to the initial flags.

The legacy code is kept in order to easily switch back to legacy mode
by defining CONFIG_SERIAL_IMX_LEGACY_CONSOLE.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Implement the necessary callbacks to allow the imx console driver to be
used as an nbcon console.

This is based on the work done on converting the 8250 driver to NBCON
console [0], adapted to the imx driver.

The _write_atomic() and _write_thread() functions access the following
registers: ucr1, ucr2, ucr3 and uts, which all needs to be protected by
the port lock. The driver has been reviewed for correct handling of
these registers, and except for a single missing lock in in
_enable_wakeup(), the driver was found sound. The registers are accessed
initially in _probe() without lock held, but I assume that is all good
and normal, as it before the uart port have been added.

A fix for the missing lock have been submitted for mainline [1].

The read_poll_timeout() call in _write_thread() have been changed to run
as a tight loop. If allowed to sleep (4th argument >0), a kernel warning
such as this one is triggered:

[    0.322860] ------------[ cut here ]------------
[    0.322870] Voluntary context switch within RCU read-side critical section!
[    0.322885] WARNING: CPU: 2 PID: 75 at kernel/rcu/tree_plugin.h:331 rcu_note_context_switch+0x454/0x52c
[    0.322907] Modules linked in:
[    0.322916] CPU: 2 UID: 0 PID: 75 Comm: pr/ttymxc1 Not tainted 6.11.0-rc7-next-20240912-g3d12610ae2ac #1
[    0.322925] Hardware name: DEIF PCM3.3 board (DT)
[    0.322929] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.322937] pc : rcu_note_context_switch+0x454/0x52c
[    0.322944] lr : rcu_note_context_switch+0x454/0x52c
[    0.322950] sp : ffff800082a3bb60
[    0.322953] x29: ffff800082a3bb60 x28: ffff0000029f5280 x27: 0000000000000000
[    0.322964] x26: ffff0000029f5280 x25: 0000000000000001 x24: ffff800081885270
[    0.322975] x23: 0000000000000000 x22: ffff0000029f5280 x21: ffff800081a6afe0
[    0.322985] x20: ffff00007fb6d880 x19: ffff00007fb6e6c0 x18: fffffffffffe3140
[    0.322996] x17: 1fffe000007a7421 x16: ffff000003d3a180 x15: 0000000000000048
[    0.323007] x14: fffffffffffe3188 x13: 216e6f6974636573 x12: 206c616369746972
[    0.323018] x11: 6320656469732d64 x10: 6165722055435220 x9 : 206e696874697720
[    0.323029] x8 : 6863746977732074 x7 : ffff8000818a0d80 x6 : ffff800082a3b920
[    0.323039] x5 : 0000000000000004 x4 : 0000000000000000 x3 : 0000000000000001
[    0.323049] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000029f5280
[    0.323060] Call trace:
[    0.323064]  rcu_note_context_switch+0x454/0x52c
[    0.323071]  __schedule+0x9c/0x854
[    0.323080]  schedule+0x34/0x104
[    0.323086]  usleep_range_state+0xf8/0x128
[    0.323096]  imx_uart_console_write_thread+0x1d4/0x248
[    0.323105]  nbcon_emit_next_record+0x25c/0x2a4
[    0.323118]  nbcon_emit_one+0xc0/0x108
[    0.323127]  nbcon_kthread_func+0x154/0x200
[    0.323138]  kthread+0x114/0x118
[    0.323147]  ret_from_fork+0x10/0x20
[    0.323156] ---[ end trace 0000000000000000 ]---

Is this as intended?

I have tried a different logic instead of the console_newline_needed. I
hope it might be found more intuitive.

[0] https://lore.kernel.org/linux-serial/20240905134719.142554-1-john.ogness@linutronix.de/
[1] https://lore.kernel.org/all/20240913-serial-imx-lockfix-v1-0-4d102746c89d@geanix.com/

v3:
- Patch 1/2 dropped as it has been merged to mainline.
- Use USEC_PER_SEC macro instead of 1000000 number.
- Fix kernel warning "Voluntary context switch within RCU read-side
  critical section!" caused by usleep_range() in read_poll_timeout().
- Remove legacy console implementation.
- Adapt to rename of driver_enter/driver_exit renamed to
  device_lock/device_unlock.
- Change _write_atomic() and write_thread() to return void.
- Change console_newline_needed logic to a simpler and (hopefully) more
  readable last_putchar_was_newline logic.
- Link to v2: https://lore.kernel.org/all/cover.1712303358.git.esben@geanix.com/

v2:
- Switch to tight loop (no udelay()) in atomic context.
- Increase timeout to 1 second.
- Add note in commit message about (no) error handling on timeout.
- Link to v1: https://lore.kernel.org/all/cover.1712156846.git.esben@geanix.com/
---
 drivers/tty/serial/imx.c | 120 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 101 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 67d4a72eda77..b043ac3cd2cd 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -230,6 +230,8 @@ struct imx_port {
 	unsigned int            saved_reg[10];
 	bool			context_saved;
 
+	bool			last_putchar_was_newline;
+
 	enum imx_tx_state	tx_state;
 	struct hrtimer		trigger_start_tx;
 	struct hrtimer		trigger_stop_tx;
@@ -2054,26 +2056,34 @@ static void imx_uart_console_putchar(struct uart_port *port, unsigned char ch)
 		barrier();
 
 	imx_uart_writel(sport, ch, URTX0);
+
+	sport->last_putchar_was_newline = (ch == '\n');
 }
 
-/*
- * Interrupts are disabled on entering
- */
-static void
-imx_uart_console_write(struct console *co, const char *s, unsigned int count)
+static void imx_uart_console_device_lock(struct console *co, unsigned long *flags)
+{
+	struct uart_port *up = &imx_uart_ports[co->index]->port;
+
+	return __uart_port_lock_irqsave(up, flags);
+}
+
+static void imx_uart_console_device_unlock(struct console *co, unsigned long flags)
+{
+	struct uart_port *up = &imx_uart_ports[co->index]->port;
+
+	return __uart_port_unlock_irqrestore(up, flags);
+}
+
+static void imx_uart_console_write_atomic(struct console *co,
+					  struct nbcon_write_context *wctxt)
 {
 	struct imx_port *sport = imx_uart_ports[co->index];
+	struct uart_port *port = &sport->port;
 	struct imx_port_ucrs old_ucr;
-	unsigned long flags;
 	unsigned int ucr1, usr2;
-	int locked = 1;
 
-	if (sport->port.sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = uart_port_trylock_irqsave(&sport->port, &flags);
-	else
-		uart_port_lock_irqsave(&sport->port, &flags);
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
 
 	/*
 	 *	First, save UCR1/2/3 and then disable interrupts
@@ -2087,10 +2097,12 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN);
 
 	imx_uart_writel(sport, ucr1, UCR1);
-
 	imx_uart_writel(sport, old_ucr.ucr2 | UCR2_TXEN, UCR2);
 
-	uart_console_write(&sport->port, s, count, imx_uart_console_putchar);
+	if (!sport->last_putchar_was_newline)
+		uart_console_write(port, "\n", 1, imx_uart_console_putchar);
+	uart_console_write(port, wctxt->outbuf, wctxt->len,
+			   imx_uart_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
@@ -2100,8 +2112,73 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 				 0, USEC_PER_SEC, false, sport, USR2);
 	imx_uart_ucrs_restore(sport, &old_ucr);
 
-	if (locked)
-		uart_port_unlock_irqrestore(&sport->port, flags);
+	nbcon_exit_unsafe(wctxt);
+}
+
+static void imx_uart_console_write_thread(struct console *co,
+					  struct nbcon_write_context *wctxt)
+{
+	struct imx_port *sport = imx_uart_ports[co->index];
+	struct uart_port *port = &sport->port;
+	struct imx_port_ucrs old_ucr;
+	unsigned int ucr1, usr2;
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
+
+	/*
+	 *	First, save UCR1/2/3 and then disable interrupts
+	 */
+	imx_uart_ucrs_save(sport, &old_ucr);
+	ucr1 = old_ucr.ucr1;
+
+	if (imx_uart_is_imx1(sport))
+		ucr1 |= IMX1_UCR1_UARTCLKEN;
+	ucr1 |= UCR1_UARTEN;
+	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN);
+
+	imx_uart_writel(sport, ucr1, UCR1);
+	imx_uart_writel(sport, old_ucr.ucr2 | UCR2_TXEN, UCR2);
+
+	if (nbcon_exit_unsafe(wctxt)) {
+		int len = READ_ONCE(wctxt->len);
+		int i;
+
+		/*
+		 * Write out the message. Toggle unsafe for each byte in order
+		 * to give another (higher priority) context the opportunity
+		 * for a friendly takeover. If such a takeover occurs, this
+		 * context must reacquire ownership in order to perform final
+		 * actions (such as re-enabling the interrupts).
+		 *
+		 * IMPORTANT: wctxt->outbuf and wctxt->len are no longer valid
+		 *	      after a reacquire so writing the message must be
+		 *	      aborted.
+		 */
+		for (i = 0; i < len; i++) {
+			if (!nbcon_enter_unsafe(wctxt))
+				break;
+
+			uart_console_write(port, wctxt->outbuf + i, 1,
+					   imx_uart_console_putchar);
+
+			if (!nbcon_exit_unsafe(wctxt))
+				break;
+		}
+	}
+
+	while (!nbcon_enter_unsafe(wctxt))
+		nbcon_reacquire_nobuf(wctxt);
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore UCR1/2/3
+	 */
+	read_poll_timeout(imx_uart_readl, usr2, usr2 & USR2_TXDC,
+			  0, USEC_PER_SEC, false, sport, USR2);
+	imx_uart_ucrs_restore(sport, &old_ucr);
+
+	nbcon_exit_unsafe(wctxt);
 }
 
 /*
@@ -2193,6 +2270,8 @@ imx_uart_console_setup(struct console *co, char *options)
 	if (retval)
 		goto error_console;
 
+	sport->last_putchar_was_newline = true;
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
@@ -2229,11 +2308,14 @@ imx_uart_console_exit(struct console *co)
 static struct uart_driver imx_uart_uart_driver;
 static struct console imx_uart_console = {
 	.name		= DEV_NAME,
-	.write		= imx_uart_console_write,
+	.write_atomic	= imx_uart_console_write_atomic,
+	.write_thread	= imx_uart_console_write_thread,
+	.device_lock	= imx_uart_console_device_lock,
+	.device_unlock	= imx_uart_console_device_unlock,
+	.flags		= CON_PRINTBUFFER | CON_NBCON,
 	.device		= uart_console_device,
 	.setup		= imx_uart_console_setup,
 	.exit		= imx_uart_console_exit,
-	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
 	.data		= &imx_uart_uart_driver,
 };

---
base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
change-id: 20240912-serial-imx-nbcon-404a797c14fc

Best regards,
-- 
Esben Haabendal <esben@geanix.com>

