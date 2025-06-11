Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC024271459;
	Wed, 11 Jun 2025 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636247; cv=none; b=E7Aw975TAyMmZtBWs3nAjHQ/u+6k4L5jhbbxxzqQEgY4yV1DNX0+opZml2TMKXT1pPYJG7st934RJ5zKk7Rni9T/GbM4+zZRslwk3hCvo3FUFI4haTzeqoHv62qusMLVMQ317AHobOl+K+lI0r4sHmbBtElnTB+tcmI0hddVjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636247; c=relaxed/simple;
	bh=5B9gtT24AhZTBn2vPPhlNepVtn42Uh/A5PW08+jvO5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oR3dvG19MQYEYOIwMifaOUieWolQ5W1EZhaJve4KJvSja3rKoaAdnWZYHakzogDINl961dGbunWcBBwkeX084ipPGDZypoVGAEUy5wipUYgaWmVl6u8/vj8Ubssd1FhY6FwsQCjbwtsU7sHVH3rvSPnFM44m6JjL/smqzAdw7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zxv4gPpW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zxv4gPpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F078C4CEF2;
	Wed, 11 Jun 2025 10:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636247;
	bh=5B9gtT24AhZTBn2vPPhlNepVtn42Uh/A5PW08+jvO5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zxv4gPpWgFvLjzLmYnQ3cquLENkKoOTX/ehXCKDU6iMcea2ZPfx66eM8aVlf+8EX6
	 dScbD1wctf/RXSRTUAUC6oWjdFA63brw73wfkPsqXlvpfQwF97kMf+VRKJNYleMogf
	 t+VTzP6qTjihIRPBmPyt+Yge3FBQmh4RKqBl27JtU5KWUlo3r94A/NwVuzdKS5hzWa
	 y0ut4oa/7yoRnu+hI66y/6lJ9YIo8hdt43appQNQDqNl2yIq1CN1Z3mDHfy5WyzQ1l
	 z1yq1FC0BPE06zyz9TwYmF6KH9CjGvgKQBQAYBM5WidcM61382/s7ysw/B8+HGZ33s
	 c4sSnyEIhkKIg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 24/33] serial: 8250: extract serial8250_set_fcr()
Date: Wed, 11 Jun 2025 12:03:10 +0200
Message-ID: <20250611100319.186924-25-jirislaby@kernel.org>
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

serial8250_do_set_termios() consists of many registers and up flags
settings. Extract all these into separate functions. This time, setting
of FCR.

serial8250_do_set_termios() looks sane at this point.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 41 ++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 0f16398cc86f..85b75ff0699e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2792,6 +2792,30 @@ static void serial8250_set_efr(struct uart_port *port, struct ktermios *termios)
 	serial_port_out(port, efr_reg, efr);
 }
 
+static void serial8250_set_fcr(struct uart_port *port, struct ktermios *termios)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	bool is_16750 = port->type == PORT_16750;
+
+	if (is_16750)
+		serial_port_out(port, UART_FCR, up->fcr);
+
+	/*
+	 * LCR DLAB must be reset to enable 64-byte FIFO mode. If the FCR is written without DLAB
+	 * set, this mode will be disabled.
+	 */
+	serial_port_out(port, UART_LCR, up->lcr);
+
+	if (is_16750)
+		return;
+
+	/* emulated UARTs (Lucent Venus 167x) need two steps */
+	if (up->fcr & UART_FCR_ENABLE_FIFO)
+		serial_port_out(port, UART_FCR, UART_FCR_ENABLE_FIFO);
+
+	serial_port_out(port, UART_FCR, up->fcr);
+}
+
 void
 serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		          const struct ktermios *old)
@@ -2823,22 +2847,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial8250_set_ier(port, termios);
 	serial8250_set_efr(port, termios);
 	serial8250_set_divisor(port, baud, quot, frac);
-
-	/*
-	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
-	 * is written without DLAB set, this mode will be disabled.
-	 */
-	if (port->type == PORT_16750)
-		serial_port_out(port, UART_FCR, up->fcr);
-
-	serial_port_out(port, UART_LCR, up->lcr);	/* reset DLAB */
-	if (port->type != PORT_16750) {
-		/* emulated UARTs (Lucent Venus 167x) need two steps */
-		if (up->fcr & UART_FCR_ENABLE_FIFO)
-			serial_port_out(port, UART_FCR, UART_FCR_ENABLE_FIFO);
-		serial_port_out(port, UART_FCR, up->fcr);	/* set fcr */
-	}
+	serial8250_set_fcr(port, termios);
 	serial8250_set_mctrl(port, port->mctrl);
+
 	uart_port_unlock_irqrestore(port, flags);
 	serial8250_rpm_put(up);
 
-- 
2.49.0

