From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v6 05/15] tty: serial: 8250: Remove else after return
Date: Wed, 13 Jan 2016 22:29:11 +0100
Message-ID: <1452720561-28443-6-git-send-email-anton.wuerfel@fau.de>
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

This patch fixes checkpatch warnings about unnecessary else blocks afte=
r
return statements.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
index 534ca18..8543719 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -805,10 +805,10 @@ static int pci_netmos_9900_numports(struct pci_de=
v *dev)
=20
 	pi =3D (c & 0xff);
=20
-	if (pi =3D=3D 2) {
+	if (pi =3D=3D 2)
 		return 1;
-	} else if ((pi =3D=3D 0) &&
-			   (dev->device =3D=3D PCI_DEVICE_ID_NETMOS_9900)) {
+
+	if ((pi =3D=3D 0) && (dev->device =3D=3D PCI_DEVICE_ID_NETMOS_9900)) =
{
 		/* two possibilities: 0x30ps encodes number of parallel and
 		 * serial ports, or 0x1000 indicates *something*. This is not
 		 * immediately obvious, since the 2s1p+4s configuration seems
@@ -816,12 +816,12 @@ static int pci_netmos_9900_numports(struct pci_de=
v *dev)
 		 * advertising the same function 3 as the 4s+2s1p config.
 		 */
 		sub_serports =3D dev->subsystem_device & 0xf;
-		if (sub_serports > 0) {
+		if (sub_serports > 0)
 			return sub_serports;
-		} else {
-			dev_err(&dev->dev, "NetMos/Mostech serial driver ignoring port on a=
mbiguous config.\n");
-			return 0;
-		}
+
+		dev_err(&dev->dev,
+			"NetMos/Mostech serial driver ignoring port on ambiguous config.\n"=
);
+		return 0;
 	}
=20
 	moan_device("unknown NetMos/Mostech program interface", dev);
--=20
1.9.1
