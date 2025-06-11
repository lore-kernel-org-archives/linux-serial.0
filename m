Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D026C393;
	Wed, 11 Jun 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636231; cv=none; b=CRtZypHlgYXwalV7WjUoFXVvKzQgi1bMhGGZ7x1/fTVpUUubTv09MeannEZsb+4DLmIEOGUCuGcEC8R5pgTQ4d6sGzxeg5y+bsDrK7go3KiRTNo99QsuQbolR+cEM/ewDb0mTLVQM0hl9QmVPcC3Xwj4GMxp9FaQ7v3OVskucZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636231; c=relaxed/simple;
	bh=y5IGopF9dCwKo6ZEh6UR60f6BBfB6HOuprnQtQedge0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaJBGmzRMTwyIFfQgjX4y+MH4pcXRjSmP/vHn9WasHb/NCdflx9Nv6CGJXi6cUcv4BeY5YGCy2tnbM2WuavI8RZJvTD1h8dg6ZXJ8Q2Ewqid1XCZ4KJWJgUoEMcQKREVmRIiptc2htJa3V7Fwes5jAHKDPrzXPD3nc6ft3sQrs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm9WQMtw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm9WQMtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E67C4CEF2;
	Wed, 11 Jun 2025 10:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636230;
	bh=y5IGopF9dCwKo6ZEh6UR60f6BBfB6HOuprnQtQedge0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cm9WQMtwBXImNIFVydHSxEhhHAvoXXJkbl+rVbf6bu9I7gSpXhuI6suNKCzdDDURn
	 MWYVa+sr+shw/ZKXPm69rPzZ4eJXV7VrYjyGZQSA+L0spqHkoN6JJRSq8LBtNxkXrQ
	 gvywt/OcFhN/MEDIaUBYInuNZGXRNxCYa+19yv503URlc9C/6xPGTDl8CNG+k0Dyld
	 d9sJuTbb7vwm9TW9sR4vRU0RXKPWT9ATNOc98QV5QrA+friMyVGeulD4Y1regsOx4Z
	 KjTUc3iwxSChEiAzdNguW6qDCQUgIhAbpNwsRDcK+TdfGpUZzMNw0KHAxQ854pOUPx
	 jxiAbq/kWHojA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 13/33] serial: 8250: extract serial8250_startup_special()
Date: Wed, 11 Jun 2025 12:02:59 +0200
Message-ID: <20250611100319.186924-14-jirislaby@kernel.org>
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

Let the serial8250_do_startup() code handle the special ports (16C950,
DA830, RSA) startup in a separate function:
serial8250_startup_special().

And instead of multiple if-else-if, use switch-case. So that it can be
easily checked for PORT_RSA now too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 53 +++++++++++++++++------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 476f5fc50237..21ff56a31b56 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2111,27 +2111,13 @@ static void serial8250_put_poll_char(struct uart_port *port,
 
 #endif /* CONFIG_CONSOLE_POLL */
 
-int serial8250_do_startup(struct uart_port *port)
+static void serial8250_startup_special(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
-	unsigned char iir;
-	int retval;
-	u16 lsr;
-
-	if (!port->fifosize)
-		port->fifosize = uart_config[port->type].fifo_size;
-	if (!up->tx_loadsz)
-		up->tx_loadsz = uart_config[port->type].tx_loadsz;
-	if (!up->capabilities)
-		up->capabilities = uart_config[port->type].flags;
-	up->mcr = 0;
-
-	if (port->iotype != up->cur_iotype)
-		set_io_from_upio(port);
 
-	serial8250_rpm_get(up);
-	if (port->type == PORT_16C950) {
+	switch (port->type) {
+	case PORT_16C950:
 		/*
 		 * Wake up and initialize UART
 		 *
@@ -2148,9 +2134,8 @@ int serial8250_do_startup(struct uart_port *port)
 		serial_port_out(port, UART_EFR, UART_EFR_ECB);
 		serial_port_out(port, UART_LCR, 0);
 		uart_port_unlock_irqrestore(port, flags);
-	}
-
-	if (port->type == PORT_DA830) {
+		break;
+	case PORT_DA830:
 		/*
 		 * Reset the port
 		 *
@@ -2167,9 +2152,35 @@ int serial8250_do_startup(struct uart_port *port)
 				UART_DA830_PWREMU_MGMT_UTRST |
 				UART_DA830_PWREMU_MGMT_URRST |
 				UART_DA830_PWREMU_MGMT_FREE);
+		break;
+	case PORT_RSA:
+		rsa_enable(up);
+		break;
 	}
+}
+
+int serial8250_do_startup(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned long flags;
+	unsigned char iir;
+	int retval;
+	u16 lsr;
+
+	if (!port->fifosize)
+		port->fifosize = uart_config[port->type].fifo_size;
+	if (!up->tx_loadsz)
+		up->tx_loadsz = uart_config[port->type].tx_loadsz;
+	if (!up->capabilities)
+		up->capabilities = uart_config[port->type].flags;
+	up->mcr = 0;
+
+	if (port->iotype != up->cur_iotype)
+		set_io_from_upio(port);
+
+	serial8250_rpm_get(up);
 
-	rsa_enable(up);
+	serial8250_startup_special(port);
 
 	/*
 	 * Clear the FIFO buffers and disable them.
-- 
2.49.0

