From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH RESEND 6/8] serial: 8250: update rs485 flags with polarity settings
Date: Fri,  9 Dec 2011 18:07:18 +0100
Message-ID: <1323450440-414-7-git-send-email-w.sang@pengutronix.de>
References: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Claudio Scordino <claudio@evidence.eu.com>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Report the only mode we can support with the 16C850.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/tty/serial/8250.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 28b3608..8cf6d76 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -2750,6 +2750,9 @@ static int serial8250_ioctl_port(struct uart_port *port,
 		serial_outp(up, UART_LCR, lcr);
 		spin_unlock_irqrestore(&up->port.lock, flags);
 
+		/* only mode supported by the 16C850 */
+		rs485ctrl.flags &= ~SER_RS485_RTS_ON_SEND;
+		rs485ctrl.flags |= SER_RS485_RTS_AFTER_SEND;
 		up->rs485_flags = rs485ctrl.flags;
 
 		return 0;
-- 
1.7.7.3
