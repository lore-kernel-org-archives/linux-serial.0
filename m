From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] drivers: tty: serial: amba-pl011: use generic ops request/release port
Date: Mon, 29 Jul 2019 16:44:05 +0200
Message-ID: <1564411445-26933-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Reduce boilerplate by using generic implementation of the trivial
request_port/release_port operations. For that to work, we have to
set the mapsize field accordingly.
---
 drivers/tty/serial/amba-pl011.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5921a33..6b7c3c7 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2094,30 +2094,13 @@ static const char *pl011_type(struct uart_port *port)
 }
 
 /*
- * Release the memory region(s) being used by 'port'
- */
-static void pl011_release_port(struct uart_port *port)
-{
-	release_mem_region(port->mapbase, SZ_4K);
-}
-
-/*
- * Request the memory region(s) being used by 'port'
- */
-static int pl011_request_port(struct uart_port *port)
-{
-	return request_mem_region(port->mapbase, SZ_4K, "uart-pl011")
-			!= NULL ? 0 : -EBUSY;
-}
-
-/*
  * Configure/autoconfigure the port.
  */
 static void pl011_config_port(struct uart_port *port, int flags)
 {
 	if (flags & UART_CONFIG_TYPE) {
 		port->type = PORT_AMBA;
-		pl011_request_port(port);
+		uart_defops_request_port(port);
 	}
 }
 
@@ -2150,8 +2133,8 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 	.flush_buffer	= pl011_dma_flush_buffer,
 	.set_termios	= pl011_set_termios,
 	.type		= pl011_type,
-	.release_port	= pl011_release_port,
-	.request_port	= pl011_request_port,
+	.release_port	= uart_defops_release_port,
+	.request_port	= uart_defops_request_port,
 	.config_port	= pl011_config_port,
 	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
@@ -2181,8 +2164,8 @@ static unsigned int sbsa_uart_get_mctrl(struct uart_port *port)
 	.shutdown	= sbsa_uart_shutdown,
 	.set_termios	= sbsa_uart_set_termios,
 	.type		= pl011_type,
-	.release_port	= pl011_release_port,
-	.request_port	= pl011_request_port,
+	.release_port	= uart_defops_release_port,
+	.request_port	= uart_defops_request_port,
 	.config_port	= pl011_config_port,
 	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
@@ -2584,6 +2567,7 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
 	uap->port.dev = dev;
 	uap->port.mapbase = mmiobase->start;
 	uap->port.membase = base;
+	uap->port.mapsize = SZ_4K;
 	uap->port.fifosize = uap->fifosize;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = index;
-- 
1.9.1
