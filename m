Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B0126D4CF;
	Wed, 11 Jun 2025 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636235; cv=none; b=CawwFcmxHGUbM2NnDibwTlf39Beu6CLYBQvEiIgvqDWfjaxkRQ8Ao3WCp3HySa0qcJKONxIBp4ufl4oo78KG2AaXVdnfUASU+zpknsJK3+B5979jIpopeIYxAduhbt+SmKJ+Ee9iWOqEiy0RQVDiXu8Q+rd6Bg6i7gNhl+CTVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636235; c=relaxed/simple;
	bh=CJJIgIthaFgjPVGuHvtpvz2/RwmOxERQHI/tN+4R/YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFOughUG1twH8Tr4+b0r+mtpEgkQklzfLfNdghbnXUtXwTcYQ85DDVL58SGjasSzQHIB4mNVxBu2nv/+3ncLLcZ/c4bmZGCh8PaP/7H83xBU2N77WkEcCTOphCeEi3bw59pT5G+rwh7KHJkg4URQT9DnoOq4HbjQs1HoOl9Jjnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ka3gV/tS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ka3gV/tS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B158C4CEEE;
	Wed, 11 Jun 2025 10:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636235;
	bh=CJJIgIthaFgjPVGuHvtpvz2/RwmOxERQHI/tN+4R/YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ka3gV/tSNLFwlUT+oes4SIHL4tKWfUya78ek45/ZyoC4xB5DB+f0EPF0nGTbtaDgU
	 6+QCHcsgDqfGaDxGQFaLAef9HQjBpU7okrwPEP3WRSOFLxKiq0sgv4oKRuysn6Bcyz
	 IAH8vtPf7bJGEqV/U94aTM3lbbCTqhCgcrooOioAMxvbZd44SzNymixLy3k+jYpY+6
	 aQUtbczjyprJaxsPbTPx7GYBKjqD6RugAGD6Qkck4Zv1KwWrjBML3hJWYtBYbDyUlH
	 +D1QtSI1pA/L/BXKMHfY4mEvl8XzNfAVBlWBMux3RKnBdPR1LU2FOvmjwC/Mv2SOyY
	 7HhAl95tIrc3A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 16/33] serial: 8250: extract serial8250_initialize()
Date: Wed, 11 Jun 2025 12:03:02 +0200
Message-ID: <20250611100319.186924-17-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100319.186924-1-jirislaby@kernel.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial8250_do_startup() initializes the ports in the middle of the
function. This code can be separated to serial8250_initialize(), so that
serial8250_do_startup() can be readable again.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 103 ++++++++++++++--------------
 1 file changed, 50 insertions(+), 53 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5466286bb44f..6851c197b31d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2247,13 +2247,59 @@ static void serial8250_THRE_test(struct uart_port *port)
 		up->bugs |= UART_BUG_THRE;
 }
 
-int serial8250_do_startup(struct uart_port *port)
+static void serial8250_initialize(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
-	unsigned char iir;
+	bool lsr_TEMT, iir_NOINT;
+
+	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
+
+	uart_port_lock_irqsave(port, &flags);
+	if (port->flags & UPF_FOURPORT) {
+		if (!port->irq)
+			port->mctrl |= TIOCM_OUT1;
+	} else {
+		/* Most PC uarts need OUT2 raised to enable interrupts. */
+		if (port->irq)
+			port->mctrl |= TIOCM_OUT2;
+	}
+
+	serial8250_set_mctrl(port, port->mctrl);
+
+	/*
+	 * Serial over Lan (SoL) hack:
+	 * Intel 8257x Gigabit ethernet chips have a 16550 emulation, to be used for Serial Over
+	 * Lan.  Those chips take a longer time than a normal serial device to signalize that a
+	 * transmission data was queued. Due to that, the above test generally fails. One solution
+	 * would be to delay the reading of iir. However, this is not reliable, since the timeout is
+	 * variable. So, let's just don't test if we receive TX irq.  This way, we'll never enable
+	 * UART_BUG_TXEN.
+	 */
+	if (!(port->quirks & UPQ_NO_TXEN_TEST)) {
+		/* Do a quick test to see if we receive an interrupt when we enable the TX irq. */
+		serial_port_out(port, UART_IER, UART_IER_THRI);
+		lsr_TEMT = serial_port_in(port, UART_LSR) & UART_LSR_TEMT;
+		iir_NOINT = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
+		serial_port_out(port, UART_IER, 0);
+
+		if (lsr_TEMT && iir_NOINT) {
+			if (!(up->bugs & UART_BUG_TXEN)) {
+				up->bugs |= UART_BUG_TXEN;
+				dev_dbg(port->dev, "enabling bad tx status workarounds\n");
+			}
+		} else {
+			up->bugs &= ~UART_BUG_TXEN;
+		}
+	}
+
+	uart_port_unlock_irqrestore(port, flags);
+}
+
+int serial8250_do_startup(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
 	int retval;
-	u16 lsr;
 
 	if (!port->fifosize)
 		port->fifosize = uart_config[port->type].fifo_size;
@@ -2310,56 +2356,7 @@ int serial8250_do_startup(struct uart_port *port)
 
 	up->ops->setup_timer(up);
 
-	/*
-	 * Now, initialize the UART
-	 */
-	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
-
-	uart_port_lock_irqsave(port, &flags);
-	if (up->port.flags & UPF_FOURPORT) {
-		if (!up->port.irq)
-			up->port.mctrl |= TIOCM_OUT1;
-	} else
-		/*
-		 * Most PC uarts need OUT2 raised to enable interrupts.
-		 */
-		if (port->irq)
-			up->port.mctrl |= TIOCM_OUT2;
-
-	serial8250_set_mctrl(port, port->mctrl);
-
-	/*
-	 * Serial over Lan (SoL) hack:
-	 * Intel 8257x Gigabit ethernet chips have a 16550 emulation, to be
-	 * used for Serial Over Lan.  Those chips take a longer time than a
-	 * normal serial device to signalize that a transmission data was
-	 * queued. Due to that, the above test generally fails. One solution
-	 * would be to delay the reading of iir. However, this is not
-	 * reliable, since the timeout is variable. So, let's just don't
-	 * test if we receive TX irq.  This way, we'll never enable
-	 * UART_BUG_TXEN.
-	 */
-	if (!(up->port.quirks & UPQ_NO_TXEN_TEST)) {
-		/*
-		 * Do a quick test to see if we receive an interrupt when we
-		 * enable the TX irq.
-		 */
-		serial_port_out(port, UART_IER, UART_IER_THRI);
-		lsr = serial_port_in(port, UART_LSR);
-		iir = serial_port_in(port, UART_IIR);
-		serial_port_out(port, UART_IER, 0);
-
-		if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
-			if (!(up->bugs & UART_BUG_TXEN)) {
-				up->bugs |= UART_BUG_TXEN;
-				dev_dbg(port->dev, "enabling bad tx status workarounds\n");
-			}
-		} else {
-			up->bugs &= ~UART_BUG_TXEN;
-		}
-	}
-
-	uart_port_unlock_irqrestore(port, flags);
+	serial8250_initialize(port);
 
 	/*
 	 * Clear the interrupt registers again for luck, and clear the
-- 
2.49.0

