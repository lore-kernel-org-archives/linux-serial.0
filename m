From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 03/75] Blackfin Serial Driver: Clean serial console and early
	prink code.
Date: Fri, 02 Jan 2009 13:40:31 +0000
Message-ID: <20090102134027.13472.16845.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60271 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752599AbZABNkQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:40:16 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Sonic Zhang <sonic.zhang@analog.com>

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/bfin_5xx.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)


diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 59a221f..88449d3 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -986,7 +986,7 @@ static void __init bfin_serial_init_ports(void)
 
 }
 
-#ifdef CONFIG_SERIAL_BFIN_CONSOLE
+#if defined(CONFIG_SERIAL_BFIN_CONSOLE) || defined(CONFIG_EARLY_PRINTK)
 /*
  * If the port was already initialised (eg, by a boot loader),
  * try to determine the current setup.
@@ -1030,24 +1030,20 @@ bfin_serial_console_get_options(struct bfin_serial_port *uart, int *baud,
 	}
 	pr_debug("%s:baud = %d, parity = %c, bits= %d\n", __func__, *baud, *parity, *bits);
 }
-#endif
 
-#if defined(CONFIG_SERIAL_BFIN_CONSOLE) || defined(CONFIG_EARLY_PRINTK)
 static struct uart_driver bfin_serial_reg;
 
 static int __init
 bfin_serial_console_setup(struct console *co, char *options)
 {
 	struct bfin_serial_port *uart;
-# ifdef CONFIG_SERIAL_BFIN_CONSOLE
 	int baud = 57600;
 	int bits = 8;
 	int parity = 'n';
-#  ifdef CONFIG_SERIAL_BFIN_CTSRTS
+# ifdef CONFIG_SERIAL_BFIN_CTSRTS
 	int flow = 'r';
-#  else
+# else
 	int flow = 'n';
-#  endif
 # endif
 
 	/*
@@ -1059,16 +1055,12 @@ bfin_serial_console_setup(struct console *co, char *options)
 		co->index = 0;
 	uart = &bfin_serial_ports[co->index];
 
-# ifdef CONFIG_SERIAL_BFIN_CONSOLE
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
 		bfin_serial_console_get_options(uart, &baud, &parity, &bits);
 
 	return uart_set_options(&uart->port, co, baud, parity, bits, flow);
-# else
-	return 0;
-# endif
 }
 #endif /* defined (CONFIG_SERIAL_BFIN_CONSOLE) ||
 				 defined (CONFIG_EARLY_PRINTK) */
@@ -1177,7 +1169,7 @@ struct console __init *bfin_earlyserial_init(unsigned int port,
 	return &bfin_early_serial_console;
 }
 
-#endif /* CONFIG_SERIAL_BFIN_CONSOLE */
+#endif /* CONFIG_EARLY_PRINTK */
 
 static struct uart_driver bfin_serial_reg = {
 	.owner			= THIS_MODULE,

