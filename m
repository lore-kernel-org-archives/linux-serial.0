Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2632701C5;
	Wed, 11 Jun 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636243; cv=none; b=XfIAOxRjmzPAydFjsD+UFNE1lrITXYYe/K+aXg6tu/2Yp9q7BV69wT6bi89tLyeXVnCyrk1R4CN7F9OfBxeLduYclqyQAb2Nqoute1zkXVczjg7bjMfFUk1iLzfZ7bbg7sjtJDSfmlekuV/3tdMNdDis8+Eu2cdDkJMTNu0HuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636243; c=relaxed/simple;
	bh=YgGgl4hmHOZF95YQRTmyFWWejDONs+53HuHseWC5klE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLUWfbVK8GH31AJLfN4bFiCLG7Nc/QCMPiRuhFDgrt/pOh26W+WH9LHIGWfM4U+6CPMDVKSclHW5bcxj9rkfnRFijOWD8i7zFhLRIVQs5C0grfG04YEJxXL2TSDmUYGekjtIRPOpqa5FrACwFJaid5zsv4Kc9Ku4bgcbrzkSmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq+T7KpH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq+T7KpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BFEC4CEF2;
	Wed, 11 Jun 2025 10:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636243;
	bh=YgGgl4hmHOZF95YQRTmyFWWejDONs+53HuHseWC5klE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qq+T7KpHhafK7EOTBRBJ+f05Py20OBwKTETYGDRqmkdoIFcKHzNEgTh/YEji5SNVJ
	 Bwqaf/G5ixol0J5/C6Qj6dFBmEYgmn+Fk/zXBGd86Owb2VQ++fbrK7LHMeid1QIgVJ
	 hCRu5DsRtkVvbc0JjXhGPs7OlZ1YEj9RQe70pBtjnh7uLwTrp1VYkg2rZp7fDVgO9n
	 T4/SvHhbTcf5CVsR3w+4665edl2kADGXbL2tZIjWFUq6+uC3VRO1M5k9ph0UGqUk+i
	 fsDCG5mcCNDkl6z6LCB2xsBwvB3zin+Il10OCkKfgHQTC86TBVMkdgByUvRQ8+I0gQ
	 OWI1ZgcKt2ebw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 21/33] serial: 8250: extract serial8250_set_errors_and_ignores
Date: Wed, 11 Jun 2025 12:03:07 +0200
Message-ID: <20250611100319.186924-22-jirislaby@kernel.org>
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

serial8250_do_set_termios() consists of many registers and up flags
settings. Extract all these into separate functions. This time, setting
of ignore_status_mask and read_status_mask.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 67 ++++++++++++++---------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b15371838366..6bb7f004d607 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2720,6 +2720,38 @@ static void serial8250_set_afe(struct uart_port *port, struct ktermios *termios)
 		up->mcr |= UART_MCR_AFE;
 }
 
+static void serial8250_set_errors_and_ignores(struct uart_port *port, struct ktermios *termios)
+{
+	/*
+	 * Specify which conditions may be considered for error handling and the ignoring of
+	 * characters. The actual ignoring of characters only occurs if the bit is set in
+	 * @ignore_status_mask as well.
+	 */
+	port->read_status_mask = UART_LSR_OE | UART_LSR_DR;
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
+	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
+		port->read_status_mask |= UART_LSR_BI;
+
+	/* Characters to ignore */
+	port->ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
+	if (termios->c_iflag & IGNBRK) {
+		port->ignore_status_mask |= UART_LSR_BI;
+		/*
+		 * If we're ignoring parity and break indicators, ignore overruns too (for real raw
+		 * support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			port->ignore_status_mask |= UART_LSR_OE;
+	}
+
+	/* ignore all characters if CREAD is not set */
+	if ((termios->c_cflag & CREAD) == 0)
+		port->ignore_status_mask |= UART_LSR_DR;
+}
+
 void
 serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		          const struct ktermios *old)
@@ -2747,40 +2779,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial8250_set_trigger_for_slow_speed(port, termios, baud);
 	serial8250_set_afe(port, termios);
 	uart_update_timeout(port, termios->c_cflag, baud);
-
-	/*
-	 * Specify which conditions may be considered for error
-	 * handling and the ignoring of characters. The actual
-	 * ignoring of characters only occurs if the bit is set
-	 * in @ignore_status_mask as well.
-	 */
-	port->read_status_mask = UART_LSR_OE | UART_LSR_DR;
-	if (termios->c_iflag & INPCK)
-		port->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
-	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
-		port->read_status_mask |= UART_LSR_BI;
-
-	/*
-	 * Characters to ignore
-	 */
-	port->ignore_status_mask = 0;
-	if (termios->c_iflag & IGNPAR)
-		port->ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
-	if (termios->c_iflag & IGNBRK) {
-		port->ignore_status_mask |= UART_LSR_BI;
-		/*
-		 * If we're ignoring parity and break indicators,
-		 * ignore overruns too (for real raw support).
-		 */
-		if (termios->c_iflag & IGNPAR)
-			port->ignore_status_mask |= UART_LSR_OE;
-	}
-
-	/*
-	 * ignore all characters if CREAD is not set
-	 */
-	if ((termios->c_cflag & CREAD) == 0)
-		port->ignore_status_mask |= UART_LSR_DR;
+	serial8250_set_errors_and_ignores(port, termios);
 
 	/*
 	 * CTS flow control flag and modem status interrupts
-- 
2.49.0

