Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA8456DF1
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049112; cv=none; b=jUblMeQt98vedV4QdqrkmKTuPaZpHDAoIWvhvu4j2ySJZOCWS7yQettsHt8bS6BAmlqe8dwVNYmDZiM7JomstNQdr+B/3BhyTZ+Aqh2dyYHBv+mWJT2sKXjmEzV8rjC4Y9exB7+wJXjTWnPjCpm7Z/Nxoe26KDEFjZR92OcDhjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049112; c=relaxed/simple;
	bh=BnFI0sxOVtRNT7Mn5Fsdwv+qqDCZu4bvha8StYmJTj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qcir3hvkUXb0UFFhmRhYgW0ti4Amj61RMjngR3YAm1QLM1foAKBWoYDWh4wJ0C4mWG+bjhM69cEWLHxM+4TpTKId6n4hB4f7BqudoJb78Z0HrS+bmfdS3FmwkyA8alc4T5mk7dskVe1mFbuXuH+IXV1Deo1v561XlHGnBUdwzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=a7FqDMV7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="a7FqDMV7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49802c418b5so48113745e9.1
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049109; x=1787653909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KU+bDqYU/O9Dr1Oo3XPL7kKeSTUBEiouuUJWuvT/yEQ=;
        b=a7FqDMV748a5tKViRv9dMygYJGVvvdQhkP9wmpsHBf8gu5nzRtCEfwpSOktrpHESDk
         wrhAZI0JM3edaJdriGeHfLafzGdtPLYddopYgyDL6pJpmP9ZorFbzVFXs2CxpbDgMlXs
         GjgObt55ENYrXwRbcV7LKZP1XKrjrc+TkDtqSjVHadbsibGdNm+WyorMC8YfYMrPmVEL
         6M3SQ45ZBH4Klq8Smyi+igZ0riz2Gj67+9cxZUzzyoaeYlOJzb6Ms5LlIGh+J/OMmhnE
         sGhD36tr8MNEea+QZZ9eZB8567Rv4okkh3IRokyJVTjwbyIBgeOEqSmt6oq38olBsQYM
         tghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049109; x=1787653909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KU+bDqYU/O9Dr1Oo3XPL7kKeSTUBEiouuUJWuvT/yEQ=;
        b=hrN2TIuQKqeG0K1Yg4/fX306fGBBxSWjkkkgkSucYDN7QIm7YWSQGfueWYxhvTMHU5
         vXdYyrDtbGIXOXN79g00N84e1Q/UvwGa0PhkY3e1yzfOW/QNOib+2PPLSqFDMF4A1DIF
         Z3vbRLZTceBpy46uTowZcest7yv4Z2d6v8DXAZ1jOZr/bj5eF/5E53UQa5pA//l9nn+0
         YxUkMiIGza+0mgPsA7auqZ2sHSnSKwi7kQ44GLieI0iR/FikYAnMxthLBnYFCyj9xtIX
         gj5HWf43xsh70ULMausWD/flDhSYcJajipi4rqV9tQP/l4axNHQ4+NBpRZMDai6fr7PN
         E8lg==
X-Forwarded-Encrypted: i=1; AHgh+RqqdR1scA3ZDkODfswUQcLNdVX+eV9H/1ipzwYyyFoxxSXf3AtXVw6i8fVdyiGit8CJkvPpHh2cbxO3QBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVj5v5P08Dx5MLVrl6IKW/IQsoppqDBIjh7fwf+aJPdg1jWRwl
	LvqhBZAAD1kfFF0GZN7IWVyhMUPYNUifutlwimfSwVZvIHyskDQgq75o3oXowTi5oYw=
X-Gm-Gg: AR+sD139JGS6oumtJBEd9svEntyf8SOHicLYcGNcgKeO4UeoUuMV0KTM3y8bISriJgs
	2K6W1AJbW4PYZEk1bZG7PfcBQr/jSE6wIdjHjPrRvpXDsYgvMdLgVYJhklO6BXW3iOL/FW1ZFeQ
	iWONWLXCzFwxbKhblFvykQi3RHETCtGKkmKQwYBt09ks9/O5d/NGOV0pNSe40R7OmyXqnJ/dDqY
	evC0kPUqsx+mklCJcTWdgOIodQtAZgKJshYy3bOaUuqfoD+RaBGqLXbyMgpYTwDH9xrkL7aO5K8
	10y8IYv7rK6Bw8PwCgij9iUXKicVS+brtv+KBzpydGop67IyVUo6Uu6Z1SVMqugPwOH24N3hKEd
	I9B15yzmjSkKDYbobakcHw860viitlCnaNY75bwKXkfe57lUzaRYPuOtsxHyg8eQQfIlKeNnmhl
	Zypdu7Shjx1VfvJvpEZ5KkJobZPeUqQHbDyH+q0NA3Hz4Z8LVs53empLD8jBn5ioZygqiG7tS/s
	U4Kojueb10elI2pf5FVeHZc2EbzdGkE5oy9HzmzSkO6DGKPXN7hs3rH15Wp
X-Received: by 2002:a05:600c:3b8f:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-499906ce446mr411847085e9.3.1787049109066;
        Tue, 18 Aug 2026 03:31:49 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:48 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 18 Aug 2026 10:29:17 +0000
Subject: [PATCH v6 4/6] mfd: aspeed-pci-core: add AST2600 PCIe BMC device
 driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-aspeed-driver-v6-v6-4-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
In-Reply-To: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
X-Mailer: b4 0.15.2

Add support for UART over PCIe between ASPEED AST2600 BMC and
host. This is the host-side driver.

Based on ASPEED 6.18 Kernel SDK and trimmed down and changed to
MFD driver.

The AST2600 has two 8250-compatible register set usable over PCIe.
These act as two UARTs. As there is only a FIFO internally between both
ends, they are called Virtual UARTs. This patch adds both VUARTs as
plat_serial8250_port. This is the core driver in charge of setting up
MSI interrupts. It doesn't bind the whole PCIe resource to allow each
sub-driver to bind the needed addresses.

This is not added as a PCI 8250 UART device, but as a MFD driver, as this
host driver can be expanded upon for IPMI over KCS. It can also be used
in the future for custom BMC<->host communication with shared memory and
doorbell.

This host module should be the entry point for setting up all features
related to an AST2600 present on the PCI bus.

Notes on the implementation:
The host can't detect the VUART addresses, so they are forced to
0x3f8 and 0x2f8, as in the initial ASPEED driver.

The MSI vector index of VUART2 has been changed from 15 to 17.
The index 15 used in the initial driver was not working.

Tested:
Data path in both direction is tested on both VUARTs.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 MAINTAINERS                   |   6 +++
 drivers/mfd/Kconfig           |  12 +++++
 drivers/mfd/Makefile          |   2 +
 drivers/mfd/aspeed-pci-core.c | 115 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 562754f2d166..7ea6c7d4703e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4011,6 +4011,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/aspeed,*
 F:	drivers/crypto/aspeed/
 
+ASPEED PCI BMC DEVICE DRIVER
+M:	Grégoire Layet <git@gregoirelayet.com>
+M:	Tan Siewert <tan.siewert@9elements.com>
+S:	Maintained
+F:	drivers/mfd/aspeed-pci-core.c
+
 ASPEED PECI CONTROLLER
 M:	Iwona Winiarska <iwona.winiarska@intel.com>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 763ce6a34782..dd780f72d169 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2573,5 +2573,17 @@ config MFD_MAX7360
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_ASPEED_PCI_BMC_DEVICE
+	tristate "ASPEED BMC PCIe device"
+	depends on PCI
+	select MFD_CORE
+	help
+	  Host-side driver for the ASPEED AST2600 BMC PCIe device found on
+	  BMC expansion cards. Exposes two 8250-compatible VUART
+	  ports.
+
+	  If unsure, say N. Choose M here if this machine has an
+	  AST2600-based BMC expansion card on its PCIe bus.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index dd4bb7e77c33..a364b1b5936b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -303,3 +303,5 @@ obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
 obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
 
 obj-$(CONFIG_MFD_LOONGSON_SE)	+= loongson-se.o
+
+obj-$(CONFIG_MFD_ASPEED_PCI_BMC_DEVICE)	+= aspeed-pci-core.o
diff --git a/drivers/mfd/aspeed-pci-core.c b/drivers/mfd/aspeed-pci-core.c
new file mode 100644
index 000000000000..2f299955bc1b
--- /dev/null
+++ b/drivers/mfd/aspeed-pci-core.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (C) ASPEED Technology Inc.
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/serial_8250.h>
+#include <linux/mfd/core.h>
+
+#define ASPEED_BMC_MULTI_MSI		32
+#define ASPEED_BMC_PCI_DEVICE_ID	0x2402
+#define ASPEED_BMC_REVISION_AST2700	0x27
+#define ASPEED_BMC_NR_VUART		2
+
+#define DRIVER_NAME "ast2600-pci-core"
+
+static const unsigned int vuart_msi_index[ASPEED_BMC_NR_VUART] = { 16, 17 };
+static const u16 vuart_port_addr[ASPEED_BMC_NR_VUART] = { 0x3f8, 0x2f8 };
+
+static struct plat_serial8250_port aspeed_uart_port[ASPEED_BMC_NR_VUART + 1] = {
+	{
+		.uartclk = 115200 * 16,
+		.iotype = UPIO_MEM32,
+		.type = PORT_16550A,
+		.flags = (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE),
+		.regshift = 2
+	},
+	{
+		.uartclk = 115200 * 16,
+		.iotype = UPIO_MEM32,
+		.type = PORT_16550A,
+		.flags = (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE),
+		.regshift = 2
+	},
+	{ 0 }
+};
+
+static const struct mfd_cell aspeed_bmc_cell = {
+	.name		= "serial8250",
+	.platform_data	= aspeed_uart_port,
+	.pdata_size	= sizeof(aspeed_uart_port),
+};
+
+static int aspeed_pci_bmc_device_setup_vuart(struct pci_dev *pdev)
+{
+	resource_size_t bar = pci_resource_start(pdev, 1);
+	unsigned int i;
+
+	for (i = 0; i < ASPEED_BMC_NR_VUART; i++) {
+		aspeed_uart_port[i].mapbase = bar + (vuart_port_addr[i] << 2);
+		aspeed_uart_port[i].irq = pci_irq_vector(pdev, vuart_msi_index[i]);
+	}
+
+	return 0;
+}
+
+static void aspeed_bmc_pci_free_irqs(void *pdev)
+{
+	pci_free_irq_vectors(pdev);
+}
+
+static int aspeed_pci_host_bmc_device_probe(struct pci_dev *pdev,
+					    const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	int rc = 0;
+
+	if (pdev->revision == ASPEED_BMC_REVISION_AST2700)
+		return dev_err_probe(dev, -ENODEV, "AST2700 detected but not supported\n");
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return dev_err_probe(dev, rc, "failed to enable device\n");
+
+	pci_set_master(pdev);
+
+	rc = pci_alloc_irq_vectors(pdev, ASPEED_BMC_MULTI_MSI, ASPEED_BMC_MULTI_MSI, PCI_IRQ_MSI);
+	if (rc < 0)
+		return dev_err_probe(dev, rc, "failed to allocate %d MSI vectors\n",
+				     ASPEED_BMC_MULTI_MSI);
+
+	rc = devm_add_action_or_reset(dev, aspeed_bmc_pci_free_irqs, pdev);
+	if (rc)
+		return rc;
+
+	aspeed_pci_bmc_device_setup_vuart(pdev);
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
+				    &aspeed_bmc_cell, 1, &pdev->resource[1],
+				    0, NULL);
+}
+
+static struct pci_device_id aspeed_bmc_dev_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASPEED, ASPEED_BMC_PCI_DEVICE_ID),
+		.class = PCI_CLASS_OTHERS << 16,
+		.class_mask = 0xFFFF00
+	},
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, aspeed_bmc_dev_pci_ids);
+
+static struct pci_driver aspeed_host_bmc_dev_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= aspeed_bmc_dev_pci_ids,
+	.probe		= aspeed_pci_host_bmc_device_probe,
+};
+
+module_pci_driver(aspeed_host_bmc_dev_driver);
+
+MODULE_AUTHOR("Grégoire Layet <gregoire.layet@9elements.com>");
+MODULE_DESCRIPTION("Host-side driver for the ASPEED BMC PCIe device");
+MODULE_LICENSE("GPL");

-- 
2.54.0

