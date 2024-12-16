Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358520457E;
	Mon, 16 Dec 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369170; cv=none; b=g4RNAH8sgsMSYow6TJ2ZpmtnWHOo1tPp1Vls4JJzCWSB4xvkKWqa4GBSv4cQRVyiMFD8sDPlIg6nbYB3X3nzj9tPwZ4+1OibSfPDBo9fOrYPTvpKpqDLLzzR144+1Ye7qz08QJtcel0bRPhMqPKQsopDjY6Zj5x179C7tmyMrnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369170; c=relaxed/simple;
	bh=j6/QL3gdZfERetxbMI/0rk9rf92p20Yw3Wr+IsPrr6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6tiuyn2monopMXO07gAyY7T+n7xvyid/7QEuqQ68pzBZNFi1+bzEfVMvjtPkLaofD5U95DLmVlT0YPBzIHWnaIICI5B2HUhssmYmQ0WCpBQ9P68p2jorZkyU90mhUIC0xcr4qEJ3lkcbzjuWG+7R/IQVOQ7288UEraOlF8T8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UAKnRJGO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NKyg8KQc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UAKnRJGO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKyg8KQc"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734369167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pR/sHqHxQXpD31p3g1/0O7LvU9aHX60Ye5Sne1phnAo=;
	b=UAKnRJGOs4Z/oTlCMOW2xarcaNaOSY9PNcZhuA24YTVuMtKm2avq0jfbfpXh9N21Kyi392
	ZG2sG1LDqZ77RjRpJBB/sACEkB+uLILrnuVs4UfauyMxuCjaN2t1ZrB4Oyy5eTY3yylJ+6
	bKDIYHoz6MseJ4ahfcUB97v8iTLfzy0y8dp8x9FWhpXBr23f/VpvcsKYtVyBj/dLbhx+jd
	gFG5wqwW1HWBdoX13H3zKwOsU3pUe3sbk/36WS3sxDHcucGvnTlibdqJgQiiv1FeI+fguJ
	KMqxQ2D6uIBi1tF+CCMFz4FDc1yhUho8pQbRW3PtPrY31J1uPMaOam9t56afuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734369167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pR/sHqHxQXpD31p3g1/0O7LvU9aHX60Ye5Sne1phnAo=;
	b=NKyg8KQcahkoUwXURAyuEcC6z42AkS/jfd7ylZKnRCJalZTvAIuWmF8KjzhZboMdpQtENa
	3m/xqnAo4AvYB9Ag==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Peter Collingbourne <pcc@google.com>
Subject: [PATCH tty-next v1 4/4] serial: 8250: Explain the role of @read_status_mask
Date: Mon, 16 Dec 2024 18:18:44 +0106
Message-Id: <20241216171244.12783-5-john.ogness@linutronix.de>
In-Reply-To: <20241216171244.12783-1-john.ogness@linutronix.de>
References: <20241216171244.12783-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The role of @read_status_mask has changed over time and seems
to still cause confusion. This can be expected since there is
zero documentation about this driver-specific variable.

Add comments to the initialization of @read_status_mask to
clarify its role.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c | 6 ++++++
 drivers/tty/serial/8250/8250_port.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 10144fcc0363..42b4aa56b902 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -412,6 +412,12 @@ static void omap_8250_set_termios(struct uart_port *port,
 	 */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
+	/*
+	 * Specify which conditions may be considered for error
+	 * handling and the ignoring of characters. The actual
+	 * ignoring of characters only occurs if the bit is set
+	 * in @ignore_status_mask as well.
+	 */
 	up->port.read_status_mask = UART_LSR_OE | UART_LSR_DR;
 	if (termios->c_iflag & INPCK)
 		up->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3b9dc2bb06eb..1a65d3e5f3c0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2785,6 +2785,12 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
+	/*
+	 * Specify which conditions may be considered for error
+	 * handling and the ignoring of characters. The actual
+	 * ignoring of characters only occurs if the bit is set
+	 * in @ignore_status_mask as well.
+	 */
 	port->read_status_mask = UART_LSR_OE | UART_LSR_DR;
 	if (termios->c_iflag & INPCK)
 		port->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
-- 
2.39.5

