From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH] serial: altera-juart: fix NULL device in log message
Date: Tue, 16 Dec 2014 15:27:46 +0800
Message-ID: <1418714866-2744-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org
List-Id: linux-serial@vger.kernel.org

Add device pointer to port->dev.

Before:

"(NULL device *): ttyJ0 at MMIO 0x1008 (irq = 2, base_baud = 0) is a
Altera JTAG UART"

After:
"altera_jtaguart 1008.serial: ttyJ0 at MMIO 0x1008 (irq = 2, base_baud = 0) is a
Altera JTAG UART"

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/tty/serial/altera_jtaguart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 192d043..0fefdd8 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -441,6 +441,7 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	port->iotype = SERIAL_IO_MEM;
 	port->ops = &altera_jtaguart_ops;
 	port->flags = UPF_BOOT_AUTOCONF;
+	port->dev = &pdev->dev;
 
 	uart_add_one_port(&altera_jtaguart_driver, port);
 
-- 
1.8.2.1
