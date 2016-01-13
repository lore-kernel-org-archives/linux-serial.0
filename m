From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v6 15/15] tty: serial: 8250: Add generic port init macro
Date: Wed, 13 Jan 2016 22:29:21 +0100
Message-ID: <1452720561-28443-16-git-send-email-anton.wuerfel@fau.de>
References: <1452720561-28443-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452720561-28443-1-git-send-email-anton.wuerfel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Joachim Eastwood <manabian@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phillip Raffeck <phillip.raffeck@fau.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hung <hpeter@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Anton Wuerfel <anton.wuerfel@fau.de>
List-Id: linux-serial@vger.kernel.org

This patch removes redundant 8250 port initialization macros and
replaces them by a single generic base-macro, which is specialized
as needed.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250.h               | 12 ++++++++
 drivers/tty/serial/8250/8250_accent.c        | 13 ++-------
 drivers/tty/serial/8250/8250_boca.c          | 41 ++++++++++++--------=
--------
 drivers/tty/serial/8250/8250_exar_st16c554.c | 17 ++++--------
 drivers/tty/serial/8250/8250_fourport.c      | 28 ++++++++-----------
 5 files changed, 49 insertions(+), 62 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8=
250.h
index d54dcd8..4672ab4 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -92,6 +92,18 @@ struct serial8250_config {
 #define SERIAL8250_SHARE_IRQS 0
 #endif
=20
+#define SERIAL8250_PORT_FLAGS(_base, _irq, _flags)		\
+	{							\
+		.iobase		=3D _base,			\
+		.irq		=3D _irq,				\
+		.uartclk	=3D 1843200,			\
+		.iotype		=3D UPIO_PORT,			\
+		.flags		=3D UPF_BOOT_AUTOCONF | (_flags),	\
+	}
+
+#define SERIAL8250_PORT(_base, _irq) SERIAL8250_PORT_FLAGS(_base, _irq=
, 0)
+
+
 static inline int serial_in(struct uart_8250_port *up, int offset)
 {
 	return up->port.serial_in(&up->port, offset);
diff --git a/drivers/tty/serial/8250/8250_accent.c b/drivers/tty/serial=
/8250/8250_accent.c
index 34b51c6..522aeae 100644
--- a/drivers/tty/serial/8250/8250_accent.c
+++ b/drivers/tty/serial/8250/8250_accent.c
@@ -10,18 +10,11 @@
 #include <linux/init.h>
 #include <linux/serial_8250.h>
=20
-#define PORT(_base,_irq)				\
-	{						\
-		.iobase		=3D _base,		\
-		.irq		=3D _irq,			\
-		.uartclk	=3D 1843200,		\
-		.iotype		=3D UPIO_PORT,		\
-		.flags		=3D UPF_BOOT_AUTOCONF,	\
-	}
+#include "8250.h"
=20
 static struct plat_serial8250_port accent_data[] =3D {
-	PORT(0x330, 4),
-	PORT(0x338, 4),
+	SERIAL8250_PORT(0x330, 4),
+	SERIAL8250_PORT(0x338, 4),
 	{ },
 };
=20
diff --git a/drivers/tty/serial/8250/8250_boca.c b/drivers/tty/serial/8=
250/8250_boca.c
index d125dc1..a63b599 100644
--- a/drivers/tty/serial/8250/8250_boca.c
+++ b/drivers/tty/serial/8250/8250_boca.c
@@ -10,32 +10,25 @@
 #include <linux/init.h>
 #include <linux/serial_8250.h>
=20
-#define PORT(_base,_irq)				\
-	{						\
-		.iobase		=3D _base,		\
-		.irq		=3D _irq,			\
-		.uartclk	=3D 1843200,		\
-		.iotype		=3D UPIO_PORT,		\
-		.flags		=3D UPF_BOOT_AUTOCONF,	\
-	}
+#include "8250.h"
=20
 static struct plat_serial8250_port boca_data[] =3D {
-	PORT(0x100, 12),
-	PORT(0x108, 12),
-	PORT(0x110, 12),
-	PORT(0x118, 12),
-	PORT(0x120, 12),
-	PORT(0x128, 12),
-	PORT(0x130, 12),
-	PORT(0x138, 12),
-	PORT(0x140, 12),
-	PORT(0x148, 12),
-	PORT(0x150, 12),
-	PORT(0x158, 12),
-	PORT(0x160, 12),
-	PORT(0x168, 12),
-	PORT(0x170, 12),
-	PORT(0x178, 12),
+	SERIAL8250_PORT(0x100, 12),
+	SERIAL8250_PORT(0x108, 12),
+	SERIAL8250_PORT(0x110, 12),
+	SERIAL8250_PORT(0x118, 12),
+	SERIAL8250_PORT(0x120, 12),
+	SERIAL8250_PORT(0x128, 12),
+	SERIAL8250_PORT(0x130, 12),
+	SERIAL8250_PORT(0x138, 12),
+	SERIAL8250_PORT(0x140, 12),
+	SERIAL8250_PORT(0x148, 12),
+	SERIAL8250_PORT(0x150, 12),
+	SERIAL8250_PORT(0x158, 12),
+	SERIAL8250_PORT(0x160, 12),
+	SERIAL8250_PORT(0x168, 12),
+	SERIAL8250_PORT(0x170, 12),
+	SERIAL8250_PORT(0x178, 12),
 	{ },
 };
=20
diff --git a/drivers/tty/serial/8250/8250_exar_st16c554.c b/drivers/tty=
/serial/8250/8250_exar_st16c554.c
index bf53aab..3a7cb82 100644
--- a/drivers/tty/serial/8250/8250_exar_st16c554.c
+++ b/drivers/tty/serial/8250/8250_exar_st16c554.c
@@ -13,20 +13,13 @@
 #include <linux/init.h>
 #include <linux/serial_8250.h>
=20
-#define PORT(_base,_irq)				\
-	{						\
-		.iobase		=3D _base,		\
-		.irq		=3D _irq,			\
-		.uartclk	=3D 1843200,		\
-		.iotype		=3D UPIO_PORT,		\
-		.flags		=3D UPF_BOOT_AUTOCONF,	\
-	}
+#include "8250.h"
=20
 static struct plat_serial8250_port exar_data[] =3D {
-	PORT(0x100, 5),
-	PORT(0x108, 5),
-	PORT(0x110, 5),
-	PORT(0x118, 5),
+	SERIAL8250_PORT(0x100, 5),
+	SERIAL8250_PORT(0x108, 5),
+	SERIAL8250_PORT(0x110, 5),
+	SERIAL8250_PORT(0x118, 5),
 	{ },
 };
=20
diff --git a/drivers/tty/serial/8250/8250_fourport.c b/drivers/tty/seri=
al/8250/8250_fourport.c
index be15826..4045180 100644
--- a/drivers/tty/serial/8250/8250_fourport.c
+++ b/drivers/tty/serial/8250/8250_fourport.c
@@ -10,24 +10,20 @@
 #include <linux/init.h>
 #include <linux/serial_8250.h>
=20
-#define PORT(_base,_irq)						\
-	{								\
-		.iobase		=3D _base,				\
-		.irq		=3D _irq,					\
-		.uartclk	=3D 1843200,				\
-		.iotype		=3D UPIO_PORT,				\
-		.flags		=3D UPF_BOOT_AUTOCONF | UPF_FOURPORT,	\
-	}
+#include "8250.h"
+
+#define SERIAL8250_FOURPORT(_base, _irq) \
+	SERIAL8250_PORT_FLAGS(_base, _irq, UPF_FOURPORT)
=20
 static struct plat_serial8250_port fourport_data[] =3D {
-	PORT(0x1a0, 9),
-	PORT(0x1a8, 9),
-	PORT(0x1b0, 9),
-	PORT(0x1b8, 9),
-	PORT(0x2a0, 5),
-	PORT(0x2a8, 5),
-	PORT(0x2b0, 5),
-	PORT(0x2b8, 5),
+	SERIAL8250_FOURPORT(0x1a0, 9),
+	SERIAL8250_FOURPORT(0x1a8, 9),
+	SERIAL8250_FOURPORT(0x1b0, 9),
+	SERIAL8250_FOURPORT(0x1b8, 9),
+	SERIAL8250_FOURPORT(0x2a0, 5),
+	SERIAL8250_FOURPORT(0x2a8, 5),
+	SERIAL8250_FOURPORT(0x2b0, 5),
+	SERIAL8250_FOURPORT(0x2b8, 5),
 	{ },
 };
=20
--=20
1.9.1
