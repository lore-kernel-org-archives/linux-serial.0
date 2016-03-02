From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v3] tty: serial: meson: Implement earlycon support
Date: Wed,  2 Mar 2016 03:49:09 +0100
Message-ID: <1456886949-26503-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-meson@googlegroups.com
Cc: Peter Hurley <peter@hurleysoftware.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Nicolas Saenz Julienne <nicolassaenzj@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Carlo Caione <carlo@caione.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "moderated list:ARM/Amlogic Meson
	SoC support" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Split off the bulk of the existing meson_serial_console_write()
implementation into meson_serial_port_write() for implementing
meson_serial_early_console_write().

Use "meson" as the earlycon driver name, courtesy of Nicolas.

Signed-off-by: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
 v2 -> v3:
 * Rename from "meson_serial" to just "meson" (Nicolas)
=20
 v1 -> v2:
 * Implement meson_serial_early_console_write() instead of reusing
   meson_serial_console_write() (Peter)
=20
 Documentation/kernel-parameters.txt |  6 ++++++
 drivers/tty/serial/meson_uart.c     | 42 +++++++++++++++++++++++++++++=
+-------
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel=
-parameters.txt
index e0a21e4556a6..a7c1377fd80f 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1039,6 +1039,12 @@ bytes respectively. Such letter suffixes can als=
o be entirely omitted.
 			the driver will use only 32-bit accessors to read/write
 			the device registers.
=20
+		meson,<addr>
+			Start an early, polled-mode console on a meson serial
+			port at the specified address. The serial port must
+			already be setup and configured. Options are not yet
+			supported.
+
 		msm_serial,<addr>
 			Start an early, polled-mode console on an msm serial
 			port at the specified address. The serial port
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson=
_uart.c
index 024445aa0521..6aea0f4a9165 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -481,18 +481,13 @@ static void meson_console_putchar(struct uart_por=
t *port, int ch)
 	writel(ch, port->membase + AML_UART_WFIFO);
 }
=20
-static void meson_serial_console_write(struct console *co, const char =
*s,
-				       u_int count)
+static void meson_serial_port_write(struct uart_port *port, const char=
 *s,
+				    u_int count)
 {
-	struct uart_port *port;
 	unsigned long flags;
 	int locked;
 	u32 val, tmp;
=20
-	port =3D meson_ports[co->index];
-	if (!port)
-		return;
-
 	local_irq_save(flags);
 	if (port->sysrq) {
 		locked =3D 0;
@@ -516,6 +511,18 @@ static void meson_serial_console_write(struct cons=
ole *co, const char *s,
 	local_irq_restore(flags);
 }
=20
+static void meson_serial_console_write(struct console *co, const char =
*s,
+				       u_int count)
+{
+	struct uart_port *port;
+
+	port =3D meson_ports[co->index];
+	if (!port)
+		return;
+
+	meson_serial_port_write(port, s, count);
+}
+
 static int meson_serial_console_setup(struct console *co, char *option=
s)
 {
 	struct uart_port *port;
@@ -554,6 +561,27 @@ static int __init meson_serial_console_init(void)
 }
 console_initcall(meson_serial_console_init);
=20
+static void meson_serial_early_console_write(struct console *co,
+					     const char *s,
+					     u_int count)
+{
+	struct earlycon_device *dev =3D co->data;
+
+	meson_serial_port_write(&dev->port, s, count);
+}
+
+static int __init
+meson_serial_early_console_setup(struct earlycon_device *device, const=
 char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write =3D meson_serial_early_console_write;
+	return 0;
+}
+OF_EARLYCON_DECLARE(meson, "amlogic,meson-uart",
+		    meson_serial_early_console_setup);
+
 #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
 #else
 #define MESON_SERIAL_CONSOLE	NULL
--=20
2.6.2

