From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] serial: 8250_pxa: honor the port number from devicetree
Date: Sun, 24 Feb 2019 12:58:02 +0100
Message-ID: <20190224115802.13436-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-serial@vger.kernel.org

Like the other OF-enabled drivers, use the port number from the firmware =
if
the devicetree specifies an alias:

  aliases {
      ...
      serial2 =3D &uart2; /* Should be ttyS2 */
  }

This is how the deprecated pxa.c driver behaved, switching to 8250_pxa
messes up the numbering.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/tty/serial/8250/8250_pxa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250=
/8250_pxa.c
index b9bcbe20a2be..c47188860e32 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -113,6 +113,10 @@ static int serial_pxa_probe(struct platform_device *=
pdev)
 	if (ret)
 		return ret;
=20
+	ret =3D of_alias_get_id(pdev->dev.of_node, "serial");
+	if (ret >=3D 0)
+		uart.port.line =3D ret;
+
 	uart.port.type =3D PORT_XSCALE;
 	uart.port.iotype =3D UPIO_MEM32;
 	uart.port.mapbase =3D mmres->start;
--=20
2.20.1
