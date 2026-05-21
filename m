Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408CE3911BD;
	Thu, 21 May 2026 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387431; cv=none; b=vD7h3524qIdrneXV2RvP5FuvhpMzE8K6mm1ikwpI9HcrAdI3vaB2PvaBjvfSxSnOU/jpJDSLzwfvHH0O9osgZqBHKObJmP8U4+roqldNKFo2ShlQ9/ItpLMQm9gMYmTnM3bMqX/TujeUevqZ9farhCfckkrpNx+X2y4VigFCHRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387431; c=relaxed/simple;
	bh=TjDNWcVBCUPRVEFLQGDCq/qcNQAmSS9j003mYviOArI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NxLAGrgXoOESiHfoIF6vdjuISpNxnH8VRbUQ0eO5dZJu0LMJBZ0gKEL+cHsA1/laJYCuhpOYz55nkdEn5vaRgY4uxaXJIkMVPvZNePZwF4ST1W9VM7Cw9LtpJsEu7JDHEYOr0r/cZqmfcy4L93xFVG7pjnH7iUU1InQMoCRPcGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=QpgMORXf; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="QpgMORXf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=X+F1iyvj77IQke+x5blxIkQHiWoRxpDO8vlmjn6Yu4U=; b=QpgMORXfOhWyEmmue0AGzHGU+9
	J65RCA3hqU+w6SOuYbav5vQyWt7j4U7t0Nuxh+vtMQnlgpujAj4nIAlohsSOzksNiJh/spLpZf+Ko
	al5pMLX/ZQc6aGELJxwFgM7uAVEQr5wvZi6Pn+dcIi+n/gySqeL21uFq6CPjN/r6uQLg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wQ7x8-000000001yA-1VnX;
	Thu, 21 May 2026 14:17:02 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 21 May 2026 14:16:53 -0400
Subject: [PATCH v3 07/10] serial: core: add new I/O type for SPI and I2C
 bus devices
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-tty-upio-v3-7-bf74567994a0@dimonoff.com>
References: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
In-Reply-To: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, ilpo.jarvinen@linux.intel.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

I2C/SPI serial drivers don't use the following struct uart_port variables:
    port->membase
    port->mapbase
    port->iobase

However, they are forced to set membase to a non-zero value so that
uart_configure_port() will succeed because of the following check:

    /* If there isn't a port here, don't do anything further. */
    if (!port->iobase && !port->mapbase && !port->membase)
        return;

Add a new I/O type for SPI and I2C bus devices to remove the need to
implement the kind of above-mentioned ambiguous workarounds to make them
work. Now that UART report functions are using uart_iotype_*() functions,
no more irrelevant I/O information are being printed for UPIO_BUS iotypes.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
With this change, uart_match_port() will always return true for UPIO_BUS
types, and this function is not used by any of the SPI/I2C drivers.
---
 drivers/tty/serial/serial_core.c | 11 ++++++-----
 include/linux/serial_core.h      |  1 +
 include/uapi/linux/serial.h      |  1 +
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index afc7c1421ad54aeb7492bbda670939498b9018fc..efc85c7762ebaa543e4c5d3efa651c302a6542ea 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2530,11 +2530,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 {
 	unsigned int flags;
 
-	/*
-	 * If there isn't a port here, don't do anything further.
-	 */
-	if (!port->iobase && !port->mapbase && !port->membase)
-		return;
+	/* If there isn't a port here, don't do anything further. */
+	if (uart_iotype_mmio(port->iotype) || uart_iotype_io(port->iotype))
+		if (!port->iobase && !port->mapbase && !port->membase)
+			return;
 
 	/*
 	 * Now do the auto configuration stuff.  Note that config_port
@@ -3230,6 +3229,8 @@ bool uart_match_port(const struct uart_port *port1,
 		return hub6_match_port(port1, port2);
 	else if (uart_iotype_mmio(port1->iotype))
 		return port1->mapbase == port2->mapbase;
+	else if (port1->iotype == UPIO_BUS)
+		return true;
 	else
 		return false;
 }
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b91ad22be11b0d0b82928b9277cf29807796830e..de179b51777bd1b173f6b3633da3435e40bb9ccb 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -437,6 +437,7 @@ enum uart_iotype {
 	UPIO_TSI	= SERIAL_IO_TSI,	/* Tsi108/109 type IO */
 	UPIO_MEM32BE	= SERIAL_IO_MEM32BE,	/* 32b big endian */
 	UPIO_MEM16	= SERIAL_IO_MEM16,	/* 16b little endian */
+	UPIO_BUS	= SERIAL_IO_BUS,	/* Serial bus I/O access (ex: SPI, I2C) */
 };
 
 struct uart_port {
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index de9b4733607e6b61b08ff7089ff90070168ff4a2..e6f61538fc2837a264d27942afaaf3f12e743445 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -72,6 +72,7 @@ struct serial_struct {
 #define SERIAL_IO_TSI	  5
 #define SERIAL_IO_MEM32BE 6
 #define SERIAL_IO_MEM16	7
+#define SERIAL_IO_BUS	8
 
 #define UART_CLEAR_FIFO		0x01
 #define UART_USE_FIFO		0x02

-- 
2.47.3

