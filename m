From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH 2/3] serial: make dio device id constant
Date: Sun, 10 Jan 2010 17:59:36 +0100
Message-ID: <4B4A0778.2000508@freemail.hu>
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

The id_table field of the struct dio_driver is constant in <linux/dio.h>
so it is worth to make the initialization data also constant.

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
diff -u -p a/drivers/serial/8250_hp300.c b/drivers/serial/8250_hp300.c
--- a/drivers/serial/8250_hp300.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/serial/8250_hp300.c 2010-01-08 18:52:23.000000000 +0100
@@ -39,7 +39,7 @@ static int __devinit hpdca_init_one(stru
 					const struct dio_device_id *ent);
 static void __devexit hpdca_remove_one(struct dio_dev *d);

-static struct dio_device_id hpdca_dio_tbl[] =3D {
+static const struct dio_device_id hpdca_dio_tbl[] =3D {
 	{ DIO_ID_DCA0 },
 	{ DIO_ID_DCA0REM },
 	{ DIO_ID_DCA1 },
_______________________________________________
Cocci mailing list
Cocci@diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
