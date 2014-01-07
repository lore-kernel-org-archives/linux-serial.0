From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 2/4] tty/serial: at91: fix race condition in atmel_serial_remove
Date: Tue, 7 Jan 2014 11:45:07 +0100
Message-ID: <671825c81b51d19b435fca8c9cc54b6fbbf51f31.1389090437.git.nicolas.ferre@atmel.com>
References: <cover.1389090437.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <cover.1389090437.git.nicolas.ferre@atmel.com>
Sender: stable-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Leilei Zhao <leilei.zhao@atmel.com>, mark.roszko@gmail.com, mdeneen@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, stable@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-serial@vger.kernel.org

From: Marek Roszko <mark.roszko@gmail.com>

The _remove callback could be called when a tasklet is scheduled. tasklet_kill
was called inside the function in order to free up any scheduled tasklets.
However it was called after uart_remove_one_port which destroys tty references
needed in the port for atmel_tasklet_func.
Simply putting the tasklet_kill at the start of the function will prevent this
conflict.

Signed-off-by: Marek Roszko <mark.roszko@gmail.com>
Acked-by: Leilei Zhao <leilei.zhao@atmel.com>
Cc: <stable@vger.kernel.org> # v3.12
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 48ea47a32d5f..c421d11b3d4c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2447,11 +2447,12 @@ static int atmel_serial_remove(struct platform_device *pdev)
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	int ret = 0;
 
+	tasklet_kill(&atmel_port->tasklet);
+
 	device_init_wakeup(&pdev->dev, 0);
 
 	ret = uart_remove_one_port(&atmel_uart, port);
 
-	tasklet_kill(&atmel_port->tasklet);
 	kfree(atmel_port->rx_ring.buf);
 
 	/* "port" is allocated statically, so we shouldn't free it */
-- 
1.8.2.2
