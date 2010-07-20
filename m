From: akpm@linux-foundation.org
Subject: [patch 1/7] "altera_uart: simplify altera_uart_console_putc()" checkpatch fixes
Date: Tue, 20 Jul 2010 15:26:10 -0700
Message-ID: <201007202226.o6KMQAWX021501@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48424 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932860Ab0GTW1P (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jul 2010 18:27:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, tklauser@distanz.ch

From: Andrew Morton <akpm@linux-foundation.org>

ERROR: code indent should use tabs where possible
#32: FILE: drivers/serial/altera_uart.c:397:
+^I         ALTERA_UART_STATUS_TRDY_MSK))$

total: 1 errors, 0 warnings, 39 lines checked

./patches/altera_uart-simplify-altera_uart_console_putc.patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

Please run checkpatch prior to sending patches


This fix got lost when someone merged "altera_uart: simplify
altera_uart_console_putc()".  Please don't lose fixes.  Please don't write
of mere patches which have trivial checkpatch errors.

Cc: Greg KH <greg@kroah.com>
Cc: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/serial/altera_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/serial/altera_uart.c~altera_uart-simplify-altera_uart_console_putc-checkpatch-fixes drivers/serial/altera_uart.c
--- a/drivers/serial/altera_uart.c~altera_uart-simplify-altera_uart_console_putc-checkpatch-fixes
+++ a/drivers/serial/altera_uart.c
@@ -394,7 +394,7 @@ int __init early_altera_uart_setup(struc
 static void altera_uart_console_putc(struct uart_port *port, const char c)
 {
 	while (!(readl(port->membase + ALTERA_UART_STATUS_REG) &
-	         ALTERA_UART_STATUS_TRDY_MSK))
+		 ALTERA_UART_STATUS_TRDY_MSK))
 		cpu_relax();
 
 	writel(c, port->membase + ALTERA_UART_TXDATA_REG);
_
