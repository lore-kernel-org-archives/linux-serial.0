Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A2D233128;
	Mon, 17 Mar 2025 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194895; cv=none; b=CaivoPzLCbR3vdtVppPnvk1vZcpvfjm+a7LlUTOuvGZP7itQMi2TdgKNfSXsgK64h1T79+L52iTz63oOE7joWES3NeKV8NfwX1vz57cmwU8EgbeRj5vdTYR3GKQext8OaVDlOHC961oZetz9CySOYTs8HWYz+3kXgFoNAoFHr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194895; c=relaxed/simple;
	bh=Rmc+5nPUH6BKMjZs2vwDRk8Yfd9ZMuQr6K56At2pRfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SD8Y5/3vnmsbx4I3lWgb2SxB6DcR2g0T0mFZFS7j0quYnqFjSyByt4XIyquTQMW6vYv1XTcpQEz8BGbNqJnp+uGn6/M/nPb2l9qk2p12f6Sl2yH1YPlvFc5/vNkal3PccBveRgWvBoznZTJARzH1d3T5e/1pE1c7RTmnU4frmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVjPKMyC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVjPKMyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A167C4CEEC;
	Mon, 17 Mar 2025 07:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194895;
	bh=Rmc+5nPUH6BKMjZs2vwDRk8Yfd9ZMuQr6K56At2pRfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVjPKMyCD09L+0K23Lk3T2iZKylANfwSMqOpOL1KthouxSvE1ZcAsmZNzPC8Oe8Np
	 BCR4IcZnLjnDeoteDrSBkg5l0RJFL9Lg3Zj83TImfXoy5BSDK83s93LTZptdybRRfX
	 BklP694g82p+RU4Wag2JA4m5MdB34TYDttSFvXJCSJh/MvIsx55dahcLt8pdi0bntJ
	 GNn8Uzb5nkix5Ld98A2CnXx1DStq2tJhnH1dz6yKyD2NWq7BMbklmMRRMyZuhhm2aJ
	 lu7LukKbGtpz95A4Owm2dSLUxNWx8TYV+qeMT8BrEFLItajweMWF8US1VDJfJFwx0k
	 8N4NQP6J930Ww==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 27/31] serial: 8250: use serial_port_in/out() helpers
Date: Mon, 17 Mar 2025 08:00:42 +0100
Message-ID: <20250317070046.24386-28-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are serial_port_in/out() helpers to be used instead of direct
p->serial_in/out(). Use them in various 8250 drivers.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

--
[v2]
* Use serial_port_in/out() and not serial_in/out() [Andy]
---
 drivers/tty/serial/8250/8250_dw.c   | 16 ++++++++--------
 drivers/tty/serial/8250/8250_fsl.c  |  8 ++++----
 drivers/tty/serial/8250/8250_omap.c |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index af24ec25d976..f068b8d7840a 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -120,12 +120,12 @@ static void dw8250_force_idle(struct uart_port *p)
 	 * enabled.
 	 */
 	if (up->fcr & UART_FCR_ENABLE_FIFO) {
-		lsr = p->serial_in(p, UART_LSR);
+		lsr = serial_port_in(p, UART_LSR);
 		if (!(lsr & UART_LSR_DR))
 			return;
 	}
 
-	(void)p->serial_in(p, UART_RX);
+	serial_port_in(p, UART_RX);
 }
 
 static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
@@ -139,7 +139,7 @@ static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
 
 	/* Make sure LCR write wasn't ignored */
 	while (tries--) {
-		unsigned int lcr = p->serial_in(p, offset);
+		unsigned int lcr = serial_port_in(p, offset);
 
 		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
 			return;
@@ -260,7 +260,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
-	unsigned int iir = p->serial_in(p, UART_IIR);
+	unsigned int iir = serial_port_in(p, UART_IIR);
 	bool rx_timeout = (iir & 0x3f) == UART_IIR_RX_TIMEOUT;
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
@@ -281,7 +281,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 		status = serial_lsr_in(up);
 
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
-			(void) p->serial_in(p, UART_RX);
+			serial_port_in(p, UART_RX);
 
 		uart_port_unlock_irqrestore(p, flags);
 	}
@@ -303,7 +303,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 
 	if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
 		/* Clear the USR */
-		(void)p->serial_in(p, d->pdata->usr_reg);
+		serial_port_in(p, d->pdata->usr_reg);
 
 		return 1;
 	}
@@ -390,7 +390,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
-	unsigned int mcr = p->serial_in(p, UART_MCR);
+	unsigned int mcr = serial_port_in(p, UART_MCR);
 
 	if (up->capabilities & UART_CAP_IRDA) {
 		if (termios->c_line == N_IRDA)
@@ -398,7 +398,7 @@ static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
 		else
 			mcr &= ~DW_UART_MCR_SIRE;
 
-		p->serial_out(p, UART_MCR, mcr);
+		serial_port_out(p, UART_MCR, mcr);
 	}
 	serial8250_do_set_ldisc(p, termios);
 }
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 1b7bd55619c6..649ae5c8304d 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -32,7 +32,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 
 	uart_port_lock_irqsave(&up->port, &flags);
 
-	iir = port->serial_in(port, UART_IIR);
+	iir = serial_port_in(port, UART_IIR);
 	if (iir & UART_IIR_NO_INT) {
 		uart_port_unlock_irqrestore(&up->port, flags);
 		return 0;
@@ -54,12 +54,12 @@ int fsl8250_handle_irq(struct uart_port *port)
 	if (unlikely((iir & UART_IIR_ID) == UART_IIR_RLSI &&
 		     (up->lsr_saved_flags & UART_LSR_BI))) {
 		up->lsr_saved_flags &= ~UART_LSR_BI;
-		port->serial_in(port, UART_RX);
+		serial_port_in(port, UART_RX);
 		uart_port_unlock_irqrestore(&up->port, flags);
 		return 1;
 	}
 
-	lsr = orig_lsr = up->port.serial_in(&up->port, UART_LSR);
+	lsr = orig_lsr = serial_port_in(port, UART_LSR);
 
 	/* Process incoming characters first */
 	if ((lsr & (UART_LSR_DR | UART_LSR_BI)) &&
@@ -71,7 +71,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 	if ((orig_lsr & UART_LSR_OE) && (up->overrun_backoff_time_ms > 0)) {
 		unsigned long delay;
 
-		up->ier = port->serial_in(port, UART_IER);
+		up->ier = serial_port_in(port, UART_IER);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
 		} else {
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index c2b75e3f106d..2a0ce11f405d 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -692,7 +692,7 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 
 		/* Synchronize UART_IER access against the console. */
 		uart_port_lock(port);
-		up->ier = port->serial_in(port, UART_IER);
+		up->ier = serial_port_in(port, UART_IER);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
 		} else {
-- 
2.49.0

