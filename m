Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F39337A83D;
	Tue, 13 Oct 2026 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874155; cv=none; b=QdvFEclLhQipe7Egy0Ec8iB4PTyko8/Lpep0QdOcptzF0pSQ9hAhNB7rXeWbQJK6FYbMJx/7SNQNpmDXOzbw+kWi0SZgDvei9+riscR92Qr3CM55zC2ugxVN/im9ZZtw5OkqH8F1Q/XgXbFTm25nPzFrq3JEhfUIewa20ZlaEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874155; c=relaxed/simple;
	bh=pLoE1mBipJT0oTRo0mFj0ZibwK2KArinql3FYWOvgTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CptTUbrh9C73TcMe4KEzoR4/mUVG4SDK86xC9WIaTXmF1kxQPobpvRGgI0kghPXRHGM0y0cTQWmqjb5iVw2IuChtX8g/ikI5wtxHDfbdLbkkCl/RweT+y0mb09j9teh9zmn61HVlkf/SU+3ibv4BpZquEpdI55JZXqmcW8kRYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfOCFJPc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfOCFJPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B32F1F000FF;
	Tue, 13 Oct 2026 06:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874151;
	bh=CMSDiTS1eVUobpouwc/YrI8TtR7JOZ2j4D3OjhcH91o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IfOCFJPcbalulmLphD0O9e1EYKJGuoUANzWEWdwBelnLc25kquVehijU22EQvm72y
	 6sKkz5IZnJQrDN6kitz6gOFzTS0lOlnORIjyoItHGjIclZmemNFpcaBu8MPX3ak/Fj
	 8HSI9eS7ATfWxhi4RPrO+6uNPLEPjtC3BpF3rAejvzKKA63FRfHiZI8anRAXKwA3be
	 PE02RQXn3V4HhpxPUYMu27U+d89YWMuNZRmpIFLflK4klKGE8PeTDJwBs9FYU2MDek
	 sLxo1DVr5Mz98jDCoADNok7ymWg1akfulRfQLop/lU2I8vxlTDCGo1hHX4sR08VebI
	 eC3oOp/jMWvRA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 6/6] serial: 8250: make port operations work on struct uart_8250_port
Date: Tue, 13 Oct 2026 08:48:51 +0200
Message-ID: <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791873876.git.jirislaby@kernel.org>
References: <cover.1791873876.git.jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

serial8250_register_8250_port() returns a line number and the other
port operations (serial8250_unregister_port(), serial8250_suspend_port(),
serial8250_resume_port()) accept it. Many drivers then convert the line
back to the port using serial8250_get_port() anyway.

Switch the interface to struct uart_8250_port:
* serial8250_register_8250_port() now returns the registered port, or
an ERR_PTR() on failure.
* serial8250_unregister_port(), serial8250_suspend_port() and
serial8250_resume_port() accept the port.

Convert all users accordingly. Drivers store the port pointer instead
of the line number. Several drivers kept a private struct only to hold
the line (airoha, dfl, em, fsl, ioc3); these are dropped and the port
is stored as drvdata directly.

This also fixes two latent issues:
* For a CIR port, serial8250_register_8250_port() used to return 0.
Callers stored this as the line, so a later unregister/suspend/resume
operated on ttyS0. Now the CIR port itself is returned.
* 8250_acorn checked ports[i] > 0 on removal, so a port registered as
line 0 was never unregistered.

There are no more users of serial8250_get_port() outside of the 8250
core, so drop its EXPORT.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Assisted-by: LLM
---
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Ray Jui <ray.jui@broadcom.com>
Cc: Scott Branden <scott.branden@broadcom.com>
Cc: Al Cooper <alcooperx@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc: Thierry Reding <thierry.reding@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: netdev@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-hardening@vger.kernel.org

[v2] include err.h (Ilpo)
---
 drivers/ptp/ptp_ocp.c                       | 36 +++++++++---------
 drivers/tty/serial/8250/8250_acorn.c        |  5 ++-
 drivers/tty/serial/8250/8250_airoha.c       | 23 ++++-------
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 13 ++++---
 drivers/tty/serial/8250/8250_bcm2835aux.c   | 20 +++++-----
 drivers/tty/serial/8250/8250_bcm7271.c      | 33 ++++++++--------
 drivers/tty/serial/8250/8250_core.c         | 40 +++++++++-----------
 drivers/tty/serial/8250/8250_dfl.c          | 22 ++++-------
 drivers/tty/serial/8250/8250_dw.c           | 13 ++++---
 drivers/tty/serial/8250/8250_dwlib.h        |  2 +-
 drivers/tty/serial/8250/8250_em.c           | 26 ++++---------
 drivers/tty/serial/8250/8250_exar.c         | 19 +++++-----
 drivers/tty/serial/8250/8250_fsl.c          | 24 ++++--------
 drivers/tty/serial/8250/8250_hp300.c        | 27 ++++++-------
 drivers/tty/serial/8250/8250_ingenic.c      | 11 +++---
 drivers/tty/serial/8250/8250_ioc3.c         | 26 +++++--------
 drivers/tty/serial/8250/8250_keba.c         | 13 +++----
 drivers/tty/serial/8250/8250_loongson.c     | 20 +++++-----
 drivers/tty/serial/8250/8250_lpc18xx.c      | 11 +++---
 drivers/tty/serial/8250/8250_lpss.c         | 18 ++++-----
 drivers/tty/serial/8250/8250_men_mcb.c      | 14 +++----
 drivers/tty/serial/8250/8250_mid.c          | 13 ++++---
 drivers/tty/serial/8250/8250_mtk.c          | 19 +++++-----
 drivers/tty/serial/8250/8250_mxpcie.c       | 13 ++++---
 drivers/tty/serial/8250/8250_ni.c           | 12 +++---
 drivers/tty/serial/8250/8250_of.c           | 25 ++++++------
 drivers/tty/serial/8250/8250_omap.c         | 42 ++++++++++-----------
 drivers/tty/serial/8250/8250_parisc.c       | 14 +++----
 drivers/tty/serial/8250/8250_pci.c          | 21 +++++------
 drivers/tty/serial/8250/8250_pci1xxxx.c     | 41 ++++++++++----------
 drivers/tty/serial/8250/8250_pericom.c      | 15 ++++----
 drivers/tty/serial/8250/8250_platform.c     | 23 +++++------
 drivers/tty/serial/8250/8250_pnp.c          | 21 +++++------
 drivers/tty/serial/8250/8250_pxa.c          | 17 +++++----
 drivers/tty/serial/8250/8250_tegra.c        | 20 +++++-----
 drivers/tty/serial/8250/8250_uniphier.c     | 21 +++++------
 drivers/tty/serial/8250/serial_cs.c         | 15 ++++----
 include/linux/serial_8250.h                 |  8 ++--
 38 files changed, 349 insertions(+), 407 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 2802989e8494..609cee1d2c80 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -344,7 +344,7 @@ struct ptp_ocp_signal {
 };
 
 struct ptp_ocp_serial_port {
-	int line;
+	struct uart_8250_port *uport;
 	int baud;
 };
 
@@ -2629,7 +2629,7 @@ ptp_ocp_register_ext(struct ptp_ocp *bp, struct ocp_resource *r)
 	return err;
 }
 
-static int
+static struct uart_8250_port *
 ptp_ocp_serial_line(struct ptp_ocp *bp, struct ocp_resource *r)
 {
 	struct pci_dev *pdev = bp->pdev;
@@ -2657,9 +2657,11 @@ ptp_ocp_register_serial(struct ptp_ocp *bp, struct ocp_resource *r)
 	struct ptp_ocp_serial_port *p = (struct ptp_ocp_serial_port *)r->extra;
 	struct ptp_ocp_serial_port port = {};
 
-	port.line = ptp_ocp_serial_line(bp, r);
-	if (port.line < 0)
-		return port.line;
+	struct uart_8250_port *uport = ptp_ocp_serial_line(bp, r);
+	if (IS_ERR(uport))
+		return PTR_ERR(uport);
+
+	port.uport = uport;
 
 	if (p)
 		port.baud = p->baud;
@@ -3804,7 +3806,7 @@ ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
 	 * as a device path (e.g., "/dev/ttyS4"), and adding a newline would
 	 * break those applications. Do not add a newline to this output.
 	 */
-	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
+	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].uport->port.line);
 }
 
 static umode_t
@@ -3821,7 +3823,7 @@ ptp_ocp_timecard_tty_is_visible(struct kobject *kobj, struct attribute *attr, in
 	dattr = container_of(attr, struct device_attribute, attr);
 	ea = container_of(dattr, struct dev_ext_attribute, attr);
 	port = &bp->port[(uintptr_t)ea->var];
-	return port->line == -1 ? 0 : 0444;
+	return port->uport ? 0444 : 0;
 }
 
 #define EXT_TTY_ATTR_RO(_name, _val)			\
@@ -5287,9 +5289,9 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
 
 	seq_printf(s, "%7s: /dev/ptp%d\n", "PTP", ptp_clock_index(bp->ptp));
 	for (i = 0; i < __PORT_COUNT; i++) {
-		if (bp->port[i].line != -1)
+		if (bp->port[i].uport)
 			seq_printf(s, "%7s: /dev/ttyS%d\n", ptp_ocp_tty_port_name(i),
-				   bp->port[i].line);
+				   bp->port[i].uport->port.line);
 	}
 
 	memset(sma_val, 0xff, sizeof(sma_val));
@@ -5613,7 +5615,7 @@ ptp_ocp_device_init(struct ptp_ocp *bp, struct pci_dev *pdev)
 	spin_lock_init(&bp->lock);
 
 	for (i = 0; i < __PORT_COUNT; i++)
-		bp->port[i].line = -1;
+		bp->port[i].uport = NULL;
 
 	bp->pdev = pdev;
 
@@ -5702,10 +5704,10 @@ ptp_ocp_phc_info(struct ptp_ocp *bp)
 }
 
 static void
-ptp_ocp_serial_info(struct device *dev, const char *name, int port, int baud)
+ptp_ocp_serial_info(struct device *dev, const char *name, struct uart_8250_port *port, int baud)
 {
-	if (port != -1)
-		dev_info(dev, "%5s: /dev/ttyS%-2d @ %6d\n", name, port, baud);
+	if (port)
+		dev_info(dev, "%5s: /dev/ttyS%-2d @ %6d\n", name, port->port.line, baud);
 }
 
 static void
@@ -5723,14 +5725,14 @@ ptp_ocp_info(struct ptp_ocp *bp)
 	ptp_ocp_phc_info(bp);
 
 	for (i = 0; i < __PORT_COUNT; i++) {
-		if (i == PORT_NMEA && bp->nmea_out && bp->port[PORT_NMEA].line != -1) {
+		if (i == PORT_NMEA && bp->nmea_out && bp->port[PORT_NMEA].uport) {
 			bp->port[PORT_NMEA].baud = -1;
 
 			reg = ioread32(&bp->nmea_out->uart_baud);
 			if (reg < ARRAY_SIZE(nmea_baud))
 				bp->port[PORT_NMEA].baud = nmea_baud[reg];
 		}
-		ptp_ocp_serial_info(dev, ptp_ocp_tty_port_name(i), bp->port[i].line,
+		ptp_ocp_serial_info(dev, ptp_ocp_tty_port_name(i), bp->port[i].uport,
 				    bp->port[i].baud);
 	}
 }
@@ -5778,8 +5780,8 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	for (i = 0; i < 4; i++)
 		ptp_ocp_unregister_ext(bp->signal_out[i]);
 	for (i = 0; i < __PORT_COUNT; i++)
-		if (bp->port[i].line != -1)
-			serial8250_unregister_port(bp->port[i].line);
+		if (bp->port[i].uport)
+			serial8250_unregister_port(bp->port[i].uport);
 	platform_device_unregister(bp->spi_flash);
 	platform_device_unregister(bp->i2c_ctrl);
 	if (bp->i2c_clk)
diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/8250/8250_acorn.c
index fb596262b9c7..d0696668493a 100644
--- a/drivers/tty/serial/8250/8250_acorn.c
+++ b/drivers/tty/serial/8250/8250_acorn.c
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/tty.h>
 #include <linux/serial_core.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
@@ -31,7 +32,7 @@ struct serial_card_type {
 
 struct serial_card_info {
 	unsigned int	num_ports;
-	int		ports[MAX_PORTS];
+	struct uart_8250_port *ports[MAX_PORTS];
 	void __iomem *vaddr;
 };
 
@@ -85,7 +86,7 @@ static void serial_card_remove(struct expansion_card *ec)
 	ecard_set_drvdata(ec, NULL);
 
 	for (i = 0; i < info->num_ports; i++)
-		if (info->ports[i] > 0)
+		if (!IS_ERR_OR_NULL(info->ports[i]))
 			serial8250_unregister_port(info->ports[i]);
 
 	kfree(info);
diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8250/8250_airoha.c
index fe72a39561c2..21f248e20771 100644
--- a/drivers/tty/serial/8250/8250_airoha.c
+++ b/drivers/tty/serial/8250/8250_airoha.c
@@ -10,6 +10,7 @@
 #include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/math64.h>
 #include <linux/module.h>
@@ -28,10 +29,6 @@
 #define   UART_AIROHA_XYD_X	GENMASK(31, 16)
 #define   UART_AIROHA_XYD_Y	GENMASK(15, 0)
 
-struct airoha_8250_priv {
-	int line;
-};
-
 #define UART_BRD_20M		0x0001
 
 #define XINDIV_CLOCK		(20 * HZ_PER_MHZ)
@@ -119,7 +116,6 @@ static int airoha_8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = { };
 	struct device *dev = &pdev->dev;
-	struct airoha_8250_priv *priv;
 	struct resource *res;
 	int ret;
 
@@ -127,10 +123,6 @@ static int airoha_8250_probe(struct platform_device *pdev)
 	if (!res)
 		return dev_err_probe(dev, -EINVAL, "invalid address\n");
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
 	uart.port.dev = dev;
 	if (device_is_compatible(dev, "airoha,an7581-hsuart"))
 		uart.port.type = UART_PORT_AIROHA_HS;
@@ -147,21 +139,20 @@ static int airoha_8250_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = serial8250_register_8250_port(&uart);
-	if (ret < 0)
-		return ret;
+	struct uart_8250_port *uport = serial8250_register_8250_port(&uart);
+	if (IS_ERR(uport))
+		return PTR_ERR(uport);
 
-	priv->line = ret;
-	platform_set_drvdata(pdev, priv);
+	platform_set_drvdata(pdev, uport);
 
 	return 0;
 }
 
 static void airoha_8250_remove(struct platform_device *ofdev)
 {
-	struct airoha_8250_priv *priv = platform_get_drvdata(ofdev);
+	struct uart_8250_port *uport = platform_get_drvdata(ofdev);
 
-	serial8250_unregister_port(priv->line);
+	serial8250_unregister_port(uport);
 }
 
 static const struct of_device_id airoha_8250_dt_ids[] = {
diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 26fc0464f1cc..c8dc87f6886c 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -6,6 +6,7 @@
  *    Copyright (C) 2006 Arnd Bergmann <arnd@arndb.de>, IBM Corp.
  */
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -34,7 +35,6 @@
 
 struct aspeed_vuart {
 	struct device		*dev;
-	int			line;
 	struct timer_list	unthrottle_timer;
 	struct uart_8250_port	*port;
 };
@@ -484,12 +484,13 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "auto-flow-control"))
 		port.capabilities |= UART_CAP_AFE;
 
-	rc = serial8250_register_8250_port(&port);
-	if (rc < 0)
+	struct uart_8250_port *uport = serial8250_register_8250_port(&port);
+	if (IS_ERR(uport)) {
+		rc = PTR_ERR(uport);
 		goto err_sysfs_remove;
+	}
 
-	vuart->line = rc;
-	vuart->port = serial8250_get_port(vuart->line);
+	vuart->port = uport;
 
 	rc = of_parse_phandle_with_fixed_args(
 		np, "aspeed,sirq-polarity-sense", 2, 0,
@@ -553,7 +554,7 @@ static void aspeed_vuart_remove(struct platform_device *pdev)
 
 	timer_delete_sync(&vuart->unthrottle_timer);
 	aspeed_vuart_set_enabled(vuart, false);
-	serial8250_unregister_port(vuart->line);
+	serial8250_unregister_port(vuart->port);
 	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
 }
 
diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 0609582a62f7..be7e132bb314 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -14,6 +14,7 @@
 
 #include <linux/clk.h>
 #include <linux/console.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -37,12 +38,12 @@
 /**
  * struct bcm2835aux_data - driver private data of BCM2835 auxiliary UART
  * @clk: clock producer of the port's uartclk
- * @line: index of the port's serial8250_ports[] entry
+ * @uport: the underlying uart_8250_port
  * @cntl: cached copy of CNTL register
  */
 struct bcm2835aux_data {
 	struct clk *clk;
-	int line;
+	struct uart_8250_port *uport;
 	u32 cntl;
 };
 
@@ -157,12 +158,12 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	up.port.uartclk *= 2;
 
 	/* register the port */
-	ret = serial8250_register_8250_port(&up);
-	if (ret < 0) {
+	data->uport = serial8250_register_8250_port(&up);
+	if (IS_ERR(data->uport)) {
+		ret = PTR_ERR(data->uport);
 		dev_err_probe(&pdev->dev, ret, "unable to register 8250 port\n");
 		goto dis_clk;
 	}
-	data->line = ret;
 
 	return 0;
 
@@ -177,7 +178,7 @@ static void bcm2835aux_serial_remove(struct platform_device *pdev)
 {
 	struct bcm2835aux_data *data = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(data->line);
+	serial8250_unregister_port(data->uport);
 	clk_disable_unprepare(data->clk);
 	device_remove_software_node(&pdev->dev);
 }
@@ -217,12 +218,11 @@ MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_match);
 static bool bcm2835aux_can_disable_clock(struct device *dev)
 {
 	struct bcm2835aux_data *data = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(data->line);
 
 	if (device_may_wakeup(dev))
 		return false;
 
-	if (uart_console(&up->port) && !console_suspend_enabled)
+	if (uart_console(&data->uport->port) && !console_suspend_enabled)
 		return false;
 
 	return true;
@@ -232,7 +232,7 @@ static int bcm2835aux_suspend(struct device *dev)
 {
 	struct bcm2835aux_data *data = dev_get_drvdata(dev);
 
-	serial8250_suspend_port(data->line);
+	serial8250_suspend_port(data->uport);
 
 	if (!bcm2835aux_can_disable_clock(dev))
 		return 0;
@@ -252,7 +252,7 @@ static int bcm2835aux_resume(struct device *dev)
 			return ret;
 	}
 
-	serial8250_resume_port(data->line);
+	serial8250_resume_port(data->uport);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 5f1140f05150..974d9af146a1 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/tty.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -204,13 +205,12 @@ static const u32 brcmstb_rate_table_7278[] = {
 };
 
 struct brcmuart_priv {
-	int		line;
 	struct clk	*baud_mux_clk;
 	unsigned long	default_mux_rate;
 	u32		real_rates[ARRAY_SIZE(brcmstb_rate_table)];
 	const u32	*rate_table;
 	ktime_t		char_wait;
-	struct uart_port *up;
+	struct uart_8250_port *uport;
 	struct hrtimer	hrt;
 	bool		shutdown;
 	bool		dma_enabled;
@@ -839,8 +839,8 @@ static int brcmuart_handle_irq(struct uart_port *p)
 static enum hrtimer_restart brcmuart_hrtimer_func(struct hrtimer *t)
 {
 	struct brcmuart_priv *priv = container_of(t, struct brcmuart_priv, hrt);
-	struct uart_port *p = priv->up;
-	struct uart_8250_port *up = up_to_u8250p(p);
+	struct uart_8250_port *up = priv->uport;
+	struct uart_port *p = &up->port;
 	unsigned int status;
 	unsigned long flags;
 
@@ -953,7 +953,6 @@ static int brcmuart_probe(struct platform_device *pdev)
 {
 	struct resource *regs;
 	const struct of_device_id *of_id = NULL;
-	struct uart_8250_port *new_port;
 	struct device *dev = &pdev->dev;
 	struct brcmuart_priv *priv;
 	struct clk *baud_mux_clk;
@@ -1083,14 +1082,12 @@ static int brcmuart_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = serial8250_register_8250_port(&up);
-	if (ret < 0) {
+	priv->uport = serial8250_register_8250_port(&up);
+	if (IS_ERR(priv->uport)) {
+		ret = PTR_ERR(priv->uport);
 		dev_err_probe(dev, ret, "unable to register 8250 port\n");
 		goto err;
 	}
-	priv->line = ret;
-	new_port = serial8250_get_port(ret);
-	priv->up = &new_port->port;
 	if (priv->dma_enabled) {
 		dma_irq = platform_get_irq_byname(pdev,  "dma");
 		if (dma_irq < 0) {
@@ -1098,7 +1095,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 			goto err1;
 		}
 		ret = devm_request_irq(dev, dma_irq, brcmuart_isr,
-				IRQF_SHARED, "uart DMA irq", &new_port->port);
+				IRQF_SHARED, "uart DMA irq", &priv->uport->port);
 		if (ret)
 			goto err1;
 	}
@@ -1107,7 +1104,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	return 0;
 
 err1:
-	serial8250_unregister_port(priv->line);
+	serial8250_unregister_port(priv->uport);
 err:
 	brcmuart_free_bufs(dev, priv);
 release_dma:
@@ -1121,7 +1118,7 @@ static void brcmuart_remove(struct platform_device *pdev)
 	struct brcmuart_priv *priv = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(priv->debugfs_dir);
-	serial8250_unregister_port(priv->line);
+	serial8250_unregister_port(priv->uport);
 	hrtimer_cancel(&priv->hrt);
 	brcmuart_free_bufs(&pdev->dev, priv);
 	if (priv->dma_enabled)
@@ -1131,7 +1128,7 @@ static void brcmuart_remove(struct platform_device *pdev)
 static int __maybe_unused brcmuart_suspend(struct device *dev)
 {
 	struct brcmuart_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct uart_8250_port *up = priv->uport;
 	struct uart_port *port = &up->port;
 	unsigned long flags;
 
@@ -1144,7 +1141,7 @@ static int __maybe_unused brcmuart_suspend(struct device *dev)
 	port->mctrl &= ~TIOCM_RTS;
 	uart_port_unlock_irqrestore(port, flags);
 
-	serial8250_suspend_port(priv->line);
+	serial8250_suspend_port(up);
 	clk_disable_unprepare(priv->baud_mux_clk);
 
 	return 0;
@@ -1153,7 +1150,7 @@ static int __maybe_unused brcmuart_suspend(struct device *dev)
 static int __maybe_unused brcmuart_resume(struct device *dev)
 {
 	struct brcmuart_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct uart_8250_port *up = priv->uport;
 	struct uart_port *port = &up->port;
 	unsigned long flags;
 	int ret;
@@ -1175,9 +1172,9 @@ static int __maybe_unused brcmuart_resume(struct device *dev)
 			return(-EBUSY);
 		}
 		brcmuart_init_dma_hardware(priv);
-		start_rx_dma(serial8250_get_port(priv->line));
+		start_rx_dma(up);
 	}
-	serial8250_resume_port(priv->line);
+	serial8250_resume_port(up);
 
 	if (priv->saved_mctrl & TIOCM_RTS) {
 		/* Restore RTS */
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 7ff307ce6aa8..42319843cb5b 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -16,6 +16,7 @@
 #include <linux/hashtable.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/err.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/console.h>
@@ -333,7 +334,6 @@ struct uart_8250_port *serial8250_get_port(int line)
 {
 	return &serial8250_ports[line];
 }
-EXPORT_SYMBOL_GPL(serial8250_get_port);
 
 static inline void serial8250_apply_quirks(struct uart_8250_port *up)
 {
@@ -600,13 +600,12 @@ int __init early_serial_setup(struct uart_port *port)
 
 /**
  *	serial8250_suspend_port - suspend one serial port
- *	@line:  serial line number
+ *	@up: serial port
  *
  *	Suspend one serial port.
  */
-void serial8250_suspend_port(int line)
+void serial8250_suspend_port(struct uart_8250_port *up)
 {
-	struct uart_8250_port *up = &serial8250_ports[line];
 	struct uart_port *port = &up->port;
 
 	if (uart_console(port)) {
@@ -630,13 +629,12 @@ EXPORT_SYMBOL(serial8250_suspend_port);
 
 /**
  *	serial8250_resume_port - resume one serial port
- *	@line:  serial line number
+ *	@up: serial port
  *
  *	Resume one serial port.
  */
-void serial8250_resume_port(int line)
+void serial8250_resume_port(struct uart_8250_port *up)
 {
-	struct uart_8250_port *up = &serial8250_ports[line];
 	struct uart_port *port = &up->port;
 
 	up->canary = 0;
@@ -865,16 +863,12 @@ static int __serial8250_register_8250_port(struct uart_8250_port *uart,
 					&uart->port);
 		if (ret)
 			return ret;
-
-		ret = uart->port.line;
 	} else {
 		dev_info(uart->port.dev,
 			"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
 			uart->port.iobase,
 			(unsigned long long)uart->port.mapbase,
 			uart->port.irq);
-
-		ret = 0;
 	}
 
 	if (!uart->lsr_save_mask)
@@ -890,7 +884,7 @@ static int __serial8250_register_8250_port(struct uart_8250_port *uart,
 		uart->overrun_backoff_time_ms = 0;
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -906,13 +900,13 @@ static int __serial8250_register_8250_port(struct uart_8250_port *uart,
  *
  *	On success the port is ready to use and the line number is returned.
  */
-int serial8250_register_8250_port(const struct uart_8250_port *up)
+struct uart_8250_port *serial8250_register_8250_port(const struct uart_8250_port *up)
 {
 	struct uart_8250_port *uart;
 	int ret;
 
 	if (up->port.uartclk == 0)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	guard(mutex)(&serial_mutex);
 
@@ -924,33 +918,33 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		 */
 		uart = serial8250_setup_port(nr_uarts);
 		if (!uart)
-			return -ENOSPC;
+			return ERR_PTR(-ENOSPC);
 		nr_uarts++;
 	}
 
 	/* Check if it is CIR already. We check this below again, see there why. */
 	if (uart->port.type == PORT_8250_CIR)
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 
 	ret = __serial8250_register_8250_port(uart, up);
-	if (ret < 0)
+	if (ret < 0) {
 		uart->port.dev = NULL;
+		return ERR_PTR(ret);
+	}
 
-	return ret;
+	return uart;
 }
 EXPORT_SYMBOL(serial8250_register_8250_port);
 
 /**
  *	serial8250_unregister_port - remove a 16x50 serial port at runtime
- *	@line: serial line number
+ *	@uart: port
  *
  *	Remove one serial port.  This may not be called from interrupt
  *	context.  We hand the port back to the our control.
  */
-void serial8250_unregister_port(int line)
+void serial8250_unregister_port(struct uart_8250_port *uart)
 {
-	struct uart_8250_port *uart = &serial8250_ports[line];
-
 	guard(mutex)(&serial_mutex);
 
 	if (uart->em485) {
@@ -963,7 +957,7 @@ void serial8250_unregister_port(int line)
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
 		uart->port.type = PORT_UNKNOWN;
 		uart->port.dev = &serial8250_isa_devs->dev;
-		uart->port.port_id = line;
+		uart->port.port_id = uart->port.line;
 		uart->capabilities = 0;
 		serial8250_init_port(uart);
 		serial8250_apply_quirks(uart);
diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
index 475ca340948c..1343375897a8 100644
--- a/drivers/tty/serial/8250/8250_dfl.c
+++ b/drivers/tty/serial/8250/8250_dfl.c
@@ -12,6 +12,7 @@
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/dfl.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
@@ -27,10 +28,6 @@
 #define DFHv1_PARAM_REG_LAYOUT_WIDTH	GENMASK_ULL(63, 32)
 #define DFHv1_PARAM_REG_LAYOUT_SHIFT	GENMASK_ULL(31, 0)
 
-struct dfl_uart {
-	int line;
-};
-
 static int dfh_get_u64_param_val(struct dfl_device *dfl_dev, int param_id, u64 *pval)
 {
 	size_t psize;
@@ -109,7 +106,6 @@ static int dfl_uart_probe(struct dfl_device *dfl_dev)
 {
 	struct device *dev = &dfl_dev->dev;
 	struct uart_8250_port uart = { };
-	struct dfl_uart *dfluart;
 	int ret;
 
 	uart.port.flags = UPF_IOREMAP;
@@ -123,24 +119,20 @@ static int dfl_uart_probe(struct dfl_device *dfl_dev)
 	if (dfl_dev->num_irqs == 1)
 		uart.port.irq = dfl_dev->irqs[0];
 
-	dfluart = devm_kzalloc(dev, sizeof(*dfluart), GFP_KERNEL);
-	if (!dfluart)
-		return -ENOMEM;
-
-	dfluart->line = serial8250_register_8250_port(&uart);
-	if (dfluart->line < 0)
-		return dev_err_probe(dev, dfluart->line, "unable to register 8250 port.\n");
+	struct uart_8250_port *uport = serial8250_register_8250_port(&uart);
+	if (IS_ERR(uport))
+		return dev_err_probe(dev, PTR_ERR(uport), "unable to register 8250 port.\n");
 
-	dev_set_drvdata(dev, dfluart);
+	dev_set_drvdata(dev, uport);
 
 	return 0;
 }
 
 static void dfl_uart_remove(struct dfl_device *dfl_dev)
 {
-	struct dfl_uart *dfluart = dev_get_drvdata(&dfl_dev->dev);
+	struct uart_8250_port *uport = dev_get_drvdata(&dfl_dev->dev);
 
-	serial8250_unregister_port(dfluart->line);
+	serial8250_unregister_port(uport);
 }
 
 #define FME_FEATURE_ID_UART 0x24
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 0ab558230370..eca02e8bd6d1 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/lockdep.h>
 #include <linux/module.h>
@@ -774,9 +775,9 @@ static int dw8250_probe(struct platform_device *pdev)
 		up->dma = &data->data.dma;
 	}
 
-	data->data.line = serial8250_register_8250_port(up);
-	if (data->data.line < 0)
-		return data->data.line;
+	data->data.uport = serial8250_register_8250_port(up);
+	if (IS_ERR(data->data.uport))
+		return PTR_ERR(data->data.uport);
 
 	platform_set_drvdata(pdev, data);
 
@@ -792,7 +793,7 @@ static void dw8250_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(dev);
 
-	serial8250_unregister_port(data->data.line);
+	serial8250_unregister_port(data->data.uport);
 
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
@@ -802,7 +803,7 @@ static int dw8250_suspend(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	serial8250_suspend_port(data->data.line);
+	serial8250_suspend_port(data->data.uport);
 
 	return 0;
 }
@@ -811,7 +812,7 @@ static int dw8250_resume(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	serial8250_resume_port(data->data.line);
+	serial8250_resume_port(data->data.uport);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index ee7a07fac0f6..39fcb1b323ad 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -80,7 +80,7 @@
 
 struct dw8250_port_data {
 	/* Port properties */
-	int			line;
+	struct uart_8250_port *uport;
 
 	/* DMA operations */
 	struct uart_8250_dma	dma;
diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index 32d077da076a..bcb71ff8ee8b 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/serial_8250.h>
@@ -28,10 +29,6 @@
 
 #define UART_HCR0_EM_SW_RESET	BIT(7) /* SW Reset */
 
-struct serial8250_em_priv {
-	int line;
-};
-
 static void serial8250_em_serial_out_helper(struct uart_port *p, int offset,
 					    int value)
 {
@@ -151,12 +148,11 @@ static void serial8250_em_serial_dl_write(struct uart_8250_port *up, u32 value)
 
 static int serial8250_em_probe(struct platform_device *pdev)
 {
-	struct serial8250_em_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct uart_8250_port up;
 	struct resource *regs;
 	struct clk *sclk;
-	int irq, ret;
+	int irq;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -166,10 +162,6 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	if (!regs)
 		return dev_err_probe(dev, -EINVAL, "missing registers\n");
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
 	sclk = devm_clk_get_enabled(dev, "sclk");
 	if (IS_ERR(sclk))
 		return dev_err_probe(dev, PTR_ERR(sclk), "unable to get clock\n");
@@ -180,7 +172,6 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	up.port.type = PORT_16750;
 	up.port.flags = UPF_FIXED_PORT | UPF_IOREMAP | UPF_FIXED_TYPE;
 	up.port.dev = dev;
-	up.port.private_data = priv;
 
 	up.port.uartclk = clk_get_rate(sclk);
 
@@ -190,20 +181,19 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	up.dl_read = serial8250_em_serial_dl_read;
 	up.dl_write = serial8250_em_serial_dl_write;
 
-	ret = serial8250_register_8250_port(&up);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "unable to register 8250 port\n");
+	struct uart_8250_port *uport = serial8250_register_8250_port(&up);
+	if (IS_ERR(uport))
+		return dev_err_probe(dev, PTR_ERR(uport), "unable to register 8250 port\n");
 
-	priv->line = ret;
-	platform_set_drvdata(pdev, priv);
+	platform_set_drvdata(pdev, uport);
 	return 0;
 }
 
 static void serial8250_em_remove(struct platform_device *pdev)
 {
-	struct serial8250_em_priv *priv = platform_get_drvdata(pdev);
+	struct uart_8250_port *up = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(priv->line);
+	serial8250_unregister_port(up);
 }
 
 static const struct of_device_id serial8250_em_dt_ids[] = {
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 29b2a29ab6f3..57847c5bd2fc 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/eeprom_93cx6.h>
+#include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/math.h>
@@ -258,7 +259,7 @@ struct exar8250 {
 	struct eeprom_93cx6	eeprom;
 	void __iomem		*virt;
 	struct platform_device	*gpio;
-	int			line[];
+	struct uart_8250_port	*uport[];
 };
 
 static inline void exar_write_reg(struct exar8250 *priv,
@@ -1460,7 +1461,7 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 	if (nr_ports == 0)
 		return dev_err_probe(&pcidev->dev, -ENODEV, "failed to get number of ports\n");
 
-	priv = devm_kzalloc(&pcidev->dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
+	priv = devm_kzalloc(&pcidev->dev, struct_size(priv, uport, nr_ports), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -1500,9 +1501,9 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 		dev_dbg(&pcidev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
 			uart.port.iobase, uart.port.irq, uart.port.iotype);
 
-		priv->line[i] = serial8250_register_8250_port(&uart);
-		if (priv->line[i] < 0) {
-			dev_err_probe(&pcidev->dev, priv->line[i],
+		priv->uport[i] = serial8250_register_8250_port(&uart);
+		if (IS_ERR(priv->uport[i])) {
+			dev_err_probe(&pcidev->dev, PTR_ERR(priv->uport[i]),
 				"Couldn't register serial port %lx, type %d, irq %d\n",
 				uart.port.iobase, uart.port.iotype, uart.port.irq);
 			break;
@@ -1519,7 +1520,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	unsigned int i;
 
 	for (i = 0; i < priv->nr; i++)
-		serial8250_unregister_port(priv->line[i]);
+		serial8250_unregister_port(priv->uport[i]);
 
 	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
@@ -1532,8 +1533,7 @@ static int exar_suspend(struct device *dev)
 	unsigned int i;
 
 	for (i = 0; i < priv->nr; i++)
-		if (priv->line[i] >= 0)
-			serial8250_suspend_port(priv->line[i]);
+		serial8250_suspend_port(priv->uport[i]);
 
 	return 0;
 }
@@ -1546,8 +1546,7 @@ static int exar_resume(struct device *dev)
 	exar_misc_clear(priv);
 
 	for (i = 0; i < priv->nr; i++)
-		if (priv->line[i] >= 0)
-			serial8250_resume_port(priv->line[i]);
+		serial8250_resume_port(priv->uport[i]);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 649ae5c8304d..3578d70594ed 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/err.h>
 #include <linux/serial_reg.h>
 #include <linux/serial_8250.h>
 
@@ -99,14 +100,9 @@ int fsl8250_handle_irq(struct uart_port *port)
 EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
 
 #ifdef CONFIG_ACPI
-struct fsl8250_data {
-	int	line;
-};
-
 static int fsl8250_acpi_probe(struct platform_device *pdev)
 {
-	struct fsl8250_data *data;
-	struct uart_8250_port port8250;
+	struct uart_8250_port *uport, port8250;
 	struct device *dev = &pdev->dev;
 	struct resource *regs;
 
@@ -148,23 +144,19 @@ static int fsl8250_acpi_probe(struct platform_device *pdev)
 	if (!port8250.port.membase)
 		return -ENOMEM;
 
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->line = serial8250_register_8250_port(&port8250);
-	if (data->line < 0)
-		return data->line;
+	uport = serial8250_register_8250_port(&port8250);
+	if (IS_ERR(uport))
+		return PTR_ERR(uport);
 
-	platform_set_drvdata(pdev, data);
+	platform_set_drvdata(pdev, uport);
 	return 0;
 }
 
 static void fsl8250_acpi_remove(struct platform_device *pdev)
 {
-	struct fsl8250_data *data = platform_get_drvdata(pdev);
+	struct uart_8250_port *uport = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(data->line);
+	serial8250_unregister_port(uport);
 }
 
 static const struct acpi_device_id fsl_8250_acpi_id[] = {
diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index 59ec0c7377a1..e9599c5c2fea 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -7,6 +7,7 @@
  * by Kars de Jong <jongk@linux-m68k.org>, May 2004.
  */
 #include <linux/module.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -27,7 +28,7 @@
 #ifdef CONFIG_HPAPCI
 struct hp300_port {
 	struct hp300_port *next;	/* next port */
-	int line;			/* line (tty) number */
+	struct uart_8250_port *uport;
 };
 
 static struct hp300_port *hp300_ports;
@@ -157,8 +158,7 @@ int __init hp300_setup_serial_console(void)
 static int hpdca_init_one(struct dio_dev *d,
 				const struct dio_device_id *ent)
 {
-	struct uart_8250_port uart;
-	int line;
+	struct uart_8250_port *uport, uart;
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	if (hp300_uart_scode == d->scode) {
@@ -177,9 +177,8 @@ static int hpdca_init_one(struct dio_dev *d,
 	uart.port.membase = (char *)(uart.port.mapbase + DIO_VIRADDRBASE);
 	uart.port.regshift = 1;
 	uart.port.dev = &d->dev;
-	line = serial8250_register_8250_port(&uart);
-
-	if (line < 0) {
+	uport = serial8250_register_8250_port(&uart);
+	if (IS_ERR(uport)) {
 		dev_notice(&d->dev,
 			  "8250_hp300: register_serial() DCA scode %d irq %d failed\n",
 			  d->scode, uart.port.irq);
@@ -188,7 +187,7 @@ static int hpdca_init_one(struct dio_dev *d,
 
 	/* Enable board-interrupts */
 	out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, DCA_IC_IE);
-	dio_set_drvdata(d, (void *)line);
+	dio_set_drvdata(d, uport);
 
 	/* Reset the DCA */
 	out_8(d->resource.start + DIO_VIRADDRBASE + DCA_ID, 0xff);
@@ -204,7 +203,6 @@ static int __init hp300_8250_init(void)
 {
 	static int called;
 #ifdef CONFIG_HPAPCI
-	int line;
 	unsigned long base;
 	struct uart_8250_port uart;
 	struct hp300_port *port;
@@ -259,9 +257,8 @@ static int __init hp300_8250_init(void)
 		uart.port.membase = (char *)(base + DIO_VIRADDRBASE);
 		uart.port.regshift = 2;
 
-		line = serial8250_register_8250_port(&uart);
-
-		if (line < 0) {
+		port->uport = serial8250_register_8250_port(&uart);
+		if (IS_ERR(port->uport)) {
 			dev_notice(uart.port.dev,
 				   "8250_hp300: register_serial() APCI %d irq %d failed\n",
 				   i, uart.port.irq);
@@ -269,7 +266,6 @@ static int __init hp300_8250_init(void)
 			continue;
 		}
 
-		port->line = line;
 		port->next = hp300_ports;
 		hp300_ports = port;
 
@@ -287,14 +283,13 @@ static int __init hp300_8250_init(void)
 #ifdef CONFIG_HPDCA
 static void hpdca_remove_one(struct dio_dev *d)
 {
-	int line;
+	struct uart_8250_port *uport = dio_get_drvdata(d);
 
-	line = (int) dio_get_drvdata(d);
 	if (d->resource.start) {
 		/* Disable board-interrupts */
 		out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, 0);
 	}
-	serial8250_unregister_port(line);
+	serial8250_unregister_port(uport);
 }
 #endif
 
@@ -304,7 +299,7 @@ static void __exit hp300_8250_exit(void)
 	struct hp300_port *port, *to_free;
 
 	for (port = hp300_ports; port; ) {
-		serial8250_unregister_port(port->line);
+		serial8250_unregister_port(port->uport);
 		to_free = port;
 		port = port->next;
 		kfree(to_free);
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 94542fc143c2..0cdadacd7019 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/console.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/libfdt.h>
 #include <linux/module.h>
@@ -29,7 +30,7 @@ struct ingenic_uart_config {
 struct ingenic_uart_data {
 	struct clk	*clk_module;
 	struct clk	*clk_baud;
-	int		line;
+	struct uart_8250_port *uport;
 };
 
 static const struct of_device_id of_match[];
@@ -297,9 +298,9 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	}
 	uart.port.uartclk = clk_get_rate(data->clk_baud);
 
-	data->line = serial8250_register_8250_port(&uart);
-	if (data->line < 0) {
-		err = data->line;
+	data->uport = serial8250_register_8250_port(&uart);
+	if (IS_ERR(data->uport)) {
+		err = PTR_ERR(data->uport);
 		goto out_disable_baudclk;
 	}
 
@@ -318,7 +319,7 @@ static void ingenic_uart_remove(struct platform_device *pdev)
 {
 	struct ingenic_uart_data *data = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(data->line);
+	serial8250_unregister_port(data->uport);
 	clk_disable_unprepare(data->clk_module);
 	clk_disable_unprepare(data->clk_baud);
 }
diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
index 28e28076782b..088242de2eff 100644
--- a/drivers/tty/serial/8250/8250_ioc3.c
+++ b/drivers/tty/serial/8250/8250_ioc3.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -17,10 +18,6 @@
 
 #define IOC3_UARTCLK (22000000 / 3)
 
-struct ioc3_8250_data {
-	int line;
-};
-
 static u32 ioc3_serial_in(struct uart_port *p, unsigned int offset)
 {
 	return readb(p->membase + (offset ^ 3));
@@ -33,20 +30,15 @@ static void ioc3_serial_out(struct uart_port *p, unsigned int offset, u32 value)
 
 static int serial8250_ioc3_probe(struct platform_device *pdev)
 {
-	struct ioc3_8250_data *data;
-	struct uart_8250_port up;
+	struct uart_8250_port *uport, up;
 	struct resource *r;
 	void __iomem *membase;
-	int irq, line;
+	int irq;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r)
 		return -ENODEV;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
 	membase = devm_ioremap(&pdev->dev, r->start, resource_size(r));
 	if (!membase)
 		return -ENOMEM;
@@ -67,19 +59,19 @@ static int serial8250_ioc3_probe(struct platform_device *pdev)
 	up.port.mapbase = r->start;
 	up.port.serial_in = ioc3_serial_in;
 	up.port.serial_out = ioc3_serial_out;
-	line = serial8250_register_8250_port(&up);
-	if (line < 0)
-		return line;
+	uport = serial8250_register_8250_port(&up);
+	if (IS_ERR(uport))
+		return PTR_ERR(uport);
 
-	platform_set_drvdata(pdev, data);
+	platform_set_drvdata(pdev, uport);
 	return 0;
 }
 
 static void serial8250_ioc3_remove(struct platform_device *pdev)
 {
-	struct ioc3_8250_data *data = platform_get_drvdata(pdev);
+	struct uart_8250_port *uport = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(data->line);
+	serial8250_unregister_port(uport);
 }
 
 static struct platform_driver serial8250_ioc3_driver = {
diff --git a/drivers/tty/serial/8250/8250_keba.c b/drivers/tty/serial/8250/8250_keba.c
index 5b791b6eefd0..c53ca05a57d7 100644
--- a/drivers/tty/serial/8250/8250_keba.c
+++ b/drivers/tty/serial/8250/8250_keba.c
@@ -62,7 +62,7 @@ enum kuart_mode {
 struct kuart {
 	struct keba_uart_auxdev *auxdev;
 	void __iomem *base;
-	unsigned int line;
+	struct uart_8250_port *uport;
 
 	unsigned int flags;
 	u8 capability;
@@ -174,7 +174,6 @@ static int kuart_probe(struct auxiliary_device *auxdev,
 	struct uart_8250_port uart = {};
 	struct resource res;
 	struct kuart *kuart;
-	int retval;
 
 	kuart = devm_kzalloc(dev, sizeof(*kuart), GFP_KERNEL);
 	if (!kuart)
@@ -250,12 +249,10 @@ static int kuart_probe(struct auxiliary_device *auxdev,
 		}
 	}
 
-	retval = serial8250_register_8250_port(&uart);
-	if (retval < 0)
-		return dev_err_probe(&auxdev->dev, retval,
+	kuart->uport = serial8250_register_8250_port(&uart);
+	if (IS_ERR(kuart->uport))
+		return dev_err_probe(&auxdev->dev, PTR_ERR(kuart->uport),
 				     "UART registration failed!\n");
-	kuart->line = retval;
-
 	return 0;
 }
 
@@ -266,7 +263,7 @@ static void kuart_remove(struct auxiliary_device *auxdev)
 	if (kuart->flags & KUART_USE_CAPABILITY)
 		kuart_set_phy_mode(kuart, KUART_MODE_NONE);
 
-	serial8250_unregister_port(kuart->line);
+	serial8250_unregister_port(kuart->uport);
 }
 
 static const struct auxiliary_device_id kuart_devtype_aux[] = {
diff --git a/drivers/tty/serial/8250/8250_loongson.c b/drivers/tty/serial/8250/8250_loongson.c
index 19acb2c6b611..6d06ed28382d 100644
--- a/drivers/tty/serial/8250/8250_loongson.c
+++ b/drivers/tty/serial/8250/8250_loongson.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/module.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/property.h>
 #include <linux/math.h>
@@ -43,7 +44,7 @@ static const struct loongson_uart_ddata ls2k1500_uart_data = {
 };
 
 struct loongson_uart_priv {
-	int line;
+	struct uart_8250_port *uport;
 	struct clk *clk;
 	struct resource *res;
 	struct reset_control *rst;
@@ -160,13 +161,12 @@ static int loongson_uart_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = serial8250_register_8250_port(&uart);
-	if (ret < 0) {
+	priv->uport = serial8250_register_8250_port(&uart);
+	if (IS_ERR(priv->uport)) {
 		reset_control_assert(priv->rst);
-		return ret;
+		return PTR_ERR(priv->uport);
 	}
 
-	priv->line = ret;
 	platform_set_drvdata(pdev, priv);
 
 	return 0;
@@ -176,16 +176,16 @@ static void loongson_uart_remove(struct platform_device *pdev)
 {
 	struct loongson_uart_priv *priv = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(priv->line);
+	serial8250_unregister_port(priv->uport);
 	reset_control_assert(priv->rst);
 }
 
 static int loongson_uart_suspend(struct device *dev)
 {
 	struct loongson_uart_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct uart_8250_port *up = priv->uport;
 
-	serial8250_suspend_port(priv->line);
+	serial8250_suspend_port(up);
 
 	if (!uart_console(&up->port) || console_suspend_enabled)
 		clk_disable_unprepare(priv->clk);
@@ -196,7 +196,7 @@ static int loongson_uart_suspend(struct device *dev)
 static int loongson_uart_resume(struct device *dev)
 {
 	struct loongson_uart_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct uart_8250_port *up = priv->uport;
 	int ret;
 
 	if (!uart_console(&up->port) || console_suspend_enabled) {
@@ -205,7 +205,7 @@ static int loongson_uart_resume(struct device *dev)
 			return ret;
 	}
 
-	serial8250_resume_port(priv->line);
+	serial8250_resume_port(up);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 6c0489c9c253..5d4d4366e711 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -29,7 +30,7 @@ struct lpc18xx_uart_data {
 	struct uart_8250_dma dma;
 	struct clk *clk_uart;
 	struct clk *clk_reg;
-	int line;
+	struct uart_8250_port *uport;
 };
 
 static int lpc18xx_rs485_config(struct uart_port *port, struct ktermios *termios,
@@ -160,13 +161,13 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 	uart.dma->rxconf.src_maxburst = 1;
 	uart.dma->txconf.dst_maxburst = 1;
 
-	ret = serial8250_register_8250_port(&uart);
-	if (ret < 0) {
+	data->uport = serial8250_register_8250_port(&uart);
+	if (IS_ERR(data->uport)) {
+		ret = PTR_ERR(data->uport);
 		dev_err(&pdev->dev, "unable to register 8250 port\n");
 		goto dis_uart_clk;
 	}
 
-	data->line = ret;
 	platform_set_drvdata(pdev, data);
 
 	return 0;
@@ -182,7 +183,7 @@ static void lpc18xx_serial_remove(struct platform_device *pdev)
 {
 	struct lpc18xx_uart_data *data = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(data->line);
+	serial8250_unregister_port(data->uport);
 	clk_disable_unprepare(data->clk_uart);
 	clk_disable_unprepare(data->clk_reg);
 }
diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 325e587ae2c4..f1b4b975571a 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/rational.h>
@@ -183,8 +184,8 @@ static int ehl_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 
 static void ehl_serial_exit(struct lpss8250 *lpss)
 {
-	if (lpss->data.line >= 0)
-		serial8250_get_port(lpss->data.line)->dma = NULL;
+	if (lpss->data.uport)
+		lpss->data.uport->dma = NULL;
 }
 
 #ifdef CONFIG_SERIAL_8250_DMA
@@ -328,8 +329,6 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 
 	lpss->board = (struct lpss8250_board *)id->driver_data;
-	/* for tests in lpss->board->exit() */
-	lpss->data.line = -1;
 
 	memset(&uart, 0, sizeof(struct uart_8250_port));
 
@@ -357,11 +356,12 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto err_exit;
 
-	ret = serial8250_register_8250_port(&uart);
-	if (ret < 0)
+	struct uart_8250_port *uport = serial8250_register_8250_port(&uart);
+	if (IS_ERR(uport)) {
+		ret = PTR_ERR(uport);
 		goto err_exit;
-
-	lpss->data.line = ret;
+	}
+	lpss->data.uport = uport;
 
 	pci_set_drvdata(pdev, lpss);
 	return 0;
@@ -376,7 +376,7 @@ static void lpss8250_remove(struct pci_dev *pdev)
 {
 	struct lpss8250 *lpss = pci_get_drvdata(pdev);
 
-	serial8250_unregister_port(lpss->data.line);
+	serial8250_unregister_port(lpss->data.uport);
 
 	lpss->board->exit(lpss);
 	pci_free_irq_vectors(pdev);
diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index 6373234da03d..1f34e58aaeaf 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -2,6 +2,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/mcb.h>
 #include <linux/serial.h>
@@ -42,7 +43,7 @@
 
 struct serial_8250_men_mcb_data {
 	int num_ports;
-	int line[MEN_Z025_MAX_UARTS];
+	struct uart_8250_port *uport[MEN_Z025_MAX_UARTS];
 	unsigned int offset[MEN_Z025_MAX_UARTS];
 };
 
@@ -218,14 +219,13 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 					    + data->offset[i];
 
 		/* ok, register the port */
-		res = serial8250_register_8250_port(&uart);
-		if (res < 0) {
+		data->uport[i] = serial8250_register_8250_port(&uart);
+		if (IS_ERR(data->uport[i])) {
 			dev_err(&mdev->dev, "unable to register UART port\n");
-			return res;
+			return PTR_ERR(data->uport[i]);
 		}
 
-		data->line[i] = res;
-		dev_info(&mdev->dev, "found MCB UART: ttyS%d\n", data->line[i]);
+		dev_info(&mdev->dev, "found MCB UART: ttyS%d\n", data->uport[i]->port.line);
 	}
 
 	return 0;
@@ -240,7 +240,7 @@ static void serial_8250_men_mcb_remove(struct mcb_device *mdev)
 		return;
 
 	for (i = 0; i < data->num_ports; i++)
-		serial8250_unregister_port(data->line[i]);
+		serial8250_unregister_port(data->uport[i]);
 }
 
 static const struct mcb_device_id serial_8250_men_mcb_ids[] = {
diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 47f820fcd1a4..44b43163df51 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/rational.h>
@@ -41,7 +42,7 @@ struct mid8250_board {
 };
 
 struct mid8250 {
-	int line;
+	struct uart_8250_port *uport;
 	int dma_index;
 	struct pci_dev *dma_dev;
 	struct uart_8250_dma dma;
@@ -335,11 +336,11 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto err;
 
-	ret = serial8250_register_8250_port(&uart);
-	if (ret < 0)
+	mid->uport = serial8250_register_8250_port(&uart);
+	if (IS_ERR(mid->uport)) {
+		ret = PTR_ERR(mid->uport);
 		goto err;
-
-	mid->line = ret;
+	}
 
 	pci_set_drvdata(pdev, mid);
 	return 0;
@@ -354,7 +355,7 @@ static void mid8250_remove(struct pci_dev *pdev)
 {
 	struct mid8250 *mid = pci_get_drvdata(pdev);
 
-	serial8250_unregister_port(mid->line);
+	serial8250_unregister_port(mid->uport);
 
 	if (mid->board->exit)
 		mid->board->exit(mid);
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 841d64f6a707..d1fb917b762a 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -6,6 +6,7 @@
  * Author: Matthias Brugger <matthias.bgg@gmail.com>
  */
 #include <linux/clk.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -68,7 +69,7 @@ enum dma_rx_status {
 #endif
 
 struct mtk8250_data {
-	int			line;
+	struct uart_8250_port	*uport;
 	unsigned int		rx_pos;
 	unsigned int		clk_count;
 	struct clk		*uart_clk;
@@ -431,7 +432,7 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(data->line);
+	struct uart_8250_port *up = data->uport;
 
 	/* wait until UART in idle status */
 	while
@@ -587,9 +588,9 @@ static int mtk8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	data->line = serial8250_register_8250_port(&uart);
-	if (data->line < 0)
-		return data->line;
+	data->uport = serial8250_register_8250_port(&uart);
+	if (IS_ERR(data->uport))
+		return PTR_ERR(data->uport);
 
 	data->rx_wakeup_irq = platform_get_irq_optional(pdev, 1);
 
@@ -605,7 +606,7 @@ static void mtk8250_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 
-	serial8250_unregister_port(data->line);
+	serial8250_unregister_port(data->uport);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
@@ -617,7 +618,7 @@ static int __maybe_unused mtk8250_suspend(struct device *dev)
 	int irq = data->rx_wakeup_irq;
 	int err;
 
-	serial8250_suspend_port(data->line);
+	serial8250_suspend_port(data->uport);
 
 	pinctrl_pm_select_sleep_state(dev);
 	if (irq >= 0) {
@@ -627,7 +628,7 @@ static int __maybe_unused mtk8250_suspend(struct device *dev)
 				"failed to enable irq wake on IRQ %d: %d\n",
 				irq, err);
 			pinctrl_pm_select_default_state(dev);
-			serial8250_resume_port(data->line);
+			serial8250_resume_port(data->uport);
 			return err;
 		}
 	}
@@ -644,7 +645,7 @@ static int __maybe_unused mtk8250_resume(struct device *dev)
 		disable_irq_wake(irq);
 	pinctrl_pm_select_default_state(dev);
 
-	serial8250_resume_port(data->line);
+	serial8250_resume_port(data->uport);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 19f1f51eec47..4935a5d1c1a3 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -9,6 +9,7 @@
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/dev_printk.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
@@ -102,7 +103,7 @@
 #define MOXA_ODD_RS_MASK	GENMASK(7, 4)
 
 struct mxpcie8250_port {
-	int line;
+	struct uart_8250_port *uport;
 	u8 rx_trig_level;
 };
 
@@ -572,12 +573,12 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		dev_dbg(dev, "Setup PCI port: port %lx, irq %d, type %d\n",
 			up.port.iobase, up.port.irq, up.port.iotype);
 
-		priv->port[i].line = serial8250_register_8250_port(&up);
-		if (priv->port[i].line < 0) {
+		priv->port[i].uport = serial8250_register_8250_port(&up);
+		if (IS_ERR(priv->port[i].uport)) {
 			dev_err(dev,
-				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
+				"Couldn't register serial port %lx, irq %d, type %d, error %pe\n",
 				up.port.iobase, up.port.irq,
-				up.port.iotype, priv->port[i].line);
+				up.port.iotype, priv->port[i].uport);
 			break;
 		}
 		priv->port[i].rx_trig_level = MOXA_PUART_RX_TRIG_DEFAULT;
@@ -592,7 +593,7 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
 	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
 
 	for (unsigned int i = 0; i < priv->nr; i++)
-		serial8250_unregister_port(priv->port[i].line);
+		serial8250_unregister_port(priv->port[i].uport);
 }
 
 static const struct pci_device_id mxpcie8250_pci_ids[] = {
diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index 9f945f8ed1de..509c1814cc87 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -14,6 +14,7 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -73,7 +74,7 @@ struct ni16550_device_info {
 };
 
 struct ni16550_data {
-	int line;
+	struct uart_8250_port *uport;
 	struct clk *clk;
 };
 
@@ -383,10 +384,9 @@ static int ni16550_probe(struct platform_device *pdev)
 		ni16550_rs485_setup(&uart->port);
 	}
 
-	ret = serial8250_register_8250_port(uart);
-	if (ret < 0)
-		return ret;
-	data->line = ret;
+	data->uport = serial8250_register_8250_port(uart);
+	if (IS_ERR(data->uport))
+		return PTR_ERR(data->uport);
 
 	platform_set_drvdata(pdev, data);
 	return 0;
@@ -396,7 +396,7 @@ static void ni16550_remove(struct platform_device *pdev)
 {
 	struct ni16550_data *data = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(data->line);
+	serial8250_unregister_port(data->uport);
 }
 
 /* NI 16550 RS-485 Interface */
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index b1561c499acd..b41ca604083f 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -8,6 +8,7 @@
 #include <linux/align.h>
 #include <linux/bits.h>
 #include <linux/console.h>
+#include <linux/err.h>
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -28,7 +29,7 @@ struct of_serial_info {
 	struct clk *bus_clk;
 	struct reset_control *rst;
 	int type;
-	int line;
+	struct uart_8250_port *uport;
 	struct notifier_block clk_notifier;
 };
 
@@ -71,11 +72,10 @@ static int of_platform_serial_clk_notifier_cb(struct notifier_block *nb, unsigne
 					      void *data)
 {
 	struct of_serial_info *info = clk_nb_to_info(nb);
-	struct uart_8250_port *port8250 = serial8250_get_port(info->line);
 	struct clk_notifier_data *ndata = data;
 
 	if (event == POST_RATE_CHANGE) {
-		serial8250_update_uartclk(&port8250->port, ndata->new_rate);
+		serial8250_update_uartclk(&info->uport->port, ndata->new_rate);
 		return NOTIFY_OK;
 	}
 
@@ -292,12 +292,13 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 			&port8250.overrun_backoff_time_ms) != 0)
 		port8250.overrun_backoff_time_ms = 0;
 
-	ret = serial8250_register_8250_port(&port8250);
-	if (ret < 0)
+	info->uport = serial8250_register_8250_port(&port8250);
+	if (IS_ERR(info->uport)) {
+		ret = PTR_ERR(info->uport);
 		goto err_dispose;
+	}
 
 	info->type = port_type;
-	info->line = ret;
 	platform_set_drvdata(ofdev, info);
 
 	if (info->clk) {
@@ -311,7 +312,7 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 
 	return 0;
 err_unregister:
-	serial8250_unregister_port(info->line);
+	serial8250_unregister_port(info->uport);
 err_dispose:
 	pm_runtime_put_sync(&ofdev->dev);
 	pm_runtime_disable(&ofdev->dev);
@@ -330,7 +331,7 @@ static void of_platform_serial_remove(struct platform_device *ofdev)
 	if (info->clk)
 		clk_notifier_unregister(info->clk, &info->clk_notifier);
 
-	serial8250_unregister_port(info->line);
+	serial8250_unregister_port(info->uport);
 
 	reset_control_assert(info->rst);
 	pm_runtime_put_sync(&ofdev->dev);
@@ -342,10 +343,10 @@ static void of_platform_serial_remove(struct platform_device *ofdev)
 static int of_serial_suspend(struct device *dev)
 {
 	struct of_serial_info *info = dev_get_drvdata(dev);
-	struct uart_8250_port *port8250 = serial8250_get_port(info->line);
+	struct uart_8250_port *port8250 = info->uport;
 	struct uart_port *port = &port8250->port;
 
-	serial8250_suspend_port(info->line);
+	serial8250_suspend_port(port8250);
 
 	if (!uart_console(port) || console_suspend_enabled) {
 		pm_runtime_put_sync(dev);
@@ -358,7 +359,7 @@ static int of_serial_suspend(struct device *dev)
 static int of_serial_resume(struct device *dev)
 {
 	struct of_serial_info *info = dev_get_drvdata(dev);
-	struct uart_8250_port *port8250 = serial8250_get_port(info->line);
+	struct uart_8250_port *port8250 = info->uport;
 	struct uart_port *port = &port8250->port;
 
 	if (!uart_console(port) || console_suspend_enabled) {
@@ -367,7 +368,7 @@ static int of_serial_resume(struct device *dev)
 		clk_prepare_enable(info->clk);
 	}
 
-	serial8250_resume_port(info->line);
+	serial8250_resume_port(port8250);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 137175aa4183..29a203ed93fd 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -11,6 +11,7 @@
 #include <linux/atomic.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/serial_8250.h>
@@ -124,7 +125,7 @@
 #define UART_OMAP_TO_H                 0x27
 struct omap8250_priv {
 	void __iomem *membase;
-	int line;
+	struct uart_8250_port *uport;
 	u8 habit;
 	u8 mdr1;
 	u8 mdr3;
@@ -628,7 +629,7 @@ static int omap_8250_dma_handle_irq(struct uart_port *port);
 static irqreturn_t omap8250_irq(int irq, void *dev_id)
 {
 	struct omap8250_priv *priv = dev_id;
-	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct uart_8250_port *up = priv->uport;
 	struct uart_port *port = &up->port;
 	unsigned int iir, lsr;
 	int ret;
@@ -711,8 +712,8 @@ static int omap_8250_startup(struct uart_port *port)
 	struct uart_8250_dma *dma = &priv->omap8250_dma;
 	int ret;
 
-	/* ISR and runtime PM need the line; probe sets it only after registration */
-	priv->line = port->line;
+	/* ISR and runtime PM need the uport; probe sets it only after registration */
+	priv->uport = up;
 
 #ifdef CONFIG_PM
 	up->capabilities |= UART_CAP_RPM;
@@ -1509,7 +1510,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	}
 
 	priv->membase = membase;
-	priv->line = -ENODEV;
+	priv->uport = NULL;
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	priv->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	cpu_latency_qos_add_request(&priv->pm_qos_request, priv->latency);
@@ -1590,12 +1591,13 @@ static int omap8250_probe(struct platform_device *pdev)
 			goto err;
 	}
 
-	ret = serial8250_register_8250_port(&up);
-	if (ret < 0) {
+	struct uart_8250_port *uport = serial8250_register_8250_port(&up);
+	if (IS_ERR(uport)) {
+		ret = PTR_ERR(uport);
 		dev_err(&pdev->dev, "unable to register 8250 port\n");
 		goto err;
 	}
-	priv->line = ret;
+	priv->uport = uport;
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
@@ -1624,10 +1626,10 @@ static void omap8250_remove(struct platform_device *pdev)
 	if (err)
 		dev_err(&pdev->dev, "Failed to resume hardware\n");
 
-	up = serial8250_get_port(priv->line);
+	up = priv->uport;
 	omap_8250_shutdown(&up->port);
-	serial8250_unregister_port(priv->line);
-	priv->line = -ENODEV;
+	serial8250_unregister_port(up);
+	priv->uport = NULL;
 	dev_pm_clear_wake_irq(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
@@ -1659,7 +1661,7 @@ static void omap8250_complete(struct device *dev)
 static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct uart_8250_port *up = priv->uport;
 	int err = 0;
 
 	err = omap8250_select_wakeup_pinctrl(dev, priv);
@@ -1669,7 +1671,7 @@ static int omap8250_suspend(struct device *dev)
 		return err;
 	}
 
-	serial8250_suspend_port(priv->line);
+	serial8250_suspend_port(up);
 
 	err = pm_runtime_resume_and_get(dev);
 	if (err)
@@ -1687,7 +1689,7 @@ static int omap8250_suspend(struct device *dev)
 static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct uart_8250_port *up = priv->uport;
 	int err;
 
 	err = pinctrl_select_default_state(dev);
@@ -1703,7 +1705,7 @@ static int omap8250_resume(struct device *dev)
 			return err;
 	}
 
-	serial8250_resume_port(priv->line);
+	serial8250_resume_port(up);
 	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
@@ -1775,10 +1777,7 @@ static int omap8250_soft_reset(struct device *dev)
 static int omap8250_runtime_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up = NULL;
-
-	if (priv->line >= 0)
-		up = serial8250_get_port(priv->line);
+	struct uart_8250_port *up = priv->uport;
 
 	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
 		int ret;
@@ -1808,15 +1807,12 @@ static int omap8250_runtime_suspend(struct device *dev)
 static int omap8250_runtime_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up = NULL;
+	struct uart_8250_port *up = priv->uport;
 
 	/* Did the hardware wake to a device IO interrupt before a wakeirq? */
 	if (atomic_read(&priv->active))
 		return 0;
 
-	if (priv->line >= 0)
-		up = serial8250_get_port(priv->line);
-
 	if (up && omap8250_lost_context(up)) {
 		guard(uart_port_lock_irq)(&up->port);
 		omap8250_restore_regs(up);
diff --git a/drivers/tty/serial/8250/8250_parisc.c b/drivers/tty/serial/8250/8250_parisc.c
index 4ba05a98791c..1bb15cbde655 100644
--- a/drivers/tty/serial/8250/8250_parisc.c
+++ b/drivers/tty/serial/8250/8250_parisc.c
@@ -5,6 +5,7 @@
  *	(c) Copyright Matthew Wilcox <willy@debian.org> 2001-2002
  */
 
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -22,9 +23,8 @@
 
 static int __init serial_init_chip(struct parisc_device *dev)
 {
-	struct uart_8250_port uart;
+	struct uart_8250_port *uport, uart;
 	unsigned long address;
-	int err;
 
 #if defined(CONFIG_64BIT) && defined(CONFIG_IOSAPIC)
 	if (!dev->irq && (dev->id.sversion == 0xad))
@@ -64,13 +64,13 @@ static int __init serial_init_chip(struct parisc_device *dev)
 	uart.port.flags	= UPF_BOOT_AUTOCONF;
 	uart.port.dev	= &dev->dev;
 
-	err = serial8250_register_8250_port(&uart);
-	if (err < 0) {
+	uport = serial8250_register_8250_port(&uart);
+	if (IS_ERR(uport)) {
 		dev_warn(&dev->dev,
-			"serial8250_register_8250_port returned error %d\n",
-			err);
+			"serial8250_register_8250_port returned error %pe\n",
+			uport);
 		iounmap(uart.port.membase);
-		return err;
+		return PTR_ERR(uport);
 	}
 
 	return 0;
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 6e53d6d72a8e..1dda63be6b89 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -20,6 +20,7 @@
 #include <linux/8250_pci.h>
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/err.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -116,7 +117,7 @@ struct serial_private {
 	unsigned int		nr;
 	struct pci_serial_quirk	*quirk;
 	const struct pciserial_board *board;
-	int			line[];
+	struct uart_8250_port	*uport[];
 };
 
 #define PCI_DEVICE_ID_HPE_PCI_SERIAL	0x37e
@@ -4028,7 +4029,7 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 			nr_ports = rc;
 	}
 
-	priv = kzalloc_flex(*priv, line, nr_ports);
+	priv = kzalloc_flex(*priv, uport, nr_ports);
 	if (!priv) {
 		priv = ERR_PTR(-ENOMEM);
 		goto err_deinit;
@@ -4071,12 +4072,12 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 		pci_dbg(dev, "Setup PCI port: port %lx, irq %d, type %d\n",
 			uart.port.iobase, uart.port.irq, uart.port.iotype);
 
-		priv->line[i] = serial8250_register_8250_port(&uart);
-		if (priv->line[i] < 0) {
+		priv->uport[i] = serial8250_register_8250_port(&uart);
+		if (IS_ERR(priv->uport[i])) {
 			pci_err(dev,
-				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
+				"Couldn't register serial port %lx, irq %d, type %d, error %pe\n",
 				uart.port.iobase, uart.port.irq,
-				uart.port.iotype, priv->line[i]);
+				uart.port.iotype, priv->uport[i]);
 			break;
 		}
 	}
@@ -4098,7 +4099,7 @@ static void pciserial_detach_ports(struct serial_private *priv)
 	int i;
 
 	for (i = 0; i < priv->nr; i++)
-		serial8250_unregister_port(priv->line[i]);
+		serial8250_unregister_port(priv->uport[i]);
 
 	/*
 	 * Find the exit quirks.
@@ -4120,8 +4121,7 @@ void pciserial_suspend_ports(struct serial_private *priv)
 	int i;
 
 	for (i = 0; i < priv->nr; i++)
-		if (priv->line[i] >= 0)
-			serial8250_suspend_port(priv->line[i]);
+		serial8250_suspend_port(priv->uport[i]);
 
 	/*
 	 * Ensure that every init quirk is properly torn down
@@ -4142,8 +4142,7 @@ void pciserial_resume_ports(struct serial_private *priv)
 		priv->quirk->init(priv->dev);
 
 	for (i = 0; i < priv->nr; i++)
-		if (priv->line[i] >= 0)
-			serial8250_resume_port(priv->line[i]);
+		serial8250_resume_port(priv->uport[i]);
 }
 EXPORT_SYMBOL_GPL(pciserial_resume_ports);
 
diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index feeede164886..af4c5c745fa9 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 #include <linux/circ_buf.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gfp_types.h>
 #include <linux/io.h>
@@ -152,7 +153,7 @@ struct pci1xxxx_8250 {
 	u8 dev_rev;
 	u8 pad[3];
 	void __iomem *membase;
-	int line[] __counted_by(nr);
+	struct uart_8250_port *uport[] __counted_by(nr);
 };
 
 static const struct serial_rs485 pci1xxxx_rs485_supported = {
@@ -551,9 +552,8 @@ static int pci1xxxx_handle_irq(struct uart_port *port)
 	return 1;
 }
 
-static bool pci1xxxx_port_suspend(int line)
+static bool pci1xxxx_port_suspend(struct uart_8250_port *up)
 {
-	struct uart_8250_port *up = serial8250_get_port(line);
 	struct uart_port *port = &up->port;
 	struct tty_port *tport = &port->state->port;
 	unsigned long flags;
@@ -578,9 +578,8 @@ static bool pci1xxxx_port_suspend(int line)
 	return ret;
 }
 
-static void pci1xxxx_port_resume(int line)
+static void pci1xxxx_port_resume(struct uart_8250_port *up)
 {
-	struct uart_8250_port *up = serial8250_get_port(line);
 	struct uart_port *port = &up->port;
 	struct tty_port *tport = &port->state->port;
 	unsigned long flags;
@@ -608,9 +607,9 @@ static int pci1xxxx_suspend(struct device *dev)
 	int i;
 
 	for (i = 0; i < priv->nr; i++) {
-		if (priv->line[i] >= 0) {
-			serial8250_suspend_port(priv->line[i]);
-			wakeup |= pci1xxxx_port_suspend(priv->line[i]);
+		if (priv->uport[i]) {
+			serial8250_suspend_port(priv->uport[i]);
+			wakeup |= pci1xxxx_port_suspend(priv->uport[i]);
 		}
 	}
 
@@ -661,9 +660,9 @@ static int pci1xxxx_resume(struct device *dev)
 	iounmap(p);
 
 	for (i = 0; i < priv->nr; i++) {
-		if (priv->line[i] >= 0) {
-			pci1xxxx_port_resume(priv->line[i]);
-			serial8250_resume_port(priv->line[i]);
+		if (priv->uport[i]) {
+			pci1xxxx_port_resume(priv->uport[i]);
+			serial8250_resume_port(priv->uport[i]);
 		}
 	}
 
@@ -779,7 +778,7 @@ static int pci1xxxx_serial_probe(struct pci_dev *pdev,
 
 	nr_ports = pci1xxxx_get_num_ports(pdev);
 
-	priv = devm_kzalloc(dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
+	priv = devm_kzalloc(dev, struct_size(priv, uport, nr_ports), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -812,8 +811,6 @@ static int pci1xxxx_serial_probe(struct pci_dev *pdev,
 		writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI, priv->membase + UART_PCI_CTRL_REG);
 
 	for (i = 0; i < nr_ports; i++) {
-		priv->line[i] = -ENODEV;
-
 		port_idx = pci1xxxx_logical_to_physical_port_translate(subsys_dev, i);
 
 		if (num_vectors == max_vec_reqd)
@@ -827,13 +824,15 @@ static int pci1xxxx_serial_probe(struct pci_dev *pdev,
 			continue;
 		}
 
-		priv->line[i] = serial8250_register_8250_port(&uart);
-		if (priv->line[i] < 0) {
+		struct uart_8250_port *uport = serial8250_register_8250_port(&uart);
+		if (IS_ERR(uport)) {
 			dev_warn(dev,
-				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
-				uart.port.iobase, uart.port.irq, uart.port.iotype,
-				priv->line[i]);
+				"Couldn't register serial port %lx, irq %d, type %d, error %pe\n",
+				uart.port.iobase, uart.port.irq, uart.port.iotype, uport);
+			continue;
 		}
+
+		priv->uport[i] = uport;
 	}
 
 	pci_set_drvdata(pdev, priv);
@@ -847,8 +846,8 @@ static void pci1xxxx_serial_remove(struct pci_dev *dev)
 	unsigned int i;
 
 	for (i = 0; i < priv->nr; i++) {
-		if (priv->line[i] >= 0)
-			serial8250_unregister_port(priv->line[i]);
+		if (priv->uport[i])
+			serial8250_unregister_port(priv->uport[i]);
 	}
 
 	pci_free_irq_vectors(dev);
diff --git a/drivers/tty/serial/8250/8250_pericom.c b/drivers/tty/serial/8250/8250_pericom.c
index b8d5b7714a9d..bbbf48c6d07d 100644
--- a/drivers/tty/serial/8250/8250_pericom.c
+++ b/drivers/tty/serial/8250/8250_pericom.c
@@ -2,6 +2,7 @@
 /* Driver for Pericom UART */
 
 #include <linux/bits.h>
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/pci.h>
@@ -45,7 +46,7 @@
 struct pericom8250 {
 	void __iomem *virt;
 	unsigned int nr;
-	int line[];
+	struct uart_8250_port *uport[];
 };
 
 static void pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
@@ -102,7 +103,7 @@ static int pericom8250_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	else
 		nr = 1;
 
-	pericom = devm_kzalloc(&pdev->dev, struct_size(pericom, line, nr), GFP_KERNEL);
+	pericom = devm_kzalloc(&pdev->dev, struct_size(pericom, uport, nr), GFP_KERNEL);
 	if (!pericom)
 		return -ENOMEM;
 
@@ -127,12 +128,12 @@ static int pericom8250_probe(struct pci_dev *pdev, const struct pci_device_id *i
 		dev_dbg(&pdev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
 			uart.port.iobase, uart.port.irq, uart.port.iotype);
 
-		pericom->line[i] = serial8250_register_8250_port(&uart);
-		if (pericom->line[i] < 0) {
+		pericom->uport[i] = serial8250_register_8250_port(&uart);
+		if (IS_ERR(pericom->uport[i])) {
 			dev_err(&pdev->dev,
-				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
+				"Couldn't register serial port %lx, irq %d, type %d, error %pe\n",
 				uart.port.iobase, uart.port.irq,
-				uart.port.iotype, pericom->line[i]);
+				uart.port.iotype, pericom->uport[i]);
 			break;
 		}
 	}
@@ -148,7 +149,7 @@ static void pericom8250_remove(struct pci_dev *pdev)
 	unsigned int i;
 
 	for (i = 0; i < pericom->nr; i++)
-		serial8250_unregister_port(pericom->line[i]);
+		serial8250_unregister_port(pericom->uport[i]);
 }
 
 static const struct pci_device_id pericom8250_pci_ids[] = {
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 0570366a71d0..9d9dba4e0439 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -11,6 +11,7 @@
 #include <linux/acpi.h>
 #include <linux/array_size.h>
 #include <linux/cleanup.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -109,7 +110,7 @@ static int serial8250_probe_acpi(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *regs;
-	int ret, line;
+	int ret;
 
 	struct uart_8250_port *uart __free(kfree) = kzalloc_obj(*uart);
 	if (!uart)
@@ -145,16 +146,12 @@ static int serial8250_probe_acpi(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	line = serial8250_register_8250_port(uart);
-	if (line < 0)
-		return line;
-
-	return 0;
+	return PTR_ERR_OR_ZERO(serial8250_register_8250_port(uart));
 }
 
 static int serial8250_probe_platform(struct platform_device *dev, struct plat_serial8250_port *p)
 {
-	int ret, i;
+	int i;
 
 	struct uart_8250_port *uart __free(kfree) = kzalloc_obj(*uart);
 	if (!uart)
@@ -191,12 +188,12 @@ static int serial8250_probe_platform(struct platform_device *dev, struct plat_se
 		if (share_irqs)
 			uart->port.irqflags |= IRQF_SHARED;
 
-		ret = serial8250_register_8250_port(uart);
-		if (ret < 0) {
+		struct uart_8250_port *uport = serial8250_register_8250_port(uart);
+		if (IS_ERR(uport)) {
 			dev_err(&dev->dev, "unable to register port at index %d "
-				"(IO%lx MEM%llx IRQ%d): %d\n", i,
+				"(IO%lx MEM%llx IRQ%d): %pe\n", i,
 				p->iobase, (unsigned long long)p->mapbase,
-				p->irq, ret);
+				p->irq, uport);
 		}
 	}
 	return 0;
@@ -238,7 +235,7 @@ static void serial8250_remove(struct platform_device *dev)
 		struct uart_8250_port *up = serial8250_get_port(i);
 
 		if (up->port.dev == &dev->dev)
-			serial8250_unregister_port(i);
+			serial8250_unregister_port(up);
 	}
 }
 
@@ -264,7 +261,7 @@ static int serial8250_resume(struct platform_device *dev)
 		struct uart_8250_port *up = serial8250_get_port(i);
 
 		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
-			serial8250_resume_port(i);
+			serial8250_resume_port(up);
 	}
 
 	return 0;
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index a6257cd6e246..f9558df37108 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -8,6 +8,7 @@
  *
  *  Ported to the Linux PnP Layer - (C) Adam Belay.
  */
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pm.h>
@@ -436,7 +437,6 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_8250_port uart, *port;
 	int ret, flags = dev_id->driver_data;
-	long line;
 
 	if (flags & UNKNOWN_DEV) {
 		ret = serial_pnp_guess_board(dev);
@@ -477,39 +477,38 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 		 uart.port.iobase, (unsigned long long)uart.port.mapbase,
 		 (unsigned long long)uart.port.mapsize, uart.port.irq, uart.port.iotype);
 
-	line = serial8250_register_8250_port(&uart);
-	if (line < 0 || (flags & CIR_PORT))
+	port = serial8250_register_8250_port(&uart);
+	if (IS_ERR(port) || (flags & CIR_PORT))
 		return -ENODEV;
 
-	port = serial8250_get_port(line);
 	if (uart_console(&port->port))
 		dev->capabilities |= PNP_CONSOLE;
 
-	pnp_set_drvdata(dev, (void *)line);
+	pnp_set_drvdata(dev, port);
 	return 0;
 }
 
 static void serial_pnp_remove(struct pnp_dev *dev)
 {
-	long line = (long)pnp_get_drvdata(dev);
+	struct uart_8250_port *uport = pnp_get_drvdata(dev);
 
 	dev->capabilities &= ~PNP_CONSOLE;
-	serial8250_unregister_port(line);
+	serial8250_unregister_port(uport);
 }
 
 static int serial_pnp_suspend(struct device *dev)
 {
-	long line = (long)dev_get_drvdata(dev);
+	struct uart_8250_port *uport = dev_get_drvdata(dev);
 
-	serial8250_suspend_port(line);
+	serial8250_suspend_port(uport);
 	return 0;
 }
 
 static int serial_pnp_resume(struct device *dev)
 {
-	long line = (long)dev_get_drvdata(dev);
+	struct uart_8250_port *uport = dev_get_drvdata(dev);
 
-	serial8250_resume_port(line);
+	serial8250_resume_port(uport);
 	return 0;
 }
 
diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 6dd0190b4843..a56aa5fec563 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -26,7 +27,7 @@
 #include "8250.h"
 
 struct pxa8250_data {
-	int			line;
+	struct uart_8250_port	*uport;
 	struct clk		*clk;
 };
 
@@ -34,7 +35,7 @@ static int __maybe_unused serial_pxa_suspend(struct device *dev)
 {
 	struct pxa8250_data *data = dev_get_drvdata(dev);
 
-	serial8250_suspend_port(data->line);
+	serial8250_suspend_port(data->uport);
 
 	return 0;
 }
@@ -43,7 +44,7 @@ static int __maybe_unused serial_pxa_resume(struct device *dev)
 {
 	struct pxa8250_data *data = dev_get_drvdata(dev);
 
-	serial8250_resume_port(data->line);
+	serial8250_resume_port(data->uport);
 
 	return 0;
 }
@@ -128,11 +129,11 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	uart.tx_loadsz = 32;
 	uart.dl_write = serial_pxa_dl_write;
 
-	ret = serial8250_register_8250_port(&uart);
-	if (ret < 0)
+	data->uport = serial8250_register_8250_port(&uart);
+	if (IS_ERR(data->uport)) {
+		ret = PTR_ERR(data->uport);
 		goto err_clk;
-
-	data->line = ret;
+	}
 
 	platform_set_drvdata(pdev, data);
 
@@ -147,7 +148,7 @@ static void serial_pxa_remove(struct platform_device *pdev)
 {
 	struct pxa8250_data *data = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(data->line);
+	serial8250_unregister_port(data->uport);
 
 	clk_unprepare(data->clk);
 }
diff --git a/drivers/tty/serial/8250/8250_tegra.c b/drivers/tty/serial/8250/8250_tegra.c
index 2f3b0075763f..2f6b822f79a8 100644
--- a/drivers/tty/serial/8250/8250_tegra.c
+++ b/drivers/tty/serial/8250/8250_tegra.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -20,7 +21,7 @@
 struct tegra_uart {
 	struct clk *clk;
 	struct reset_control *rst;
-	int line;
+	struct uart_8250_port *uport;
 };
 
 static void tegra_uart_handle_break(struct uart_port *p)
@@ -103,12 +104,13 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clkdisable;
 
-	ret = serial8250_register_8250_port(&port8250);
-	if (ret < 0)
+	uart->uport = serial8250_register_8250_port(&port8250);
+	if (IS_ERR(uart->uport)) {
+		ret = PTR_ERR(uart->uport);
 		goto err_ctrl_assert;
+	}
 
 	platform_set_drvdata(pdev, uart);
-	uart->line = ret;
 
 	return 0;
 
@@ -124,7 +126,7 @@ static void tegra_uart_remove(struct platform_device *pdev)
 {
 	struct tegra_uart *uart = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(uart->line);
+	serial8250_unregister_port(uart->uport);
 	reset_control_assert(uart->rst);
 	clk_disable_unprepare(uart->clk);
 }
@@ -133,10 +135,10 @@ static void tegra_uart_remove(struct platform_device *pdev)
 static int tegra_uart_suspend(struct device *dev)
 {
 	struct tegra_uart *uart = dev_get_drvdata(dev);
-	struct uart_8250_port *port8250 = serial8250_get_port(uart->line);
+	struct uart_8250_port *port8250 = uart->uport;
 	struct uart_port *port = &port8250->port;
 
-	serial8250_suspend_port(uart->line);
+	serial8250_suspend_port(port8250);
 
 	if (!uart_console(port) || console_suspend_enabled)
 		clk_disable_unprepare(uart->clk);
@@ -147,13 +149,13 @@ static int tegra_uart_suspend(struct device *dev)
 static int tegra_uart_resume(struct device *dev)
 {
 	struct tegra_uart *uart = dev_get_drvdata(dev);
-	struct uart_8250_port *port8250 = serial8250_get_port(uart->line);
+	struct uart_8250_port *port8250 = uart->uport;
 	struct uart_port *port = &port8250->port;
 
 	if (!uart_console(port) || console_suspend_enabled)
 		clk_prepare_enable(uart->clk);
 
-	serial8250_resume_port(uart->line);
+	serial8250_resume_port(port8250);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 7d558b750f83..a8ee45a0d41e 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/console.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -31,7 +32,7 @@
 #define UNIPHIER_UART_DLR		(9 << (UNIPHIER_UART_REGSHIFT))
 
 struct uniphier8250_priv {
-	int line;
+	struct uart_8250_port *uport;
 	struct clk *clk;
 	spinlock_t atomic_write_lock;
 };
@@ -212,11 +213,9 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	up.dl_read = uniphier_serial_dl_read;
 	up.dl_write = uniphier_serial_dl_write;
 
-	ret = serial8250_register_8250_port(&up);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "failed to register 8250 port\n");
-
-	priv->line = ret;
+	priv->uport = serial8250_register_8250_port(&up);
+	if (IS_ERR(priv->uport))
+		return dev_err_probe(dev, PTR_ERR(priv->uport), "failed to register 8250 port\n");
 
 	platform_set_drvdata(pdev, priv);
 
@@ -227,15 +226,15 @@ static void uniphier_uart_remove(struct platform_device *pdev)
 {
 	struct uniphier8250_priv *priv = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(priv->line);
+	serial8250_unregister_port(priv->uport);
 }
 
 static int __maybe_unused uniphier_uart_suspend(struct device *dev)
 {
 	struct uniphier8250_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct uart_8250_port *up = priv->uport;
 
-	serial8250_suspend_port(priv->line);
+	serial8250_suspend_port(up);
 
 	if (!uart_console(&up->port) || console_suspend_enabled)
 		clk_disable_unprepare(priv->clk);
@@ -246,7 +245,7 @@ static int __maybe_unused uniphier_uart_suspend(struct device *dev)
 static int __maybe_unused uniphier_uart_resume(struct device *dev)
 {
 	struct uniphier8250_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct uart_8250_port *up = priv->uport;
 	int ret;
 
 	if (!uart_console(&up->port) || console_suspend_enabled) {
@@ -255,7 +254,7 @@ static int __maybe_unused uniphier_uart_resume(struct device *dev)
 			return ret;
 	}
 
-	serial8250_resume_port(priv->line);
+	serial8250_resume_port(up);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index 80483fc7388d..5dcd1544e478 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -34,6 +34,7 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
@@ -86,7 +87,7 @@ struct serial_info {
 	int			manfid;
 	int			prodid;
 	int			c950ctrl;
-	int			line[4];
+	struct uart_8250_port	*uport[4];
 	const struct serial_quirk *quirk;
 };
 
@@ -266,7 +267,7 @@ static void serial_remove(struct pcmcia_device *link)
 	 * Recheck to see if the device is still configured.
 	 */
 	for (i = 0; i < info->ndev; i++)
-		serial8250_unregister_port(info->line[i]);
+		serial8250_unregister_port(info->uport[i]);
 
 	if (!info->slave)
 		pcmcia_disable_device(link);
@@ -278,7 +279,7 @@ static int serial_suspend(struct pcmcia_device *link)
 	int i;
 
 	for (i = 0; i < info->ndev; i++)
-		serial8250_suspend_port(info->line[i]);
+		serial8250_suspend_port(info->uport[i]);
 
 	return 0;
 }
@@ -289,7 +290,7 @@ static int serial_resume(struct pcmcia_device *link)
 	int i;
 
 	for (i = 0; i < info->ndev; i++)
-		serial8250_resume_port(info->line[i]);
+		serial8250_resume_port(info->uport[i]);
 
 	if (info->quirk && info->quirk->wakeup)
 		info->quirk->wakeup(link);
@@ -347,7 +348,6 @@ static int setup_serial(struct pcmcia_device *handle, struct serial_info *info,
 			unsigned int iobase, int irq)
 {
 	struct uart_8250_port uart;
-	int line;
 
 	memset(&uart, 0, sizeof(uart));
 	uart.port.iobase = iobase;
@@ -361,14 +361,13 @@ static int setup_serial(struct pcmcia_device *handle, struct serial_info *info,
 	if (info->quirk && info->quirk->setup)
 		info->quirk->setup(handle, &uart);
 
-	line = serial8250_register_8250_port(&uart);
-	if (line < 0) {
+	info->uport[info->ndev] = serial8250_register_8250_port(&uart);
+	if (IS_ERR(info->uport[info->ndev])) {
 		pr_err("serial_cs: serial8250_register_8250_port() at 0x%04lx, irq %d failed\n",
 							(unsigned long)iobase, irq);
 		return -EINVAL;
 	}
 
-	info->line[info->ndev] = line;
 	info->ndev++;
 
 	return 0;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index eeb868e93e15..d91c0477be9d 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -186,10 +186,10 @@ static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
 	return container_of(up, struct uart_8250_port, port);
 }
 
-int serial8250_register_8250_port(const struct uart_8250_port *);
-void serial8250_unregister_port(int line);
-void serial8250_suspend_port(int line);
-void serial8250_resume_port(int line);
+struct uart_8250_port *serial8250_register_8250_port(const struct uart_8250_port *);
+void serial8250_unregister_port(struct uart_8250_port *);
+void serial8250_suspend_port(struct uart_8250_port *);
+void serial8250_resume_port(struct uart_8250_port *);
 
 int early_serial_setup(struct uart_port *port);
 int early_serial8250_setup(struct earlycon_device *device, const char *options);
-- 
2.56.0

