Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D2C159596;
	Wed, 18 Dec 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514978; cv=none; b=mahyuHr5hAZS8QVOVuCsFTBGC5ceT+ciyH9suU9YRIswGDlLDqMxOGCvhOTj/6qRaEBeoy7P6N6hPt9Lj9epvXGQAEZLVv//SG3sxkmdLws0yImaPecTqmFVGd+85LwZA0eCPo00sZ3q3s9KNOJh63AaADhci/whVEMn1rzGXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514978; c=relaxed/simple;
	bh=DIPexDAwQNzeHIRX1J9masGD7lvlUFwW1jj02jyGYI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GfXTIi9dE8Z0m1nvjEmU2O9w7KM5FkNExyPhqFSFzZ15idgsXYW/P9bzzZ3jnaJkmrtwTMOSlv6RwVEhvdkynPid2rtb2OzQSMXBsM5Mf6g3qIgdeR4ESoF7+CxU2o/eOJ5SyKTdmH1j1Ef7zEhDGsy7xLoIMB0Ll9XQUq5ecAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WM/z5PWG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WM/z5PWG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734514976; x=1766050976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DIPexDAwQNzeHIRX1J9masGD7lvlUFwW1jj02jyGYI8=;
  b=WM/z5PWGPEPEEJTRZ5/Qm+Oe4sgk5M8C+7t+nAFdzxbjx8Qk4fIa6x0W
   2Ncte3S6rPolEd/RAaOkBGHrLko9k21xpTUB0RcJZvQOY7yl7wvMgAj72
   OHQ3GAt2Qocew/4kYrxLal2tpa2yI5GShnIhDgxIf12v2bR+MZjrjwc/1
   jOk+euPgMpihFZsiWKN569m1BvOV/yld/EkrmJATFzwc+fjY6UaG52X78
   l6eOnk7xVWNITJywa7ISztfSmj4kJdJ8Z/Daa6yhC69/XuGat8D23mIkz
   Kx5qKdnJAmDM65QptOKBjY1jmzk/b+vu2+NZaZf/tVw3kYf8VP6ctSNS4
   A==;
X-CSE-ConnectionGUID: /A78245aRYSurV+bCq6fFg==
X-CSE-MsgGUID: VjwX72/5QmesaiPPKb9Jug==
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35355235"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Dec 2024 02:42:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 18 Dec 2024 02:42:55 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 18 Dec 2024 02:42:52 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH v1 tty-next] 8250: microchip: pci1xxxx: Add workaround for RTS bit toggle
Date: Wed, 18 Dec 2024 15:10:17 +0530
Message-ID: <20241218094017.18290-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In the B0 revision, the RTS pin remains high due to incorrect hardware
mapping. To address this issue, enable auto-direction control with the
RTS bit in ADCL_CFG_REG. This configuration ensures that the RTS pin
goes low when the terminal is opened and high when the terminal is
closed. Additionally, we reset the step counter for Rx and Tx engines
by writing into FRAC_DIV_CFG_REG.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 60 ++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index d3930bf32fe4..f462b3d1c104 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -78,6 +78,12 @@
 #define UART_TX_BYTE_FIFO			0x00
 #define UART_FIFO_CTL				0x02
 
+#define UART_MODEM_CTL_REG			0x04
+#define UART_MODEM_CTL_RTS_SET			BIT(1)
+
+#define UART_LINE_STAT_REG			0x05
+#define UART_LINE_XMIT_CHECK_MASK		GENMASK(6, 5)
+
 #define UART_ACTV_REG				0x11
 #define UART_BLOCK_SET_ACTIVE			BIT(0)
 
@@ -94,6 +100,7 @@
 #define UART_BIT_SAMPLE_CNT_16			16
 #define BAUD_CLOCK_DIV_INT_MSK			GENMASK(31, 8)
 #define ADCL_CFG_RTS_DELAY_MASK			GENMASK(11, 8)
+#define FRAC_DIV_TX_END_POINT_MASK		GENMASK(23, 20)
 
 #define UART_WAKE_REG				0x8C
 #define UART_WAKE_MASK_REG			0x90
@@ -134,6 +141,11 @@
 #define UART_BST_STAT_LSR_FRAME_ERR		0x8000000
 #define UART_BST_STAT_LSR_THRE			0x20000000
 
+#define GET_MODEM_CTL_RTS_STATUS(reg)		((reg) & UART_MODEM_CTL_RTS_SET)
+#define GET_RTS_PIN_STATUS(val)			(((val) & TIOCM_RTS) >> 1)
+#define RTS_TOGGLE_STATUS_MASK(val, reg)	(GET_MODEM_CTL_RTS_STATUS(reg) \
+						 != GET_RTS_PIN_STATUS(val))
+
 struct pci1xxxx_8250 {
 	unsigned int nr;
 	u8 dev_rev;
@@ -254,6 +266,47 @@ static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
 	       port->membase + UART_BAUD_CLK_DIVISOR_REG);
 }
 
+static void pci1xxxx_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	u32 fract_div_cfg_reg;
+	u32 line_stat_reg;
+	u32 modem_ctl_reg;
+	u32 adcl_cfg_reg;
+
+	adcl_cfg_reg = readl(port->membase + ADCL_CFG_REG);
+
+	/* HW is responsible in ADCL_EN case */
+	if ((adcl_cfg_reg & (ADCL_CFG_EN | ADCL_CFG_PIN_SEL)))
+		return;
+
+	modem_ctl_reg = readl(port->membase + UART_MODEM_CTL_REG);
+
+	serial8250_do_set_mctrl(port, mctrl);
+
+	if (RTS_TOGGLE_STATUS_MASK(mctrl, modem_ctl_reg)) {
+		line_stat_reg = readl(port->membase + UART_LINE_STAT_REG);
+		if (line_stat_reg & UART_LINE_XMIT_CHECK_MASK) {
+			fract_div_cfg_reg = readl(port->membase +
+						  FRAC_DIV_CFG_REG);
+
+			writel((fract_div_cfg_reg &
+			       ~(FRAC_DIV_TX_END_POINT_MASK)),
+			       port->membase + FRAC_DIV_CFG_REG);
+
+			/* Enable ADC and set the nRTS pin */
+			writel((adcl_cfg_reg | (ADCL_CFG_EN |
+			       ADCL_CFG_PIN_SEL)),
+			       port->membase + ADCL_CFG_REG);
+
+			/* Revert to the original settings */
+			writel(adcl_cfg_reg, port->membase + ADCL_CFG_REG);
+
+			writel(fract_div_cfg_reg, port->membase +
+			       FRAC_DIV_CFG_REG);
+		}
+	}
+}
+
 static int pci1xxxx_rs485_config(struct uart_port *port,
 				 struct ktermios *termios,
 				 struct serial_rs485 *rs485)
@@ -631,9 +684,14 @@ static int pci1xxxx_setup(struct pci_dev *pdev,
 	port->port.rs485_config = pci1xxxx_rs485_config;
 	port->port.rs485_supported = pci1xxxx_rs485_supported;
 
-	/* From C0 rev Burst operation is supported */
+	/*
+	 * C0 and later revisions support Burst operation.
+	 * RTS workaround in mctrl is applicable only to B0.
+	 */
 	if (rev >= 0xC0)
 		port->port.handle_irq = pci1xxxx_handle_irq;
+	else if (rev == 0xB0)
+		port->port.set_mctrl = pci1xxxx_set_mctrl;
 
 	ret = serial8250_pci_setup_port(pdev, port, 0, PORT_OFFSET * port_idx, 0);
 	if (ret < 0)
-- 
2.25.1

