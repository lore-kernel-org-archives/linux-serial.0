From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] serial: 8250_of: assume reg-shift of 2 for mrvl,mmp-uart
Date: Sun, 24 Feb 2019 13:00:53 +0100
Message-ID: <20190224120053.13682-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

There are two other drivers that bind to mrvl,mmp-uart and both of them
assume register shift of 2 bits. There are device trees that lack the
property and rely on that assumption.

If this driver wins the race to bind to those devices, it should behave
the same as the older deprecated driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_of.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/=
8250_of.c
index a1a85805d010..2488de1c4bc4 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -130,6 +130,10 @@ static int of_platform_serial_setup(struct platform_=
device *ofdev,
 		port->flags |=3D UPF_IOREMAP;
 	}
=20
+	/* Compatibility with the deprecated pxa driver and 8250_pxa drivers. *=
/
+	if (of_device_is_compatible(np, "mrvl,mmp-uart"))
+		port->regshift =3D 2;
+
 	/* Check for registers offset within the devices address range */
 	if (of_property_read_u32(np, "reg-shift", &prop) =3D=3D 0)
 		port->regshift =3D prop;
--=20
2.20.1
