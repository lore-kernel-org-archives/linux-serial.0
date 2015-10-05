From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH] serial: atmel: fix compiler warning on address cast
Date: Mon,  5 Oct 2015 18:00:52 +0100
Message-ID: <1444064452-12285-1-git-send-email-andre.przywara@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Turning on KVM and LPAE support on top of a multi_v7_defconfig will
produce a compiler warning in the Atmel serial driver:
drivers/tty/serial/atmel_serial.c: In function 'atmel_verify_port':
drivers/tty/serial/atmel_serial.c:2299:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  if ((void *)port->mapbase != ser->iomem_base)
      ^

Fix that by using the cast on the right hand side instead, as similar
code already does in other drivers.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/atmel_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index cd30a45..28039ce 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2296,7 +2296,7 @@ static int atmel_verify_port(struct uart_port *port, struct serial_struct *ser)
 		ret = -EINVAL;
 	if (port->uartclk / 16 != ser->baud_base)
 		ret = -EINVAL;
-	if ((void *)port->mapbase != ser->iomem_base)
+	if (port->mapbase != (unsigned long)ser->iomem_base)
 		ret = -EINVAL;
 	if (port->iobase != ser->port)
 		ret = -EINVAL;
-- 
2.5.1
