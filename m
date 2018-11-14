From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/3] serial: imx: fix error handling in console_setup
Date: Wed, 14 Nov 2018 18:49:38 +0100
Message-ID: <20181114174940.7865-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: fabio.estevam@nxp.com, u.kleine-koenig@pengutronix.de, s.hauer@pengutronix.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-serial@vger.kernel.org

The ipg clock only needs to be unprepared in case preparing
per clock fails. The ipg clock has already disabled at the point.

Fixes: 1cf93e0d5488 ("serial: imx: remove the uart_console() check")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0f67197a3783..313c3b1900a8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2068,7 +2068,7 @@ imx_uart_console_setup(struct console *co, char *options)
 
 	retval = clk_prepare(sport->clk_per);
 	if (retval)
-		clk_disable_unprepare(sport->clk_ipg);
+		clk_unprepare(sport->clk_ipg);
 
 error_console:
 	return retval;
-- 
2.19.1
