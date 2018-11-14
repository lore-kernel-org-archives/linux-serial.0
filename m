From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/3] serial: imx: unprepare console clocks on remove
Date: Wed, 14 Nov 2018 18:49:39 +0100
Message-ID: <20181114174940.7865-2-stefan@agner.ch>
References: <20181114174940.7865-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114174940.7865-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: fabio.estevam@nxp.com, u.kleine-koenig@pengutronix.de, s.hauer@pengutronix.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-serial@vger.kernel.org

Currently imx_uart_console_setup() prepares clocks which do not
get unprepared anywhere. Check whether the console has been used
by testing if index is set and unprepare clocks in this case.

This makes sure that clocks are properly unprepared after the
console device has been unbound.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/imx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 313c3b1900a8..757c91e5105a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2085,7 +2085,7 @@ static struct console imx_uart_console = {
 	.data		= &imx_uart_uart_driver,
 };
 
-#define IMX_CONSOLE	&imx_uart_console
+#define IMX_CONSOLE	(&imx_uart_console)
 
 #ifdef CONFIG_OF
 static void imx_uart_console_early_putchar(struct uart_port *port, int ch)
@@ -2378,8 +2378,17 @@ static int imx_uart_probe(struct platform_device *pdev)
 static int imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+
+	if (IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE) && IMX_CONSOLE->index >= 0) {
+		clk_unprepare(sport->clk_ipg);
+		clk_unprepare(sport->clk_per);
+		IMX_CONSOLE->index = -1;
+	}
 
-	return uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	return ret;
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
-- 
2.19.1
