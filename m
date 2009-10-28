From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/2] MIPS: Alchemy: UARTs are 16550A
Date: Wed, 28 Oct 2009 20:09:14 +0100
Message-ID: <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
References: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:59649 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbZJ1TJO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Oct 2009 15:09:14 -0400
Received: by ewy4 with SMTP id 4so1069405ewy.37
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2009 12:09:18 -0700 (PDT)
In-Reply-To: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>

UART autodetection breaks on the Au1300 but the IP blocks are
identical, at least in the datasheets.

Pass uart type on to the 8250 driver via platform data, and move
the MSR quirk to another place sind autoconf() is now no longer
called on init.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Tested on DB1200 and DB1300.
The mips parts apply on top of Ralf's mips-queue tree.

 arch/mips/alchemy/common/platform.c |    4 +++-
 drivers/serial/8250.c               |   13 +++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 195e5b3..3be14b0 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -26,7 +26,9 @@
 		.irq		= _irq,				\
 		.regshift	= 2,				\
 		.iotype		= UPIO_AU,			\
-		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
+		.flags		= UPF_SKIP_TEST | UPF_IOREMAP |	\
+				  UPF_FIXED_TYPE,		\
+		.type		= PORT_16550A,			\
 	}
 
 static struct plat_serial8250_port au1x00_uart_data[] = {
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 2ff81eb..9538e5b 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1214,12 +1214,6 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	}
 #endif
 
-#ifdef CONFIG_SERIAL_8250_AU1X00
-	/* if access method is AU, it is a 16550 with a quirk */
-	if (up->port.type == PORT_16550A && up->port.iotype == UPIO_AU)
-		up->bugs |= UART_BUG_NOMSR;
-#endif
-
 	serial_outp(up, UART_LCR, save_lcr);
 
 	if (up->capabilities != uart_config[up->port.type].flags) {
@@ -2586,6 +2580,13 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 
 	if (flags & UART_CONFIG_TYPE)
 		autoconfig(up, probeflags);
+
+#ifdef CONFIG_SERIAL_8250_AU1X00
+	/* if access method is AU, it is a 16550 with a quirk */
+	if (up->port.type == PORT_16550A && up->port.iotype == UPIO_AU)
+		up->bugs |= UART_BUG_NOMSR;
+#endif
+
 	if (up->port.type != PORT_UNKNOWN && flags & UART_CONFIG_IRQ)
 		autoconfig_irq(up);
 
-- 
1.6.5

