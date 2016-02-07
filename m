From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH] tty: serial: meson: Implement earlycon support
Date: Sun,  7 Feb 2016 21:57:15 +0100
Message-ID: <1454878635-24396-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Carlo Caione <carlo@caione.org>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Reuse the existing console write implementation for implementing
DT-based and command-line-based earlycon support.

Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
 Documentation/kernel-parameters.txt |  6 ++++++
 drivers/tty/serial/meson_uart.c     | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel=
-parameters.txt
index 602065c..90801ac 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1030,6 +1030,12 @@ Such letter suffixes can also be entirely omitte=
d.
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
index b12a37b..6f89567 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -548,6 +548,19 @@ static int __init meson_serial_console_init(void)
 }
 console_initcall(meson_serial_console_init);
=20
+static int __init
+meson_serial_early_console_setup(struct earlycon_device *device, const=
 char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write =3D meson_serial_console_write;
+	return 0;
+}
+EARLYCON_DECLARE(meson_serial, meson_serial_early_console_setup);
+OF_EARLYCON_DECLARE(meson_serial, "amlogic,meson-uart",
+		    meson_serial_early_console_setup);
+
 #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
 #else
 #define MESON_SERIAL_CONSOLE	NULL
--=20
2.6.2

