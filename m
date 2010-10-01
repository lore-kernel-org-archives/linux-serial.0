From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: [PATCH 6/8] altera_uart: Fixup type usage of port flags
Date: Fri, 1 Oct 2010 17:22:37 +0400
Message-ID: <20101001132237.GF25897@oksana.dev.rtsoft.ru>
References: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:65327 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932587Ab0JANWo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Oct 2010 09:22:44 -0400
Content-Disposition: inline
In-Reply-To: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

port->flags is of type upf_t, which corresponds to UPF_* flags.

ASYNC_BOOT_AUTOCONF is an unsigned integer, which happen to
be the same as UPF_BOOT_AUTOCONF.

Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/serial/altera_uart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/altera_uart.c b/drivers/serial/altera_uart.c
index 99e007f..304181c 100644
--- a/drivers/serial/altera_uart.c
+++ b/drivers/serial/altera_uart.c
@@ -420,7 +420,7 @@ int __init early_altera_uart_setup(struct altera_uart_platform_uart *platp)
 		port->iotype = SERIAL_IO_MEM;
 		port->irq = platp[i].irq;
 		port->uartclk = platp[i].uartclk;
-		port->flags = ASYNC_BOOT_AUTOCONF;
+		port->flags = UPF_BOOT_AUTOCONF;
 		port->ops = &altera_uart_ops;
 		port->private_data = platp;
 	}
@@ -550,7 +550,7 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
 	port->iotype = SERIAL_IO_MEM;
 	port->uartclk = platp->uartclk;
 	port->ops = &altera_uart_ops;
-	port->flags = ASYNC_BOOT_AUTOCONF;
+	port->flags = UPF_BOOT_AUTOCONF;
 	port->private_data = platp;
 
 	uart_add_one_port(&altera_uart_driver, port);
-- 
1.7.0.5

