Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D52750FA;
	Thu, 14 Aug 2025 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156316; cv=none; b=Au1OP26TKi7dicjvuCciYceOOlng+27Hc1XvbrI+b3Uiyp7inUzKuz5xTU7ixy0vjkZziWXj50DY7Xrq6xCPoABYtgZ9XI4qGmaBPhRDgxnNm9KlSQtKOpAGoI+1WL9ZZoYsKvyi0RrejKh9fzNs2Ji0dYDpJBAVxA/TUfr/jgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156316; c=relaxed/simple;
	bh=JSvmbsUXGxQiTPTUgF6Q+ZmZQGZx3+bOh4O8C4iliTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cvdb+bimS0B36uldGEF+6Zv0isR7xdVTEPr8vg0D+jPwn6z9vCGNwdjERrZC8BvweJxU6c/n3M0w6jY36NIS5p4rrt9/oS6c4KcJAXGXd/JBgjGpmk38NcPnv+K5vbTMg6Uzs8tSKVrP3TtA2W/TlwjHRV8VJd4D6Ovy61vrHAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd2YzL67; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd2YzL67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4875FC4CEF5;
	Thu, 14 Aug 2025 07:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156316;
	bh=JSvmbsUXGxQiTPTUgF6Q+ZmZQGZx3+bOh4O8C4iliTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nd2YzL67n28YT/6+mamTPxBHBP9aLRRqmHqAcWBiis92HlxBs9RJzggEusDFoFQ3Q
	 XCEcHGIAsO0AgQjLqtI+k0mm0oz03rKewfZtzUukEgZAv1ObTAmwzZj4ISPqxk2J6P
	 JSF+tlZGHrQgjnOoxaGS2gH+pBbNflwsMok8g+LHc2f/QviOCG6utTKsWCr8Z2mjTc
	 uy/NHt/2EJ5Py8EF3gfFxYkuh5anwjmcTt1Z5HxML5ZjdfSCl3x+1rdeGMySHaBJZD
	 GLIeLi67z5w2ppPFzFqCSlcfsGtB7zFX56Dez5vYH1fG03c5aY5NLBKMhmhGSkZuml
	 Ke5bFHabHuAPg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 11/16] serial: 8250_omap: extract omap_8250_set_termios_atomic()
Date: Thu, 14 Aug 2025 09:24:51 +0200
Message-ID: <20250814072456.182853-12-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814072456.182853-1-jirislaby@kernel.org>
References: <20250814072456.182853-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To use guard()s easily in omap_8250_set_termios(), split it into atomic
and non-atomic part. The former can be easily guarded -- without a need
of indenting or moving code.

omap_8250_set_termios() would likely profit from a cleanup similar to
one in serial8250_do_set_termios() in commit cdc4a3e0b235 ("serial:
8250: extract serial8250_set_fcr()") and earlier.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_omap.c | 39 ++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 6707f55bdbe7..ba03955fdc6e 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -369,18 +369,12 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 		serial8250_em485_stop_tx(up, true);
 }
 
-/*
- * OMAP can use "CLK / (16 or 13) / div" for baud rate. And then we have have
- * some differences in how we want to handle flow control.
- */
-static void omap_8250_set_termios(struct uart_port *port,
-				  struct ktermios *termios,
-				  const struct ktermios *old)
+static void omap_8250_set_termios_atomic(struct uart_port *port, struct ktermios *termios,
+					 const struct ktermios *old, unsigned int baud)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct omap8250_priv *priv = port->private_data;
-	unsigned char cval = 0;
-	unsigned int baud;
+	u8 cval;
 
 	cval = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
 
@@ -393,12 +387,6 @@ static void omap_8250_set_termios(struct uart_port *port,
 	if (termios->c_cflag & CMSPAR)
 		cval |= UART_LCR_SPAR;
 
-	/*
-	 * Ask the core to calculate the divisor for us.
-	 */
-	baud = uart_get_baud_rate(port, termios, old,
-				  port->uartclk / 16 / UART_DIV_MAX,
-				  port->uartclk / 13);
 	omap_8250_get_divisor(port, baud, priv);
 
 	/*
@@ -518,6 +506,27 @@ static void omap_8250_set_termios(struct uart_port *port,
 	uart_port_unlock_irq(&up->port);
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
+}
+
+/*
+ * OMAP can use "CLK / (16 or 13) / div" for baud rate. And then we have have
+ * some differences in how we want to handle flow control.
+ */
+static void omap_8250_set_termios(struct uart_port *port,
+				  struct ktermios *termios,
+				  const struct ktermios *old)
+{
+	struct omap8250_priv *priv = port->private_data;
+	unsigned int baud;
+
+	/*
+	 * Ask the core to calculate the divisor for us.
+	 */
+	baud = uart_get_baud_rate(port, termios, old,
+				  port->uartclk / 16 / UART_DIV_MAX,
+				  port->uartclk / 13);
+
+	omap_8250_set_termios_atomic(port, termios, old, baud);
 
 	/* calculate wakeup latency constraint */
 	priv->calc_latency = USEC_PER_SEC * 64 * 8 / baud;
-- 
2.50.1

