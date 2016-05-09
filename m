From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v2] TTY: serial, handle platform_get_irq retval properly
Date: Mon,  9 May 2016 09:23:35 +0200
Message-ID: <1462778615-14718-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <kernel@pengutronix.de>, Russell King <linux@armlinux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Laxman Dewangan <ldewangan@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-tegra@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

platform_get_irq can fail, so we should handle negative value when
returned.

[v2]

platform_get_irq can actually return zero on some platforms. So do not
remove checks for irq =3D=3D 0 there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: "Uwe Kleine-K=C3=B6nig" <kernel@pengutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-tegra@vger.kernel.org
---
 drivers/tty/serial/amba-pl011.c   | 8 +++++++-
 drivers/tty/serial/fsl_lpuart.c   | 8 +++++++-
 drivers/tty/serial/pmac_zilog.c   | 2 +-
 drivers/tty/serial/serial-tegra.c | 7 ++++++-
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-=
pl011.c
index a2aa655f56c4..c70bb41800f1 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2553,11 +2553,17 @@ static int sbsa_uart_probe(struct platform_devi=
ce *pdev)
 	if (!uap)
 		return -ENOMEM;
=20
+	ret =3D platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot obtain irq\n");
+		return ret;
+	}
+	uap->port.irq	=3D ret;
+
 	uap->reg_offset	=3D vendor_sbsa.reg_offset;
 	uap->vendor	=3D &vendor_sbsa;
 	uap->fifosize	=3D 32;
 	uap->port.iotype =3D vendor_sbsa.access_32b ? UPIO_MEM32 : UPIO_MEM;
-	uap->port.irq	=3D platform_get_irq(pdev, 0);
 	uap->port.ops	=3D &sbsa_uart_pops;
 	uap->fixed_baud =3D baudrate;
=20
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_l=
puart.c
index 3d790033744e..7f95f782a485 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1830,7 +1830,13 @@ static int lpuart_probe(struct platform_device *=
pdev)
 	sport->port.dev =3D &pdev->dev;
 	sport->port.type =3D PORT_LPUART;
 	sport->port.iotype =3D UPIO_MEM;
-	sport->port.irq =3D platform_get_irq(pdev, 0);
+	ret =3D platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot obtain irq\n");
+		return ret;
+	}
+	sport->port.irq =3D ret;
+
 	if (sport->lpuart32)
 		sport->port.ops =3D &lpuart32_pops;
 	else
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_=
zilog.c
index e156e39d620c..b24b0556f5a8 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1720,7 +1720,7 @@ static int __init pmz_init_port(struct uart_pmac_=
port *uap)
=20
 	r_ports =3D platform_get_resource(uap->pdev, IORESOURCE_MEM, 0);
 	irq =3D platform_get_irq(uap->pdev, 0);
-	if (!r_ports || !irq)
+	if (!r_ports || irq <=3D 0)
 		return -ENODEV;
=20
 	uap->port.mapbase  =3D r_ports->start;
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/ser=
ial-tegra.c
index bee1e5867426..4c4674b51db9 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1310,7 +1310,12 @@ static int tegra_uart_probe(struct platform_devi=
ce *pdev)
 	}
=20
 	u->iotype =3D UPIO_MEM32;
-	u->irq =3D platform_get_irq(pdev, 0);
+	ret =3D platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Couldn't get IRQ\n");
+		return ret;
+	}
+	u->irq =3D ret;
 	u->regshift =3D 2;
 	ret =3D uart_add_one_port(&tegra_uart_driver, u);
 	if (ret < 0) {
--=20
2.8.2
