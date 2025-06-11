Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AA271A7B;
	Wed, 11 Jun 2025 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636249; cv=none; b=qSrjWpWPRsNpSyJTC0wSXua8+sZuixjltf5uVXv2SM24EXnODim2k/hqA+Ayu3EsopCTVLr0LnjqSNnoFPrnUlTVb+/wtYy80FZJWqQ6deeSOAMLV5dD45c+zLlWNoQY1obSot7M5aQMGFP7AChjbr0mFGLhn6fhz0gCLJFZI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636249; c=relaxed/simple;
	bh=qOAKptBoRTWs5a8BW/VyavKeswkJR7m83lczPmzKOiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNxN0+BIp/Kgip26JxK9UkK7lJYLWifMqzH9kEF1bUq76pS80FZtcWj7fUztmiC46yeU/eIaANuRKuROXSb4r1W1IW3HxswQJFlM8kHGCDcq9JSNgV7g/Nf1zPQc8H0faSGIlDv26lsSAhtvHI5HIVpdBwbmZOIznY/Rw+k2Aiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwwD5uu6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwwD5uu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADD5C4CEEE;
	Wed, 11 Jun 2025 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636249;
	bh=qOAKptBoRTWs5a8BW/VyavKeswkJR7m83lczPmzKOiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IwwD5uu6pRuAxXG9puQ9zlX4OMPPGoOeVfEdOTXu9JlAiKa4JNR7qyWW5eZzo2YZa
	 py09/UXcOowDzc5RlMkOTHfdSDCJGWiZzyE3cyWaPSnWEaHo8twFc1NpVi/D2GbTvY
	 1Lt8bJ7ZHaub8nUj/j1g0m7bWB3NPkNlfxJjDD7q1/y1p0iR12FM/PHmBbCaxfvT8X
	 EgC+VVC0vJNoKcUU0mjp8OdBzIETbt0Z7OQVhypV/KZbGtjJTDyRG5D35PlP1zFaHm
	 Y0el/RCq1UNXzQ/ppMeZSYNaO8XzPCoGUi5RwKxl8oahhy61YaqeradPtYU2FsMB6e
	 aRfTL02mTbVWg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 25/33] serial: 8250: lcr compute cleanup
Date: Wed, 11 Jun 2025 12:03:11 +0200
Message-ID: <20250611100319.186924-26-jirislaby@kernel.org>
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

* use 'lcr' as variable containing the "computed value" (and not 'cval')
* use 'u8' for the type (and not 'unsigned char')
* drop useless comment

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 85b75ff0699e..2af89038e50e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2547,23 +2547,20 @@ static unsigned int serial8250_get_divisor(struct uart_port *port,
 	return serial8250_do_get_divisor(port, baud, frac);
 }
 
-static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
-					    tcflag_t c_cflag)
+static unsigned char serial8250_compute_lcr(struct uart_8250_port *up, tcflag_t c_cflag)
 {
-	unsigned char cval;
-
-	cval = UART_LCR_WLEN(tty_get_char_size(c_cflag));
+	u8 lcr = UART_LCR_WLEN(tty_get_char_size(c_cflag));
 
 	if (c_cflag & CSTOPB)
-		cval |= UART_LCR_STOP;
+		lcr |= UART_LCR_STOP;
 	if (c_cflag & PARENB)
-		cval |= UART_LCR_PARITY;
+		lcr |= UART_LCR_PARITY;
 	if (!(c_cflag & PARODD))
-		cval |= UART_LCR_EPAR;
+		lcr |= UART_LCR_EPAR;
 	if (c_cflag & CMSPAR)
-		cval |= UART_LCR_SPAR;
+		lcr |= UART_LCR_SPAR;
 
-	return cval;
+	return lcr;
 }
 
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
@@ -2821,12 +2818,12 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		          const struct ktermios *old)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned char cval;
 	unsigned long flags;
 	unsigned int baud, quot, frac = 0;
+	u8 lcr;
 
 	serial8250_set_mini(port, termios);
-	cval = serial8250_compute_lcr(up, termios->c_cflag);
+	lcr = serial8250_compute_lcr(up, termios->c_cflag);
 	baud = serial8250_get_baud_rate(port, termios, old);
 	quot = serial8250_get_divisor(port, baud, &frac);
 
@@ -2839,7 +2836,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial8250_rpm_get(up);
 	uart_port_lock_irqsave(port, &flags);
 
-	up->lcr = cval;					/* Save computed LCR */
+	up->lcr = lcr;
 	serial8250_set_trigger_for_slow_speed(port, termios, baud);
 	serial8250_set_afe(port, termios);
 	uart_update_timeout(port, termios->c_cflag, baud);
-- 
2.49.0

