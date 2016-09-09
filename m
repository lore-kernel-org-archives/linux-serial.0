From: Rob Herring <robh@kernel.org>
Subject: [PATCH 9/9] tty: serial_core: add tty NULL check in uart_port_startup
Date: Fri,  9 Sep 2016 17:37:10 -0500
Message-ID: <20160909223711.26238-10-robh@kernel.org>
References: <20160909223711.26238-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

If we don't have a tty when calling uart_port_startup, skip the baudrate
and modem control setup which depend on tty->termios struct. Either
tty_port clients will configure the line in a separate call or we'll
move termios into the tty_port.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b9ec9fd688a2..2c3b187d517b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -199,7 +199,7 @@ static int uart_port_startup(struct tty_port *port, int init_hw)
 	}
 
 	retval = uport->ops->startup(uport);
-	if (retval == 0) {
+	if (retval == 0 && tty) {
 		if (uart_console(uport) && uport->cons->cflag) {
 			tty->termios.c_cflag = uport->cons->cflag;
 			uport->cons->cflag = 0;
-- 
2.9.3
