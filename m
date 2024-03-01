Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC459146
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329977; cv=none; b=OHTlUo69Z8+bYKmkuel55Yl0uQOezs8e57K3kbUTpIZEZSFeaFvb1SMJQ0jPYVejwT6DAZ37l28TSXwbZp1Lni6sQ9yRa6phXX43gjH+NoA1FHgBIq96Y9sstZsufAk5dHVv2/FWgwTeE3RISWyyA99KhhKThyrlVor8V5qaPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329977; c=relaxed/simple;
	bh=95CvMzwLEYvN0YPdFgnvtB83kTTr7qCy0v8blcJOJG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UldQlj86LX8Izq6YUh3lEeq+UbJHviYMo6Ubt+Z807ltOW1HvHvCM0Trde8zKFg7Ty067r1EJxkKtIfX2Y9gRRVIGdjYWFmOpC9B0H2WEaofnvofXK3EbX/wBXFDG6Eiu31zz3+qolHB15DF9mqGGATgJP21VOnpSYg7y753eC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fpkk8WdB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oSX8W81+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fpkk8WdB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oSX8W81+"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gr2ZxEwFtSX4/4G1RgLzPTzSQg478W3tlH7lcsXH0mc=;
	b=fpkk8WdB0bre+7rLpCRoW15tSHtAa/O4wATJbIud9rMy0nRIbnXFi3dS1unLyTMbYBRXUF
	HiVK4tXA4/FMISi949igIbIJM7AODSe/QgrqD8MJzd70YgJzfcf+AAPvJuMvRuQquy/2eC
	NhU2t12++7gk4neMB+c/qd3LmGfe25SyN21X8+/oL/cNdYL3rlqtaSZwZQXiceuQbGqVZb
	h1S6OXd5s/A12s5mbYH6exS6ejDmIpI3OTq9luwoUcljx2Bt/mub0vGKat6p4ldroN8FkJ
	nFO5KchHg67GHcBKJ6M4BJnvpOP7H1qV9q6LAIjv5KUfDqgTo7lNk0aeJ+vUDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gr2ZxEwFtSX4/4G1RgLzPTzSQg478W3tlH7lcsXH0mc=;
	b=oSX8W81+15FcseS/E4G2apZY2qxtBj1NzB//CfXTjM9toOs5x8V/lBQoRnqSTwhOfW17Yl
	u7GtZvLyQt2gKzCg==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 14/18] serial: pch: Make push_rx() return void.
Date: Fri,  1 Mar 2024 22:45:27 +0100
Message-ID: <20240301215246.891055-15-bigeasy@linutronix.de>
In-Reply-To: <20240301215246.891055-1-bigeasy@linutronix.de>
References: <20240301215246.891055-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

push_rx() returns always 0.

Make push_rx() return void.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/pch_uart.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 29ed6f8621d7d..124eb816fca7e 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -599,16 +599,14 @@ static void pch_uart_hal_set_break(struct eg20t_port =
*priv, int on)
 	iowrite8(lcr, priv->membase + UART_LCR);
 }
=20
-static int push_rx(struct eg20t_port *priv, const unsigned char *buf,
-		   int size)
+static void push_rx(struct eg20t_port *priv, const unsigned char *buf,
+		    int size)
 {
 	struct uart_port *port =3D &priv->port;
 	struct tty_port *tport =3D &port->state->port;
=20
 	tty_insert_flip_string(tport, buf, size);
 	tty_flip_buffer_push(tport);
-
-	return 0;
 }
=20
 static int dma_push_rx(struct eg20t_port *priv, int size)
@@ -761,7 +759,7 @@ static int handle_rx_to(struct eg20t_port *priv)
 {
 	struct pch_uart_buffer *buf;
 	int rx_size;
-	int ret;
+
 	if (!priv->start_rx) {
 		pch_uart_hal_disable_interrupt(priv, PCH_UART_HAL_RX_INT |
 						     PCH_UART_HAL_RX_ERR_INT);
@@ -770,9 +768,7 @@ static int handle_rx_to(struct eg20t_port *priv)
 	buf =3D &priv->rxbuf;
 	do {
 		rx_size =3D pch_uart_hal_read(priv, buf->buf, buf->size);
-		ret =3D push_rx(priv, buf->buf, rx_size);
-		if (ret)
-			return 0;
+		push_rx(priv, buf->buf, rx_size);
 	} while (rx_size =3D=3D buf->size);
=20
 	return PCH_UART_HANDLED_RX_INT;
--=20
2.43.0

