Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630022749FA;
	Wed, 11 Jun 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636257; cv=none; b=GxvtYBezPGudTrTb2wDciKp4Y86Knn7xproqbX1Q+59zo4H9GS8xpuju9O81WtE8SXOWgTZ1/DXJCdwLD3dv6EJhWDONk3+mZauHVVUri1htZIyp3I5XWCTqv1c4CK0XBsjB12BKEnaY+2e9FuPY3ZRm1MAnCMlp3K/A/c36ttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636257; c=relaxed/simple;
	bh=yv/RaTW9MuC3s3vDA052dackvAJiP/l11cLARUKG7co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCbdlFjX0VN6d5a3E0LTVNfjPvxB75gqScJ+hTiIEk06OVf05CXg0KXHIfDHIaF64h7qHW68O3HQNQK90X/ZenXBioNQ7Q9wGDRdo8Z4Eq5xEy66vbte/21ZmPrwm341kj4OxmI9BvL14GcQjMNCBHrak47VErjJZqjckpsyGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8HB5jaP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8HB5jaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3442C4CEF2;
	Wed, 11 Jun 2025 10:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636256;
	bh=yv/RaTW9MuC3s3vDA052dackvAJiP/l11cLARUKG7co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8HB5jaPPkKuGtW0E9IQaFvuvkR8d3NDRMLU1z6KIyzqOwqEYU95JgcmCwdhj27Sq
	 aNpSybkuRyfFZCS/mRZJxHZHspA2RwFCd6JVxNnxPGIdt1a05pinCcaC0P1RZBczc6
	 mt6EzpDgeEbTOviIwQczx/w53gMnpFeiB6IZ3U8FO4QxUGSXwOJwcTKp0Cxq/wWEib
	 bNShiXHD3+qM0dgX6itMcDSXWDgkYUQD+dbPNzy9hesMhnvUARJAJcpkjdeqIM+XfV
	 GXBnjN6TQoCsHb3iYSqom2K9RvClS+aCHXtyQWANcy2yT6Zbrd9wwKWSwyyYYGzzwr
	 DjblzLYqsdufQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 30/33] serial: 8250: invert serial8250_register_8250_port() CIR condition
Date: Wed, 11 Jun 2025 12:03:16 +0200
Message-ID: <20250611100319.186924-31-jirislaby@kernel.org>
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

There is no point in a long 'if' in serial8250_register_8250_port() to
just return ENOSPC for PORT_8250_CIR ports. Invert the condition and
return immediately.

'gpios' variable was moved to its set location.

And return ENODEV instead of ENOSPC. The latter is a leftover from the
previous find-uart 'if'. The former makes a lot more sense in this case.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_core.c | 253 ++++++++++++++--------------
 1 file changed, 127 insertions(+), 126 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 2bac9c7827de..10f25bae9f46 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -725,139 +725,140 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		nr_uarts++;
 	}
 
-	if (uart->port.type != PORT_8250_CIR) {
-		struct mctrl_gpios *gpios;
-
-		if (uart->port.dev)
-			uart_remove_one_port(&serial8250_reg, &uart->port);
-
-		uart->port.ctrl_id	= up->port.ctrl_id;
-		uart->port.port_id	= up->port.port_id;
-		uart->port.iobase       = up->port.iobase;
-		uart->port.membase      = up->port.membase;
-		uart->port.irq          = up->port.irq;
-		uart->port.irqflags     = up->port.irqflags;
-		uart->port.uartclk      = up->port.uartclk;
-		uart->port.fifosize     = up->port.fifosize;
-		uart->port.regshift     = up->port.regshift;
-		uart->port.iotype       = up->port.iotype;
-		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
-		uart->bugs		= up->bugs;
-		uart->port.mapbase      = up->port.mapbase;
-		uart->port.mapsize      = up->port.mapsize;
-		uart->port.private_data = up->port.private_data;
-		uart->tx_loadsz		= up->tx_loadsz;
-		uart->capabilities	= up->capabilities;
-		uart->port.throttle	= up->port.throttle;
-		uart->port.unthrottle	= up->port.unthrottle;
-		uart->port.rs485_config	= up->port.rs485_config;
-		uart->port.rs485_supported = up->port.rs485_supported;
-		uart->port.rs485	= up->port.rs485;
-		uart->rs485_start_tx	= up->rs485_start_tx;
-		uart->rs485_stop_tx	= up->rs485_stop_tx;
-		uart->lsr_save_mask	= up->lsr_save_mask;
-		uart->dma		= up->dma;
-
-		/* Take tx_loadsz from fifosize if it wasn't set separately */
-		if (uart->port.fifosize && !uart->tx_loadsz)
-			uart->tx_loadsz = uart->port.fifosize;
-
-		if (up->port.dev) {
-			uart->port.dev = up->port.dev;
-			ret = uart_get_rs485_mode(&uart->port);
-			if (ret)
-				goto err;
-		}
+	if (uart->port.type == PORT_8250_CIR) {
+		ret = -ENODEV;
+		goto unlock;
+	}
 
-		if (up->port.flags & UPF_FIXED_TYPE)
-			uart->port.type = up->port.type;
+	if (uart->port.dev)
+		uart_remove_one_port(&serial8250_reg, &uart->port);
+
+	uart->port.ctrl_id	= up->port.ctrl_id;
+	uart->port.port_id	= up->port.port_id;
+	uart->port.iobase       = up->port.iobase;
+	uart->port.membase      = up->port.membase;
+	uart->port.irq          = up->port.irq;
+	uart->port.irqflags     = up->port.irqflags;
+	uart->port.uartclk      = up->port.uartclk;
+	uart->port.fifosize     = up->port.fifosize;
+	uart->port.regshift     = up->port.regshift;
+	uart->port.iotype       = up->port.iotype;
+	uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
+	uart->bugs		= up->bugs;
+	uart->port.mapbase      = up->port.mapbase;
+	uart->port.mapsize      = up->port.mapsize;
+	uart->port.private_data = up->port.private_data;
+	uart->tx_loadsz		= up->tx_loadsz;
+	uart->capabilities	= up->capabilities;
+	uart->port.throttle	= up->port.throttle;
+	uart->port.unthrottle	= up->port.unthrottle;
+	uart->port.rs485_config	= up->port.rs485_config;
+	uart->port.rs485_supported = up->port.rs485_supported;
+	uart->port.rs485	= up->port.rs485;
+	uart->rs485_start_tx	= up->rs485_start_tx;
+	uart->rs485_stop_tx	= up->rs485_stop_tx;
+	uart->lsr_save_mask	= up->lsr_save_mask;
+	uart->dma		= up->dma;
+
+	/* Take tx_loadsz from fifosize if it wasn't set separately */
+	if (uart->port.fifosize && !uart->tx_loadsz)
+		uart->tx_loadsz = uart->port.fifosize;
+
+	if (up->port.dev) {
+		uart->port.dev = up->port.dev;
+		ret = uart_get_rs485_mode(&uart->port);
+		if (ret)
+			goto err;
+	}
 
-		/*
-		 * Only call mctrl_gpio_init(), if the device has no ACPI
-		 * companion device
-		 */
-		if (!has_acpi_companion(uart->port.dev)) {
-			gpios = mctrl_gpio_init(&uart->port, 0);
-			if (IS_ERR(gpios)) {
-				ret = PTR_ERR(gpios);
-				goto err;
-			} else {
-				uart->gpios = gpios;
-			}
-		}
+	if (up->port.flags & UPF_FIXED_TYPE)
+		uart->port.type = up->port.type;
 
-		serial8250_set_defaults(uart);
-
-		/* Possibly override default I/O functions.  */
-		if (up->port.serial_in)
-			uart->port.serial_in = up->port.serial_in;
-		if (up->port.serial_out)
-			uart->port.serial_out = up->port.serial_out;
-		if (up->port.handle_irq)
-			uart->port.handle_irq = up->port.handle_irq;
-		/*  Possibly override set_termios call */
-		if (up->port.set_termios)
-			uart->port.set_termios = up->port.set_termios;
-		if (up->port.set_ldisc)
-			uart->port.set_ldisc = up->port.set_ldisc;
-		if (up->port.get_mctrl)
-			uart->port.get_mctrl = up->port.get_mctrl;
-		if (up->port.set_mctrl)
-			uart->port.set_mctrl = up->port.set_mctrl;
-		if (up->port.get_divisor)
-			uart->port.get_divisor = up->port.get_divisor;
-		if (up->port.set_divisor)
-			uart->port.set_divisor = up->port.set_divisor;
-		if (up->port.startup)
-			uart->port.startup = up->port.startup;
-		if (up->port.shutdown)
-			uart->port.shutdown = up->port.shutdown;
-		if (up->port.pm)
-			uart->port.pm = up->port.pm;
-		if (up->port.handle_break)
-			uart->port.handle_break = up->port.handle_break;
-		if (up->dl_read)
-			uart->dl_read = up->dl_read;
-		if (up->dl_write)
-			uart->dl_write = up->dl_write;
-
-		if (uart->port.type != PORT_8250_CIR) {
-			if (uart_console_registered(&uart->port))
-				pm_runtime_get_sync(uart->port.dev);
-
-			if (serial8250_isa_config != NULL)
-				serial8250_isa_config(0, &uart->port,
-						&uart->capabilities);
-
-			serial8250_apply_quirks(uart);
-			ret = uart_add_one_port(&serial8250_reg,
-						&uart->port);
-			if (ret)
-				goto err;
-
-			ret = uart->port.line;
+	/*
+	 * Only call mctrl_gpio_init(), if the device has no ACPI
+	 * companion device
+	 */
+	if (!has_acpi_companion(uart->port.dev)) {
+		struct mctrl_gpios *gpios = mctrl_gpio_init(&uart->port, 0);
+		if (IS_ERR(gpios)) {
+			ret = PTR_ERR(gpios);
+			goto err;
 		} else {
-			dev_info(uart->port.dev,
-				"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
-				uart->port.iobase,
-				(unsigned long long)uart->port.mapbase,
-				uart->port.irq);
-
-			ret = 0;
+			uart->gpios = gpios;
 		}
+	}
 
-		if (!uart->lsr_save_mask)
-			uart->lsr_save_mask = LSR_SAVE_FLAGS;	/* Use default LSR mask */
+	serial8250_set_defaults(uart);
+
+	/* Possibly override default I/O functions.  */
+	if (up->port.serial_in)
+		uart->port.serial_in = up->port.serial_in;
+	if (up->port.serial_out)
+		uart->port.serial_out = up->port.serial_out;
+	if (up->port.handle_irq)
+		uart->port.handle_irq = up->port.handle_irq;
+	/*  Possibly override set_termios call */
+	if (up->port.set_termios)
+		uart->port.set_termios = up->port.set_termios;
+	if (up->port.set_ldisc)
+		uart->port.set_ldisc = up->port.set_ldisc;
+	if (up->port.get_mctrl)
+		uart->port.get_mctrl = up->port.get_mctrl;
+	if (up->port.set_mctrl)
+		uart->port.set_mctrl = up->port.set_mctrl;
+	if (up->port.get_divisor)
+		uart->port.get_divisor = up->port.get_divisor;
+	if (up->port.set_divisor)
+		uart->port.set_divisor = up->port.set_divisor;
+	if (up->port.startup)
+		uart->port.startup = up->port.startup;
+	if (up->port.shutdown)
+		uart->port.shutdown = up->port.shutdown;
+	if (up->port.pm)
+		uart->port.pm = up->port.pm;
+	if (up->port.handle_break)
+		uart->port.handle_break = up->port.handle_break;
+	if (up->dl_read)
+		uart->dl_read = up->dl_read;
+	if (up->dl_write)
+		uart->dl_write = up->dl_write;
 
-		/* Initialise interrupt backoff work if required */
-		if (up->overrun_backoff_time_ms > 0) {
-			uart->overrun_backoff_time_ms =
-				up->overrun_backoff_time_ms;
-			INIT_DELAYED_WORK(&uart->overrun_backoff,
-					serial_8250_overrun_backoff_work);
-		} else {
-			uart->overrun_backoff_time_ms = 0;
-		}
+	if (uart->port.type != PORT_8250_CIR) {
+		if (uart_console_registered(&uart->port))
+			pm_runtime_get_sync(uart->port.dev);
+
+		if (serial8250_isa_config != NULL)
+			serial8250_isa_config(0, &uart->port,
+					&uart->capabilities);
+
+		serial8250_apply_quirks(uart);
+		ret = uart_add_one_port(&serial8250_reg,
+					&uart->port);
+		if (ret)
+			goto err;
+
+		ret = uart->port.line;
+	} else {
+		dev_info(uart->port.dev,
+			"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
+			uart->port.iobase,
+			(unsigned long long)uart->port.mapbase,
+			uart->port.irq);
+
+		ret = 0;
+	}
+
+	if (!uart->lsr_save_mask)
+		uart->lsr_save_mask = LSR_SAVE_FLAGS;	/* Use default LSR mask */
+
+	/* Initialise interrupt backoff work if required */
+	if (up->overrun_backoff_time_ms > 0) {
+		uart->overrun_backoff_time_ms =
+			up->overrun_backoff_time_ms;
+		INIT_DELAYED_WORK(&uart->overrun_backoff,
+				serial_8250_overrun_backoff_work);
+	} else {
+		uart->overrun_backoff_time_ms = 0;
 	}
 
 unlock:
-- 
2.49.0

