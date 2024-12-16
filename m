Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655EC146599;
	Mon, 16 Dec 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369169; cv=none; b=t6kr/sTHg40rfa2psx9NmyNVayv3RRqVztPXKuL94S0IGMda4JSwUhuPAkAzdG+3Rqa3KV1tw86H8vfNc5MEtDrV8kkELoqwDy6RqWs/Re8PwH2YCTlLkAGm3Z6fSfaABv5f33TijQ6xZU+Qe2nU/SqbI7r3Yin1H5hTkzOVdGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369169; c=relaxed/simple;
	bh=sVMl+jn1gO7/B56wvNDox+JTcyMMStgWzsj2WddAzZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKnYA41hQhVgk6Olcx0uzk//eg78MaBXGRxAuwA9XaMTHD2LCvlo3ch/pHDwWY/Uvj1ncdOdB3LS6He/m4MVXnNuBgG1TBFbxDY2sOgnv4ZEmW8dFpFU/i4MrBWR1fPnhfb7ST17wTwZ/Rq8RQxO+V0mxbAYt14JvYSyOMYryws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OEBIBINY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/vUGJZ7f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OEBIBINY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/vUGJZ7f"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734369166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4LDy/bdxAIfmqXtWO12bc7RfBH5jaXLX1SR92lnOds=;
	b=OEBIBINYLCgJV4AMjqIupQwWPmRWmPqQhhOEoXZSzYL61UQB+2Tmq6oA3IrlHZP7NoCU6p
	5UVmGd3zWgM5i99VhHqe3AAViTGrcidUv+PVRDwi+BDJnpEWUnQGg6L44oAlcDMUkFmjDj
	BYhK6aQS9lVaJ22pXEnnZ+ldGAlegZRqntJGz9VoqG/loIs+nbBUSh2ud64UBdQi1RQ0Fh
	x4ibcsg8Vtof9ACmYDd2sqiz+iuNhwdkWnvP7QpoUoZu3U6+YANUa3UR7/6DaiOxwpIqu0
	TWRenhHAASipkLtuWdDGBgUaKBSdyTC3Dz4rjPsgVO3pnIAViomvboqNdV7eeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734369166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4LDy/bdxAIfmqXtWO12bc7RfBH5jaXLX1SR92lnOds=;
	b=/vUGJZ7fPqiA2R9JZiyiz9KkBnErqaYSVsmHW+iYjh4d2YQwxOjLlIDThkf232I8knc2to
	/bx9kVjMTmhCsLDQ==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Peter Collingbourne <pcc@google.com>
Subject: [PATCH tty-next v1 3/4] serial: 8250: Never adjust UART_LSR_DR in @read_status_mask
Date: Mon, 16 Dec 2024 18:18:43 +0106
Message-Id: <20241216171244.12783-4-john.ogness@linutronix.de>
In-Reply-To: <20241216171244.12783-1-john.ogness@linutronix.de>
References: <20241216171244.12783-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CREAD feature of termios is implemented by setting/clearing
UART_LSR_DR within @ignore_status_mask. For this feature to
function correctly, it requires that UART_LSR_DR is never
masked (unset) in @read_status_mask so that uart_insert_char()
can properly drop the character if CREAD is disabled.

Currently there are code paths that clear/set UART_LSR_DR from
@read_status_mask at times. This appears to be a relic from
Linux 1.1.60, where @read_status_mask could be used to mask
all UART_LSR reading. However, since Linux 2.1.8 that is no
longer the case. Now if UART_LSR_DR is cleared from
@read_status_mask, received characters may not be dropped
even though CREAD is disabled.

This can be seen when:

- CREAD is disabled (UART_LSR_DR is set in @ignore_status_mask)
- LSR has an error bit set from UART_LSR_BRK_ERROR_BITS
  (and that error is not ignored via @ignore_status_mask)
- UART_LSR_DR is cleared in @read_status_mask

In this case characters will be inserted into the tty buffer
even though they should be ignored.

Remove all setting/clearing of UART_LSR_DR for
@read_status_mask except for its initialization.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 1 -
 drivers/tty/serial/8250/8250_omap.c | 1 -
 drivers/tty/serial/8250/8250_port.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 5f9f06911795..2b70e82dffeb 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -675,7 +675,6 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 
 	uart_port_lock_irqsave(port, &flags);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
-	up->port.read_status_mask |= UART_LSR_DR;
 	serial_out(up, UART_IER, up->ier);
 	uart_port_unlock_irqrestore(port, flags);
 }
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 5290aed76a5e..10144fcc0363 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -838,7 +838,6 @@ static void omap_8250_unthrottle(struct uart_port *port)
 	if (up->dma)
 		up->dma->rx_dma(up);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
-	port->read_status_mask |= UART_LSR_DR;
 	serial_out(up, UART_IER, up->ier);
 	uart_port_unlock_irqrestore(port, flags);
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a5c1b069c67b..3b9dc2bb06eb 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1390,7 +1390,6 @@ static void serial8250_stop_rx(struct uart_port *port)
 	serial8250_rpm_get(up);
 
 	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
-	up->port.read_status_mask &= ~UART_LSR_DR;
 	serial_port_out(port, UART_IER, up->ier);
 
 	serial8250_rpm_put(up);
-- 
2.39.5

