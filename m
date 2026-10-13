Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435273EB105
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874137; cv=none; b=ds/2OqAfIMQ8iaoexxStvENDh+vwg74jj+KEUo3b5AhCNa0QDA8qLTw7h+VMOuTo0nWTnNlWNzwaRE4PKnx5RkkDASqx6acqQYpaZpTspsfULdgMnQeFQ1iwJouYcUNVdb388MeMQbi789Z8SUN16RCdfGQuFNNGTXL8MpDEnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874137; c=relaxed/simple;
	bh=GIGqHdy7Dp8Jfd9natvTvh1J3NM+ZuKuRsvfGuNkMX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmpPe6idqrXbFqjMGMjXi44T62T0AxMI3mlsHQ6J2BD25URTyp5GW1BJ9xi30lPBIr8cLaVa1hJVp61Gc8z1+81isnTMeKuYD5eRFAWvq3S4CYOREY/xECbuNAxtJy5RCHwhr9vCijbR2INz3D42VdQhvngsEob6mPaC+cKdfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0iakSrG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0iakSrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012371F00893;
	Tue, 13 Oct 2026 06:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874135;
	bh=GPefA9kwmN3arJe2wQPaqvc8TM3BM4CI2iBv4WJzDy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X0iakSrGD4vpLIO44eGeZWk7DB8TW3b2ysNhqt/KUdZwJeSPeVZWRmd4pkOgYQuwB
	 V4ix78LU1dbsgU34NM6+IsbqSlQ1EdrCq/vArYkJ+aW/Ga01T6868j1sL86q4A2XZJ
	 JlgY/5ZHDo8Oqp0Ijzhdm5pvUJ5ZPKN5lrxaMJIF9a3fTd5VPTR6Il9pKjV7PWsejF
	 QraU9BExwK5DR3nw/N9xY4pH8sdnLamKygMQCg4JPX48Ee90qeqfKbjux7dgGVaRiP
	 L51NVZ8o30s34tmjgPZ1eFaEiUC+mLGa5KX9aE59PM/f9xT3qFudlEX6MhaQiXhSqR
	 +JVsfGf65w2dQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 1/6] serial: 8250: drop err label from serial8250_register_8250_port()
Date: Tue, 13 Oct 2026 08:48:46 +0200
Message-ID: <baf799ad88f9ef43093ae96731f48a5e88d726dd.1791873876.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791873876.git.jirislaby@kernel.org>
References: <cover.1791873876.git.jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial8250_register_8250_port() holds serial_mutex using guard(), but
still uses goto-based error handling. Mixing the two is discouraged by
the cleanup guidelines.

Move the part of the function which configures the found port into a
new helper: __serial8250_register_8250_port(). It returns an int and
uses plain returns on failures. The caller now resets uart->port.dev on
failure at a single place, so the err label can go.

While at it, simplify the mctrl_gpio_init() error handling: return
PTR_ERR() directly and drop the else branch.

No functional change intended.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Assisted-by: LLM
---
 drivers/tty/serial/8250/8250_core.c | 98 +++++++++++++++--------------
 1 file changed, 52 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 11424fef7c08..7ff307ce6aa8 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -743,46 +743,12 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 	serial_out(up, UART_IER, up->ier);
 }
 
-/**
- *	serial8250_register_8250_port - register a serial port
- *	@up: serial port template
- *
- *	Configure the serial port specified by the request. If the
- *	port exists and is in use, it is hung up and unregistered
- *	first.
- *
- *	The port is then probed and if necessary the IRQ is autodetected
- *	If this fails an error is returned.
- *
- *	On success the port is ready to use and the line number is returned.
- */
-int serial8250_register_8250_port(const struct uart_8250_port *up)
+static int __serial8250_register_8250_port(struct uart_8250_port *uart,
+					   const struct uart_8250_port *up)
 {
-	struct uart_8250_port *uart;
 	bool cons_flow;
 	int ret;
 
-	if (up->port.uartclk == 0)
-		return -EINVAL;
-
-	guard(mutex)(&serial_mutex);
-
-	uart = serial8250_find_match_or_unused(&up->port);
-	if (!uart) {
-		/*
-		 * If the port is past the initial isa ports, initialize a new
-		 * port and increment nr_uarts accordingly.
-		 */
-		uart = serial8250_setup_port(nr_uarts);
-		if (!uart)
-			return -ENOSPC;
-		nr_uarts++;
-	}
-
-	/* Check if it is CIR already. We check this below again, see there why. */
-	if (uart->port.type == PORT_8250_CIR)
-		return -ENODEV;
-
 	/* Preserve specified console flow control. */
 	cons_flow = uart_cons_flow_enabled(&uart->port);
 
@@ -826,7 +792,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		uart->port.dev = up->port.dev;
 		ret = uart_get_rs485_mode(&uart->port);
 		if (ret)
-			goto err;
+			return ret;
 	}
 
 	if (up->port.flags & UPF_FIXED_TYPE)
@@ -838,12 +804,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	 */
 	if (uart->port.dev && !has_acpi_companion(uart->port.dev)) {
 		struct mctrl_gpios *gpios = mctrl_gpio_init(&uart->port, 0);
-		if (IS_ERR(gpios)) {
-			ret = PTR_ERR(gpios);
-			goto err;
-		} else {
-			uart->gpios = gpios;
-		}
+		if (IS_ERR(gpios))
+			return PTR_ERR(gpios);
+
+		uart->gpios = gpios;
 	}
 
 	serial8250_set_defaults(uart);
@@ -900,7 +864,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		ret = uart_add_one_port(&serial8250_reg,
 					&uart->port);
 		if (ret)
-			goto err;
+			return ret;
 
 		ret = uart->port.line;
 	} else {
@@ -927,9 +891,51 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	}
 
 	return ret;
+}
+
+/**
+ *	serial8250_register_8250_port - register a serial port
+ *	@up: serial port template
+ *
+ *	Configure the serial port specified by the request. If the
+ *	port exists and is in use, it is hung up and unregistered
+ *	first.
+ *
+ *	The port is then probed and if necessary the IRQ is autodetected
+ *	If this fails an error is returned.
+ *
+ *	On success the port is ready to use and the line number is returned.
+ */
+int serial8250_register_8250_port(const struct uart_8250_port *up)
+{
+	struct uart_8250_port *uart;
+	int ret;
+
+	if (up->port.uartclk == 0)
+		return -EINVAL;
+
+	guard(mutex)(&serial_mutex);
+
+	uart = serial8250_find_match_or_unused(&up->port);
+	if (!uart) {
+		/*
+		 * If the port is past the initial isa ports, initialize a new
+		 * port and increment nr_uarts accordingly.
+		 */
+		uart = serial8250_setup_port(nr_uarts);
+		if (!uart)
+			return -ENOSPC;
+		nr_uarts++;
+	}
+
+	/* Check if it is CIR already. We check this below again, see there why. */
+	if (uart->port.type == PORT_8250_CIR)
+		return -ENODEV;
+
+	ret = __serial8250_register_8250_port(uart, up);
+	if (ret < 0)
+		uart->port.dev = NULL;
 
-err:
-	uart->port.dev = NULL;
 	return ret;
 }
 EXPORT_SYMBOL(serial8250_register_8250_port);
-- 
2.56.0

