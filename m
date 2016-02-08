From: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
Subject: [PATCH] tty: serial: meson: Add earlycon support
Date: Mon,  8 Feb 2016 01:38:53 +0000
Message-ID: <1454895533-7219-1-git-send-email-nicolassaenzj@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, jslaby@suse.com, gregkh@linuxfoundation.org, corbet@lwn.net
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
---
 Documentation/kernel-parameters.txt |  6 ++++++
 drivers/tty/serial/meson_uart.c     | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 551ecf0..1661af4 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1025,6 +1025,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			the driver will use only 32-bit accessors to read/write
 			the device registers.
 
+		meson,<addr>
+			Start an early, polled-mode console on an meson serial
+			port at the specified address. The serial port
+			must already be setup and configured. Options are not
+			yet supported.
+
 		msm_serial,<addr>
 			Start an early, polled-mode console on an msm serial
 			port at the specified address. The serial port
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index b12a37b..f6ff2fa 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -548,6 +548,28 @@ static int __init meson_serial_console_init(void)
 }
 console_initcall(meson_serial_console_init);
 
+static void meson_early_console_write(struct console *con, const char *s,
+				      unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, meson_console_putchar);
+}
+
+static int __init meson_early_console_setup(struct earlycon_device *device,
+					    const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = meson_early_console_write;
+	return 0;
+}
+
+EARLYCON_DECLARE(meson, meson_early_console_setup);
+OF_EARLYCON_DECLARE(meson, "amlogic,meson-uart",
+		    meson_early_console_setup);
+
 #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
 #else
 #define MESON_SERIAL_CONSOLE	NULL
-- 
2.5.0

