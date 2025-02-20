Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9E213E62;
	Thu, 20 Feb 2025 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050216; cv=none; b=O9sDQhtGTeqwxQOUpHKIMgsT76F1Iuax2wW6zlbLfKhaUFYDR8OF4Y4yOZnuGN0mwTMSCKJAvO+FgTv5hSKgpW8w2HSvyPfziHfWTjylLSG9Hji/BLPZMto5yljxj6ffcPGu5gbX0Q5r0pxFYeWPPD+oP/Ai167lVTPowBXFhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050216; c=relaxed/simple;
	bh=/Eg4ergRjLpzswoDlZwSe78LJCFnUOArT/6Zkrq+FBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMhY4tdJ7cMI1RNGDSp7asTHrz1Vw0iTDDreXdVvK6vmDD//QlC5uX22lm6H63EXvKXsc2pIaixCch4cUAN40fgkE+lnxu07x+gHPZZknIAWIiKfj5RBdYqWhmCJ7aHJ0zjEHj4sXJ6truetadb4SfLwbde2b8sJ/rTW0+7X/2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF3VdaOE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF3VdaOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316E0C4CEDD;
	Thu, 20 Feb 2025 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050216;
	bh=/Eg4ergRjLpzswoDlZwSe78LJCFnUOArT/6Zkrq+FBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XF3VdaOEtn5vXpbnnAtlHsyPYNOXFbs1MQbwUs5QptorQM3U+G9ZETRcwOoiIZzO6
	 keS8+OyUK4dmiBmDyT1VJKGxJgfLyXurbrgPk4jS9koVkDRglTEGnynwwRwLeEZsbO
	 ZAXeyy6lxpv0YqXza90lF0BXkpClbOC7KXuEK+LD1KVusVYThGv4qmwd1iMRW7i2Ug
	 0UjL7ozzdfQsgmbDe660bDlxjbRCXE6K+T7Wy/ohOsrgBzTd2Pp50nywlKHpVxSAn4
	 H7L7kYg4tCgvD+whqk/EThndf0Nn3mY4Atwsg2/ogZCb29tC3VBbFsFqBMtfLeW0NG
	 emk9ytb7Prh0Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 26/29] serial: 8250: use serial_in/out() helpers
Date: Thu, 20 Feb 2025 12:16:03 +0100
Message-ID: <20250220111606.138045-27-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are serial_in/out() helpers to be used instead of direct
p->serial_in/out(). Use them in various 8250 drivers.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c   | 17 +++++++++--------
 drivers/tty/serial/8250/8250_fsl.c  |  8 ++++----
 drivers/tty/serial/8250/8250_omap.c |  2 +-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index af24ec25d976..d0abbdd630ac 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -120,16 +120,17 @@ static void dw8250_force_idle(struct uart_port *p)
 	 * enabled.
 	 */
 	if (up->fcr & UART_FCR_ENABLE_FIFO) {
-		lsr = p->serial_in(p, UART_LSR);
+		lsr = serial_in(up, UART_LSR);
 		if (!(lsr & UART_LSR_DR))
 			return;
 	}
 
-	(void)p->serial_in(p, UART_RX);
+	serial_in(up, UART_RX);
 }
 
 static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
 {
+	struct uart_8250_port *up = up_to_u8250p(p);
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
 	void __iomem *addr = p->membase + (offset << p->regshift);
 	int tries = 1000;
@@ -139,7 +140,7 @@ static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
 
 	/* Make sure LCR write wasn't ignored */
 	while (tries--) {
-		unsigned int lcr = p->serial_in(p, offset);
+		unsigned int lcr = serial_in(up, offset);
 
 		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
 			return;
@@ -260,7 +261,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
-	unsigned int iir = p->serial_in(p, UART_IIR);
+	unsigned int iir = serial_in(up, UART_IIR);
 	bool rx_timeout = (iir & 0x3f) == UART_IIR_RX_TIMEOUT;
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
@@ -281,7 +282,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 		status = serial_lsr_in(up);
 
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
-			(void) p->serial_in(p, UART_RX);
+			serial_in(up, UART_RX);
 
 		uart_port_unlock_irqrestore(p, flags);
 	}
@@ -303,7 +304,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 
 	if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
 		/* Clear the USR */
-		(void)p->serial_in(p, d->pdata->usr_reg);
+		serial_in(up, d->pdata->usr_reg);
 
 		return 1;
 	}
@@ -390,7 +391,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
-	unsigned int mcr = p->serial_in(p, UART_MCR);
+	unsigned int mcr = serial_in(up, UART_MCR);
 
 	if (up->capabilities & UART_CAP_IRDA) {
 		if (termios->c_line == N_IRDA)
@@ -398,7 +399,7 @@ static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
 		else
 			mcr &= ~DW_UART_MCR_SIRE;
 
-		p->serial_out(p, UART_MCR, mcr);
+		serial_out(up, UART_MCR, mcr);
 	}
 	serial8250_do_set_ldisc(p, termios);
 }
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 1b7bd55619c6..df8f846f3d54 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -32,7 +32,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 
 	uart_port_lock_irqsave(&up->port, &flags);
 
-	iir = port->serial_in(port, UART_IIR);
+	iir = serial_in(up, UART_IIR);
 	if (iir & UART_IIR_NO_INT) {
 		uart_port_unlock_irqrestore(&up->port, flags);
 		return 0;
@@ -54,12 +54,12 @@ int fsl8250_handle_irq(struct uart_port *port)
 	if (unlikely((iir & UART_IIR_ID) == UART_IIR_RLSI &&
 		     (up->lsr_saved_flags & UART_LSR_BI))) {
 		up->lsr_saved_flags &= ~UART_LSR_BI;
-		port->serial_in(port, UART_RX);
+		serial_in(up, UART_RX);
 		uart_port_unlock_irqrestore(&up->port, flags);
 		return 1;
 	}
 
-	lsr = orig_lsr = up->port.serial_in(&up->port, UART_LSR);
+	lsr = orig_lsr = serial_in(up, UART_LSR);
 
 	/* Process incoming characters first */
 	if ((lsr & (UART_LSR_DR | UART_LSR_BI)) &&
@@ -71,7 +71,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 	if ((orig_lsr & UART_LSR_OE) && (up->overrun_backoff_time_ms > 0)) {
 		unsigned long delay;
 
-		up->ier = port->serial_in(port, UART_IER);
+		up->ier = serial_in(up, UART_IER);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
 		} else {
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index c2b75e3f106d..16610782258e 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -692,7 +692,7 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 
 		/* Synchronize UART_IER access against the console. */
 		uart_port_lock(port);
-		up->ier = port->serial_in(port, UART_IER);
+		up->ier = serial_in(up, UART_IER);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
 		} else {
-- 
2.48.1

