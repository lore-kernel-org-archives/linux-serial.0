Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C6C331237
	for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224998; cv=none; b=qMIWHSRhrxDTkNGC+hPmuQ+MDQgTjrhAjqIfIu1IJmhUYHIdBTG8UBAeDAt/dvvgO4TObhsqFqjue3hXl1ZtMyKw2t47vznA0Gg3EXEhDpoLf+56yPguF7m+gm9aDXpB6NyRUIg/w/qtv8nKS7CMCgdnPpiV76bV3lR1sK1SP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224998; c=relaxed/simple;
	bh=ClRTXFBwIBwnvAlDoFKopCEaejgk+0ezfkPZbcLbTyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrgNBRJAGWAGSyRMEvvD9SQsvBznN9X5sQhJGUTrJnU6lnqsQM3n+yOvFZ7Nhz8VjjbRoHhLFmxz+ePbzmzdwJ0en9iPGPOKYQjTTJvirajRlwZNreId6On8Z90JIE9go34Qbgx5w3GR6zqt4Fc9ygfXv1tb2Fi/2mur8orJHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=A8Zdegx9; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="A8Zdegx9"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so4416102f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782224995; x=1782829795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzFl26ddi0jEQXsVe9q4+m4rXNgAUesMeoLcq3/Soy8=;
        b=A8Zdegx9MZ2djBYNTYg2UNkyLgS3Fg3qFZoiJ/8fF7euJ+F48pMH/M35qXa3OU0I7z
         3PXOtSUMwzIeS2YIVXtzWrimadcMrvRXrK+4A4F8eIR1fNH5RfYuh46+20+XXTy0cWj7
         WZboUOcrf45tS5s8fIS+TGR137sasE1CqC8zF+mmE/oSGYHkdqxqFTJRocFxUUDe0qhi
         n6Zv+I8YEGXqMoS9wpZbiK/ZCXW5kjevvoGLybEDlrf8iAxlFDCXcHQ7go9RWbXN414M
         Kf+W2Dmra3WaVWQ3WuQnmv2C4q1JjkDAoxFE6H0HisApmf+yrRbKOEZ0x2gBGL+Qdu2+
         0lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224995; x=1782829795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FzFl26ddi0jEQXsVe9q4+m4rXNgAUesMeoLcq3/Soy8=;
        b=nQWQhlISujOVnXIiPvBqK7ASGh/UFT14KN+/0Da716+aMLAR/R182iFEbzYZm/5t88
         nTliF/HiGF/K6OF47GGdVN9yGYtpeMptliVsvoCJFzz6MW29sPPy/NNzx1iP3FspJlFP
         i9EaNDyPr5A60y7KKSDxx4x7y4aFSP0HOxWierLp5xM8+r2SbqBoKgbu1+H1QycdwwQW
         70ffvuqyWTp2waan+FXb7UK0HiWXpVyrqZ/5NzNf6FdhiH+Wj1PYTOhHRWYMMcydT665
         GHokp21cqKqMQbs51sawwjTc7adgKyEwRQ2tFrIW6zFqkPDoK73Y+FL7Xx1dkISezHtQ
         lACw==
X-Forwarded-Encrypted: i=1; AFNElJ/kd6Ky6lFOL9Z11HGJRbFapsVqaGZpvUA6ZfsUsAYP7RJnB3MatEG4/Ows7dwBX4kxn9e9zlaLvK6+5xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAeX95loJPYN6p/X/s9xbo7CA0RovcE2bWDCWL9A0y2fJT2iF5
	uXHiWXM2r2tuJdc66lgHt+6yFLlcrM3TQNbSaqFO8MZfq+zOlsW8KaOsyHIO/x/hTDw=
X-Gm-Gg: AfdE7cl4zF77wRBW7FpcJ3orf8fXJEbVBNCJ1uhl/DZZxVXNhewWVQKykwb36ZQ/vl/
	IPVociMB7w++b0340bPs/oKxsDMNaMRZVToyIs0LrvEBN68UCIzhsisY1IAxcmoYK8zvhmjGSOo
	FtB/1LMz/2tk0GUUkI38fygynXoSIGqTj19NgwHa+cqYNVI+o4ApQ0j77VlWHbOYgSpHzOSMKGj
	Mg5GfJiZRUmt3JEc/w8951w2rMU6OIp1N5ActNz1YPrWkFUdljOtMXAT7v+xaPScuaKYwonFw05
	HtXU7GnlpyDfWsRSq5h3/Xkru0G4Wt+XJ77ZsmREZuNyx0zDTAyR/Q6GWH8uwMcW0grzBLkVaCW
	C/Z2ompCf+g/jGg0K79hkKA7Y08XSSIqH2l1VXclGV0YMACNygKe4FLY3S+dHmsrX5MR3Y938QU
	kHJa3EeQD8xq1scsjgKGPxs0gp/Mfph3badb9r8Kn15dYkJ7cQJqv6vWXQuBOr1exbwPpkqVk/H
	75vqnGkeg9tQI7/p9N5PyHTyyOA
X-Received: by 2002:a05:600c:698c:b0:492:4c9e:c95d with SMTP id 5b1f17b1804b1-4925b3b21e1mr48666485e9.18.1782224995461;
        Tue, 23 Jun 2026 07:29:55 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:29:55 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v3 5/7] soc: aspeed: add host-side PCIe BMC device driver
Date: Tue, 23 Jun 2026 14:25:43 +0000
Message-ID: <8746971524bf4186c9a393dab637ad4e27ce4563.1782224059.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782224059.git.gregoire.layet@9elements.com>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for VUART over PCIe between BMC and host.
This add host side driver.
This only support the AST2600.

Taken from ASPEED 6.18 Kernel SDK and trimmed down.

The host can't detect the VUART adresses, they are forced
at 0x3f8 and 0x2f8, similar from the initial ASPEED driver.

The MSI vector index has been changed for the VUART2 from 15 to 17.
The index 15 used in the initial driver was not working.

Data path in both direction is tested on both VUART.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
Tested-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/soc/aspeed/Kconfig               |   8 +
 drivers/soc/aspeed/Makefile              |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 183 +++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index 63a656449a1a..ebd023b10701 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -4,6 +4,14 @@ if ARCH_ASPEED || COMPILE_TEST
 
 menu "ASPEED SoC drivers"
 
+config ASPEED_HOST_BMC_DEV
+	tristate "ASPEED Host BMC Device"
+	depends on PCI
+	depends on SERIAL_8250
+	help
+	  Enable support for the ASPEED AST2600 BMC Device on the Host.
+	  This configure the PCIe and setup two 8250 compatible VUART ports.
+
 config ASPEED_LPC_CTRL
 	tristate "ASPEED LPC firmware cycle control"
 	select REGMAP
diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index b35d74592964..c515e163eab7 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ASPEED_HOST_BMC_DEV)	+= aspeed-host-bmc-dev.o
 obj-$(CONFIG_ASPEED_LPC_CTRL)		+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
 obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
diff --git a/drivers/soc/aspeed/aspeed-host-bmc-dev.c b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
new file mode 100644
index 000000000000..3160b6aedb5b
--- /dev/null
+++ b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (C) ASPEED Technology Inc.
+
+#include <linux/init.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+
+#define BMC_MULTI_MSI	32
+#define PCI_BMC_DEVICE_ID 0x2402
+
+#define DRIVER_NAME "aspeed-host-bmc-dev"
+
+enum aspeed_platform_id {
+	ASPEED,
+};
+
+static int vuart_msi_index[2] = { 16, 17 };
+static int vuart_port_addr[2] = {0x3f8, 0x2f8};
+
+struct aspeed_pci_bmc_dev {
+	struct device *dev;
+	kernel_ulong_t driver_data;
+	int id;
+
+	unsigned long message_bar_base;
+
+	struct uart_8250_port uart[2];
+	int uart_line[2];
+
+	int *msi_idx_table;
+};
+
+static void aspeed_pci_setup_irq_resource(struct pci_dev *pdev)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+
+	pci_bmc_dev->msi_idx_table = vuart_msi_index;
+
+	if (pci_alloc_irq_vectors(pdev, 1, BMC_MULTI_MSI, PCI_IRQ_INTX | PCI_IRQ_MSI) <= 1)
+		/* If pci_alloc fail, set all msi index to the first vector */
+		memset(pci_bmc_dev->msi_idx_table, 0, sizeof(vuart_msi_index));
+}
+
+static int aspeed_pci_bmc_device_setup_vuart(struct pci_dev *pdev, int idx)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct uart_8250_port *uart = &pci_bmc_dev->uart[idx];
+	u16 vuart_ioport;
+	int ret;
+
+	/* Assign the line to non-exist device before everything is setup */
+	pci_bmc_dev->uart_line[idx] = -ENOENT;
+
+	vuart_ioport = vuart_port_addr[idx];
+	/* ASPEED BMC device shift adresses by 2 to the left */
+	vuart_ioport = vuart_ioport << 2;
+
+	uart->port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	uart->port.uartclk = 115200 * 16;
+	uart->port.irq = pci_irq_vector(pdev, pci_bmc_dev->msi_idx_table[idx]);
+	uart->port.dev = dev;
+	uart->port.iotype = UPIO_MEM32;
+	uart->port.iobase = 0;
+	uart->port.mapbase = pci_bmc_dev->message_bar_base + vuart_ioport;
+	uart->port.membase = 0;
+	uart->port.type = PORT_16550A;
+	uart->port.flags |= (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE);
+	uart->port.regshift = 2;
+
+	ret = serial8250_register_8250_port(&pci_bmc_dev->uart[idx]);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "Can't setup PCIe VUART%d\n", idx);
+		return ret;
+	}
+
+	pci_bmc_dev->uart_line[idx] = ret;
+
+	return 0;
+}
+
+static void aspeed_pci_host_bmc_device_release_vuart(struct pci_dev *pdev, int idx)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+
+	if (pci_bmc_dev->uart_line[idx] >= 0)
+		serial8250_unregister_port(pci_bmc_dev->uart_line[idx]);
+}
+
+static int aspeed_pci_host_setup(struct pci_dev *pdev)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+	int rc = 0;
+
+	pci_bmc_dev->message_bar_base = pci_resource_start(pdev, 1);
+
+	if (pdev->revision == 0x27) {
+		pr_err("AST2700 detected but not supported");
+		return -ENODEV;
+	}
+
+	rc = aspeed_pci_bmc_device_setup_vuart(pdev, 0);
+	if (rc)
+		return rc;
+
+	rc = aspeed_pci_bmc_device_setup_vuart(pdev, 1);
+	if (rc)
+		goto out_freeVUART1;
+
+	return 0;
+
+out_freeVUART1:
+	aspeed_pci_host_bmc_device_release_vuart(pdev, 0);
+
+	return rc;
+}
+
+static int aspeed_pci_host_bmc_device_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev;
+	int rc = 0;
+
+	pci_bmc_dev = devm_kzalloc(&pdev->dev, sizeof(*pci_bmc_dev), GFP_KERNEL);
+	if (!pci_bmc_dev)
+		return -ENOMEM;
+
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		dev_err(&pdev->dev, "pci_enable_device() returned error %d\n", rc);
+		return rc;
+	}
+
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, pci_bmc_dev);
+
+	aspeed_pci_setup_irq_resource(pdev);
+
+	/* Setup BMC PCI device */
+	rc = aspeed_pci_host_setup(pdev);
+	if (rc) {
+		dev_err(&pdev->dev, "ASPEED PCIe Host device returned error %d\n", rc);
+		pci_free_irq_vectors(pdev);
+		pci_disable_device(pdev);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void aspeed_pci_host_bmc_device_remove(struct pci_dev *pdev)
+{
+	aspeed_pci_host_bmc_device_release_vuart(pdev, 0);
+	aspeed_pci_host_bmc_device_release_vuart(pdev, 1);
+
+	pci_free_irq_vectors(pdev);
+	pci_disable_device(pdev);
+}
+
+static struct pci_device_id aspeed_host_bmc_dev_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASPEED, PCI_BMC_DEVICE_ID), .class = 0xFF0000, .class_mask = 0xFFFF00,
+	  .driver_data = ASPEED },
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, aspeed_host_bmc_dev_pci_ids);
+
+static struct pci_driver aspeed_host_bmc_dev_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= aspeed_host_bmc_dev_pci_ids,
+	.probe		= aspeed_pci_host_bmc_device_probe,
+	.remove		= aspeed_pci_host_bmc_device_remove,
+};
+
+module_driver(aspeed_host_bmc_dev_driver, pci_register_driver, pci_unregister_driver);
+
+MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
+MODULE_DESCRIPTION("ASPEED Host BMC DEVICE Driver");
+MODULE_LICENSE("GPL");
-- 
2.54.0

