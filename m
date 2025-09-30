Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72951FE471;
	Tue, 30 Sep 2025 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217300; cv=none; b=CY95xqZGXb9cnHLDQqLjz277kAOJll1tkpzMW/yqGuYGNfO2NMGqEhUK9ZOJKMrOmN56om6UVoSOSe7vB79ASmJ1nXHgpslrKkvydzXUPyzbCodwJXqHfYl3Tzo5d0X9ISucuRiihHTrN7Kn4PGLt4gfsxDvzzNJxnZUYH1d+Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217300; c=relaxed/simple;
	bh=VwCJWMy8ItpsfKfl1EIkVsSnBddauVq27KalmhGJTwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=on4cpgVsbKSiFBiRDSpHfv0DyE8Z65fmBIjEVB0KflCMZx8FD/Kn1HDgRGw1mWiuNJlGKKgFx6cBbO0Z+E477uZ58//pyg2msTSPhbniyVzNSTANRwLoIHTYRpzYw/F594f2hFV7HiZBtgIxKtxgGTERHyh5jJrmPNmZBGJt/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=EiwHKXHQ; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="EiwHKXHQ"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=838262a34c=fe@dev.tdt.de>)
	id 1v3UmM-008ZFJ-48; Tue, 30 Sep 2025 09:28:06 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1v3UmL-000HDn-CP; Tue, 30 Sep 2025 09:28:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1759217284;
	bh=32t1lEtoWQjAJxO5HBEyfgVyOgcv2EL9CkXnvNB6Ga8=;
	h=From:To:Cc:Subject:Date:From;
	b=EiwHKXHQwbtIRstYgkukHsruJEGV/2Axksf7+ISx6hfxHMpLuY6b5LJ/YXckPqEFD
	 LwEPBhSNkTXseypZNYKwdvlEgxVQlSbB9VOw3ve69p2d7DNkYflh5//3t0+pfUMYL3
	 4zlwsFBOqZSy8NqWUOgYrpdRQiYoef+2ziSow3if6zMVpvF31j6V3SCrc3kK9O2K51
	 TO+3pXWj2ZBThAlevStBCltBk32E4e6HpaVm1MUjJcOJ0rCmkagRVXhCm+pnse+l7R
	 2RrcqVqtl/2e4k1YcAyyUClpa+R96/S+2KHDlmMcDdY8rzbhiALlBIq5jxud7eOD+l
	 MCYSOIRIsx9zA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id E223F240042;
	Tue, 30 Sep 2025 09:28:04 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id C890D240036;
	Tue, 30 Sep 2025 09:28:04 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 4FF1926780;
	Tue, 30 Sep 2025 09:28:04 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	kumaravel.thiagarajan@microchip.com,
	andriy.shevchenko@linux.intel.com, pnewman@connecttech.com,
	angelogioacchino.delregno@collabora.com, peterz@infradead.org,
	yujiaoliang@vivo.com, arnd@kernel.org, cang1@live.co.uk,
	macro@orcam.me.uk, schnelle@linux.ibm.com,
	Eckert.Florian@googlemail.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v2] serial: 8250_pcilib: Replace deprecated PCI functions
Date: Tue, 30 Sep 2025 09:27:43 +0200
Message-ID: <20250930072743.791580-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1759217285-DCD9713C-C5B4E1A5/0/0

When the '8250_exar' module is loaded into the kernel, a kernel trace
with 'WARN_ON(legacy_iomap_table[bar])' is dumped to the console,
because the old pci table mapping is still used in '8250_pcilib'.

The old function have been deprecated in commit e354bb84a4c1 ("PCI:
Deprecate pcim_iomap_table(), pcim_iomap_regions_request_all()").

The remapping already takes or must take place in the driver that calls
the function 'serial8250_pci_setup_port()'. The remapping should only be
called once via 'pcim_iomap()'. Therefore the remapping moved to the
caller of 'serial8250_pci_setup_port()'.

To replace the outdated/legacy iomap_table processing in '8250_pcilib' th=
e
function signature of 'serial8250_pci_setup_port()' has been extended wit=
h
an already iomapped address value. So this can be used directly without
io mapping again.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---

v2:
* The function 'pcim_iomap()' returns a NULL pointer in the event of an
  error, so error handling has been adjusted.

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
index 152f914c599d..f0f13fdda2df 100644
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
+		if (!iomem)
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
--=20
2.39.5

