From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 7/7] serial: remove back and forth conversions in serial_out_sync
Date: Thu,  8 Mar 2012 19:12:14 -0500
Message-ID: <1331251934-25540-8-git-send-email-paul.gortmaker@windriver.com>
References: <1331251934-25540-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44824 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758706Ab2CIAMb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2012 19:12:31 -0500
In-Reply-To: <1331251934-25540-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

The two callers to serial_out_sync() have a struct port right
there in scope, but then pass in a struct 8250_port which then
is locally resolved back to a struct port.

Delete the needless back and forth and just pass in the struct
port directly.  Rename the function to have "_port" in its
name, so the name <--> args relationship is consistent with the
other serial_in/out vs serial_port_in/out function classes.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250/8250.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 7898295..5b149b4 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -467,9 +467,8 @@ static void set_io_from_upio(struct uart_port *p)
 }
 
 static void
-serial_out_sync(struct uart_8250_port *up, int offset, int value)
+serial_port_out_sync(struct uart_port *p, int offset, int value)
 {
-	struct uart_port *p = &up->port;
 	switch (p->iotype) {
 	case UPIO_MEM:
 	case UPIO_MEM32:
@@ -2024,11 +2023,11 @@ static int serial8250_startup(struct uart_port *port)
 			disable_irq_nosync(port->irq);
 
 		wait_for_xmitr(up, UART_LSR_THRE);
-		serial_out_sync(up, UART_IER, UART_IER_THRI);
+		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
 		udelay(1); /* allow THRE to set */
 		iir1 = serial_port_in(port, UART_IIR);
 		serial_port_out(port, UART_IER, 0);
-		serial_out_sync(up, UART_IER, UART_IER_THRI);
+		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
 		udelay(1); /* allow a working UART time to re-assert THRE */
 		iir = serial_port_in(port, UART_IIR);
 		serial_port_out(port, UART_IER, 0);
-- 
1.7.9.1

