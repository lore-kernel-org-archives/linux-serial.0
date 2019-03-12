From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 6/8] drivers: tty: serial: vt8500: use memres
Date: Tue, 12 Mar 2019 15:57:38 +0100
Message-ID: <1552402660-31730-7-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

---
 drivers/tty/serial/vt8500_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 3d58e9b..331a9dd 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -696,13 +696,13 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 				      );
 	vt8500_port->uart.type = PORT_VT8500;
 	vt8500_port->uart.iotype = UPIO_MEM;
-	vt8500_port->uart.mapbase = mmres->start;
 	vt8500_port->uart.irq = irqres->start;
 	vt8500_port->uart.fifosize = 16;
 	vt8500_port->uart.ops = &vt8500_uart_pops;
 	vt8500_port->uart.line = port;
 	vt8500_port->uart.dev = &pdev->dev;
 	vt8500_port->uart.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
+	uart_memres_set(&vt8500_port->uart, *mmres);
 
 	/* Serial core uses the magic "16" everywhere - adjust for it */
 	vt8500_port->uart.uartclk = 16 * clk_get_rate(vt8500_port->clk) /
-- 
1.9.1
