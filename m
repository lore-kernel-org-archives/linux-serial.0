From: Michael Westermann <mw@microdata-pos.de>
Subject: change HW flow-control
Date: Thu, 6 May 2004 16:39:09 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040506163909.A21706@microdata-pos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from port-212-202-104-142.reverse.qsc.de ([212.202.104.142]:32018
	"EHLO imail.microdata-pos.de") by vger.kernel.org with ESMTP
	id S262045AbUEFOjK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 May 2004 10:39:10 -0400
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I work on a change for the serial driver, 
first for a i386 kernel 2.4.xx. Many POS printers and devices 
from different vendors use DTR/DSR flow control, not RTS/CTS. 

I think it's a good idea to change the serial.c module for flexible
flow control. My idea is to add one or two additional variables 
for the hw flow control.

info->modem_flow 	/* Modem lines  */ 
info->status_flow 	/* Status lines */

example: setting for ctrscts in serial.c not complete.

@@ -1751,6 +1751,8 @@
 		info->IER |= UART_IER_MSI;
 	if (cflag & CRTSCTS) {
 		info->flags |= ASYNC_CTS_FLOW;
+		info->status_flow = UART_MSR_CTS;
+		info->modem_flow  = UART_MCR_RTS;
 		info->IER |= UART_IER_MSI;
 	} else
 		info->flags &= ~ASYNC_CTS_FLOW;


With this change can we use few different flow-controls e.g.
CTS/DTR, DTR/DSR RTS/DSR .. DTR/CD. 

I think is a good idea to integrate the new settings in the termios flags.

/* c_lflag bits */
#define CHWFLOW	001000000000 

and set the hw stop and start bits in the  c_cc array.
either in the VSTART and VSTOP field or in the free field index 17 and 18.    	

Alternatively the new HW flow lines could be set with a new ioctl.
 
What is the best way to set status_flow and modem_flow?  

Michael
