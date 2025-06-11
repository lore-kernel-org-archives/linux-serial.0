Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F0026D4E2;
	Wed, 11 Jun 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636234; cv=none; b=Ans+1wFny1/9I9mj5yMmtawvrZ29FpIMp8NY7yDDej3paXq2yIUj2q03HFjEQmXK4M3cXYEAnDQOpWwAuMv91Hs6TloQwZxwcu9+HCi3dkmMB5HtHJ/HgPDNrKeZ497Il92lx/Gh5N2yT/4FPdsNdSyFIQQMPbfC5rhzSYxHYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636234; c=relaxed/simple;
	bh=ux5Y5OYcWn8VeMYcmbr4S7y2Gif49OHeQpMD/bE4dJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbLJOxK7ewpZZLHNEQsA1uBlEbK6r0BATUU+I60+uDeWD9sPL7xLXE42fLx/AKpLbx01FMBUnMWhtD4PEcG5zajNoJnrMpX7rYBFiQpXsN7E87hQ5wpkDJmviBK+iUtVzLYp4yAjyXwbjg7iY9DoQCC8UtB2JiSmEW7B3czL+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJtYnya9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJtYnya9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4EBC4CEEE;
	Wed, 11 Jun 2025 10:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636233;
	bh=ux5Y5OYcWn8VeMYcmbr4S7y2Gif49OHeQpMD/bE4dJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJtYnya9JY7rCLaNJ1+A7uI31O7UYoUKU9RIoW+PeR2o1FWlZUu6tEH3iHYGBltmo
	 eJsFKUtuAuSRiHFJnkXkz098si0MA+wae1picc+wa9BAl5cPxh3ucl6bDOUh2PADYL
	 IxNdqbbX+TcFgIRa38X/uCSoZCuJ3wrC5fTUXpKZSxUG8ywmTaMoefZJtIvh0dGoZl
	 7fOp/Ed3esloo8H3lz2wY1WMbd3dpnNB23nvqSqbIN3DAT4PqmmYcFEeasN1DF+HcR
	 4BcS8rYmDc9oWbPd8T0VmcMepGcSnXsUeZeamrNkWXFuezApl8ovePgOpmZkP7aGn5
	 qvlAAaI4QOfjA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 15/33] serial: 8250: extract serial8250_THRE_test()
Date: Wed, 11 Jun 2025 12:03:01 +0200
Message-ID: <20250611100319.186924-16-jirislaby@kernel.org>
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

serial8250_do_startup() contains a stand-alone code for probing THRE.
Furthermore, the code block is conditional (port->irq and test for
UPF_NO_THRE_TEST).

Move this code to a separate function. The conditional can be evaluated
easier there -- by a simple return in the beginning. So the indentation
level lowers and the code is overall more readable now.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 92 +++++++++++++++--------------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c09a90b38d8f..5466286bb44f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2199,6 +2199,54 @@ static void serial8250_set_TRG_levels(struct uart_port *port)
 	}
 }
 
+static void serial8250_THRE_test(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned long flags;
+	bool iir_noint1, iir_noint2;
+
+	if (!port->irq)
+		return;
+
+	if (up->port.flags & UPF_NO_THRE_TEST)
+		return;
+
+	if (port->irqflags & IRQF_SHARED)
+		disable_irq_nosync(port->irq);
+
+	/*
+	 * Test for UARTs that do not reassert THRE when the transmitter is idle and the interrupt
+	 * has already been cleared.  Real 16550s should always reassert this interrupt whenever the
+	 * transmitter is idle and the interrupt is enabled.  Delays are necessary to allow register
+	 * changes to become visible.
+	 *
+	 * Synchronize UART_IER access against the console.
+	 */
+	uart_port_lock_irqsave(port, &flags);
+
+	wait_for_xmitr(up, UART_LSR_THRE);
+	serial_port_out_sync(port, UART_IER, UART_IER_THRI);
+	udelay(1); /* allow THRE to set */
+	iir_noint1 = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
+	serial_port_out(port, UART_IER, 0);
+	serial_port_out_sync(port, UART_IER, UART_IER_THRI);
+	udelay(1); /* allow a working UART time to re-assert THRE */
+	iir_noint2 = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
+	serial_port_out(port, UART_IER, 0);
+
+	uart_port_unlock_irqrestore(port, flags);
+
+	if (port->irqflags & IRQF_SHARED)
+		enable_irq(port->irq);
+
+	/*
+	 * If the interrupt is not reasserted, or we otherwise don't trust the iir, setup a timer to
+	 * kick the UART on a regular basis.
+	 */
+	if ((!iir_noint1 && iir_noint2) || up->port.flags & UPF_BUG_THRE)
+		up->bugs |= UART_BUG_THRE;
+}
+
 int serial8250_do_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -2258,49 +2306,7 @@ int serial8250_do_startup(struct uart_port *port)
 	if (retval)
 		goto out;
 
-	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
-		unsigned char iir1;
-
-		if (port->irqflags & IRQF_SHARED)
-			disable_irq_nosync(port->irq);
-
-		/*
-		 * Test for UARTs that do not reassert THRE when the
-		 * transmitter is idle and the interrupt has already
-		 * been cleared.  Real 16550s should always reassert
-		 * this interrupt whenever the transmitter is idle and
-		 * the interrupt is enabled.  Delays are necessary to
-		 * allow register changes to become visible.
-		 *
-		 * Synchronize UART_IER access against the console.
-		 */
-		uart_port_lock_irqsave(port, &flags);
-
-		wait_for_xmitr(up, UART_LSR_THRE);
-		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
-		udelay(1); /* allow THRE to set */
-		iir1 = serial_port_in(port, UART_IIR);
-		serial_port_out(port, UART_IER, 0);
-		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
-		udelay(1); /* allow a working UART time to re-assert THRE */
-		iir = serial_port_in(port, UART_IIR);
-		serial_port_out(port, UART_IER, 0);
-
-		uart_port_unlock_irqrestore(port, flags);
-
-		if (port->irqflags & IRQF_SHARED)
-			enable_irq(port->irq);
-
-		/*
-		 * If the interrupt is not reasserted, or we otherwise
-		 * don't trust the iir, setup a timer to kick the UART
-		 * on a regular basis.
-		 */
-		if ((!(iir1 & UART_IIR_NO_INT) && (iir & UART_IIR_NO_INT)) ||
-		    up->port.flags & UPF_BUG_THRE) {
-			up->bugs |= UART_BUG_THRE;
-		}
-	}
+	serial8250_THRE_test(port);
 
 	up->ops->setup_timer(up);
 
-- 
2.49.0

