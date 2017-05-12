From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] serial: altera_jtaguart: adding iounmap()
Date: Sat, 13 May 2017 00:36:22 +0300
Message-ID: <1494624982-3245-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

The driver does ioremap(port->mapbase, ALTERA_JTAGUART_SIZE),
but there is no any iounmap().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/tty/serial/altera_jtaguart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 18e3f8342b85..0475f5d261ce 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -478,6 +478,7 @@ static int altera_jtaguart_remove(struct platform_device *pdev)
 
 	port = &altera_jtaguart_ports[i].port;
 	uart_remove_one_port(&altera_jtaguart_driver, port);
+	iounmap(port->membase);
 
 	return 0;
 }
-- 
2.7.4
