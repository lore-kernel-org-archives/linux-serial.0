Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EE7C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 11:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A83F613D3
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 11:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244822AbhI2Lcx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 07:32:53 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:24799 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245647AbhI2Lcw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 07:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632915070; x=1664451070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hv3+IEtojMKE+vEzkCL7bVerbCyGxE3ycqNei2x2ZWA=;
  b=i2wSrHXHZaX38S87P5QJeoldL1DJFPprc3qmtmnQ+i90AxuhwuRdvxaN
   uVoX6NtVwy3/OEpEm3SM+7ndsh1a8hd6hEYlAq3PmbeMd+vAoTxhsJBDC
   dHSkbnRSHVQsJfQOF7IcEBrtusPEd+YR6CfRVdHGr6W3+Xyu27iG57H4A
   XzIyL/al76ltmqCXvyXj2DnPVI8m3u0/TBtcFfuQb82SKIMIO+4u789je
   IGULvxRL2Hnl0YNGJW7JkxUM6uEpwqGkuNS+0RJpIMxcFnax7bC/HO8b4
   Ma2+AH+wvMu9DxX/JfidmdGfZojDy0eAG8Feq1os1JrjaMbd42cNrRexX
   Q==;
IronPort-SDR: +019nIeqeEELZd42+WPkN+19QMwKRQ/2uz5AaiwoSk1zzj1irsfoQ3W8BDqnXtjfPrgOOp0aFa
 nXnigeh8RFuGVHv/opXRZ2LUbakS19HQ3VRgZqzgug5QM7Cv4iASFv6Ao7Uy0K2Dwwntskr3kE
 /lrBRlogvmTUjLn0i3uFU/ssW5pbpN0vfABbI/GINHIOAFtZU6mRIIdUunRm8EQXlD2NTmwNPB
 KGVe2a/X/WG1RLJK4dCjZz02rrYn08E1NU4tbg18wWbdAOrTKYQakq25Ww0c7ksDfZjkiZ2bvj
 7aBRYT93CbNYq9ULNz4qv5us
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="138399103"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2021 04:31:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 29 Sep 2021 04:31:10 -0700
Received: from CHE-LT-I17972LX.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 29 Sep 2021 04:31:04 -0700
From:   LakshmiPraveen Kopparthi <LakshmiPraveen.Kopparthi@microchip.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <macro@orcam.me.uk>,
        <zev@bewilderbeest.net>, <vigneshr@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>
Subject: [PATCH v1 1/3] serial:8250:Add basic driver support for MCHP PCI1XXXX UART
Date:   Wed, 29 Sep 2021 17:00:47 +0530
Message-ID: <20210929113049.64557-2-LakshmiPraveen.Kopparthi@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929113049.64557-1-LakshmiPraveen.Kopparthi@microchip.com>
References: <20210929113049.64557-1-LakshmiPraveen.Kopparthi@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch adds the support to enumerate the UART ports for all the
combinations and writes the necessary port specific registers to
initialise the UART ports.In addition to that, writes to the module
registers are added in the init and exit callbacks to support the
suspend and resume functionality.

This patch adds the wakeup feature support.Each UART port has three
wakeup sources and this patch handles the suspend and wakeup
sequence.

Signed-off-by: LakshmiPraveen Kopparthi <LakshmiPraveen.Kopparthi@microchip.com>
---
 drivers/tty/serial/8250/8250_pci.c  | 298 ++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c |   8 +
 include/uapi/linux/serial_core.h    |   3 +
 3 files changed, 309 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 93159557a2fb..12a3e0bd50aa 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -58,6 +58,13 @@ struct serial_private {
 
 #define PCI_DEVICE_ID_HPE_PCI_SERIAL	0x37e
 
+#define PCI_VENDOR_ID_MCHP_PCI1XXXX	0x1055
+#define PCI_DEVICE_ID_MCHP_PCI12000	0xA002
+#define PCI_DEVICE_ID_MCHP_PCI11010	0xA012
+#define PCI_DEVICE_ID_MCHP_PCI11101	0xA022
+#define PCI_DEVICE_ID_MCHP_PCI11400	0xA032
+#define PCI_DEVICE_ID_MCHP_PCI11414	0xA042
+
 static const struct pci_device_id pci_use_msi[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
 			 0xA000, 0x1000) },
@@ -67,6 +74,16 @@ static const struct pci_device_id pci_use_msi[] = {
 			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
 			 PCI_ANY_ID, PCI_ANY_ID) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_MCHP_PCI1XXXX,
+			PCI_DEVICE_ID_MCHP_PCI12000, PCI_ANY_ID, PCI_ANY_ID) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_MCHP_PCI1XXXX,
+			PCI_DEVICE_ID_MCHP_PCI11101, PCI_ANY_ID, PCI_ANY_ID) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_MCHP_PCI1XXXX,
+			PCI_DEVICE_ID_MCHP_PCI11010, PCI_ANY_ID, PCI_ANY_ID) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_MCHP_PCI1XXXX,
+			PCI_DEVICE_ID_MCHP_PCI11400, PCI_ANY_ID, PCI_ANY_ID) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_MCHP_PCI1XXXX,
+			PCI_DEVICE_ID_MCHP_PCI11414, PCI_ANY_ID, PCI_ANY_ID) },
 	{ }
 };
 
@@ -1853,6 +1870,218 @@ pci_moxa_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, 0);
 }
 
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_4P	0x0001
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3P012	0x0002
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3P013	0x0003
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3P023	0x0004
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3P123	0x0005
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P01	0x0006
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P02	0x0007
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P03	0x0008
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P12	0x0009
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P13	0x000A
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P23	0x000B
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1P0	0x000C
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1P1	0x000D
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1P2	0x000E
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1P3	0x000F
+
+#define UART_ACTV_REG 0x11
+#define UART_PCI_CTRL_REG 0x80
+#define UART_WAKE_REG 0x8C
+#define UART_WAKE_MASK_REG 0x90
+#define UART_RESET_REG 0x94
+
+static char pci1xxxx_port_suspend(int line)
+{
+	struct uart_8250_port *up = serial8250_get_port(line);
+	struct uart_port *port = &up->port;
+	unsigned long flags;
+	u8 wakeup_mask;
+	char ret = 0;
+
+	if (port->suspended == 0 && port->dev) {
+		wakeup_mask = readb(up->port.membase + UART_WAKE_MASK_REG);
+
+		spin_lock_irqsave(&port->lock, flags);
+		port->mctrl &= ~TIOCM_OUT2;
+		port->ops->set_mctrl(port, port->mctrl);
+		spin_unlock_irqrestore(&port->lock, flags);
+
+		if ((wakeup_mask & 0x01) == 0x00)
+			ret = 0x01;
+		else
+			ret = 0x00;
+	}
+	writeb(0x07, port->membase + UART_WAKE_REG);
+	return ret;
+}
+
+void pci1xxxx_port_resume(int line)
+{
+	struct uart_8250_port *up = serial8250_get_port(line);
+	struct uart_port *port = &up->port;
+	unsigned long flags;
+
+	writeb(0x07, port->membase + UART_WAKE_REG);
+	if (port->suspended == 0) {
+		spin_lock_irqsave(&port->lock, flags);
+		port->mctrl |= TIOCM_OUT2;
+		port->ops->set_mctrl(port, port->mctrl);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+}
+
+static int mchp_pci1xxxx_init(struct pci_dev *dev)
+{
+	struct serial_private *priv = pci_get_drvdata(dev);
+	unsigned int data;
+	void __iomem *p;
+	int rc = 0;
+	int i;
+
+	switch (dev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1P0:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1P1:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1P2:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1P3:
+		rc = 1;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P01:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P02:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P03:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P12:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P13:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P23:
+		rc = 2;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3P012:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3P123:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3P013:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3P023:
+		rc = 3;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_4P:
+		rc = 4;
+		break;
+	}
+
+	if (!IS_ERR_OR_NULL(priv)) {
+		for (i = 0; i < priv->nr; i++) {
+			if (priv->line[i] >= 0)
+				pci1xxxx_port_resume(priv->line[i]);
+		}
+	}
+
+	p = pci_ioremap_bar(dev, 0);
+	if (p) {
+		data = readl(p + UART_RESET_REG);
+		writel(data & (~(0x01 << 16)),
+		       p + UART_RESET_REG);
+
+		writeb(0x00, (p + UART_PCI_CTRL_REG));
+
+		iounmap(p);
+	} else {
+		moan_device("remapping of bar 0 memory failed", dev);
+		return -ENOMEM;
+	}
+	return rc;
+}
+
+static void mchp_pci1xxxx_exit(struct pci_dev *dev)
+{
+	struct serial_private *priv = pci_get_drvdata(dev);
+	unsigned int data;
+	void __iomem *p;
+	char wakeup = 0;
+	int i;
+
+	if (!IS_ERR_OR_NULL(priv)) {
+		for (i = 0; i < priv->nr; i++) {
+			if (priv->line[i] >= 0)
+				wakeup |= pci1xxxx_port_suspend(priv->line[i]);
+		}
+	}
+	p = pci_ioremap_bar(dev, 0);
+	if (p) {
+		data = readl(p + UART_RESET_REG);
+		writel(data | (0x01 << 16),
+		       p + UART_RESET_REG);
+
+		if (wakeup & 0x01)
+			writeb(0x01, (p + UART_PCI_CTRL_REG));
+		iounmap(p);
+	} else {
+		moan_device("remapping of bar 0 memory failed", dev);
+	}
+}
+
+static int mchp_pci1xxxx_setup(struct serial_private *priv,
+			       const struct pciserial_board *board,
+			       struct uart_8250_port *port, int idx)
+{
+	unsigned int bar = FL_GET_BASE(board->flags);
+	int first_offset = 0;
+	int offset;
+	int ret;
+
+	switch (priv->dev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1P1:
+		first_offset = 256;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1P2:
+		first_offset = 512;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1P3:
+		first_offset = 768;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P02:
+		if (idx > 0)
+			idx++;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P03:
+		if (idx > 0)
+			idx += 2;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P12:
+		first_offset = 256;
+		if (idx > 0)
+			idx++;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P13:
+		first_offset = 256;
+		if (idx > 0)
+			idx++;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2P23:
+		first_offset = 512;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3P123:
+		first_offset = 256;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3P013:
+		if (idx > 1)
+			idx++;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3P023:
+		if (idx > 0)
+			idx++;
+		break;
+	}
+
+	offset = first_offset + idx * board->uart_offset;
+	port->port.flags |= UPF_FIXED_TYPE | UPF_SKIP_TEST;
+	port->port.type = PORT_MCHP16550A;
+	ret = setup_port(priv, port, bar, offset, board->reg_shift);
+	if (ret < 0)
+		return ret;
+
+	writeb(0x07, port->port.membase + UART_WAKE_REG);
+	writeb(0x01, (port->port.membase + UART_ACTV_REG));
+	return 0;
+}
+
 #define PCI_VENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_SUBVENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_DEVICE_ID_OCTPRO		0x0001
@@ -2778,6 +3007,51 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.setup		= pci_fintek_f815xxa_setup,
 		.init		= pci_fintek_f815xxa_init,
 	},
+	{
+		.vendor         = PCI_VENDOR_ID_MCHP_PCI1XXXX,
+		.device         = PCI_DEVICE_ID_MCHP_PCI12000,
+		.subvendor      = PCI_ANY_ID,
+		.subdevice      = PCI_ANY_ID,
+		.setup          = mchp_pci1xxxx_setup,
+		.init		 = mchp_pci1xxxx_init,
+		.exit		 = mchp_pci1xxxx_exit,
+	},
+	{
+		.vendor         = PCI_VENDOR_ID_MCHP_PCI1XXXX,
+		.device         = PCI_DEVICE_ID_MCHP_PCI11010,
+		.subvendor      = PCI_ANY_ID,
+		.subdevice      = PCI_ANY_ID,
+		.setup          = mchp_pci1xxxx_setup,
+		.init		 = mchp_pci1xxxx_init,
+		.exit		 = mchp_pci1xxxx_exit,
+	},
+	{
+		.vendor         = PCI_VENDOR_ID_MCHP_PCI1XXXX,
+		.device         = PCI_DEVICE_ID_MCHP_PCI11101,
+		.subvendor      = PCI_ANY_ID,
+		.subdevice      = PCI_ANY_ID,
+		.setup          = mchp_pci1xxxx_setup,
+		.init		 = mchp_pci1xxxx_init,
+		.exit		 = mchp_pci1xxxx_exit,
+	},
+	{
+		.vendor         = PCI_VENDOR_ID_MCHP_PCI1XXXX,
+		.device         = PCI_DEVICE_ID_MCHP_PCI11400,
+		.subvendor      = PCI_ANY_ID,
+		.subdevice      = PCI_ANY_ID,
+		.setup          = mchp_pci1xxxx_setup,
+		.init		 = mchp_pci1xxxx_init,
+		.exit		 = mchp_pci1xxxx_exit,
+	},
+	{
+		.vendor         = PCI_VENDOR_ID_MCHP_PCI1XXXX,
+		.device         = PCI_DEVICE_ID_MCHP_PCI11414,
+		.subvendor      = PCI_ANY_ID,
+		.subdevice      = PCI_ANY_ID,
+		.setup          = mchp_pci1xxxx_setup,
+		.init		 = mchp_pci1xxxx_init,
+		.exit		 = mchp_pci1xxxx_exit,
+	},
 
 	/*
 	 * Default "match everything" terminator entry
@@ -2979,6 +3253,7 @@ enum pci_board_num_t {
 	pbn_moxa8250_2p,
 	pbn_moxa8250_4p,
 	pbn_moxa8250_8p,
+	pbn_mchp_pci1xxxx,
 };
 
 /*
@@ -3809,6 +4084,13 @@ static struct pciserial_board pci_boards[] = {
 		.base_baud      = 921600,
 		.uart_offset	= 0x200,
 	},
+	[pbn_mchp_pci1xxxx] = {
+		.flags		= FL_BASE0,
+		.num_ports      = 1,
+		.base_baud      = 3000000,
+		.uart_offset	= 256,
+		.first_offset	= 0,
+	},
 };
 
 static const struct pci_device_id blacklist[] = {
@@ -5698,6 +5980,22 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/* Amazon PCI serial device */
 	{ PCI_DEVICE(0x1d0f, 0x8250), .driver_data = pbn_b0_1_115200 },
 
+	/* Microchip PCI to serial interface */
+	{PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11010,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, pbn_mchp_pci1xxxx },
+	{PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11101,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, pbn_mchp_pci1xxxx },
+	{PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11400,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, pbn_mchp_pci1xxxx },
+	{PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11414,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, pbn_mchp_pci1xxxx },
+	{PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI12000,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, pbn_mchp_pci1xxxx },
 	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 66374704747e..6a7936f52d9a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -307,6 +307,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 32, 64, 112},
 		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP,
 	},
+	[PORT_MCHP16550A] = {
+		.name		= "MCHP16550A",
+		.fifo_size	= 256,
+		.tx_loadsz	= 256,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
+		.rxtrig_bytes	= {2, 66, 130, 194},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index c4042dcfdc0c..21f73b42c46f 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -274,4 +274,7 @@
 /* Freescale LINFlexD UART */
 #define PORT_LINFLEXUART	122
 
+/* MCHP 16550A UART with 256 byte FIFOs */
+#define PORT_MCHP16550A 123
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.25.1

