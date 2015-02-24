From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 05/13] serial: 8250_early: Remove early_device variable
Date: Tue, 24 Feb 2015 11:37:02 -0500
Message-ID: <1424795830-31223-6-git-send-email-peter@hurleysoftware.com>
References: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

early_device was only required for serial8250_find_port_for_earlycon(),
which was replaced by extensible console matching.

Fixup early_serial8250_write() to get the earlycon_device * from
console->data (which is initialized by {of_}setup_earlycon()).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_early.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 49bca65..d7b831b 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -36,8 +36,6 @@
 #include <asm/io.h>
 #include <asm/serial.h>
 
-static struct earlycon_device *early_device;
-
 unsigned int __weak __init serial8250_early_in(struct uart_port *port, int offset)
 {
 	switch (port->iotype) {
@@ -90,7 +88,8 @@ static void __init serial_putc(struct uart_port *port, int c)
 static void __init early_serial8250_write(struct console *console,
 					const char *s, unsigned int count)
 {
-	struct uart_port *port = &early_device->port;
+	struct earlycon_device *device = console->data;
+	struct uart_port *port = &device->port;
 	unsigned int ier;
 
 	/* Save the IER and disable interrupts preserving the UUE bit */
@@ -157,7 +156,6 @@ static int __init early_serial8250_setup(struct earlycon_device *device,
 
 	init_port(device);
 
-	early_device = device;
 	device->con->write = early_serial8250_write;
 	return 0;
 }
-- 
2.3.0
