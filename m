From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2] serial: imx: fix cached UCR2 read on software reset
Date: Fri, 20 Apr 2018 14:44:07 +0200
Message-ID: <20180420124407.12892-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: u.kleine-koenig@pengutronix.de, festevam@gmail.com, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-serial@vger.kernel.org

To reset the UART the SRST needs be cleared (low active). According
to the documentation the bit will remain active for 4 module clocks
until it is cleared (set to 1).

Hence the real register need to be read in case the cached register
indicates that the SRST bit is zero.

This bug lead to wrong baudrate because the baud rate register got
restored before reset completed in imx_flush_buffer.

Fixes: 3a0ab62f43de ("serial: imx: implement shadow registers for UCRx and UFCR")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hi Greg,

Since this fixes a regression it should go into v4.17...

--
Stefan


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
