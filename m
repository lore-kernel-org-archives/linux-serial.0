Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7B026B96A;
	Wed, 11 Jun 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636230; cv=none; b=MWVYb2SQByi9juPOwc+IseWrQImh/YUu899EBjkAPUYw48oEsXrfXj0ulRSqLOiBYeasZpP413uGtJ1JclyQXJvXU16X5gReiFBZr7ZTPMGj4hcQ40zOmccyACeDljfb4JmH0jwuyhD3xoh2tgYqsJTlga9b7v828z8NF0V9rmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636230; c=relaxed/simple;
	bh=08ufG9vWt1WGuJKkmahEWPaJTsUJqrGw7oYBQIVD+5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMxB7C9TLMsaR5dojfk671B5SvNO8MZhm4BcpghLhvARbpgU4030kdbJxCs3GIV7pNu68NRtFmWyO0mALnL/mbK9TNvE/kulnF4Q0X5lZa52tXnkMSBB+r5zFmFBZ/uR5t+5gdVwzgwXnjYLDdz/3w1whJntlLAyLNT2Ux3vleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys6DIfQY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys6DIfQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4482AC4CEF1;
	Wed, 11 Jun 2025 10:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636229;
	bh=08ufG9vWt1WGuJKkmahEWPaJTsUJqrGw7oYBQIVD+5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ys6DIfQYTbzDgcRQZ5ZJDXevPDh4kRT8rZEN9AuR9DDfyCuP3/3gHvLp9lap5e9tX
	 AHAcT+67ljasNt6WG/3BQwb9S21T1g9OIi8u9Ro7saVdvCHbXwYPJObp0QJtLWzPi2
	 0d/cDHV88290UVEelgqBP5lsQgf1F6MtDX9rsJhZ5Remt5LuUCCXmx9LoNNTbLNX3P
	 jqFjPv8BBBVEB9uKZ+ldo0jpEiHHNcjvlffiqFUzbOAl3azVOYsoONZfmoM1EW614z
	 cJgDNDZBgEfsyYTwVSlTvxopvYub44/QufS9YQnMNLiQuVt8eyaG+R2eKuAhcfmEG8
	 7xKDfWoRTcVZw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 12/33] serial: 8250: move RSA functions to 8250_rsa.c
Date: Wed, 11 Jun 2025 12:02:58 +0200
Message-ID: <20250611100319.186924-13-jirislaby@kernel.org>
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

They are RSA-specific, so should live in a preexisting 8250_rsa.c. Move
them there.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250.h      |  8 +++
 drivers/tty/serial/8250/8250_port.c | 99 -----------------------------
 drivers/tty/serial/8250/8250_rsa.c  | 92 +++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 99 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 18530c31a598..cfe6ba286b45 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -318,8 +318,16 @@ static inline void serial8250_pnp_exit(void) { }
 
 #ifdef CONFIG_SERIAL_8250_RSA
 void univ8250_rsa_support(struct uart_ops *ops);
+void rsa_enable(struct uart_8250_port *up);
+void rsa_disable(struct uart_8250_port *up);
+void rsa_autoconfig(struct uart_8250_port *up);
+void rsa_reset(struct uart_8250_port *up);
 #else
 static inline void univ8250_rsa_support(struct uart_ops *ops) { }
+static inline void rsa_enable(struct uart_8250_port *up) {}
+static inline void rsa_disable(struct uart_8250_port *up) {}
+static inline void rsa_autoconfig(struct uart_8250_port *up) {}
+static inline void rsa_reset(struct uart_8250_port *up) {}
 #endif
 
 #ifdef CONFIG_SERIAL_8250_FINTEK
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d8a90818f431..476f5fc50237 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -713,105 +713,6 @@ static void serial8250_clear_IER(struct uart_8250_port *up)
 		serial_out(up, UART_IER, 0);
 }
 
-#ifdef CONFIG_SERIAL_8250_RSA
-/*
- * Attempts to turn on the RSA FIFO.  Returns zero on failure.
- * We set the port uart clock rate if we succeed.
- */
-static int __rsa_enable(struct uart_8250_port *up)
-{
-	unsigned char mode;
-	int result;
-
-	mode = serial_in(up, UART_RSA_MSR);
-	result = mode & UART_RSA_MSR_FIFO;
-
-	if (!result) {
-		serial_out(up, UART_RSA_MSR, mode | UART_RSA_MSR_FIFO);
-		mode = serial_in(up, UART_RSA_MSR);
-		result = mode & UART_RSA_MSR_FIFO;
-	}
-
-	if (result)
-		up->port.uartclk = SERIAL_RSA_BAUD_BASE * 16;
-
-	return result;
-}
-
-/*
- * If this is an RSA port, see if we can kick it up to the higher speed clock.
- */
-static void rsa_enable(struct uart_8250_port *up)
-{
-	if (up->port.type != PORT_RSA)
-		return;
-
-	if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
-		uart_port_lock_irq(&up->port);
-		__rsa_enable(up);
-		uart_port_unlock_irq(&up->port);
-	}
-	if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
-		serial_out(up, UART_RSA_FRR, 0);
-}
-
-/*
- * Attempts to turn off the RSA FIFO and resets the RSA board back to 115kbps compat mode. It is
- * unknown why interrupts were disabled in here. However, the caller is expected to preserve this
- * behaviour by grabbing the spinlock before calling this function.
- */
-static void rsa_disable(struct uart_8250_port *up)
-{
-	unsigned char mode;
-	int result;
-
-	if (up->port.type != PORT_RSA)
-		return;
-
-	if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16)
-		return;
-
-	uart_port_lock_irq(&up->port);
-	mode = serial_in(up, UART_RSA_MSR);
-	result = !(mode & UART_RSA_MSR_FIFO);
-
-	if (!result) {
-		serial_out(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
-		mode = serial_in(up, UART_RSA_MSR);
-		result = !(mode & UART_RSA_MSR_FIFO);
-	}
-
-	if (result)
-		up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
-	uart_port_unlock_irq(&up->port);
-}
-
-static void rsa_autoconfig(struct uart_8250_port *up)
-{
-	/* Only probe for RSA ports if we got the region. */
-	if (up->port.type != PORT_16550A)
-		return;
-	if (!(up->probe & UART_PROBE_RSA))
-		return;
-
-	if (__rsa_enable(up))
-		up->port.type = PORT_RSA;
-}
-
-static void rsa_reset(struct uart_8250_port *up)
-{
-	if (up->port.type != PORT_RSA)
-		return;
-
-	serial_out(up, UART_RSA_FRR, 0);
-}
-#else
-static inline void rsa_enable(struct uart_8250_port *up) {}
-static inline void rsa_disable(struct uart_8250_port *up) {}
-static inline void rsa_autoconfig(struct uart_8250_port *up) {}
-static inline void rsa_reset(struct uart_8250_port *up) {}
-#endif /* CONFIG_SERIAL_8250_RSA */
-
 /*
  * This is a quickie test to see how big the FIFO is.
  * It doesn't work at all the time, more's the pity.
diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
index 4c8b9671bd41..59d2ecf23068 100644
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -107,6 +107,98 @@ void univ8250_rsa_support(struct uart_ops *ops)
 module_param_hw_array(probe_rsa, ulong, ioport, &probe_rsa_count, 0444);
 MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
 
+/*
+ * Attempts to turn on the RSA FIFO.  Returns zero on failure.
+ * We set the port uart clock rate if we succeed.
+ */
+static int __rsa_enable(struct uart_8250_port *up)
+{
+	unsigned char mode;
+	int result;
+
+	mode = serial_in(up, UART_RSA_MSR);
+	result = mode & UART_RSA_MSR_FIFO;
+
+	if (!result) {
+		serial_out(up, UART_RSA_MSR, mode | UART_RSA_MSR_FIFO);
+		mode = serial_in(up, UART_RSA_MSR);
+		result = mode & UART_RSA_MSR_FIFO;
+	}
+
+	if (result)
+		up->port.uartclk = SERIAL_RSA_BAUD_BASE * 16;
+
+	return result;
+}
+
+/*
+ * If this is an RSA port, see if we can kick it up to the higher speed clock.
+ */
+void rsa_enable(struct uart_8250_port *up)
+{
+	if (up->port.type != PORT_RSA)
+		return;
+
+	if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
+		uart_port_lock_irq(&up->port);
+		__rsa_enable(up);
+		uart_port_unlock_irq(&up->port);
+	}
+	if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
+		serial_out(up, UART_RSA_FRR, 0);
+}
+
+/*
+ * Attempts to turn off the RSA FIFO and resets the RSA board back to 115kbps compat mode. It is
+ * unknown why interrupts were disabled in here. However, the caller is expected to preserve this
+ * behaviour by grabbing the spinlock before calling this function.
+ */
+void rsa_disable(struct uart_8250_port *up)
+{
+	unsigned char mode;
+	int result;
+
+	if (up->port.type != PORT_RSA)
+		return;
+
+	if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16)
+		return;
+
+	uart_port_lock_irq(&up->port);
+	mode = serial_in(up, UART_RSA_MSR);
+	result = !(mode & UART_RSA_MSR_FIFO);
+
+	if (!result) {
+		serial_out(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
+		mode = serial_in(up, UART_RSA_MSR);
+		result = !(mode & UART_RSA_MSR_FIFO);
+	}
+
+	if (result)
+		up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
+	uart_port_unlock_irq(&up->port);
+}
+
+void rsa_autoconfig(struct uart_8250_port *up)
+{
+	/* Only probe for RSA ports if we got the region. */
+	if (up->port.type != PORT_16550A)
+		return;
+	if (!(up->probe & UART_PROBE_RSA))
+		return;
+
+	if (__rsa_enable(up))
+		up->port.type = PORT_RSA;
+}
+
+void rsa_reset(struct uart_8250_port *up)
+{
+	if (up->port.type != PORT_RSA)
+		return;
+
+	serial_out(up, UART_RSA_FRR, 0);
+}
+
 #ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
 #ifndef MODULE
 /*
-- 
2.49.0

