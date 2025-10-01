Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED01E19DF4A;
	Wed,  1 Oct 2025 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320478; cv=none; b=XDFAaRgNVZrhqxJYMlyjWaAHbMLq4XUJwwsX69UFIGIVKf6Z6EFeU0VjCMhyXpZs5BdTMfOHVjAe1Twes3ng+7bSFHJ/jmIEQtwN7L4F7+lTsQr+ZTzDudqOeoB35UeGQHEGWu0YiWbtmXeEhpPx5H6uyj0/h951jkaGsFqkxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320478; c=relaxed/simple;
	bh=wVfHvtbdTmXkr4S8Xx8DJfP4J2Tkk11mOXXLfVA65Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYox15LLS3WvikqEigyBk2emr4lsuHnclytIEe2doFEh3nj/Rlzmb4FS367Q+pB6RwMatle+x4y0d4BzPwyM09LIW/YLsNMgC0dWWUSkN/uBDgynP1dyRxnp1JCAC64vOS66NKK3iv0LPLhHWZcN7hJdcN/NhYlBzu+KT0167bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from ripper.localnet (p200300c5973a2BE00000000000000C00.dip0.t-ipconnect.de [IPv6:2003:c5:973a:2be0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id BE8E5FA12C;
	Wed,  1 Oct 2025 14:07:53 +0200 (CEST)
From: Sven Eckelmann <se@simonwunderlich.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: ar933x: Add polling support
Date: Wed, 01 Oct 2025 14:07:53 +0200
Message-ID: <7867515.MhkbZ0Pkbq@ripper>
In-Reply-To:
 <20251001-ar933x-kgdb-support-v1-1-5fffd9e36a01@simonwunderlich.de>
References:
 <20251001-ar933x-kgdb-support-v1-1-5fffd9e36a01@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10404020.NyiUUSuA9g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart10404020.NyiUUSuA9g
Content-Type: multipart/mixed; boundary="nextPart3614437.VLH7GnMWUR";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Sven Eckelmann <se@simonwunderlich.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: ar933x: Add polling support
Date: Wed, 01 Oct 2025 14:07:53 +0200
Message-ID: <7867515.MhkbZ0Pkbq@ripper>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart3614437.VLH7GnMWUR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 1 October 2025 13:47:26 CEST Sven Eckelmann wrote:
> KGDB requires at least the polling hooks .poll_get_char and .poll_put_char
> to transmit/receive character via the serial driver.
> 
> Signed-off-by: Sven Eckelmann <se@simonwunderlich.de>
> ---
>  drivers/tty/serial/ar933x_uart.c | 62 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)

I also had a look at break detection to ease the debugging on our side. Just 
to be able to switch to KGDB mode via gdb.

While I got it working, it is more a hack than a good implementation. I've 
attached the hack in case someone wants to continue to work on it.


On Wednesday, 1 October 2025 14:05:41 CEST Greg Kroah-Hartman wrote:
> Right now, the development tree you have sent a patch for is "closed"
> due to the timing of the merge window.  Don't worry, the patch(es) you
> have sent are not lost, and will be looked at after the merge window is
> over (after the -rc1 kernel is released by Linus).

*looks at the calendar* Oh, yes, there was something.

Regards,
	Sven
--nextPart3614437.VLH7GnMWUR
Content-Disposition: attachment;
 filename="RFC-0001-serial-ar933x-Handle-break-events.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="utf-8";
 name="RFC-0001-serial-ar933x-Handle-break-events.patch"

From 7892ef568d7ca4c1c2a0ed9fb8edbadfe8e70177 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <se@simonwunderlich.de>
Date: Mon, 15 Sep 2025 15:35:14 +0200
Subject: [PATCH RFC] serial: ar933x: Handle break events

Signed-off-by: Sven Eckelmann <se@simonwunderlich.de>
---
 drivers/tty/serial/ar933x_uart.c | 53 ++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 5b491db9d2fc..bc0a63e4934b 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -105,6 +105,30 @@ static inline void ar933x_uart_stop_tx_interrupt(struct ar933x_uart_port *up)
 	ar933x_uart_write(up, AR933X_UART_INT_EN_REG, up->ier);
 }
 
+static inline void ar933x_uart_start_rxbreak_on_interrupt(struct ar933x_uart_port *up)
+{
+	up->ier |= AR933X_UART_INT_RX_BREAK_ON;
+	ar933x_uart_write(up, AR933X_UART_INT_EN_REG, up->ier);
+}
+
+static inline void ar933x_uart_stop_rxbreak_on_interrupt(struct ar933x_uart_port *up)
+{
+	up->ier &= ~AR933X_UART_INT_RX_BREAK_ON;
+	ar933x_uart_write(up, AR933X_UART_INT_EN_REG, up->ier);
+}
+
+static inline void ar933x_uart_start_rxbreak_off_interrupt(struct ar933x_uart_port *up)
+{
+	up->ier |= AR933X_UART_INT_RX_BREAK_OFF;
+	ar933x_uart_write(up, AR933X_UART_INT_EN_REG, up->ier);
+}
+
+static inline void ar933x_uart_stop_rxbreak_off_interrupt(struct ar933x_uart_port *up)
+{
+	up->ier &= ~AR933X_UART_INT_RX_BREAK_OFF;
+	ar933x_uart_write(up, AR933X_UART_INT_EN_REG, up->ier);
+}
+
 static inline void ar933x_uart_start_rx_interrupt(struct ar933x_uart_port *up)
 {
 	up->ier |= AR933X_UART_INT_RX_VALID;
@@ -212,6 +236,7 @@ static void ar933x_uart_stop_rx(struct uart_port *port)
 		container_of(port, struct ar933x_uart_port, port);
 
 	ar933x_uart_stop_rx_interrupt(up);
+	ar933x_uart_stop_rxbreak_on_interrupt(up);
 }
 
 static void ar933x_uart_break_ctl(struct uart_port *port, int break_state)
@@ -444,11 +469,14 @@ static irqreturn_t ar933x_uart_interrupt(int irq, void *dev_id)
 {
 	struct ar933x_uart_port *up = dev_id;
 	unsigned int status;
+	bool is_break;
 
 	status = ar933x_uart_read(up, AR933X_UART_CS_REG);
 	if ((status & AR933X_UART_CS_HOST_INT) == 0)
 		return IRQ_NONE;
 
+	is_break = status & AR933X_UART_CS_RX_BREAK;
+
 	uart_port_lock(&up->port);
 
 	status = ar933x_uart_read(up, AR933X_UART_INT_REG);
@@ -467,6 +495,29 @@ static irqreturn_t ar933x_uart_interrupt(int irq, void *dev_id)
 		ar933x_uart_tx_chars(up);
 	}
 
+	if (status & AR933X_UART_INT_RX_BREAK_ON)
+		ar933x_uart_write(up, AR933X_UART_INT_REG,
+				  AR933X_UART_INT_RX_BREAK_ON);
+
+	if (status & AR933X_UART_INT_RX_BREAK_OFF)
+		ar933x_uart_write(up, AR933X_UART_INT_REG,
+				  AR933X_UART_INT_RX_BREAK_OFF);
+
+	if (is_break) {
+		/* disable "active break" interrupt */
+		ar933x_uart_stop_rxbreak_on_interrupt(up);
+		ar933x_uart_start_rxbreak_off_interrupt(up);
+
+		/* inform serial core about break */
+		up->port.icount.brk++;
+		if (!up->port.sysrq)
+			uart_handle_break(&up->port);
+	} else if (!(up->ier & AR933X_UART_INT_RX_BREAK_ON)) {
+		/* enable "active break" interrupt */
+		ar933x_uart_start_rxbreak_on_interrupt(up);
+		ar933x_uart_stop_rxbreak_off_interrupt(up);
+	}
+
 	uart_unlock_and_check_sysrq(&up->port);
 
 	return IRQ_HANDLED;
@@ -496,6 +547,7 @@ static int ar933x_uart_startup(struct uart_port *port)
 
 	/* Enable RX interrupts */
 	ar933x_uart_start_rx_interrupt(up);
+	ar933x_uart_start_rxbreak_on_interrupt(up);
 
 	uart_port_unlock_irqrestore(&up->port, flags);
 
@@ -829,6 +881,7 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	port->ops = &ar933x_uart_ops;
 	port->rs485_config = ar933x_config_rs485;
 	port->rs485_supported = ar933x_rs485_supported;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_AR933X_CONSOLE);
 
 	baud = ar933x_uart_get_baud(port->uartclk, AR933X_UART_MAX_SCALE, 1);
 	up->min_baud = max_t(unsigned int, baud, AR933X_UART_MIN_BAUD);
-- 
2.47.3


--nextPart3614437.VLH7GnMWUR--

--nextPart10404020.NyiUUSuA9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaN0ZmQAKCRBND3cr0xT1
ywGzAPsFCLRPtWjIKKMOPiJgUHt9/a/kB9VLlt9XHQCHww49ogD+OfJtIcZck+YJ
bMVdW9STk6uGpFRTLgw1FP0KpG6uLQY=
=vKFC
-----END PGP SIGNATURE-----

--nextPart10404020.NyiUUSuA9g--



