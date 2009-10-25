From: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
Subject: [PATCH] serial, 8250: calculate irqflags bitmask before loop
Date: Sun, 25 Oct 2009 12:01:34 -0200
Message-ID: <b8bf37780910250701r58d25082y12ea482f6c1b2ea4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vw0-f184.google.com ([209.85.212.184]:33938 "EHLO
	mail-vw0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbZJYOBt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 Oct 2009 10:01:49 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>, ddaney@caviumnetworks.com, tpaoletti@caviumnetworks.com, gregkh@suse.de, linux-serial@vger.kernel.orglinux list <lin>
Cc: me <andre.goddard@gmail.com>

=46rom 3619427f21e450763b7cc1b12f7c21b2300e49e8 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Goddard=3D20Rosa?=3D <andre.godd=
ard@gmail.com>
Date: Sat, 24 Oct 2009 11:57:18 -0200
Subject: [PATCH] serial, 8250: calculate irqflags bitmask before loop
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Andr=E9 Goddard Rosa <andre.goddard@gmail.com>

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index b1ae774..b22dcc3 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2646,7 +2646,7 @@ static void __init serial8250_isa_init_ports(void=
)
 {
 	struct uart_8250_port *up;
 	static int first =3D 1;
-	int i;
+	int i, irqflag =3D 0;

 	if (!first)
 		return;
@@ -2670,6 +2670,9 @@ static void __init serial8250_isa_init_ports(void=
)
 		up->port.ops =3D &serial8250_pops;
 	}

+	if (share_irqs)
+		irqflag =3D IRQF_SHARED;
+
 	for (i =3D 0, up =3D serial8250_ports;
 	     i < ARRAY_SIZE(old_serial_port) && i < nr_uarts;
 	     i++, up++) {
@@ -2683,8 +2686,7 @@ static void __init serial8250_isa_init_ports(void=
)
 		up->port.iotype   =3D old_serial_port[i].io_type;
 		up->port.regshift =3D old_serial_port[i].iomem_reg_shift;
 		set_io_from_upio(&up->port);
-		if (share_irqs)
-			up->port.irqflags |=3D IRQF_SHARED;
+		up->port.irqflags |=3D irqflag;
 	}
 }

@@ -2940,10 +2942,13 @@ static int __devinit serial8250_probe(struct
platform_device *dev)
 {
 	struct plat_serial8250_port *p =3D dev->dev.platform_data;
 	struct uart_port port;
-	int ret, i;
+	int ret, i, irqflag =3D 0;

 	memset(&port, 0, sizeof(struct uart_port));

+	if (share_irqs)
+		irqflag =3D IRQF_SHARED;
+
 	for (i =3D 0; p && p->flags !=3D 0; p++, i++) {
 		port.iobase		=3D p->iobase;
 		port.membase		=3D p->membase;
@@ -2960,8 +2965,7 @@ static int __devinit serial8250_probe(struct
platform_device *dev)
 		port.serial_in		=3D p->serial_in;
 		port.serial_out		=3D p->serial_out;
 		port.dev		=3D &dev->dev;
-		if (share_irqs)
-			port.irqflags |=3D IRQF_SHARED;
+		port.irqflags		|=3D irqflag;
 		ret =3D serial8250_register_port(&port);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
--=20
1.6.5.1.75.g02d56
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
