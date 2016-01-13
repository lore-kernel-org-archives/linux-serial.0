From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v6 13/15] tty: serial: 8250: Merge duplicate conditions
Date: Wed, 13 Jan 2016 22:29:19 +0100
Message-ID: <1452720561-28443-14-git-send-email-anton.wuerfel@fau.de>
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

This patch refactors a switch case statement by merging an if condition
in the default case into an identical condition right after the switch
statement.
This comes with a slight change in behaviour: If pci_netmos_9900_numpor=
ts
returns 0, an additional warning is printed.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
index fbd4222..b22e5a5 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -850,13 +850,13 @@ static int pci_netmos_init(struct pci_dev *dev)
 			break;
=20
 		default:
-			if (num_serial =3D=3D 0 ) {
-				moan_device("unknown NetMos/Mostech device", dev);
-			}
+			break;
 	}
=20
-	if (num_serial =3D=3D 0)
+	if (num_serial =3D=3D 0) {
+		moan_device("unknown NetMos/Mostech device", dev);
 		return -ENODEV;
+	}
=20
 	return num_serial;
 }
--=20
1.9.1
