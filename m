From: Leilei Zhao <leilei.zhao@atmel.com>
Subject: [PATCH v2 5/5] tty/serial: at91: correct the usage of tasklet
Date: Fri, 27 Feb 2015 16:07:18 +0800
Message-ID: <1425024438-31355-6-git-send-email-leilei.zhao@atmel.com>
References: <1425024438-31355-1-git-send-email-leilei.zhao@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425024438-31355-1-git-send-email-leilei.zhao@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, jslaby@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Leilei Zhao <leilei.zhao@atmel.com>
List-Id: linux-serial@vger.kernel.org

The tasklet may be scheduled and executed after serial port
was shutdown, for example, DMA rx callback will schedule the
tasklet while serial port is shutting down, especially serial
port is sending and receiving data in a higher baud rate and
it's killed by external program. In this case, tasklet_kill
can only clear the current scheduling out, so tasklet should
be disabled to prevent being executed in later scheduling.
Otherwise, the tasklet executed after serial port was shutdown
can lead to kernel crash.

Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 777c196..c93e0fd 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1755,6 +1755,8 @@ static int atmel_startup(struct uart_port *port)
 	if (retval)
 		goto free_irq;
 
+	tasklet_enable(&atmel_port->tasklet);
+
 	/*
 	 * Initialize DMA (if necessary)
 	 */
@@ -1858,6 +1860,7 @@ static void atmel_shutdown(struct uart_port *port)
 	 * Clear out any scheduled tasklets before
 	 * we destroy the buffers
 	 */
+	tasklet_disable(&atmel_port->tasklet);
 	tasklet_kill(&atmel_port->tasklet);
 
 	/*
@@ -2251,6 +2254,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 
 	tasklet_init(&atmel_port->tasklet, atmel_tasklet_func,
 			(unsigned long)port);
+	tasklet_disable(&atmel_port->tasklet);
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
 
-- 
1.7.9.5
