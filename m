From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH RESEND 5/8] serial: 8250: reject delaying RTS with RS485
Date: Fri,  9 Dec 2011 18:07:17 +0100
Message-ID: <1323450440-414-6-git-send-email-w.sang@pengutronix.de>
References: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Claudio Scordino <claudio@evidence.eu.com>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

There might be chips capable of doing this, but for now nothing is implemented,
so reject usage of this feature.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/tty/serial/8250.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 6a2f47f..28b3608 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -2735,6 +2735,9 @@ static int serial8250_ioctl_port(struct uart_port *port,
 				   sizeof(rs485ctrl)))
 			return -EFAULT;
 
+		if (rs485ctrl.delay_rts_before_send || rs485ctrl.delay_rts_after_send)
+			return -EOPNOTSUPP;
+
 		spin_lock_irqsave(&up->port.lock, flags);
 		lcr = serial_inp(up, UART_LCR);
 		serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
-- 
1.7.7.3
