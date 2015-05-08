From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] serial: of_serial: do not set port.type twice
Date: Fri,  8 May 2015 13:03:13 +0900
Message-ID: <1431057793-4025-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The port.type has already been set by of_platform_serial_setup()
called from a few lines above.
Setting it to the same value is redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/of_serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 137381e..28b9b47 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -188,7 +188,6 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	{
 		struct uart_8250_port port8250;
 		memset(&port8250, 0, sizeof(port8250));
-		port.type = port_type;
 		port8250.port = port;
 
 		if (port.fifosize)
-- 
1.9.1
