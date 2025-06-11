Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E532270EA9;
	Wed, 11 Jun 2025 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636246; cv=none; b=u7BJgmnuca7MeqOzL1UADfhMEF1pnTrQFktWL520W/km1rml1iEzkFRsgpWvDNg2qqiridGYxnLNdqBJ+w3YVHoUAflsbyWxTjlZqdVztJ76X45qmealHpBj4kL8x2M4Dn6tlNbNlXzOtrRP0bIQy1MzA5ZxQuLTO90TABMXjCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636246; c=relaxed/simple;
	bh=KrS7UF/iteN9keGU/ybxP25+KoQLtb2QJ16P7m4vfEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4hHBG4s8m4RKJiV2hGH11QalNPGerwAzNnpxz/xJU8HcAY/wjhpLe1cf90Ac3Izusrb0OmUwH7FQztgJ/+xpMcRKk+NwV8MMPymyYHzvNBT2zHvaoF13MsJDu4Zi/O0utiPu4wJ5bpx/FOeueFqfvUOG+eU8fn55ZnN1CjzkqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/WyqptG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/WyqptG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5F8C4CEF3;
	Wed, 11 Jun 2025 10:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636246;
	bh=KrS7UF/iteN9keGU/ybxP25+KoQLtb2QJ16P7m4vfEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/WyqptGLktSWxJ7sJTg1Sy/x8+bdTam74nE48tsEyn/FBqPUgc8Jij6GhobGzSMj
	 vEKLNVMQBqwEazYhqMRoXAie/NYz9n8+PWpR07sbGchBdxTGNCqXfHpEUCDpuHB8vY
	 tJjojNMpbNhM2h0nQxonPrC69ZmiW8UoKSMUdbzcJice/6M3PtaFtWdNULDBFA53+5
	 P1tbaIRw7GqKEWTedDaKz/44KzSPQ3cnt7moG9bMhubW1SWCvAoNIf8mL68SE2YOhr
	 zK2nWNI/DEet06fN1dVj9pqVsvLlDoWjfXdbF+gJ0JrLqwMlSpOLSM54lHgM7LU7qg
	 fjyFDTFSNNbcg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 23/33] serial: 8250: extract serial8250_set_efr()
Date: Wed, 11 Jun 2025 12:03:09 +0200
Message-ID: <20250611100319.186924-24-jirislaby@kernel.org>
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
of EFR for UART_CAP_EFR ports.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 43 +++++++++++++++++------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2c045a4369fc..0f16398cc86f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2768,6 +2768,30 @@ static void serial8250_set_ier(struct uart_port *port, struct ktermios *termios)
 	serial_port_out(port, UART_IER, up->ier);
 }
 
+static void serial8250_set_efr(struct uart_port *port, struct ktermios *termios)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	u8 efr_reg = UART_EFR;
+	u8 efr = 0;
+
+	if (!(up->capabilities & UART_CAP_EFR))
+		return;
+
+	/*
+	 * TI16C752/Startech hardware flow control.  FIXME:
+	 * - TI16C752 requires control thresholds to be set.
+	 * - UART_MCR_RTS is ineffective if auto-RTS mode is enabled.
+	 */
+	if (termios->c_cflag & CRTSCTS)
+		efr |= UART_EFR_CTS;
+
+	if (port->flags & UPF_EXAR_EFR)
+		efr_reg = UART_XR_EFR;
+
+	serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_port_out(port, efr_reg, efr);
+}
+
 void
 serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		          const struct ktermios *old)
@@ -2797,24 +2821,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, termios->c_cflag, baud);
 	serial8250_set_errors_and_ignores(port, termios);
 	serial8250_set_ier(port, termios);
-
-	if (up->capabilities & UART_CAP_EFR) {
-		unsigned char efr = 0;
-		/*
-		 * TI16C752/Startech hardware flow control.  FIXME:
-		 * - TI16C752 requires control thresholds to be set.
-		 * - UART_MCR_RTS is ineffective if auto-RTS mode is enabled.
-		 */
-		if (termios->c_cflag & CRTSCTS)
-			efr |= UART_EFR_CTS;
-
-		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
-		if (port->flags & UPF_EXAR_EFR)
-			serial_port_out(port, UART_XR_EFR, efr);
-		else
-			serial_port_out(port, UART_EFR, efr);
-	}
-
+	serial8250_set_efr(port, termios);
 	serial8250_set_divisor(port, baud, quot, frac);
 
 	/*
-- 
2.49.0

