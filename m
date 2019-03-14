From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 36/45] drivers: tty: serial: pic32_uart: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:06 +0100
Message-ID: <1552602855-26086-37-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/pic32_uart.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 0bdf168..b4f0b29 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -614,15 +614,19 @@ static int pic32_uart_request_port(struct uart_port *port)
 	if (unlikely(!res_mem))
 		return -EINVAL;
 
-	if (!request_mem_region(port->mapbase, resource_size(res_mem),
-				"pic32_uart_mem"))
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     resource_size(res_mem),
+				     "pic32_uart_mem"))
 		return -EBUSY;
 
 	port->membase = devm_ioremap_nocache(port->dev, port->mapbase,
 						resource_size(res_mem));
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, resource_size(res_mem));
+		devm_release_mem_region(port->dev,
+					port->mapbase,
+					resource_size(res_mem));
 		return -ENOMEM;
 	}
 
@@ -641,7 +645,7 @@ static void pic32_uart_release_port(struct uart_port *port)
 		return;
 	res_size = resource_size(res_mem);
 
-	release_mem_region(port->mapbase, res_size);
+	devm_release_mem_region(port->dev, port->mapbase, res_size);
 }
 
 /* serial core request to do any port required auto-configuration */
-- 
1.9.1
