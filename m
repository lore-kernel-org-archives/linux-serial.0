Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B512D4657DA;
	Tue, 28 Apr 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398880; cv=none; b=oNwfGo7akliuR+y2bj0b4JJpIaQLeFevLQ+tIzgTAgDN4A9L99bQeqQRyeoFe+Jr+kwPvFj+u1YI57lQIRyDOY1DP7PRYarfBy0W54oU3I0XZeHrOho8bBEgeUQxrjb/jVzhyJLeQ+2kbNIpJnkGBADAK8ofG7MOOF9PsNjvB6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398880; c=relaxed/simple;
	bh=zAXU2SdSD7A3mNzmBEJdbSK4E3xriyxmzzVnV4SFz0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+KzTg8KmqrmHWssiRT9yvJK9CWpnQz8F+znLeBvoZlpwSMbcf9zFh8C9K1EqYyNHQNkdOmXjC1uZxGfPGBaesgzH5TVshaI4xQtRi1JMsQf7qOrK4se39zHzng5jRbbuovVemAO6Fh0UtHuuKG+K8z80+TVdIIncEKCprU103U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=sDp1CTl4; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="sDp1CTl4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=GvahBXX0LqIbjoZ82Y4DwbPRt/Flvj94EgzONMQXHuo=; b=sDp1CTl4+B9NutE4czC2JZwZjo
	a6AEIB9qConfZRNWu0HnD8MrU83M8/XV87ZXYvNgAcDXIcSfqqBrYHKDSbkzlAMbiZIuXPioVRuQP
	qUkTAjXGiAHTjcOncwRHcDHUBBiEbsPF4O8sKmb3sssPrS//nRP0cDJu1S1utn6t2iZA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdk-000000004cz-2pqi;
	Tue, 28 Apr 2026 13:54:32 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:53:57 -0400
Subject: [PATCH v2 11/15] serial: core: add new I/O type for SPI and I2C
 bus devices
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tty-upio-v2-11-01c1857cf761@dimonoff.com>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
In-Reply-To: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
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
index d0d4dba41fb9ee43403391d9d599abc1d64b48ec..0e015477848504e37afb34c8088957083f1662c7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2516,11 +2516,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 {
 	unsigned int flags;
 
-	/*
-	 * If there isn't a port here, don't do anything further.
-	 */
-	if (!port->iobase && !port->mapbase && !port->membase)
-		return;
+	/* If there isn't a port here, don't do anything further. */
+	if (uart_iotype_mmio(port->iotype) || uart_iotype_legacy_io(port->iotype))
+		if (!port->iobase && !port->mapbase && !port->membase)
+			return;
 
 	/*
 	 * Now do the auto configuration stuff.  Note that config_port
@@ -3216,6 +3215,8 @@ bool uart_match_port(const struct uart_port *port1,
 		return hub6_match_port(port1, port2);
 	else if (uart_iotype_mmio(port1->iotype))
 		return port1->mapbase == port2->mapbase;
+	else if (port1->iotype == UPIO_BUS)
+		return true;
 	else
 		return false;
 }
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index fc3f5ebe389658c197ffc105ce4ac11cacef59bb..626dd939c53c9f920d71aadd360ec0ea0bacce0d 100644
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

