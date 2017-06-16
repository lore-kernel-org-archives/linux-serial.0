From: Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v2] serial: Delete dead code for CIR serial ports
Date: Fri, 16 Jun 2017 17:17:14 +0200
Message-ID: <20170616151714.30835-1-mbrugger@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: andriy.shevchenko@linux.intel.com, ed.blake@imgtec.com, vigneshr@ti.com, alexander.sverdlin@nokia.com, yegorslists@googlemail.com, mbrugger@suse.com, dhowells@redhat.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Commit e4fda3a04275 ("serial: don't register CIR serial ports") adds a
check for PORT_8250_CIR to serial8250_register_8250_port(). But the code
isn't needed as the function never takes the branch when the port is CIR
serial port.

This patch deletes the dead code.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/tty/serial/8250/8250_core.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 1aab3010fbfa..b5def356af63 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1043,24 +1043,13 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		if (up->dl_write)
 			uart->dl_write = up->dl_write;
 
-		if (uart->port.type != PORT_8250_CIR) {
-			if (serial8250_isa_config != NULL)
-				serial8250_isa_config(0, &uart->port,
-						&uart->capabilities);
-
-			ret = uart_add_one_port(&serial8250_reg,
-						&uart->port);
-			if (ret == 0)
-				ret = uart->port.line;
-		} else {
-			dev_info(uart->port.dev,
-				"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
-				uart->port.iobase,
-				(unsigned long long)uart->port.mapbase,
-				uart->port.irq);
+		if (serial8250_isa_config != NULL)
+			serial8250_isa_config(0, &uart->port,
+					&uart->capabilities);
 
-			ret = 0;
-		}
+		ret = uart_add_one_port(&serial8250_reg, &uart->port);
+		if (ret == 0)
+			ret = uart->port.line;
 	}
 	mutex_unlock(&serial_mutex);
 
-- 
2.12.3
