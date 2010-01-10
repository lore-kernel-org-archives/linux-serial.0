From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH 3/3] serial: make PCI device id constant
Date: Sun, 10 Jan 2010 17:59:40 +0100
Message-ID: <4B4A077C.7020406@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <cocci-bounces@diku.dk>
List-Unsubscribe: <http://lists.diku.dk/mailman/listinfo/cocci>,
	<mailto:cocci-request@diku.dk?subject=unsubscribe>
List-Archive: <http://lists.diku.dk/pipermail/cocci>
List-Post: <mailto:cocci@diku.dk>
List-Help: <mailto:cocci-request@diku.dk?subject=help>
List-Subscribe: <http://lists.diku.dk/mailman/listinfo/cocci>,
	<mailto:cocci-request@diku.dk?subject=subscribe>
Sender: cocci-bounces@diku.dk
Errors-To: cocci-bounces@diku.dk
To: linux-serial@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@diku.dk
List-Id: linux-serial@vger.kernel.org

From: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

The id_table field of the struct pci_driver is constant in <linux/pci.h>
so it is worth to make initialization data also constant.

The semantic match that finds this kind of pattern is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
disable decl_init,const_decl_init;
identifier I1, I2, x;
@@
	struct I1 {
	  ...
	  const struct I2 *x;
	  ...
	};
@s@
identifier r.I1, y;
identifier r.x, E;
@@
	struct I1 y =3D {
	  .x =3D E,
	};
@c@
identifier r.I2;
identifier s.E;
@@
	const struct I2 E[] =3D ... ;
@depends on !c@
identifier r.I2;
identifier s.E;
@@
+	const
	struct I2 E[] =3D ...;
// </smpl>

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
Cc: Julia Lawall <julia@diku.dk>
Cc: cocci@diku.dk
---
diff -u -p a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- a/drivers/serial/8250_pci.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/serial/8250_pci.c 2010-01-08 18:40:05.000000000 +0100
@@ -2567,7 +2567,7 @@ static int pciserial_resume_one(struct p
 }
 #endif

-static struct pci_device_id serial_pci_tbl[] =3D {
+static const struct pci_device_id serial_pci_tbl[] =3D {
 	/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUBVE=
NDOR_ID' */
 	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
 		PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001, 0, 0,
diff -u -p a/drivers/serial/jsm/jsm_driver.c b/drivers/serial/jsm/jsm_dri=
ver.c
--- a/drivers/serial/jsm/jsm_driver.c 2010-01-07 19:08:45.000000000 +0100
+++ b/drivers/serial/jsm/jsm_driver.c 2010-01-08 18:41:09.000000000 +0100
@@ -218,7 +218,7 @@ static void __devexit jsm_remove_one(str
 	kfree(brd);
 }

-static struct pci_device_id jsm_pci_tbl[] =3D {
+static const struct pci_device_id jsm_pci_tbl[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9), 0, 0, 0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9PRI), 0, 0, 1 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45), 0, 0, 2 },
_______________________________________________
Cocci mailing list
Cocci@diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
