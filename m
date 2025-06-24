Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EA4257AEC;
	Tue, 24 Jun 2025 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752408; cv=none; b=hSzV+mbnL/1Bb7Fq265WMCoXRpWxEfHfuoL9AW9ERJ5dgc3CbrPiGEKyThnvB53QoaPvpj12pcceeLKe8kvEIessVDn5X4YPyx5c2cdyKwUpuNuykK6ErpkX+nDMbJ/DG7s4l9PksZhPO2Dapa9e+3Pdea7dsKdbRqpyHZb0FSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752408; c=relaxed/simple;
	bh=G8PjAIa9XOPiFoXRKbmwdGUTMo1rGxiHqOlTpaFSPt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2FS0tbd2oOcPUblYvqzP9vkmySlcOp/LYPVfKnqSXd2KiuaEhqsOkX1CgfNBxy+faC9Mmd/p1jA+ILxCTGPbpGvN8mt4Y4XXpAF+Usi5Y6ZU9A3tKp7JCH9pkk7Aw126XfjdhLl9aoMRtHFJxLVLyxML7HymKRNdwYO5d2L008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTUKQw3E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTUKQw3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337CEC4CEE3;
	Tue, 24 Jun 2025 08:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750752408;
	bh=G8PjAIa9XOPiFoXRKbmwdGUTMo1rGxiHqOlTpaFSPt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTUKQw3EgQ6ku9yqvkCE91ueeDckmGvkpCs+XKZ2bfErVTNLP0oWlQhG//fBR6cL2
	 z4axo3uWwYtCwo0MC1HP6Yd2qYO92MjlrOAO8EbgqI1qDh9oM4GNtpZUw2zyMfamfL
	 tA8K4vsy3EtxIiykEu7WMz1K012Atlo6k8sIpLhY3iC8dGjEZdiqDZ80WW/lMjH/l2
	 ehMk/EwfSuSlNaQw1LO3nREQR5dhuXDqLS8s93QmYKZ21euKLUEEeQlUDzOwi+LAn+
	 bPKxVlt3txwYn3N/VOjPhANLTXmfa1UXXCXkJ1ExpJoNJF0N8asw5Ueq9MD91w56yq
	 DbymDjx2HeFDQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/5] serial: 8250: extract serial8250_iir_txen_test()
Date: Tue, 24 Jun 2025 10:06:38 +0200
Message-ID: <20250624080641.509959-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250624080641.509959-1-jirislaby@kernel.org>
References: <20250624080641.509959-1-jirislaby@kernel.org>
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
index 0f85a2f292fc..5bb0ca04da55 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2230,16 +2230,19 @@ static void serial8250_init_mctrl(struct uart_port *port)
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
@@ -2247,26 +2250,30 @@ static void serial8250_initialize(struct uart_port *port)
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
2.50.0

