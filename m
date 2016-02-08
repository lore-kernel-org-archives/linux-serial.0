From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2] tty: serial: meson: Implement earlycon support
Date: Mon,  8 Feb 2016 13:04:03 +0100
Message-ID: <1454933043-15351-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-meson@googlegroups.com
Cc: Carlo Caione <carlo@caione.org>, linux-arm-kernel@lists.infradead.org, Matthias Brugger <mbrugger@suse.com>, Nicolas Saenz <nicolassaenzj@gmail.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Split off the bulk of the existing meson_serial_console_write()
implementation into meson_serial_port_write() for implementing
meson_serial_early_console_write().

Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
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
index 59e15150a9d8..237f0ee20afb 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1025,6 +1025,12 @@ bytes respectively. Such letter suffixes can als=
o be entirely omitted.
 			the driver will use only 32-bit accessors to read/write
 			the device registers.
=20
+		meson_serial,<addr>
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
index b12a37bd37b6..9efcfa2de31e 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -475,18 +475,13 @@ static void meson_console_putchar(struct uart_por=
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
@@ -510,6 +505,18 @@ static void meson_serial_console_write(struct cons=
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
@@ -548,6 +555,27 @@ static int __init meson_serial_console_init(void)
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
+OF_EARLYCON_DECLARE(meson_serial, "amlogic,meson-uart",
+		    meson_serial_early_console_setup);
+
 #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
 #else
 #define MESON_SERIAL_CONSOLE	NULL
--=20
2.6.2

