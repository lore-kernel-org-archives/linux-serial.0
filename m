Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224A524AF1;
	Tue, 13 Oct 2026 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897576; cv=none; b=a7xj8/G9/c1J0IIwcCOKI9+6hWPbkzAMYgHPE48P+t/UT1frvSGKgOecWsSUQKvb/fR3E03E8CwC6zA1MjHEgNAXl4bo8PovYNYcyz48z4lB8Iif3cxoUQPHCELpjb7cVwVl/JthmDWF7YleG0jiPzAPYPkg3dOZCqoNJb3LdwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897576; c=relaxed/simple;
	bh=Vem9Et3lqTzDhSQ7HpE+JhuCvtbidS/9lbDXN7o0ExU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lml8O2b8LC8/iP7/P9fvE5sixiYPN12MP8Yr5caSrIFcXo9in0qshWDJPmiJDfAaz2bvHLXJSiQmMm9Ew+hE2cHxfLR0/u7xL8LuYqpMTgYmts1PhF14+IM3dxysza1Zd8FMPn6PYgM/6k4ayMF3CWWAoxx9PVhsV/8HFl4UUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOA46U30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOA46U30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F331F000FF;
	Tue, 13 Oct 2026 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897574;
	bh=Gj11+UEMUGLSUh2LRkcChhxUjf2HlAuTiNG5V1rTais=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SOA46U309+sV0bHG+Qe/2ZgChQZDj3VIQYeqnwOKlt1hvGBqMIJERmSwHlBE1cfVG
	 JuiKN6AKpgXcnPCmpaL/N4FpZ6m4BRqyGmGTDRcyKSXC0TZ83qiION3oQaOQdhYh0k
	 hUaHF5DNKTYx9vPwhcv6mVXznve73hI5oqWQkDDYi4TB1RdlRyniyyhjmTsO5I7Au4
	 JmNjDfqLtohfiZaRKWaKQ2JLiOzoSvRf/DrczhlO4tdvU7YLN5J/+tQODml3qtBT+b
	 tQtgzm3ItCfvdYdO4szSyoMJoiPrYyQa4QCmhrrI/mH/s+LZR4aNFI+CYnWB2mQJBG
	 CzLG8HgFVTQkw==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	mfd@lists.linux.dev,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 31/53] mfd: ioc3: Add support for IOC4
Date: Tue, 13 Oct 2026 15:16:51 +0200
Message-ID: <2e8b812274f3049c687c37d1b7c3b3a4ee22d008.1791890466.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOC4 is IOC3's successor on IP35 Origin 350-class boards. Its serial and
PS/2 cores reuse IOC3's drivers and its interrupt status splits into two
banks. The serial ports need IOC4 firmware revision 62 or later and are
not registered on older firmware.

The serial, interrupt and GPIO register definitions in asm/sn/ioc4.h
follow include/linux/ioc4.h and drivers/tty/serial/ioc4_serial.c, removed
by commit f7bc6e42bf12 ("drivers: remove the SGI SN2 IOC4 base support")
and commit a017ef17cfd8 ("tty/serial: remove the ioc4_serial driver").

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 MAINTAINERS                                   |   1 +
 arch/mips/include/asm/sn/ioc4.h               | 142 ++++++++
 drivers/mfd/ioc3.c                            | 323 +++++++++++++++---
 drivers/tty/serial/8250/8250_ioc3.c           |   5 +-
 include/linux/platform_data/sgi-ioc3-serial.h |  13 +
 5 files changed, 438 insertions(+), 46 deletions(-)
 create mode 100644 arch/mips/include/asm/sn/ioc4.h
 create mode 100644 include/linux/platform_data/sgi-ioc3-serial.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c..a30c09a55c72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18219,6 +18219,7 @@ F:	arch/mips/
 F:	drivers/platform/mips/
 F:	include/dt-bindings/mips/
 F:	include/linux/platform_data/pic32.h
+F:	include/linux/platform_data/sgi-ioc3-serial.h
 
 MIPS BOSTON DEVELOPMENT BOARD
 M:	Paul Burton <paulburton@kernel.org>
diff --git a/arch/mips/include/asm/sn/ioc4.h b/arch/mips/include/asm/sn/ioc4.h
new file mode 100644
index 000000000000..781fcfb81b5e
--- /dev/null
+++ b/arch/mips/include/asm/sn/ioc4.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * IOC4 -- SGI's I/O ASIC on Tezro/Origin 350-class boards.
+ *
+ * Copyright (C) 2003-2006 Silicon Graphics, Inc.
+ */
+#ifndef MIPS_SN_IOC4_H
+#define MIPS_SN_IOC4_H
+
+#include <linux/types.h>
+
+struct ioc4_serialregs {
+	u32	sscr;
+	u32	stpir;
+	u32	stcir;
+	u32	srpir;
+	u32	srcir;
+	u32	srtr;
+	u32	shadow;
+};
+
+struct ioc4_uartregs {
+	u8	i4u_lcr;
+	union {
+		u8	i4u_iir;	/* read only */
+		u8	i4u_fcr;	/* write only */
+	};
+	union {
+		u8	i4u_ier;	/* DLAB == 0 */
+		u8	i4u_dlm;	/* DLAB == 1 */
+	};
+	union {
+		u8	i4u_rbr;	/* read only, DLAB == 0 */
+		u8	i4u_thr;	/* write only, DLAB == 0 */
+		u8	i4u_dll;	/* DLAB == 1 */
+	};
+	u8	i4u_scr;
+	u8	i4u_msr;
+	u8	i4u_lsr;
+	u8	i4u_mcr;
+};
+
+struct ioc4_serioregs {
+	u32	km_csr;
+	u32	k_rd;
+	u32	m_rd;
+	u32	k_wd;
+	u32	m_wd;
+};
+
+/* ATA/ATAPI block: one taskfile register per 32-bit word. */
+struct ioc4_ata_regs {
+	u32	cmd[8];		/* 0x000, data through status/command */
+	u32	ctrl;		/* 0x020, altstatus/devctrl */
+	u32	pad[(0x040 - 0x024) / 4]; /* 0x024 */
+	u32	dma[9];		/* 0x040, DMA engine */
+};
+
+/* Register layout of IOC4 in PCI BAR0. */
+struct ioc4 {
+	u32	pci_err_addr_l;	/* 0x00000 */
+	u32	pci_err_addr_h;	/* 0x00004 */
+	u32	sio_ir;		/* 0x00008 */
+	u32	other_ir;	/* 0x0000c */
+	u32	sio_ies;	/* 0x00010 */
+	u32	other_ies;	/* 0x00014 */
+	u32	sio_iec;	/* 0x00018 */
+	u32	other_iec;	/* 0x0001c */
+	u32	sio_cr;		/* 0x00020 */
+	u32	pad0;		/* 0x00024 */
+	u32	int_out;	/* 0x00028 */
+	u32	pad1;		/* 0x0002c */
+	u32	gpcr_s;		/* 0x00030 */
+	u32	gpcr_c;		/* 0x00034 */
+	u32	gpdr;		/* 0x00038 */
+	u32	pad2;		/* 0x0003c */
+	u32	gppr[8];	/* 0x00040 */
+
+	u32	pad3[(0x100 - 0x60) / 4];	/* 0x00060 */
+
+	struct ioc4_ata_regs	ata;	/* 0x00100 */
+
+	u32	pad3b[(0x200 - 0x164) / 4];	/* 0x00164 */
+
+	struct ioc4_serioregs	serio;	/* 0x00200, IOC4_KBC_BASE */
+
+	u32	pad4[(0x300 - 0x214) / 4];
+
+	u32	sbbr01_l;	/* 0x00300 */
+	u32	sbbr01_h;	/* 0x00304 */
+	u32	sbbr23_l;	/* 0x00308 */
+	u32	sbbr23_h;	/* 0x0030c */
+
+	struct ioc4_serialregs	port[4];	/* 0x00310 */
+	struct ioc4_uartregs	uart[4];	/* 0x00380 */
+};
+
+/* Bytebus device 0, where the TOD chip sits. */
+#define IOC4_BYTEBUS_DEV0	0x80000L
+
+/* sio_ir carries serial events only, one 8-bit group per port. */
+#define IOC4_SIO_IR_TX_MT	0x01	/* TX ring buffer empty */
+#define IOC4_SIO_IR_RX_FULL	0x02	/* RX ring buffer full */
+#define IOC4_SIO_IR_RX_HIGH	0x04	/* RX high-water exceeded */
+#define IOC4_SIO_IR_RX_TIMER	0x08	/* RX timer has triggered */
+#define IOC4_SIO_IR_DELTA_DCD	0x10	/* DELTA_DCD seen */
+#define IOC4_SIO_IR_DELTA_CTS	0x20	/* DELTA_CTS seen */
+#define IOC4_SIO_IR_INT		0x40	/* UART pass-through interrupt */
+#define IOC4_SIO_IR_TX_EXPLICIT	0x80	/* TX, MCW, or delay complete */
+
+#define IOC4_SIO_IR_PORT_SHIFT(port)	((port) * 8)
+#define IOC4_SIO_IR_PORT_INT(port) \
+	(IOC4_SIO_IR_INT << IOC4_SIO_IR_PORT_SHIFT(port))
+
+/* Bit index of IOC4_SIO_IR_INT; DEFINE_RES_IRQ() needs a constant. */
+#define IOC4_SIO_IR_INT_BIT		6
+#define IOC4_SIO_IR_PORT_INT_BIT(port) \
+	(IOC4_SIO_IR_PORT_SHIFT(port) + IOC4_SIO_IR_INT_BIT)
+
+#define IOC4_OTHER_IR_ATA_INT		0x00000001	/* ATA passthru */
+#define IOC4_OTHER_IR_ATA_MEMERR	0x00000002	/* ATA PCI error */
+#define IOC4_OTHER_IR_S0_MEMERR		0x00000004	/* port 0 PCI error */
+#define IOC4_OTHER_IR_S1_MEMERR		0x00000008	/* port 1 PCI error */
+#define IOC4_OTHER_IR_S2_MEMERR		0x00000010	/* port 2 PCI error */
+#define IOC4_OTHER_IR_S3_MEMERR		0x00000020	/* port 3 PCI error */
+/* The IX-brick wires this bit to the PS/2 ports. */
+#define IOC4_OTHER_IR_KBD_INT		0x00000040
+#define IOC4_OTHER_IR_RT_INT		0x00800000	/* INT_OUT latch */
+#define IOC4_OTHER_IR_GEN_INT		0xff000000	/* generic pins */
+
+#define IOC4_OTHER_IR_KBD_INT_BIT	6	/* bit index */
+
+#define IOC4_SSCR_DMA_EN	0x10000000	/* enable ring buffer DMA */
+
+/* GPIO pins 4-7 select RS232 or RS422 mode for the four UARTs. */
+#define IOC4_GPCR_UART_MODESEL(port)		(0x10 << (port))
+#define IOC4_GPPR_UART_MODESEL_PIN(port)	(4 + (port))
+
+/* The serial core runs off the PCI bus clock, 66MHz in the IX-brick. */
+#define IOC4_UARTCLK	66666667
+
+#endif /* MIPS_SN_IOC4_H */
diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
index 5f8ac364b610..57956c00263f 100644
--- a/drivers/mfd/ioc3.c
+++ b/drivers/mfd/ioc3.c
@@ -19,11 +19,13 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/sgi-ioc3-serial.h>
 #include <linux/platform_data/sgi-w1.h>
 #include <linux/rtc/ds1685.h>
 
 #include <asm/pci/bridge.h>
 #include <asm/sn/ioc3.h>
+#include <asm/sn/ioc4.h>
 
 #define IOC3_IRQ_SERIAL_A	6
 #define IOC3_IRQ_SERIAL_B	15
@@ -37,9 +39,33 @@
 /* 1.2 us latency timer (40 cycles at 33 MHz) */
 #define IOC3_LATENCY	40
 
+struct ioc3_priv_data;
+
+/*
+ * One interrupt bank: an ir/ies/iec register triplet covering 32 hwirqs.
+ * IOC3 has a single bank. IOC4 keeps only the four serial ports in
+ * sio_ir and moves ATA, memory-error, keyboard, RT and generic-pin
+ * events into a second bank, other_ir.
+ */
+struct ioc3_irq_bank {
+	u16 ir, ies, iec;	/* BAR0 offsets */
+	u32 lvl_mask;		/* hwirqs needing level-triggered handling */
+};
+
+struct ioc3_variant {
+	const char *name;
+	struct irq_chip *chip;
+	const struct ioc3_irq_bank *banks;
+	unsigned int nr_banks;
+	unsigned int nr_irqs;
+	u16 pci_command;	/* extra PCI_COMMAND bits to set at probe */
+	int (*setup)(struct ioc3_priv_data *ipd);
+};
+
 struct ioc3_priv_data {
 	struct irq_domain *domain;
-	struct ioc3 __iomem *regs;
+	void __iomem *base;
+	const struct ioc3_variant *var;
 	struct pci_dev *pdev;
 	int domain_irq;
 };
@@ -48,24 +74,27 @@ static void ioc3_irq_ack(struct irq_data *d)
 {
 	struct ioc3_priv_data *ipd = irq_data_get_irq_chip_data(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
+	const struct ioc3_irq_bank *bank = &ipd->var->banks[hwirq / 32];
 
-	writel(BIT(hwirq), &ipd->regs->sio_ir);
+	writel(BIT(hwirq % 32), ipd->base + bank->ir);
 }
 
 static void ioc3_irq_mask(struct irq_data *d)
 {
 	struct ioc3_priv_data *ipd = irq_data_get_irq_chip_data(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
+	const struct ioc3_irq_bank *bank = &ipd->var->banks[hwirq / 32];
 
-	writel(BIT(hwirq), &ipd->regs->sio_iec);
+	writel(BIT(hwirq % 32), ipd->base + bank->iec);
 }
 
 static void ioc3_irq_unmask(struct irq_data *d)
 {
 	struct ioc3_priv_data *ipd = irq_data_get_irq_chip_data(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
+	const struct ioc3_irq_bank *bank = &ipd->var->banks[hwirq / 32];
 
-	writel(BIT(hwirq), &ipd->regs->sio_ies);
+	writel(BIT(hwirq % 32), ipd->base + bank->ies);
 }
 
 static struct irq_chip ioc3_irq_chip = {
@@ -75,16 +104,25 @@ static struct irq_chip ioc3_irq_chip = {
 	.irq_unmask	= ioc3_irq_unmask,
 };
 
+static struct irq_chip ioc4_irq_chip = {
+	.name		= "IOC4",
+	.irq_ack	= ioc3_irq_ack,
+	.irq_mask	= ioc3_irq_mask,
+	.irq_unmask	= ioc3_irq_unmask,
+};
+
 static int ioc3_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
-	/* Set level IRQs for every interrupt contained in IOC3_LVL_MASK */
-	if (BIT(hwirq) & IOC3_LVL_MASK)
-		irq_set_chip_and_handler(irq, &ioc3_irq_chip, handle_level_irq);
+	struct ioc3_priv_data *ipd = d->host_data;
+	const struct ioc3_irq_bank *bank = &ipd->var->banks[hwirq / 32];
+
+	if (BIT(hwirq % 32) & bank->lvl_mask)
+		irq_set_chip_and_handler(irq, ipd->var->chip, handle_level_irq);
 	else
-		irq_set_chip_and_handler(irq, &ioc3_irq_chip, handle_edge_irq);
+		irq_set_chip_and_handler(irq, ipd->var->chip, handle_edge_irq);
 
-	irq_set_chip_data(irq, d->host_data);
+	irq_set_chip_data(irq, ipd);
 	return 0;
 }
 
@@ -103,17 +141,21 @@ static void ioc3_irq_handler(struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
 	struct ioc3_priv_data *ipd = domain->host_data;
-	struct ioc3 __iomem *regs = ipd->regs;
-	u32 pending, mask;
+	unsigned int i;
 
-	pending = readl(&regs->sio_ir);
-	mask = readl(&regs->sio_ies);
-	pending &= mask; /* Mask off not enabled interrupts */
+	for (i = 0; i < ipd->var->nr_banks; i++) {
+		const struct ioc3_irq_bank *bank = &ipd->var->banks[i];
+		u32 pending = readl(ipd->base + bank->ir) &
+			      readl(ipd->base + bank->ies);
 
-	if (pending)
-		generic_handle_domain_irq(domain, __ffs(pending));
-	else
-		spurious_interrupt();
+		if (pending) {
+			generic_handle_domain_irq(domain,
+						  i * 32 + __ffs(pending));
+			return;
+		}
+	}
+
+	spurious_interrupt();
 }
 
 /*
@@ -134,11 +176,12 @@ static int ioc3_irq_domain_setup(struct ioc3_priv_data *ipd, int irq)
 	struct irq_domain *domain;
 	struct fwnode_handle *fn;
 
-	fn = irq_domain_alloc_named_fwnode("IOC3");
+	fn = irq_domain_alloc_named_fwnode(ipd->var->name);
 	if (!fn)
 		goto err;
 
-	domain = irq_domain_create_linear(fn, 24, &ioc3_irq_domain_ops, ipd);
+	domain = irq_domain_create_linear(fn, ipd->var->nr_irqs,
+					  &ioc3_irq_domain_ops, ipd);
 	if (!domain) {
 		irq_domain_free_fwnode(fn);
 		goto err;
@@ -182,21 +225,19 @@ static struct mfd_cell ioc3_serial_cells[] = {
 
 static int ioc3_serial_setup(struct ioc3_priv_data *ipd)
 {
+	struct ioc3 __iomem *regs = ipd->base;
 	int ret;
 
 	/* Set gpio pins for RS232/RS422 mode selection */
-	writel(GPCR_UARTA_MODESEL | GPCR_UARTB_MODESEL,
-		&ipd->regs->gpcr_s);
+	writel(GPCR_UARTA_MODESEL | GPCR_UARTB_MODESEL, &regs->gpcr_s);
 	/* Select RS232 mode for uart a */
-	writel(0, &ipd->regs->gppr[6]);
+	writel(0, &regs->gppr[6]);
 	/* Select RS232 mode for uart b */
-	writel(0, &ipd->regs->gppr[7]);
+	writel(0, &regs->gppr[7]);
 
 	/* Switch both ports to 16650 mode */
-	writel(readl(&ipd->regs->port_a.sscr) & ~SSCR_DMA_EN,
-	       &ipd->regs->port_a.sscr);
-	writel(readl(&ipd->regs->port_b.sscr) & ~SSCR_DMA_EN,
-	       &ipd->regs->port_b.sscr);
+	writel(readl(&regs->port_a.sscr) & ~SSCR_DMA_EN, &regs->port_a.sscr);
+	writel(readl(&regs->port_b.sscr) & ~SSCR_DMA_EN, &regs->port_b.sscr);
 	udelay(1000); /* Wait until mode switch is done */
 
 	ret = mfd_add_devices(&ipd->pdev->dev, PLATFORM_DEVID_AUTO,
@@ -270,10 +311,11 @@ static struct mfd_cell ioc3_eth_cells[] = {
 
 static int ioc3_eth_setup(struct ioc3_priv_data *ipd)
 {
+	struct ioc3 __iomem *regs = ipd->base;
 	int ret;
 
 	/* Enable One-Wire bus */
-	writel(GPCR_MLAN_EN, &ipd->regs->gpcr_s);
+	writel(GPCR_MLAN_EN, &regs->gpcr_s);
 
 	/* Generate unique identifier */
 	snprintf(ioc3_w1_platform_data.dev_id,
@@ -539,14 +581,12 @@ static struct {
 
 static int ioc3_setup(struct ioc3_priv_data *ipd)
 {
+	struct ioc3 __iomem *regs = ipd->base;
 	u32 sid;
 	int i;
 
-	/* Clear IRQs */
-	writel(~0, &ipd->regs->sio_iec);
-	writel(~0, &ipd->regs->sio_ir);
-	writel(0, &ipd->regs->eth.eier);
-	writel(~0, &ipd->regs->eth.eisr);
+	writel(0, &regs->eth.eier);
+	writel(~0, &regs->eth.eisr);
 
 	/* Read subsystem vendor id and subsystem id */
 	pci_read_config_dword(ipd->pdev, PCI_SUBSYSTEM_VENDOR_ID, &sid);
@@ -565,10 +605,16 @@ static int ioc3_setup(struct ioc3_priv_data *ipd)
 static int ioc3_mfd_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *pci_id)
 {
+	const struct ioc3_variant *var = (void *)pci_id->driver_data;
 	struct ioc3_priv_data *ipd;
-	struct ioc3 __iomem *regs;
+	void __iomem *base;
+	unsigned int i;
+	u16 cmd;
 	int ret;
 
+	if (!var)
+		return -ENODEV;
+
 	ret = pci_enable_device(pdev);
 	if (ret)
 		return ret;
@@ -576,6 +622,12 @@ static int ioc3_mfd_probe(struct pci_dev *pdev,
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, IOC3_LATENCY);
 	pci_set_master(pdev);
 
+	if (var->pci_command) {
+		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+		pci_write_config_word(pdev, PCI_COMMAND,
+				      cmd | var->pci_command);
+	}
+
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
 		pr_err("%s: No usable DMA configuration, aborting.\n",
@@ -591,24 +643,31 @@ static int ioc3_mfd_probe(struct pci_dev *pdev,
 		goto out_disable_device;
 	}
 	ipd->pdev = pdev;
+	ipd->var = var;
 
 	/*
 	 * Map all IOC3 registers.  These are shared between subdevices
 	 * so the main IOC3 module manages them.
 	 */
-	regs = pci_ioremap_bar(pdev, 0);
-	if (!regs) {
+	base = pci_ioremap_bar(pdev, 0);
+	if (!base) {
 		dev_warn(&pdev->dev, "ioc3: Unable to remap PCI BAR for %s.\n",
 			 pci_name(pdev));
 		ret = -ENOMEM;
 		goto out_disable_device;
 	}
-	ipd->regs = regs;
+	ipd->base = base;
 
 	/* Track PCI-device specific data */
 	pci_set_drvdata(pdev, ipd);
 
-	ret = ioc3_setup(ipd);
+	/* Clear IRQs */
+	for (i = 0; i < var->nr_banks; i++) {
+		writel(~0, base + var->banks[i].iec);
+		writel(~0, base + var->banks[i].ir);
+	}
+
+	ret = var->setup(ipd);
 	if (ret) {
 		/* Remove all already added MFD devices */
 		mfd_remove_devices(&ipd->pdev->dev);
@@ -619,7 +678,7 @@ static int ioc3_mfd_probe(struct pci_dev *pdev,
 			irq_domain_free_fwnode(fn);
 			free_irq(ipd->domain_irq, (void *)ipd);
 		}
-		pci_iounmap(pdev, regs);
+		pci_iounmap(pdev, base);
 		goto out_disable_device;
 	}
 
@@ -633,12 +692,15 @@ static int ioc3_mfd_probe(struct pci_dev *pdev,
 static void ioc3_mfd_remove(struct pci_dev *pdev)
 {
 	struct ioc3_priv_data *ipd;
+	unsigned int i;
 
 	ipd = pci_get_drvdata(pdev);
 
 	/* Clear and disable all IRQs */
-	writel(~0, &ipd->regs->sio_iec);
-	writel(~0, &ipd->regs->sio_ir);
+	for (i = 0; i < ipd->var->nr_banks; i++) {
+		writel(~0, ipd->base + ipd->var->banks[i].iec);
+		writel(~0, ipd->base + ipd->var->banks[i].ir);
+	}
 
 	/* Release resources */
 	mfd_remove_devices(&ipd->pdev->dev);
@@ -649,12 +711,183 @@ static void ioc3_mfd_remove(struct pci_dev *pdev)
 		irq_domain_free_fwnode(fn);
 		free_irq(ipd->domain_irq, (void *)ipd);
 	}
-	pci_iounmap(pdev, ipd->regs);
+	pci_iounmap(pdev, ipd->base);
 	pci_disable_device(pdev);
 }
 
+static const struct ioc3_irq_bank ioc3_irq_banks[] = {
+	{
+		.ir = offsetof(struct ioc3, sio_ir),
+		.ies = offsetof(struct ioc3, sio_ies),
+		.iec = offsetof(struct ioc3, sio_iec),
+		.lvl_mask = IOC3_LVL_MASK,
+	},
+};
+
+static const struct ioc3_variant ioc3_variant = {
+	.name = "IOC3",
+	.chip = &ioc3_irq_chip,
+	.banks = ioc3_irq_banks,
+	.nr_banks = ARRAY_SIZE(ioc3_irq_banks),
+	.nr_irqs = 24,
+	.setup = ioc3_setup,
+};
+
+#define IOC4_NUM_PORTS		4
+#define IOC4_SERIAL_MIN_REV	62
+
+/* hwirqs 0-31 are sio_ir's, 32-63 other_ir's. */
+#define IOC4_IRQ_OTHER_BASE	32
+#define IOC4_NUM_IRQS		64
+
+/* In sio_ir only the four UART pass-through bits are level triggered. */
+#define IOC4_LVL_MASK \
+	(IOC4_SIO_IR_PORT_INT(0) | IOC4_SIO_IR_PORT_INT(1) | \
+	 IOC4_SIO_IR_PORT_INT(2) | IOC4_SIO_IR_PORT_INT(3))
+
+#define IOC4_UART_RES(port) {						\
+	DEFINE_RES_MEM(offsetof(struct ioc4, uart[port]),		\
+		       sizeof_field(struct ioc4, uart[port])),		\
+	DEFINE_RES_IRQ(IOC4_SIO_IR_PORT_INT_BIT(port)),			\
+}
+
+static const struct resource ioc4_uart_resources[][2] = {
+	IOC4_UART_RES(0),
+	IOC4_UART_RES(1),
+	IOC4_UART_RES(2),
+	IOC4_UART_RES(3),
+};
+
+static const struct resource ioc4_kbd_resources[] = {
+	DEFINE_RES_MEM(offsetof(struct ioc4, serio),
+		       sizeof_field(struct ioc4, serio)),
+	DEFINE_RES_IRQ(IOC4_IRQ_OTHER_BASE + IOC4_OTHER_IR_KBD_INT_BIT)
+};
+
+static const struct resource ioc4_rtc_resources[] = {
+	DEFINE_RES_MEM(IOC4_BYTEBUS_DEV0, M48T35_REG_SIZE)
+};
+
+static const struct ioc3_serial8250_platform_data ioc4_serial_pdata = {
+	.uartclk = IOC4_UARTCLK,
+};
+
+#define IOC4_SERIAL_CELL(port) {					\
+	.name = "ioc3-serial8250",					\
+	.resources = ioc4_uart_resources[port],				\
+	.num_resources = ARRAY_SIZE(ioc4_uart_resources[port]),		\
+	.platform_data = &ioc4_serial_pdata,				\
+	.pdata_size = sizeof(ioc4_serial_pdata),			\
+}
+
+static const struct mfd_cell ioc4_serial_cells[] = {
+	IOC4_SERIAL_CELL(0),
+	IOC4_SERIAL_CELL(1),
+	IOC4_SERIAL_CELL(2),
+	IOC4_SERIAL_CELL(3),
+};
+
+static const struct mfd_cell ioc4_cells[] = {
+	{
+		.name = "ioc3-kbd",
+		.resources = ioc4_kbd_resources,
+		.num_resources = ARRAY_SIZE(ioc4_kbd_resources),
+	},
+	{
+		.name = "rtc-m48t35-ip35",
+		.resources = ioc4_rtc_resources,
+		.num_resources = ARRAY_SIZE(ioc4_rtc_resources),
+	},
+};
+
+static int ioc4_serial_setup(struct ioc3_priv_data *ipd)
+{
+	struct ioc4 __iomem *regs = ipd->base;
+	int ret, i;
+
+	if (ipd->pdev->revision < IOC4_SERIAL_MIN_REV) {
+		dev_warn(&ipd->pdev->dev,
+			 "serial ports need IOC4 firmware revision %u or later\n",
+			 IOC4_SERIAL_MIN_REV);
+		return 0;
+	}
+
+	/* Set gpio pins for RS232/RS422 mode selection */
+	writel(IOC4_GPCR_UART_MODESEL(0) | IOC4_GPCR_UART_MODESEL(1) |
+	       IOC4_GPCR_UART_MODESEL(2) | IOC4_GPCR_UART_MODESEL(3),
+	       &regs->gpcr_s);
+
+	for (i = 0; i < IOC4_NUM_PORTS; i++) {
+		/* Select RS232 mode, and switch the port to 16650 mode */
+		writel(0, &regs->gppr[IOC4_GPPR_UART_MODESEL_PIN(i)]);
+		writel(readl(&regs->port[i].sscr) & ~IOC4_SSCR_DMA_EN,
+		       &regs->port[i].sscr);
+	}
+	udelay(1000); /* Wait until mode switch is done */
+
+	ret = mfd_add_devices(&ipd->pdev->dev, PLATFORM_DEVID_AUTO,
+			      ioc4_serial_cells, ARRAY_SIZE(ioc4_serial_cells),
+			      &ipd->pdev->resource[0], 0, ipd->domain);
+	if (ret)
+		dev_err(&ipd->pdev->dev, "Failed to add 16550 subdevs\n");
+
+	return ret;
+}
+
+static int ioc4_setup(struct ioc3_priv_data *ipd)
+{
+	int ret;
+
+	dev_info(&ipd->pdev->dev, "IOC4 firmware revision %u\n",
+		 ipd->pdev->revision);
+
+	ret = ioc3_irq_domain_setup(ipd, ipd->pdev->irq);
+	if (ret)
+		return ret;
+
+	ret = ioc4_serial_setup(ipd);
+	if (ret)
+		return ret;
+
+	ret = mfd_add_devices(&ipd->pdev->dev, PLATFORM_DEVID_AUTO,
+			      ioc4_cells, ARRAY_SIZE(ioc4_cells),
+			      &ipd->pdev->resource[0], 0, ipd->domain);
+	if (ret)
+		dev_err(&ipd->pdev->dev, "Failed to add IOC4 subdevs\n");
+
+	return ret;
+}
+
+static const struct ioc3_irq_bank ioc4_irq_banks[] = {
+	{
+		.ir = offsetof(struct ioc4, sio_ir),
+		.ies = offsetof(struct ioc4, sio_ies),
+		.iec = offsetof(struct ioc4, sio_iec),
+		.lvl_mask = IOC4_LVL_MASK,
+	},
+	{
+		.ir = offsetof(struct ioc4, other_ir),
+		.ies = offsetof(struct ioc4, other_ies),
+		.iec = offsetof(struct ioc4, other_iec),
+	},
+};
+
+static const struct ioc3_variant ioc4_variant = {
+	.name = "IOC4",
+	.chip = &ioc4_irq_chip,
+	.banks = ioc4_irq_banks,
+	.nr_banks = ARRAY_SIZE(ioc4_irq_banks),
+	.nr_irqs = IOC4_NUM_IRQS,
+	/* Parity and SERR# reporting, as the SN2 IOC4 core enabled them. */
+	.pci_command = PCI_COMMAND_PARITY | PCI_COMMAND_SERR,
+	.setup = ioc4_setup,
+};
+
 static struct pci_device_id ioc3_mfd_id_table[] = {
-	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3, PCI_ANY_ID, PCI_ANY_ID },
+	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3, PCI_ANY_ID, PCI_ANY_ID,
+	  0, 0, (kernel_ulong_t)&ioc3_variant },
+	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC4, PCI_ANY_ID, PCI_ANY_ID,
+	  0, 0, (kernel_ulong_t)&ioc4_variant },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, ioc3_mfd_id_table);
@@ -669,5 +902,5 @@ static struct pci_driver ioc3_mfd_driver = {
 module_pci_driver(ioc3_mfd_driver);
 
 MODULE_AUTHOR("Thomas Bogendoerfer <tbogendoerfer@suse.de>");
-MODULE_DESCRIPTION("SGI IOC3 MFD driver");
+MODULE_DESCRIPTION("SGI IOC3/IOC4 MFD driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
index 28e28076782b..5d3c0190f19e 100644
--- a/drivers/tty/serial/8250/8250_ioc3.c
+++ b/drivers/tty/serial/8250/8250_ioc3.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/platform_data/sgi-ioc3-serial.h>
 #include <linux/platform_device.h>
 
 #include "8250.h"
@@ -33,6 +34,7 @@ static void ioc3_serial_out(struct uart_port *p, unsigned int offset, u32 value)
 
 static int serial8250_ioc3_probe(struct platform_device *pdev)
 {
+	const struct ioc3_serial8250_platform_data *pdata;
 	struct ioc3_8250_data *data;
 	struct uart_8250_port up;
 	struct resource *r;
@@ -56,9 +58,10 @@ static int serial8250_ioc3_probe(struct platform_device *pdev)
 		irq = 0; /* no interrupt -> use polling */
 
 	/* Register serial ports with 8250.c */
+	pdata = dev_get_platdata(&pdev->dev);
 	memset(&up, 0, sizeof(struct uart_8250_port));
 	up.port.iotype = UPIO_MEM;
-	up.port.uartclk = IOC3_UARTCLK;
+	up.port.uartclk = pdata ? pdata->uartclk : IOC3_UARTCLK;
 	up.port.type = PORT_16550A;
 	up.port.irq = irq;
 	up.port.flags = (UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ);
diff --git a/include/linux/platform_data/sgi-ioc3-serial.h b/include/linux/platform_data/sgi-ioc3-serial.h
new file mode 100644
index 000000000000..ae4690f33125
--- /dev/null
+++ b/include/linux/platform_data/sgi-ioc3-serial.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SGI IOC3/IOC4 8250-compatible UART cells
+ */
+
+#ifndef PLATFORM_DATA_SGI_IOC3_SERIAL_H
+#define PLATFORM_DATA_SGI_IOC3_SERIAL_H
+
+struct ioc3_serial8250_platform_data {
+	unsigned int uartclk;
+};
+
+#endif /* PLATFORM_DATA_SGI_IOC3_SERIAL_H */
-- 
2.47.3

