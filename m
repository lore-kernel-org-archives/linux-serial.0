From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] serial: uartps: Do not allow use aliases >= MAX_UART_INSTANCES
Date: Mon,  8 Oct 2018 14:17:19 +0200
Message-ID: <01aec25ae2cee7857d92140e98fde1da28393937.1539001037.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, geert@linux-m68k.org, gregkh@linuxfoundation.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Aliases >= MAX_UART_INSTANCES is no problem to find out and use but in
error path is necessary skip clearing bits in bitmap to ensure that only
bits in allocated bitmap are handled and nothing beyond that.
Without this patch when for example serial90 alias is used then in error
patch bit 90 is clear in 32bit wide bitmap.

Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Based on tty-next tree.

---
 drivers/tty/serial/xilinx_uartps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e82d1d56399f..29a18103182d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1673,7 +1673,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 err_out_id:
 	mutex_lock(&bitmap_lock);
-	clear_bit(cdns_uart_data->id, bitmap);
+	if (cdns_uart_data->id < MAX_UART_INSTANCES)
+		clear_bit(cdns_uart_data->id, bitmap);
 	mutex_unlock(&bitmap_lock);
 	return rc;
 }
@@ -1698,7 +1699,8 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
 	mutex_lock(&bitmap_lock);
-	clear_bit(cdns_uart_data->id, bitmap);
+	if (cdns_uart_data->id < MAX_UART_INSTANCES)
+		clear_bit(cdns_uart_data->id, bitmap);
 	mutex_unlock(&bitmap_lock);
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
-- 
1.9.1
