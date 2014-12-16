From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH] serial: altera-uart: fix NULL device in log message
Date: Tue, 16 Dec 2014 15:28:34 +0800
Message-ID: <1418714914-2836-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org
List-Id: linux-serial@vger.kernel.org

Add device pointer to port->dev.

Before:

"(NULL device *): ttyAL0 at MMIO 0x2020 (irq = 6, base_baud = 3125000)
is a Altera UART"

After:
"altera_uart 2020.serial: ttyAL0 at MMIO 0x2020 (irq = 6, base_baud = 3125000)
is a Altera UART"

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/tty/serial/altera_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index eb15a50..b2859fe 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -589,6 +589,7 @@ static int altera_uart_probe(struct platform_device *pdev)
 	port->iotype = SERIAL_IO_MEM;
 	port->ops = &altera_uart_ops;
 	port->flags = UPF_BOOT_AUTOCONF;
+	port->dev = &pdev->dev;
 
 	platform_set_drvdata(pdev, port);
 
-- 
1.8.2.1
