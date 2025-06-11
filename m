Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21F26C3AD;
	Wed, 11 Jun 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636232; cv=none; b=KU/q4cdgB/5c8f4A+qD9iwpaW3Uohk7RPaDvCVZ31O+Ms8utCjOPQlgIiWBWMoiHWOInR4O3NAIhKGofxAD5Mynd0kQDNYdEMjmRPTRQhh2gAcxJcX3h2dRtdiDYYTmerjX/NeyarPKqLNcGnF1ubfsxf6KCeCmF6IDC+NO/J/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636232; c=relaxed/simple;
	bh=tbi25yz4ZSThWLio+Que2+49CMR0gxF2qcWOskJMf08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOErYE1siMZuoOuPb5i3naWGKwfamyVX/slpn8XkIUbfkuJzTXkzgnVcMcpJpxW3P7LIDJXbbpRdyV0ArkLSiA6sFE343ErHvTZX1ETv4RY6OWOA0/lIDtEgKz7xprMWvhRUt7ysZasoIcZq6ZOfYww0YDg4oTR6RHcnljbr6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cayj+Goq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cayj+Goq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCC2C4CEEE;
	Wed, 11 Jun 2025 10:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636232;
	bh=tbi25yz4ZSThWLio+Que2+49CMR0gxF2qcWOskJMf08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cayj+GoqLyG91E6KovFtTZ5NmY3xZTn1Q//Yt+SoBQUtdb1uu8dbFqeczjzyAGe5M
	 UtQdJ4IeTXoa0KyLfFoYTrC55idNKpiYJy8XHOTLurpsUh5PoTM/yj0GvEpHvxyaWZ
	 PnIDkiP5UODret+UhZLPgz28hu2W0Saehiduk6/FL8fxl5FjE4ds7XGaI1a1A8eCqv
	 WX6qVpqZVA/7yYmPdRzqhrnV2diiV92jv//xQ0h0zUeEEwHrDEeY4ZwhjnIbAm2PBo
	 OybVK2MNULq844r1U4QQ5kzYiWNwZVaxzMTxdySYXSxBqXK/LF3loEdmv1W1Nw9ACf
	 ZuZRjaMl3/BUg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 14/33] serial: 8250: extract serial8250_set_TRG_levels()
Date: Wed, 11 Jun 2025 12:03:00 +0200
Message-ID: <20250611100319.186924-15-jirislaby@kernel.org>
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

serial8250_do_startup() contains peculiar trigger levels setup for
special ports (16850, ALTR_16550_*). Move this away to a separate
function: serial8250_set_TRG_levels().

And use switch-case instead of 'if's.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 77 +++++++++++++++--------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 21ff56a31b56..c09a90b38d8f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2159,6 +2159,46 @@ static void serial8250_startup_special(struct uart_port *port)
 	}
 }
 
+static void serial8250_set_TRG_levels(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	switch (port->type) {
+	/* For a XR16C850, we need to set the trigger levels */
+	case PORT_16850: {
+		u8 fctr;
+
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+		fctr = serial_in(up, UART_FCTR) & ~(UART_FCTR_RX|UART_FCTR_TX);
+		fctr |= UART_FCTR_TRGD;
+		serial_port_out(port, UART_FCTR, fctr | UART_FCTR_RX);
+		serial_port_out(port, UART_TRG, UART_TRG_96);
+		serial_port_out(port, UART_FCTR, fctr | UART_FCTR_TX);
+		serial_port_out(port, UART_TRG, UART_TRG_96);
+
+		serial_port_out(port, UART_LCR, 0);
+		break;
+	}
+	/* For the Altera 16550 variants, set TX threshold trigger level. */
+	case PORT_ALTR_16550_F32:
+	case PORT_ALTR_16550_F64:
+	case PORT_ALTR_16550_F128:
+		if (port->fifosize <= 1)
+			return;
+
+		/* Bounds checking of TX threshold (valid 0 to fifosize-2) */
+		if (up->tx_loadsz < 2 || up->tx_loadsz > port->fifosize) {
+			dev_err(port->dev, "TX FIFO Threshold errors, skipping\n");
+			return;
+		}
+		serial_port_out(port, UART_ALTR_AFR, UART_ALTR_EN_TXFIFO_LW);
+		serial_port_out(port, UART_ALTR_TX_LOW, port->fifosize - up->tx_loadsz);
+		port->handle_irq = serial8250_tx_threshold_handle_irq;
+		break;
+	}
+}
+
 int serial8250_do_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -2208,42 +2248,7 @@ int serial8250_do_startup(struct uart_port *port)
 		goto out;
 	}
 
-	/*
-	 * For a XR16C850, we need to set the trigger levels
-	 */
-	if (port->type == PORT_16850) {
-		unsigned char fctr;
-
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-
-		fctr = serial_in(up, UART_FCTR) & ~(UART_FCTR_RX|UART_FCTR_TX);
-		serial_port_out(port, UART_FCTR,
-				fctr | UART_FCTR_TRGD | UART_FCTR_RX);
-		serial_port_out(port, UART_TRG, UART_TRG_96);
-		serial_port_out(port, UART_FCTR,
-				fctr | UART_FCTR_TRGD | UART_FCTR_TX);
-		serial_port_out(port, UART_TRG, UART_TRG_96);
-
-		serial_port_out(port, UART_LCR, 0);
-	}
-
-	/*
-	 * For the Altera 16550 variants, set TX threshold trigger level.
-	 */
-	if (((port->type == PORT_ALTR_16550_F32) ||
-	     (port->type == PORT_ALTR_16550_F64) ||
-	     (port->type == PORT_ALTR_16550_F128)) && (port->fifosize > 1)) {
-		/* Bounds checking of TX threshold (valid 0 to fifosize-2) */
-		if ((up->tx_loadsz < 2) || (up->tx_loadsz > port->fifosize)) {
-			dev_err(port->dev, "TX FIFO Threshold errors, skipping\n");
-		} else {
-			serial_port_out(port, UART_ALTR_AFR,
-					UART_ALTR_EN_TXFIFO_LW);
-			serial_port_out(port, UART_ALTR_TX_LOW,
-					port->fifosize - up->tx_loadsz);
-			port->handle_irq = serial8250_tx_threshold_handle_irq;
-		}
-	}
+	serial8250_set_TRG_levels(port);
 
 	/* Check if we need to have shared IRQs */
 	if (port->irq && (up->port.flags & UPF_SHARE_IRQ))
-- 
2.49.0

