Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CC71F416C;
	Mon, 23 Jun 2025 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664772; cv=none; b=TIWo5Shfi1DuVp0HmrznmKSD+uWyP+2lr/51lskrVu3831s1/2MXcd9z9M48BiygfdSxSP+y+Kgn6A23GB5+9i5VUH+TE+5ytc9q/eMd97K2LxaI3rzxCOJwhQDlqXRBJOl/HnI4iznz5e79ufwV7Y3qLyYun41WQLvMXeNc3IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664772; c=relaxed/simple;
	bh=ZnV7znpD2ocTdeYohSYU9ZU52h1QVnyZ0yB7lLjcdyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLEhT+eAR6lBJfDOJDxpAYzBCn7IFQP/e6b05dM50XiNNmB0WTfopS7Nk8F7j+d8njIz9dM9lW/Dq5bU5+dYIQjPVdhLMfBjEcHsaKbcLgk8OWh4Nm5jIvugNmof1xM78Ndmqv2j2kbKSGl+EGgAyKQrgjOsabSy9UkGaioZ0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejh4Msyh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejh4Msyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DA7C4CEF2;
	Mon, 23 Jun 2025 07:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750664772;
	bh=ZnV7znpD2ocTdeYohSYU9ZU52h1QVnyZ0yB7lLjcdyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejh4Msyhb0i90JH/nBKT4I+U4nHF3A6OX3faAjZozFN8qf+PNCptHmhVg1J8TNgZ+
	 VCER9fQNrgsixQnSKKDk9cdzEnJRa2/3Rcs1InvhP1Uxo2hWr9HErvXB09m8eTiScT
	 UnKQMlR/VQ8uFSTG7vQ0w8Zd6ozxW0WLDgSgbJz7u9XI3m/xJC6olZlSeUyjsvJRrJ
	 KEmbS9iEafT/hHz70GeGSqYn5YuPqIltghndfhC442bpwHxV81+eTDcG6leOUuiRxD
	 EJZvftm1ewNou0H/QpBRZBsVdOPuN64jZy3gRkUiK2NurGwQdAMPtNBNngz888HFIW
	 cr7bNvldiMiKQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/5] serial: 8250: extract serial8250_iir_txen_test()
Date: Mon, 23 Jun 2025 09:46:03 +0200
Message-ID: <20250623074606.456532-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623074606.456532-1-jirislaby@kernel.org>
References: <20250623074606.456532-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After commit 795158691cc0 ("serial: 8250: extract
serial8250_initialize()"), split serial8250_initialize() even more --
the TX enable test part of this code can be separated into
serial8250_iir_txen_test().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 49 ++++++++++++++++-------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ca82ce26715a..584563c45424 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2233,16 +2233,19 @@ static void serial8250_init_mctrl(struct uart_port *port)
 	serial8250_set_mctrl(port, port->mctrl);
 }
 
-static void serial8250_initialize(struct uart_port *port)
+static void serial8250_iir_txen_test(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned long flags;
 	bool lsr_TEMT, iir_NOINT;
 
-	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
+	if (port->quirks & UPQ_NO_TXEN_TEST)
+		return;
 
-	uart_port_lock_irqsave(port, &flags);
-	serial8250_init_mctrl(port);
+	/* Do a quick test to see if we receive an interrupt when we enable the TX irq. */
+	serial_port_out(port, UART_IER, UART_IER_THRI);
+	lsr_TEMT = serial_port_in(port, UART_LSR) & UART_LSR_TEMT;
+	iir_NOINT = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
+	serial_port_out(port, UART_IER, 0);
 
 	/*
 	 * Serial over Lan (SoL) hack:
@@ -2250,26 +2253,30 @@ static void serial8250_initialize(struct uart_port *port)
 	 * Lan.  Those chips take a longer time than a normal serial device to signalize that a
 	 * transmission data was queued. Due to that, the above test generally fails. One solution
 	 * would be to delay the reading of iir. However, this is not reliable, since the timeout is
-	 * variable. So, let's just don't test if we receive TX irq.  This way, we'll never enable
-	 * UART_BUG_TXEN.
+	 * variable. So, in case of UPQ_NO_TXEN_TEST, let's just don't test if we receive TX irq.
+	 * This way, we'll never enable UART_BUG_TXEN.
 	 */
-	if (!(port->quirks & UPQ_NO_TXEN_TEST)) {
-		/* Do a quick test to see if we receive an interrupt when we enable the TX irq. */
-		serial_port_out(port, UART_IER, UART_IER_THRI);
-		lsr_TEMT = serial_port_in(port, UART_LSR) & UART_LSR_TEMT;
-		iir_NOINT = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
-		serial_port_out(port, UART_IER, 0);
-
-		if (lsr_TEMT && iir_NOINT) {
-			if (!(up->bugs & UART_BUG_TXEN)) {
-				up->bugs |= UART_BUG_TXEN;
-				dev_dbg(port->dev, "enabling bad tx status workarounds\n");
-			}
-		} else {
-			up->bugs &= ~UART_BUG_TXEN;
+	if (lsr_TEMT && iir_NOINT) {
+		if (!(up->bugs & UART_BUG_TXEN)) {
+			up->bugs |= UART_BUG_TXEN;
+			dev_dbg(port->dev, "enabling bad tx status workarounds\n");
 		}
+		return;
 	}
 
+	/* FIXME: why is this needed? */
+	up->bugs &= ~UART_BUG_TXEN;
+}
+
+static void serial8250_initialize(struct uart_port *port)
+{
+	unsigned long flags;
+
+	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
+
+	uart_port_lock_irqsave(port, &flags);
+	serial8250_init_mctrl(port);
+	serial8250_iir_txen_test(port);
 	uart_port_unlock_irqrestore(port, flags);
 }
 
-- 
2.49.0

