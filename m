Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382132343AF;
	Mon, 17 Mar 2025 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194898; cv=none; b=EQnN26gOftsowXIlwmM6aJxwocPKxGN+oe1MzuNC6QK96o3paxVtrJztpG4HjYwWjrkzgu5P9bO2v2/d++jT1h4TpE9Qr8j7qKPTGiQelxeGJt1cAmNU0CZvNQoocyAuUFozbwoHViO+busy8R0Mr+f5EHjt2faEkEeeot0bMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194898; c=relaxed/simple;
	bh=HpOa6PM92cYj5X2CZarvKMvG/Q3+msQj808muX1qxpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEDp2lw3DttFi3n6colZNY5vsj5KMfxrTjSc5qq2S8tSO9frS9i73R/K2RZLUI+Vkm1AOsk7St12Z0GTVF18qPKuoHquWZDdSUBTgGoMEF+wS0sQktqqtHSBEhGP43HYDixcd48kKD0JEMPpJmbDqTaplvC7WkaPBhXdoyTvpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwkHSH3U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwkHSH3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8095C4CEE3;
	Mon, 17 Mar 2025 07:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194898;
	bh=HpOa6PM92cYj5X2CZarvKMvG/Q3+msQj808muX1qxpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwkHSH3Ug9lo/CZnvdG937I09ucLZsHk34n3fWrVInHNUsCffBfvDGu8NGFRAxr7+
	 lJv/FoOCTtDs70+9xnRbnHgdRXtSnhJ4kY4fZbGXH4H0JQgqW8yW8JNGTwWq1/vEA1
	 llXLg+8XG1U+G2f9Y0vlGwWykkZ6Kj8Q+b2mc7bNy9kJ38RXP5PN2d4TCHzFp+5IEh
	 NSi2EfcCtPoTcX7lDUoftFsdtuhv6OY7AhDW/huqLR0AwNJiXQtR7vfcRtxuQx2qJI
	 WpHs9D6Xle6Iq5SAMbB6bvkkYFMzm7lEhV0bgiQ/WKG6TIRD8zMLgqepdFYsxwbn++
	 rhV/v8UkdY3gQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 29/31] serial: 8250_port: do not use goto for UPQ_NO_TXEN_TEST code flow
Date: Mon, 17 Mar 2025 08:00:44 +0100
Message-ID: <20250317070046.24386-30-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is unnecessary here and makes the code harder to follow. Invert the
condition and drop the goto+label.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 34 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3f256e96c722..6466f60416a9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2406,28 +2406,26 @@ int serial8250_do_startup(struct uart_port *port)
 	 * test if we receive TX irq.  This way, we'll never enable
 	 * UART_BUG_TXEN.
 	 */
-	if (up->port.quirks & UPQ_NO_TXEN_TEST)
-		goto dont_test_tx_en;
-
-	/*
-	 * Do a quick test to see if we receive an interrupt when we enable
-	 * the TX irq.
-	 */
-	serial_port_out(port, UART_IER, UART_IER_THRI);
-	lsr = serial_port_in(port, UART_LSR);
-	iir = serial_port_in(port, UART_IIR);
-	serial_port_out(port, UART_IER, 0);
+	if (!(up->port.quirks & UPQ_NO_TXEN_TEST)) {
+		/*
+		 * Do a quick test to see if we receive an interrupt when we
+		 * enable the TX irq.
+		 */
+		serial_port_out(port, UART_IER, UART_IER_THRI);
+		lsr = serial_port_in(port, UART_LSR);
+		iir = serial_port_in(port, UART_IIR);
+		serial_port_out(port, UART_IER, 0);
 
-	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
-		if (!(up->bugs & UART_BUG_TXEN)) {
-			up->bugs |= UART_BUG_TXEN;
-			dev_dbg(port->dev, "enabling bad tx status workarounds\n");
+		if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
+			if (!(up->bugs & UART_BUG_TXEN)) {
+				up->bugs |= UART_BUG_TXEN;
+				dev_dbg(port->dev, "enabling bad tx status workarounds\n");
+			}
+		} else {
+			up->bugs &= ~UART_BUG_TXEN;
 		}
-	} else {
-		up->bugs &= ~UART_BUG_TXEN;
 	}
 
-dont_test_tx_en:
 	uart_port_unlock_irqrestore(port, flags);
 
 	/*
-- 
2.49.0

