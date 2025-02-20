Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7191F63C1;
	Thu, 20 Feb 2025 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050220; cv=none; b=IqxY1fC6R9YlSEZbBAh401lIIvvoXg2avPP8YKVyOGggkIPcTdwtg5vZGnCPJ7dY4tGz0onsChDVj8KQs53r+T7g7x7EoewktFVdntMCSUYvOGAE+UVpcVIVPxdDfMX0+mTldAdDIHUERA1HJKKUUYuy3wxUdxZBrWjDQtPs40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050220; c=relaxed/simple;
	bh=cs498CI6MfOXxYxsHGXoAGXOl9jBzyPtxRhMChIkLog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aM63PFkynGpOL+51DNetewnfQQI46iq6PO+LkSQHNYuX2pb9YKejE/DZU3PaFaT3wX1VaF1JSFRnDn9Ux4pu9Hk47Hr8jvd5StfCNtMsMy4uLhu4j5oZl16G7+gwzlj/fOHTOYqqjFM0ubWBB/SNktzAUSbR5agZyiO2WzZshwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3oS2zol; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3oS2zol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985F2C4CEDD;
	Thu, 20 Feb 2025 11:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050219;
	bh=cs498CI6MfOXxYxsHGXoAGXOl9jBzyPtxRhMChIkLog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3oS2zolXmJS0u9KZq/ubJtOXMJUbNJ5fRGlo0mG2h166Pb5uqvb4dasm+piTFRzu
	 BksoG7hWN5gvW4217Z5pWO6l9PsniumWc3kNsDHcLho1szGsfkheQZjPGK5Hp9Abgq
	 Z/VxdF1z5DnHKh5Scws04GoBQ/ZwvLYCulx3tp8hrgSGQ1EhnABiX5qxJ5c1XNhxE3
	 qRtJaES9MF0EK9olHxjxVEsPXjvapXpSnMdmSVcVLqPnHomZqVxY344A8rI96otfvH
	 78Xeii+/vAeg5o9ov2TSog4Vii7oiNFQtNF15iuT7eIzCtL9+nonT+hEkWeoXwpzTj
	 pYRODblt9Uosg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 28/29] serial: 8250_port: do not use goto for UPQ_NO_TXEN_TEST code flow
Date: Thu, 20 Feb 2025 12:16:05 +0100
Message-ID: <20250220111606.138045-29-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
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
index c57f44882abb..4ac5f16fc6ba 100644
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
2.48.1

