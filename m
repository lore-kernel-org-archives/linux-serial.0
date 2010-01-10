From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH 1/3] serial: make Open Firmware device id constant
Date: Sun, 10 Jan 2010 17:59:30 +0100
Message-ID: <4B4A0772.9070007@freemail.hu>
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

The match_table field of the struct of_device_id is constant in <linux/of=
_platform.h>
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
diff -u -p a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
--- a/drivers/serial/of_serial.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/serial/of_serial.c 2010-01-08 18:42:19.000000000 +0100
@@ -158,7 +158,7 @@ static int of_platform_serial_remove(str
 /*
  * A few common types, add more as needed.
  */
-static struct of_device_id __devinitdata of_platform_serial_table[] =3D =
{
+static const struct of_device_id of_platform_serial_table[] __devinitcon=
st =3D {
 	{ .type =3D "serial", .compatible =3D "ns8250",   .data =3D (void *)POR=
T_8250, },
 	{ .type =3D "serial", .compatible =3D "ns16450",  .data =3D (void *)POR=
T_16450, },
 	{ .type =3D "serial", .compatible =3D "ns16550a", .data =3D (void *)POR=
T_16550A, },
diff -u -p a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.=
c
--- a/drivers/serial/mpc52xx_uart.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/serial/mpc52xx_uart.c 2010-01-08 18:45:41.000000000 +0100
@@ -1088,7 +1088,7 @@ static struct uart_driver mpc52xx_uart_d
 /* OF Platform Driver                                                   =
    */
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
*/

-static struct of_device_id mpc52xx_uart_of_match[] =3D {
+static const struct of_device_id mpc52xx_uart_of_match[] =3D {
 #ifdef CONFIG_PPC_MPC52xx
 	{ .compatible =3D "fsl,mpc5200-psc-uart", .data =3D &mpc52xx_psc_ops, }=
,
 	/* binding used by old lite5200 device trees: */
diff -u -p a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
--- a/drivers/serial/uartlite.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/serial/uartlite.c 2010-01-08 18:47:33.000000000 +0100
@@ -25,7 +25,7 @@
 #include <linux/of_platform.h>

 /* Match table for of_platform binding */
-static struct of_device_id ulite_of_match[] __devinitdata =3D {
+static const struct of_device_id ulite_of_match[] __devinitconst =3D {
 	{ .compatible =3D "xlnx,opb-uartlite-1.00.b", },
 	{ .compatible =3D "xlnx,xps-uartlite-1.00.a", },
 	{}
diff -u -p a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm=
_uart/cpm_uart_core.c
--- a/drivers/serial/cpm_uart/cpm_uart_core.c 2009-12-03 04:51:21.0000000=
00 +0100
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c 2010-01-08 18:49:48.0000000=
00 +0100
@@ -1355,7 +1355,7 @@ static int __devexit cpm_uart_remove(str
 	return uart_remove_one_port(&cpm_reg, &pinfo->port);
 }

-static struct of_device_id cpm_uart_match[] =3D {
+static const struct of_device_id cpm_uart_match[] =3D {
 	{
 		.compatible =3D "fsl,cpm1-smc-uart",
 	},
diff -u -p a/drivers/serial/ucc_uart.c b/drivers/serial/ucc_uart.c
--- a/drivers/serial/ucc_uart.c 2010-01-07 19:08:45.000000000 +0100
+++ b/drivers/serial/ucc_uart.c 2010-01-08 18:50:15.000000000 +0100
@@ -1475,7 +1475,7 @@ static int ucc_uart_remove(struct of_dev
 	return 0;
 }

-static struct of_device_id ucc_uart_match[] =3D {
+static const struct of_device_id ucc_uart_match[] =3D {
 	{
 		.type =3D "serial",
 		.compatible =3D "ucc_uart",
diff -u -p a/drivers/serial/apbuart.c b/drivers/serial/apbuart.c
--- a/drivers/serial/apbuart.c 2010-01-07 19:08:45.000000000 +0100
+++ b/drivers/serial/apbuart.c 2010-01-08 18:51:23.000000000 +0100
@@ -576,7 +576,7 @@ static int __devinit apbuart_probe(struc

 }

-static struct of_device_id __initdata apbuart_match[] =3D {
+static const struct of_device_id apbuart_match[] __initconst =3D {
 	{
 	 .name =3D "GAISLER_APBUART",
 	 },
_______________________________________________
Cocci mailing list
Cocci@diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
