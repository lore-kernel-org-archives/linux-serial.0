Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1C326FDB6;
	Wed, 11 Jun 2025 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636242; cv=none; b=BdBafX4msV86/eqnQMmwZaz5B0BrgPlmJEEwBapjnAK+Ic4CfT6jsw4h48Cww2cd8hz4W18xI5iTu/ScBV+FBEB2U5EHUz2GuVdRTCmdmd8y8qDF8ItjtdvOlNNRUSPbkE7uuJXFz+yxESUa4zYe2gxuUDU8jbodWS4icmDJWa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636242; c=relaxed/simple;
	bh=WOJjaorRqfEH2qZy3pWluuuC4luyiJuKzvdIlQZ69oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFjlbLsDavGBcj4erDSqacmw7EuZlbDc1HgQDDaBABleK+wSe7PnUM5Qr01atzb+BiC5ljcFWtisP2rqAn0UeSIYomyMCt/ErY309nv4QcZZpU8M99S2NEmUhRoGRxMQu9jK3+nxf+lF1FJ3NbT12SyCqgbIV/HZA4mg9gZOl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2uzF4ej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2uzF4ej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747FBC4CEF1;
	Wed, 11 Jun 2025 10:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636241;
	bh=WOJjaorRqfEH2qZy3pWluuuC4luyiJuKzvdIlQZ69oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2uzF4ej6ZKn2ohQOliTICTjUUuhpjL+JVGw1fmltPdRZxH5zvz8K7DRc65lY7o4e
	 4ljKZgq6sXCp5IFO4BMLnhxDddhTnoNGDwc5kvWqW0r8+btDQuT79bkgo5SKn/eikf
	 QvRIJbefRLV7rfR6tf9DocaTVgEA4U0CEpIcT+mm0Onn8aDhZIh7gLfIL2QTdGP4iN
	 ilvz+GfvWI9Q+YZI6L1hW0sCUagaXejNUHNCBNYKbit8lrcFAo6qHXhXF3PJ4d/ti/
	 nhZHWwy6p9QaUnHWE2WRtwYAcbwsv+5zlzMoDpn9kbimQ+kII2tAtEDyvvT+HW17jM
	 Gf2YHS5xCzQUQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 20/33] serial: 8250: extract serial8250_set_afe()
Date: Wed, 11 Jun 2025 12:03:06 +0200
Message-ID: <20250611100319.186924-21-jirislaby@kernel.org>
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
of MCR for UART_CAP_AFE ports.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 32 +++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 52385314c426..b15371838366 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2704,6 +2704,22 @@ static void serial8250_set_trigger_for_slow_speed(struct uart_port *port, struct
 	up->fcr |= UART_FCR_TRIGGER_1;
 }
 
+/*
+ * MCR-based auto flow control. When AFE is enabled, RTS will be deasserted when the receive FIFO
+ * contains more characters than the trigger, or the MCR RTS bit is cleared.
+ */
+static void serial8250_set_afe(struct uart_port *port, struct ktermios *termios)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	if (!(up->capabilities & UART_CAP_AFE))
+		return;
+
+	up->mcr &= ~UART_MCR_AFE;
+	if (termios->c_cflag & CRTSCTS)
+		up->mcr |= UART_MCR_AFE;
+}
+
 void
 serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		          const struct ktermios *old)
@@ -2729,21 +2745,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	up->lcr = cval;					/* Save computed LCR */
 	serial8250_set_trigger_for_slow_speed(port, termios, baud);
-
-	/*
-	 * MCR-based auto flow control.  When AFE is enabled, RTS will be
-	 * deasserted when the receive FIFO contains more characters than
-	 * the trigger, or the MCR RTS bit is cleared.
-	 */
-	if (up->capabilities & UART_CAP_AFE) {
-		up->mcr &= ~UART_MCR_AFE;
-		if (termios->c_cflag & CRTSCTS)
-			up->mcr |= UART_MCR_AFE;
-	}
-
-	/*
-	 * Update the per-port timeout.
-	 */
+	serial8250_set_afe(port, termios);
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/*
-- 
2.49.0

