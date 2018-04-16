From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] serial: imx: fix cached UCR2 read on software reset
Date: Mon, 16 Apr 2018 17:35:02 +0200
Message-ID: <20180416153502.11814-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-serial@vger.kernel.org

To reset the UART the SRST needs be cleared (low active). According
to the documentation the bit will remain active for 4 module clocks
until it is cleared (set to 1).

Hence the real register need to be read in case the cached register
indcates that the SRST bit is zero.

This bug lead to wrong baudrate because the baud rate register got
restored before reset completed in imx_flush_buffer.

Fixes: 3a0ab62f43de ("serial: imx: implement shadow registers for UCRx and UFCR")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 91f3a1a5cb7f..4ff6bd6eb9ab 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -316,7 +316,7 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 		 * differ from the value that was last written. As it only
 		 * clears after being set, reread conditionally.
 		 */
-		if (sport->ucr2 & UCR2_SRST)
+		if (!(sport->ucr2 & UCR2_SRST))
 			sport->ucr2 = readl(sport->port.membase + offset);
 		return sport->ucr2;
 		break;
-- 
2.17.0
