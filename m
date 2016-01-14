From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v7 12/15] tty: serial: 8250: Correct conversion specifiers
Date: Thu, 14 Jan 2016 16:08:21 +0100
Message-ID: <1452784104-30840-13-git-send-email-anton.wuerfel@fau.de>
References: <1452784104-30840-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452784104-30840-1-git-send-email-anton.wuerfel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Joachim Eastwood <manabian@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phillip Raffeck <phillip.raffeck@fau.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hung <hpeter@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Anton Wuerfel <anton.wuerfel@fau.de>
List-Id: linux-serial@vger.kernel.org

This patch fixes compiler warnings about wrong conversion specifiers us=
ed
in a debug output in 8250_pnp.c. The precise warning is:

drivers/tty/serial/8250/8250_pnp.c: In function =E2=80=98serial_pnp_pro=
be=E2=80=99:
include/linux/dynamic_debug.h:64:16: warning: format =E2=80=98%x=E2=80=99=
 expects argument
of [...]

drivers/tty/serial/8250/8250_pnp.c:467:2: note: in expansion of macro
=E2=80=98dev_dbg=E2=80=99
  dev_dbg(&dev->dev,
  ^
include/linux/dynamic_debug.h:64:16: warning: format =E2=80=98%lx=E2=80=
=99 expects argument
of [...]

drivers/tty/serial/8250/8250_pnp.c:467:2: note: in expansion of macro
=E2=80=98dev_dbg=E2=80=99
  dev_dbg(&dev->dev,
  ^

Those warnings never got triggered, because the command was nested
in an #ifdef, which is removed by a patch of this series.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_pnp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/82=
50/8250_pnp.c
index 0c32c59..b2d163c 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -465,8 +465,8 @@ serial_pnp_probe(struct pnp_dev *dev, const struct =
pnp_device_id *dev_id)
 		return -ENODEV;
=20
 	dev_dbg(&dev->dev,
-		 "Setup PNP port: port %x, mem 0x%lx, irq %d, type %d\n",
-		 uart.port.iobase, uart.port.mapbase,
+		 "Setup PNP port: port %lx, mem %pa, irq %d, type %d\n",
+		 uart.port.iobase, &uart.port.mapbase,
 		 uart.port.irq, uart.port.iotype);
=20
 	if (flags & CIR_PORT) {
--=20
1.9.1
