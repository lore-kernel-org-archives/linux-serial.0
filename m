Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814B304BDF;
	Wed, 24 Sep 2025 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721446; cv=none; b=r38G4WereIs6M88SjQkRbLZjHo9G3fsYqjII0Y4iFebJYqXPB0IEs+e0V5+sR37XWr3LbvE4+omVYQeGsrHziVL2gGqxquvrLHd87jp5Tt9dE5yOgqSWC5V+0nUDxMRV7saOSmUZ8e3LWg8hG+YPzFS4fd4SYQ9EK7JbvwkkJUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721446; c=relaxed/simple;
	bh=k14L0GDW8becF8NGOUpw+cLrQO/7WBC7qFAlCeJM9Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMkcmI4W+hpa01nOLRdtUT2B0qewT/QSBfxerj0bQkyHp2jQmcgXi1eRNOxzRP4MhHurvSYRHV7iMsoE7qMi4uz9KzrI3Q2ZQD0zJ4YbkHSfYr/lGh08H90bYmRBMG7uRMvajnx7FpM26Ikui0zsFTjBFv++HPfSEGN2kGJ+DQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=EjxMOUKS; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="EjxMOUKS"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=8376ac7522=fe@dev.tdt.de>)
	id 1v1Pfa-00BbW5-T8; Wed, 24 Sep 2025 15:36:30 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1v1PfZ-00FCuR-Cw; Wed, 24 Sep 2025 15:36:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1758720988;
	bh=bJYsrHx0nwgEiYUjvvl9QWllyAPYJEPKdCvQ9kU4BB0=;
	h=From:To:Cc:Subject:Date:From;
	b=EjxMOUKSkedR2oJ09tBi5+5zoBakAEhABEZg3ymxAin5y1InywSLXOlXueuLh6+co
	 +d5vh9IHRc+SSxz56j9X4qUoR8RJQKo8DXbGxEaEb0841qHDjjrcjA4WEAyT3aInAJ
	 I67/JlgqcIlvTv8WBzXFjgX8WZKWqsnroiTg4ouzMtIy+fiiYrKSpRuJH5wm6jj+NM
	 MkGr8YjveivPMaMu4NF7SqGBvBtEapVFCpizqU8XF72RPDKUd8f/hm4sBky6Q9+DpZ
	 tiQutrkPrMzjrx1bRfYYa6vjFEGAwfLGDidMNsQ2J9ySIBQtWZUGOy4vtujEvXAIsj
	 ux844YJXugXLw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id E6C14240041;
	Wed, 24 Sep 2025 15:36:28 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id CE374240036;
	Wed, 24 Sep 2025 15:36:28 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 4EA4022FAE;
	Wed, 24 Sep 2025 15:36:28 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	kumaravel.thiagarajan@microchip.com,
	tharunkumar.pasumarthi@microchip.com,
	andriy.shevchenko@linux.intel.com, pnewman@connecttech.com,
	angelogioacchino.delregno@collabora.com, peterz@infradead.org,
	yujiaoliang@vivo.com, arnd@kernel.org, cang1@live.co.uk,
	macro@orcam.me.uk, schnelle@linux.ibm.com,
	Eckert.Florian@googlemail.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH] serial: 8250_pcilib: Replace deprecated PCI functions
Date: Wed, 24 Sep 2025 15:35:45 +0200
Message-ID: <20250924133544.2666514-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1758720990-B1D84A68-3392869A/0/0
X-purgate: clean
X-purgate-type: clean

When the '8250_exar' module is loaded in to the kernel, a kernel trace
with 'WARN_ON(legacy_iomap_table[bar])' is dumped to the console,
because the old pci table mapping is still used in '8250_pcilib'.

The old function have been deprecated in commit e354bb84a4c1 ("PCI:
Deprecate pcim_iomap_table(), pcim_iomap_regions_request_all()").

The remapping already takes or must take place in the driver that calls
the function 'serial8250_pci_setup_port()'. The remapping should only be
called once via 'pcim_iomap()'. Therefore the remapping moved to the
caller of 'serial8250_pci_setup_port()'.

To use the new functions in '8250_pcilib' the function signature of
'serial8250_pci_setup_port()' has been extended with an already iomapped
address value. So this can be used directly without mapping again.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/tty/serial/8250/8250_exar.c     |  4 ++--
 drivers/tty/serial/8250/8250_pci.c      | 10 +++++++++-
 drivers/tty/serial/8250/8250_pci1xxxx.c | 10 +++++-----
 drivers/tty/serial/8250/8250_pcilib.c   |  7 ++-----
 drivers/tty/serial/8250/8250_pcilib.h   |  2 +-
 5 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/825=
0/8250_exar.c
index 04a0cbab02c2..3c16a849b474 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -503,7 +503,7 @@ static int default_setup(struct exar8250 *priv, struc=
t pci_dev *pcidev,
 	unsigned char status;
 	int err;
=20
-	err =3D serial8250_pci_setup_port(pcidev, port, 0, offset, board->reg_s=
hift);
+	err =3D serial8250_pci_setup_port(pcidev, port, 0, offset, board->reg_s=
hift, priv->virt);
 	if (err)
 		return err;
=20
@@ -831,7 +831,7 @@ static int cti_port_setup_common(struct exar8250 *pri=
v,
 	port->port.port_id =3D idx;
 	port->port.uartclk =3D priv->osc_freq;
=20
-	ret =3D serial8250_pci_setup_port(pcidev, port, 0, offset, 0);
+	ret =3D serial8250_pci_setup_port(pcidev, port, 0, offset, 0, priv->vir=
t);
 	if (ret)
 		return ret;
=20
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250=
/8250_pci.c
index 152f914c599d..edd5f28f04c6 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -165,7 +165,15 @@ static int
 setup_port(struct serial_private *priv, struct uart_8250_port *port,
 	   u8 bar, unsigned int offset, int regshift)
 {
-	return serial8250_pci_setup_port(priv->dev, port, bar, offset, regshift=
);
+	void __iomem *iomem =3D NULL;
+
+	if (pci_resource_flags(priv->dev, bar) & IORESOURCE_MEM) {
+		iomem =3D pcim_iomap(priv->dev, bar, 0);
+		if (IS_ERR(iomem))
+			return -ENOMEM;
+	}
+
+	return serial8250_pci_setup_port(priv->dev, port, bar, offset, regshift=
, iomem);
 }
=20
 /*
diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial=
/8250/8250_pci1xxxx.c
index 4c149db84692..feeede164886 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -671,7 +671,7 @@ static int pci1xxxx_resume(struct device *dev)
 }
=20
 static int pci1xxxx_setup(struct pci_dev *pdev,
-			  struct uart_8250_port *port, int port_idx, int rev)
+			  struct uart_8250_port *port, int port_idx, struct pci1xxxx_8250 *pr=
iv)
 {
 	int ret;
=20
@@ -698,12 +698,12 @@ static int pci1xxxx_setup(struct pci_dev *pdev,
 	 * C0 and later revisions support Burst operation.
 	 * RTS workaround in mctrl is applicable only to B0.
 	 */
-	if (rev >=3D 0xC0)
+	if (priv->dev_rev >=3D 0xC0)
 		port->port.handle_irq =3D pci1xxxx_handle_irq;
-	else if (rev =3D=3D 0xB0)
+	else if (priv->dev_rev =3D=3D 0xB0)
 		port->port.set_mctrl =3D pci1xxxx_set_mctrl;
=20
-	ret =3D serial8250_pci_setup_port(pdev, port, 0, PORT_OFFSET * port_idx=
, 0);
+	ret =3D serial8250_pci_setup_port(pdev, port, 0, PORT_OFFSET * port_idx=
, 0, priv->membase);
 	if (ret < 0)
 		return ret;
=20
@@ -821,7 +821,7 @@ static int pci1xxxx_serial_probe(struct pci_dev *pdev=
,
 		else
 			uart.port.irq =3D pci_irq_vector(pdev, 0);
=20
-		rc =3D pci1xxxx_setup(pdev, &uart, port_idx, priv->dev_rev);
+		rc =3D pci1xxxx_setup(pdev, &uart, port_idx, priv);
 		if (rc) {
 			dev_warn(dev, "Failed to setup port %u\n", i);
 			continue;
diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8=
250/8250_pcilib.c
index d8d0ae0d7238..9d5d2531a33b 100644
--- a/drivers/tty/serial/8250/8250_pcilib.c
+++ b/drivers/tty/serial/8250/8250_pcilib.c
@@ -22,19 +22,16 @@ int serial_8250_warn_need_ioport(struct pci_dev *dev)
 EXPORT_SYMBOL_NS_GPL(serial_8250_warn_need_ioport, "SERIAL_8250_PCI");
=20
 int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port=
 *port,
-		   u8 bar, unsigned int offset, int regshift)
+		   u8 bar, unsigned int offset, int regshift, void __iomem *iomem)
 {
 	if (bar >=3D PCI_STD_NUM_BARS)
 		return -EINVAL;
=20
 	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
-		if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
-			return -ENOMEM;
-
 		port->port.iotype =3D UPIO_MEM;
 		port->port.iobase =3D 0;
 		port->port.mapbase =3D pci_resource_start(dev, bar) + offset;
-		port->port.membase =3D pcim_iomap_table(dev)[bar] + offset;
+		port->port.membase =3D iomem + offset;
 		port->port.regshift =3D regshift;
 	} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
 		port->port.iotype =3D UPIO_PORT;
diff --git a/drivers/tty/serial/8250/8250_pcilib.h b/drivers/tty/serial/8=
250/8250_pcilib.h
index 16a274574cde..ab18de8d1355 100644
--- a/drivers/tty/serial/8250/8250_pcilib.h
+++ b/drivers/tty/serial/8250/8250_pcilib.h
@@ -12,6 +12,6 @@ struct pci_dev;
 struct uart_8250_port;
=20
 int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port=
 *port, u8 bar,
-		   unsigned int offset, int regshift);
+		   unsigned int offset, int regshift, void __iomem *iomem);
=20
 int serial_8250_warn_need_ioport(struct pci_dev *dev);

base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
--=20
2.39.5

