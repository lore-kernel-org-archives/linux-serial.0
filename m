From: Michael Hordijk <mwh13@pitt.edu>
Subject: [PATCH 2.6.16.18] 8250: Serial console enable Tx fix
Date: Fri, 26 May 2006 21:49:12 -0400
Message-ID: <4477B018.1020101@pitt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.netapp.com ([216.240.18.37]:56838 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1751755AbWE0BtQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 May 2006 21:49:16 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

     Enabling the Tx interrupt from console_write on buggy UART (UART_BUG_TXEN) 
breaks console transmit on said UART.  Revert to previous UART_IER restore and 
use serial8250_start_tx() to cause the transmit path to start and not hang.

Signed-off-by: Michael W. J. Hordijk <mwh13@pitt.edu>

--- linux-2.6.16.y/drivers/serial/8250.c.orig   2006-05-26 21:25:09.000116360 -0400
+++ linux-2.6.16.y/drivers/serial/8250.c        2006-05-26 21:26:54.000841539 -0400
@@ -2229,8 +2229,13 @@ serial8250_console_write(struct console
          *      and restore the IER
          */
         wait_for_xmitr(up, BOTH_EMPTY);
-       up->ier |= UART_IER_THRI;
-       serial_out(up, UART_IER, ier | UART_IER_THRI);
+       serial_out(up, UART_IER, ier);
+
+       /*
+        *      Start transmitting again in case it was clobbered racing between
+        *      console and tty output.
+        */
+       serial8250_start_tx(up);
  }

  static int serial8250_console_setup(struct console *co, char *options)
