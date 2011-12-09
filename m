From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH RESEND 1/8] serial: 8250: replace hardcoded 0xbf with #define
Date: Fri,  9 Dec 2011 18:07:13 +0100
Message-ID: <1323450440-414-2-git-send-email-w.sang@pengutronix.de>
References: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Claudio Scordino <claudio@evidence.eu.com>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Makes it easier to find all occurences requesting CONF_MODE_B.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/tty/serial/8250.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index eeadf1b..f8f2320 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -2000,7 +2000,7 @@ static int serial8250_startup(struct uart_port *port)
 		serial_outp(up, UART_IER, 0);
 		serial_outp(up, UART_LCR, 0);
 		serial_icr_write(up, UART_CSR, 0); /* Reset the UART */
-		serial_outp(up, UART_LCR, 0xBF);
+		serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_outp(up, UART_EFR, UART_EFR_ECB);
 		serial_outp(up, UART_LCR, 0);
 	}
-- 
1.7.7.3
