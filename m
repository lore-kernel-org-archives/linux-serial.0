From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/7] serial: delete useless void casts in 8250.c
Date: Thu,  8 Mar 2012 19:12:10 -0500
Message-ID: <1331251934-25540-4-git-send-email-paul.gortmaker@windriver.com>
References: <1331251934-25540-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44799 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab2CIAM1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2012 19:12:27 -0500
In-Reply-To: <1331251934-25540-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

These might have worked some magic with an ancient gcc back in
1992, but "objdump --disassemble" on gcc 4.6 on x86-64 shows
identical output before and after this commit.  Send the casts
and their hysterical rasins to the bitbucket.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250/8250.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 4009e24..6a71716 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -1218,7 +1218,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 		ICP = (up->port.iobase & 0xfe0) | 0x1f;
 		save_ICP = inb_p(ICP);
 		outb_p(0x80, ICP);
-		(void) inb_p(ICP);
+		inb_p(ICP);
 	}
 
 	/* forget possible initially masked and pending IRQ */
@@ -1238,10 +1238,10 @@ static void autoconfig_irq(struct uart_8250_port *up)
 			    UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2);
 	}
 	serial_out(up, UART_IER, 0x0f);	/* enable all intrs */
-	(void)serial_in(up, UART_LSR);
-	(void)serial_in(up, UART_RX);
-	(void)serial_in(up, UART_IIR);
-	(void)serial_in(up, UART_MSR);
+	serial_in(up, UART_LSR);
+	serial_in(up, UART_RX);
+	serial_in(up, UART_IIR);
+	serial_in(up, UART_MSR);
 	serial_out(up, UART_TX, 0xFF);
 	udelay(20);
 	irq = probe_irq_off(irqs);
@@ -1973,10 +1973,10 @@ static int serial8250_startup(struct uart_port *port)
 	/*
 	 * Clear the interrupt registers.
 	 */
-	(void) serial_in(up, UART_LSR);
-	(void) serial_in(up, UART_RX);
-	(void) serial_in(up, UART_IIR);
-	(void) serial_in(up, UART_MSR);
+	serial_in(up, UART_LSR);
+	serial_in(up, UART_RX);
+	serial_in(up, UART_IIR);
+	serial_in(up, UART_MSR);
 
 	/*
 	 * At this point, there's no way the LSR could still be 0xff;
@@ -2152,7 +2152,7 @@ dont_test_tx_en:
 		 */
 		icp = (up->port.iobase & 0xfe0) | 0x01f;
 		outb_p(0x80, icp);
-		(void) inb_p(icp);
+		inb_p(icp);
 	}
 
 	return 0;
@@ -2198,7 +2198,7 @@ static void serial8250_shutdown(struct uart_port *port)
 	 * Read data port to reset things, and then unlink from
 	 * the IRQ chain.
 	 */
-	(void) serial_in(up, UART_RX);
+	serial_in(up, UART_RX);
 
 	del_timer_sync(&up->timer);
 	up->timer.function = serial8250_timeout;
-- 
1.7.9.1

