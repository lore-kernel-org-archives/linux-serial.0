From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 1/6] serial: 8250_dw: add support for clocks property when using DeviceTree
Date: Thu,  7 Mar 2013 23:14:15 +0100
Message-ID: <1362694460-1919-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33214 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759154Ab3CGWOx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Mar 2013 17:14:53 -0500
In-Reply-To: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kevin@allwinnertech.com, sunny@allwinnertech.com, shuge@allwinnertech.com, =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

=46rom: Emilio L=C3=B3pez <emilio@elopez.com.ar>

This commit implements support for using the "clocks" DT property, inst=
ead
of having to use clock-frequency.

Signed-off-by: Emilio L=C3=B3pez <emilio@elopez.com.ar>
---
 drivers/tty/serial/8250/8250_dw.c |   32 ++++++++++++++++++++++-------=
---
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
index db0e66f..8f03800 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/clk.h>
=20
 #include "8250.h"
=20
@@ -55,8 +56,9 @@
=20
=20
 struct dw8250_data {
-	int	last_lcr;
-	int	line;
+	int		last_lcr;
+	int		line;
+	struct clk	*clk;
 };
=20
 static void dw8250_serial_out(struct uart_port *p, int offset, int val=
ue)
@@ -116,6 +118,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 static int dw8250_probe_of(struct uart_port *p)
 {
 	struct device_node	*np =3D p->dev->of_node;
+	struct dw8250_data	*data =3D p->private_data;
 	u32			val;
=20
 	if (!of_property_read_u32(np, "reg-io-width", &val)) {
@@ -137,8 +140,15 @@ static int dw8250_probe_of(struct uart_port *p)
 		p->regshift =3D val;
=20
 	if (of_property_read_u32(np, "clock-frequency", &val)) {
-		dev_err(p->dev, "no clock-frequency property set\n");
-		return -EINVAL;
+		/* Get clk rate through clk driver if present */
+		data->clk =3D clk_get(p->dev, NULL);
+		if (IS_ERR(data->clk)) {
+			dev_err(p->dev, "clk or clock-frequency not defined\n");
+			return -EINVAL;
+		}
+
+		clk_prepare_enable(data->clk);
+		val =3D clk_get_rate(data->clk);
 	}
 	p->uartclk =3D val;
=20
@@ -300,6 +310,12 @@ static int dw8250_probe(struct platform_device *pd=
ev)
=20
 	dw8250_setup_port(&uart);
=20
+	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	uart.port.private_data =3D data;
+
 	if (pdev->dev.of_node) {
 		err =3D dw8250_probe_of(&uart.port);
 		if (err)
@@ -312,12 +328,6 @@ static int dw8250_probe(struct platform_device *pd=
ev)
 		return -ENODEV;
 	}
=20
-	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	uart.port.private_data =3D data;
-
 	data->line =3D serial8250_register_8250_port(&uart);
 	if (data->line < 0)
 		return data->line;
@@ -333,6 +343,8 @@ static int dw8250_remove(struct platform_device *pd=
ev)
=20
 	serial8250_unregister_port(data->line);
=20
+	clk_disable_unprepare(data->clk);
+
 	return 0;
 }
=20
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
