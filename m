Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3341CB3D
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525124; cv=none; b=VkJFobuQHNkmhkekAQpI1lhg3UXMx/6UYSRyzCqg966nyht1VPiIVHpPKiBx3V1mnmIW05KYLovyOt/WJc2Eil1BUPnzEmYcQZSkxITd+ghbo/iPTQA0Eg6MN41zRq0mRfWBt/eP70YIuhVrFQAXmYM0UOTqSESL5YXfLXMdNyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525124; c=relaxed/simple;
	bh=Cuf6+ZFpQj9as82hqAYL+jDoHowhB1w1fudH1PX2eog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neLuH8zFjxWngHR0oiMhK8TbcdkT2FJDbkraU6s6f7Zelg08V1VK4LUdjSCGUHzG2fieaQ6CsJsdyKE9TMkFxLpXks6/yl7Geb+lkEKPNluwh4hFlQbG8lpCzjI2NSzoL6Y9SOiYYnjjJTCaLX2c+0yjBy+tOlrpDa1FqN1N0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=LB8LH953; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="LB8LH953"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so1416005e9.0
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525121; x=1784129921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f1Rm+ycDLzcJTW5brmAbfPnl/20w3yUac+m/GbIIsJs=;
        b=LB8LH953g6QNFsMNzHBHh2rZHbMGPJOZZogRPhXpQuARsnU66JCl8DZ7lSyW7xHJaH
         BlZ7TAznJABPdMUXiQtn5MskJsLWJBzFkl44uezqwGDuqxTxiQvECnsVUxqqhzKg+O93
         yELc5OJ1SIOrdCNLN5nbodnLxl65K9jzZtltnXYbBuJvvdL2d9gzyvZygFpawpijlkrD
         qtE8llpJbn7SFEr11jzHYGi+Ubi0nI3n8vvu0oI0lPdd76jhG82H50C0i4uuSe2M1nM+
         b3k8/cYWBJKWQTpb+9Zysk/TmAjlhMpzRwByZSIuV8rN2qt+HXWWv1TCFoHJVBDcLn5D
         L2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525121; x=1784129921;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f1Rm+ycDLzcJTW5brmAbfPnl/20w3yUac+m/GbIIsJs=;
        b=OWMKhv9QwtOYmakzp0xThcUibgxxhix4GkHvFVF8s8cLZdocN518DQEWZNwbaLMuxQ
         XpdheL95Dx0UCo6U5we4wOYLCJ/GQlCc4ejRbSvuImW4ejM+cgtDo2xBBp3vWiEpHvwr
         TqzEzuAXJRZez9TNwGzspKpVywZPzpopzTfyiaZhK6yynpinm5u6MgRPq5wcfb3BwiAV
         KBYdNHx1mHRUSbRzeJgbh2Nv4wpeMyh1CFDsPi83b3IKBXJ8g2/EuPah6wAEAy0/KFE8
         PLeGWSud0BQQsRrO9yEISWkffLTf/9GqqVgUSFpVIsMjUxnjKJQzzqExSE7qoUzON7kc
         lniA==
X-Forwarded-Encrypted: i=1; AHgh+RoDsTVSxNXh76UgooO1t+4FugFX9D8tCI/QyES/n+QSM/9yzuZOru//hwaigl2jLw27d8DT5D8hRvpqNN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU1XYQDAV6ajfBsaqjUDgDGsf2QMk75jCve/4/19ffdvR2ZyIM
	mf9tRZNeOGB3aDymjqFl5cOViA+v4An3oZwTzaXbD+SK3GIbstiJiMo//TE4TrGBGFA=
X-Gm-Gg: AfdE7cndJrRcib7zBIe896RnNY8/WvxCRAG4WQSTyRLrkBNroyGJUFYe9rcqeiQHIP7
	swIh6GgVuXOx0qD5NRYCZSjcV0MU+F/ZoCf34/sKoe/IZAX4eqICbMRh4/zeip8fTuKuBpWqSHE
	yuciAEu/WUu2VswPMqzHO7dpxRjb4k8sgQjX9ClE92732z9WyIirzSLwRZ4ArQ6iNSZMmJBb3Dr
	ZZv6bMrHduGyoIXBSheKdIVQv7CpIGoGIRK8FSaInNtrlfSuv7G4rVXCds2awiU475UfltVTSLn
	ssEPLBXcBkhqtUc85KDLKhCiePO7+O0HVbtlZubspHhrI50SSwOKpNJHvL5xOJ9dCQHjjb9WtjE
	M3W+dItCkCWYjjBzQONqrCDm8yhMiMeuatEjhr9xF3CgbedtAfEB98JgFraQDh8ykuXjHSeiajA
	pV/vUN4vzZEsTrCjqpfqFvJjG8/iaahDzhtmUgYsPfokBCUwyHZkWH3erDLFHUvydgsu0ycY/SN
	lDukHgUD3vRNKdFDgfmV1aDA0Nx
X-Received: by 2002:a05:600c:8b72:b0:493:c634:952 with SMTP id 5b1f17b1804b1-493e69b0dc8mr29860325e9.7.1783525121089;
        Wed, 08 Jul 2026 08:38:41 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:40 -0700 (PDT)
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
Subject: [PATCH v4 5/7] soc: aspeed: add host-side PCIe BMC device driver
Date: Wed,  8 Jul 2026 15:35:57 +0000
Message-ID: <51e455417bdcfe608270c6cb2806b1fd971fb998.1783524645.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for VUART over PCIe between BMC and host.
Add the host side driver.
Support only the AST2600.

Taken from ASPEED 6.18 Kernel SDK and trimmed down.

The host can't detect the VUART addresses, so force them to
0x3f8 and 0x2f8, as in the initial ASPEED driver.

Change the MSI vector index of VUART2 from 15 to 17.
The index 15 used in the initial driver was not working.

Data path in both direction is tested on both VUART.

This module is added in soc/aspeed as it's very soc specific.
This is not added as a PCI 8250 UART device as this host module can
be expanded upon for IPMI over KCS. It can also be used in the
future for custom BMC<->host communication with shared memory and doorbell.

This host module should be the entry point for setting up all features
related to an AST2600 present on the PCI bus.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/soc/aspeed/Kconfig               |  15 ++
 drivers/soc/aspeed/Makefile              |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 174 +++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index f579ee0b5afa..147a9033bdc4 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -55,3 +55,18 @@ config ASPEED_SOCINFO
 endmenu
 
 endif
+
+menu "ASPEED host-side drivers"
+	depends on PCI
+
+config ASPEED_HOST_BMC_DEV
+	tristate "ASPEED host-side BMC PCIe device"
+	depends on SERIAL_8250
+	help
+	  Host-side driver for the ASPEED AST2600 BMC PCIe device found on
+	  BMC expansion cards. Exposes two 8250-compatible VUART
+	  ports.
+
+	  If unsure, say N. Choose M to build aspeed-host-bmc-dev.
+
+endmenu
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
index 000000000000..e586d0505577
--- /dev/null
+++ b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (C) ASPEED Technology Inc.
+
+#include <linux/init.h>
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
+static const int vuart_msi_index[2] = { 16, 17 };
+static const int vuart_port_addr[2] = {0x3f8, 0x2f8};
+
+struct aspeed_pci_bmc_dev {
+	unsigned long message_bar_base;
+
+	struct uart_8250_port uart[2];
+	int uart_line[2];
+};
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
+	/* ASPEED BMC device shift addresses by 2 to the left */
+	vuart_ioport = vuart_ioport << 2;
+
+	uart->port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	uart->port.uartclk = 115200 * 16;
+	uart->port.irq = pci_irq_vector(pdev, vuart_msi_index[idx]);
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
+		goto out_free_VUART0;
+
+	return 0;
+
+out_free_VUART0:
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
+	rc = pci_alloc_irq_vectors(pdev, BMC_MULTI_MSI, BMC_MULTI_MSI, PCI_IRQ_INTX | PCI_IRQ_MSI);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "aspeed_pci_setup_irq_resource() returned error %d\n", rc);
+		goto disable_device;
+	}
+
+	/* Setup BMC PCI device */
+	rc = aspeed_pci_host_setup(pdev);
+	if (rc) {
+		dev_err(&pdev->dev, "ASPEED PCIe Host device returned error %d\n", rc);
+		goto free_irq;
+	}
+
+	return 0;
+
+free_irq:
+	pci_free_irq_vectors(pdev);
+disable_device:
+	pci_disable_device(pdev);
+	return rc;
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
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASPEED, PCI_BMC_DEVICE_ID),
+		.class = 0xFF0000, .class_mask = 0xFFFF00,
+		.driver_data = ASPEED },
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

