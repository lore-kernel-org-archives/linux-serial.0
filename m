Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8221A9FBC;
	Thu, 23 Apr 2026 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975317; cv=none; b=VS6vzrt2lNezu3pVpxIf7Y8faRQ9RO7TxXjo3QCP7GqHPUulvvUYKtmbnrKeCcxt9TzVqB9x58DH2hoV9nmfwEetsQDKuf/dgykRAH7Mwq59S5mstOxYANlYWhxO6mSg3o7Xv9m/u8xAgX7n2mqjQIGg1YItaS1I1hqK5wb8zYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975317; c=relaxed/simple;
	bh=hYqIBi0VFMy6IzsGunnD3iLdF1NANeFoJCk3H9NxnTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRzInP8BeWvkPaSkNIo6ynsc3paPV3nlgUi8VaRKoE8JU1qn7sPV1/nMBSmZa7T8DBlD7hfbvR4a0m/7WJRlSBGRr+eOUsK4NAR9cOvR2w5BbFVgaXRK8zmERqn9E2lhQSuJ+xJQQYLzBHJclc3LbafmdyAKrLEnRB1hMp9WfeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=maFIxuMD; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="maFIxuMD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=qw+mWkwXmc7RqCOdYgUO0rX4W3Y65E0lYe2p4WpQZ4s=; b=maFIxuMDvkP/MZ1AQbqaBRjstW
	tVaG0yyWMsLuW3qBgKlr19pOTXR3bh2bsb8ns6l2Ke7GKaQMlNxx4V6wCuSOIXP2DSrHMEwgpQtLB
	mJyCx/3fR+eXbq2vWrwTKWbYEdlaYyM1PFuM7KAuOjjldHcrhqS+tNkso87CWpkm+RB4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wG0S5-000000002qN-2dD5;
	Thu, 23 Apr 2026 16:15:09 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 23 Apr 2026 16:15:05 -0400
Subject: [PATCH 5/9] serial: core: add new I/O type for SPI and I2C bus
 devices
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-tty-upio-v1-5-baf82d3b86d1@dimonoff.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
In-Reply-To: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
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
work.

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
index cb5da344305e397b42f47bdbc2c053fc487ed784..0bfdb69817e4259681fbc4658c9a68200aa2b65f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2527,11 +2527,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
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
@@ -3230,6 +3229,8 @@ bool uart_match_port(const struct uart_port *port1,
 			return false;
 		else
 			return true;
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

