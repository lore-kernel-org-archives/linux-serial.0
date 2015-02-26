From: Leilei Zhao <leilei.zhao@atmel.com>
Subject: [PATCH 3/5] tty/serial: at91: revise the return type of atmel_init_property
Date: Thu, 26 Feb 2015 14:55:23 +0800
Message-ID: <1424933725-16242-4-git-send-email-leilei.zhao@atmel.com>
References: <1424933725-16242-1-git-send-email-leilei.zhao@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424933725-16242-1-git-send-email-leilei.zhao@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, jslaby@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Leilei Zhao <leilei.zhao@atmel.com>
List-Id: linux-serial@vger.kernel.org

The function of atmel_init_property is to set the work manner of
atmel serial ports according to the property in device trees.
If DMA or PDC is not set or something goes wrong in getting property,
the work manner will switch to general PIO mode, thus there will
not be any failure case in this function. It's actually a procedure.
So changing the return type from int to void.

Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 6a4d44d..30a62cd 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1534,7 +1534,7 @@ static void atmel_tasklet_func(unsigned long data)
 	spin_unlock(&port->lock);
 }
 
-static int atmel_init_property(struct atmel_uart_port *atmel_port,
+static void atmel_init_property(struct atmel_uart_port *atmel_port,
 				struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1575,7 +1575,6 @@ static int atmel_init_property(struct atmel_uart_port *atmel_port,
 		atmel_port->use_dma_tx  = false;
 	}
 
-	return 0;
 }
 
 static void atmel_init_rs485(struct uart_port *port,
@@ -2235,8 +2234,8 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	struct uart_port *port = &atmel_port->uart;
 	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
 
-	if (!atmel_init_property(atmel_port, pdev))
-		atmel_set_ops(port);
+	atmel_init_property(atmel_port, pdev);
+	atmel_set_ops(port);
 
 	atmel_init_rs485(port, pdev);
 
-- 
1.7.9.5
