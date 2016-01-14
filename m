From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v7 11/15] tty: serial: 8250: Remove SERIAL_DEBUG_PNP macro
Date: Thu, 14 Jan 2016 16:08:20 +0100
Message-ID: <1452784104-30840-12-git-send-email-anton.wuerfel@fau.de>
References: <1452784104-30840-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452784104-30840-1-git-send-email-anton.wuerfel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Joachim Eastwood <manabian@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phillip Raffeck <phillip.raffeck@fau.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hung <hpeter@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, =?UTF-8?q?Anton=20W=C3=BCrfel?= <anton.wuerfel@fau.de>
List-Id: linux-serial@vger.kernel.org

=46rom: Phillip Raffeck <phillip.raffeck@fau.de>

This patch removes the macro SERIAL_DEBUG_PNP, which is used to enable
debugging at compile time.
As SERIAL_DEBUG_PNP is an orphan, the corresponding #ifdef is removed.
To keep the ability to enable debugging at compile time,
the call to printk(KERN_DEBUG ...) is replaced by a corresponding
call to dev_dbg(), which is configurable via CONFIG_DYNAMIC_DEBUG.

Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_pnp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/82=
50/8250_pnp.c
index 00846a7..0c32c59 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -464,11 +464,11 @@ serial_pnp_probe(struct pnp_dev *dev, const struc=
t pnp_device_id *dev_id)
 	} else
 		return -ENODEV;
=20
-#ifdef SERIAL_DEBUG_PNP
-	printk(KERN_DEBUG
-		"Setup PNP port: port %x, mem 0x%lx, irq %d, type %d\n",
-		       uart.port.iobase, uart.port.mapbase, uart.port.irq, uart.port=
=2Eiotype);
-#endif
+	dev_dbg(&dev->dev,
+		 "Setup PNP port: port %x, mem 0x%lx, irq %d, type %d\n",
+		 uart.port.iobase, uart.port.mapbase,
+		 uart.port.irq, uart.port.iotype);
+
 	if (flags & CIR_PORT) {
 		uart.port.flags |=3D UPF_FIXED_PORT | UPF_FIXED_TYPE;
 		uart.port.type =3D PORT_8250_CIR;
--=20
1.9.1
