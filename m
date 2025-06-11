Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2259926FDB6;
	Wed, 11 Jun 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636245; cv=none; b=H3Nhe5GC4zr1uflLQhLDJwxfXIGEmE48lWZI8N3u02G6sWhz6Ni/cF9hc+5/yTotMbzsoyNuTSbvBSk4agYuLVBuYr5HTs1DLiP0J2agHqvf75Cz986VOfp6MEvLRQUhkl3ojUSw0SNSiAYDTPMSKDZ2u53WF68JFsO3zXlIplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636245; c=relaxed/simple;
	bh=KipqVa0cNBWMnucUp3kii6iZVqiqOBeiBoGWeEe2I+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WO5342wB4cp9cfUitZw2fPwQdkWpHP85o9h3XweCmv4tC0OMXFq+OWNnqEPQx7NnowN6ZIlplSongqUoJpqFX6fg3eNqjWWf1FIuK0MSnkeedmYiv4cB8w9vumridmncr0zUas+N4oGSl1Zx9xPRp54aGnmG2ZngvNKEjlIk8YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1FFDVyv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1FFDVyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83431C4CEF2;
	Wed, 11 Jun 2025 10:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636244;
	bh=KipqVa0cNBWMnucUp3kii6iZVqiqOBeiBoGWeEe2I+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1FFDVyvU0mI35SVPNWaLTNLsnlFtr+TbnyNSm/+UKPx9Yh5RoD++TiBwYTVxWFMZ
	 umaJ28++7YMaWxWyOdabGxBGE4XPULVq0ku0FmT5TPw6yzB2WfhpVNc8j0HB6I0oVH
	 DdBUbJwOCe8Z8/8AcqbQvs4IcGZGXheNGYn7Hp6CzLXbqZoq8QaT39m7u1LEHQdU6i
	 xXbwRD3EAi6mGA3sxL5ZUqNIy5oqFjpMlSv8eRCOsMK2q4U4EluFYV9skH3eNcdz3q
	 ud+MFGmXdrzW1qaETBitbuyeISU1pjCzEq9/1ID7YXOiXxLnzafcYfBfONYpdo0tqM
	 4DSfgw0yWn+MA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 22/33] serial: 8250: extract serial8250_set_ier()
Date: Wed, 11 Jun 2025 12:03:08 +0200
Message-ID: <20250611100319.186924-23-jirislaby@kernel.org>
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
of IER.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 31 ++++++++++++++++-------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6bb7f004d607..2c045a4369fc 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2752,6 +2752,22 @@ static void serial8250_set_errors_and_ignores(struct uart_port *port, struct kte
 		port->ignore_status_mask |= UART_LSR_DR;
 }
 
+static void serial8250_set_ier(struct uart_port *port, struct ktermios *termios)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	/* CTS flow control flag and modem status interrupts */
+	up->ier &= ~UART_IER_MSI;
+	if (!(up->bugs & UART_BUG_NOMSR) && UART_ENABLE_MS(&up->port, termios->c_cflag))
+		up->ier |= UART_IER_MSI;
+	if (up->capabilities & UART_CAP_UUE)
+		up->ier |= UART_IER_UUE;
+	if (up->capabilities & UART_CAP_RTOIE)
+		up->ier |= UART_IER_RTOIE;
+
+	serial_port_out(port, UART_IER, up->ier);
+}
+
 void
 serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		          const struct ktermios *old)
@@ -2780,20 +2796,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial8250_set_afe(port, termios);
 	uart_update_timeout(port, termios->c_cflag, baud);
 	serial8250_set_errors_and_ignores(port, termios);
-
-	/*
-	 * CTS flow control flag and modem status interrupts
-	 */
-	up->ier &= ~UART_IER_MSI;
-	if (!(up->bugs & UART_BUG_NOMSR) &&
-			UART_ENABLE_MS(&up->port, termios->c_cflag))
-		up->ier |= UART_IER_MSI;
-	if (up->capabilities & UART_CAP_UUE)
-		up->ier |= UART_IER_UUE;
-	if (up->capabilities & UART_CAP_RTOIE)
-		up->ier |= UART_IER_RTOIE;
-
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_set_ier(port, termios);
 
 	if (up->capabilities & UART_CAP_EFR) {
 		unsigned char efr = 0;
-- 
2.49.0

