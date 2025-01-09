Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C5216E12
	for <linux-serial@vger.kernel.org>; Thu,  9 Jan 2025 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424570; cv=none; b=WbrTIwfQ/ZVZxo56F+FSazOdPBBzg0j2f3uahOqgeKZQ0fU2ikMZvk+jFtEk+XEMn9syT6VXPeamsfJY7kxOuOH5RS+l+VP+hrxkbnbYifNqS0A1LvjGjQS8dQwlAmTrHzWB7aQT1HqA722d+OP9GMKY7DCnqBHY73QNM0SgLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424570; c=relaxed/simple;
	bh=HE8nbJi1Xb1DwgNSlZYpK6LkiOkTqwFG93+xUjEaw2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ATKetpIzo7Sb96UuTWznx2T6qRlhkdU+bhxHb8lJDXkj2A3NAgnRWu34JJ5bEqxAj+TOCz5l89WbdoxwKIG76USLW8cTgOB7i4OZknHzRuaZCS/DaaLWjqJbim4mWXANACzg8LFaKcRAPJ8BcrBCEw6wgjHbuTJad5ceAOCawAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=dGkrr6mn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="dGkrr6mn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1736424547;
	bh=nmOvcYAk4I1cIEb8TdiQgvFwANxHx6ROhpH2hY99X64=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=dGkrr6mnURb0CzciAWLMLFTOknUt44RD9NfUnBwgwwaUl92RUobjgPVKkQNaPz6md
	 L0R48tZZXqsRZjWDf90D5RjHvS5ayrrFIftyiGjubgz/Hu2aj9Vgq+FS8RC2FkVg2A
	 9jL+CX8xYU/2AdXh0uCO3yW59UPx1cjNSzolQYIQ=
X-QQ-mid: bizesmtpip4t1736424503trxb7a4
X-QQ-Originating-IP: LcxtlZi0S+tRh7YKwOEYnjcHWPvnp7CshAHgjbE3tF0=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 09 Jan 2025 20:08:20 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9136327612947122579
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	wangyuli@uniontech.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	andriy.shevchenko@linux.intel.com,
	arnd@kernel.org,
	schnelle@linux.ibm.com,
	pnewman@connecttech.com,
	sunilvl@ventanamicro.com,
	paulmck@kernel.org,
	arnd@arndb.de,
	zhanjun@uniontech.com,
	guanwentao@uniontech.com,
	Zhuozhen He <hezhuozhen@uniontech.com>,
	Guowei Chen <chenguowei@uniontech.com>
Subject: [PATCH] serial: 8250_it8768e: Create iTE IT8768E specific 8250 driver
Date: Thu,  9 Jan 2025 20:08:08 +0800
Message-ID: <41B1320691916DE6+20250109120808.559950-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MfQnJH+7WKv6UHYLDscBQ5DJy+xOdpl6Jp5qgZ3sDiVCsphrxIpiLlZz
	iUJxwoZAgoNddXT0TFPRIuHA5FaFLS5JAD2ntpGgYponXMokLrIgl4RltcPRNFV3VPYqOUf
	jqQ/W2cVwTM1/7Iu4eUCGDoAnqLaJhRlyHf+38DbeThB5khf4qQLeeIKrjFqcFyVX2UQUdr
	ovIyp1TerVx46++58K0cwrBAPwjJBEMBoC9FqVMPnmwhBJKxps4+c/xQGqh7u9JIvsVqkj1
	30QVoVtF0lGvDbl5hYBwh/7e2l1tzekutIk6F+pABNcUS3VxK1J2j+kVWrXaH/C00gSPOwl
	WS04OWE18ocSZJqp1HP02ZBQptQrBBt46xMUmKxjqdksBdbARDT13Jt5hgqBRUn7BzMh3q5
	z0b+aoEt6fsIJZMHtFO5gP3asEsI21Jb9ZK28dSVjczDgeqnPWfmYTvtpTaOhKvXjs/GERu
	+RQNidXass0BsomYwMwFo+mvIEBdQcbkme0A5DliLYndvRpa9kQsBiS0OEasZjfTOk/smld
	qoEIwC6SvfyXcZ5hYp2084GI7C9phSNjrZbGl9ybtQEaHf5TFvwn9pwlKAfDUYCKqeNkkgT
	x3/cdFhZQZZMMnU2Gt1R1K5BiHWvQodsKs+vWu6hPtIFMj7fUb/S98sQ3N3i6xxthk27UVf
	tI0Swv/aeo5AR8AP85Mr9fWR64UkqYSo44/OMbX64kjRUa1yXxdbkqj0tujEOO+ffNGtfdZ
	CbInx8mD58lt3V42oaTxF/VU2oRVCffuxHA7UCmAMDYV8O5WFGgr2PJmdycpWkK5EkF7Mkw
	gHp9C05QQWcOw9kG5PdegJ8aL8XXdoU+1WgfWPL7LANdZECsiOIy/LaPfWrN0PsIR2Ay7tB
	gUGY6GFyDbwC0DwRhGBU7YPIBDssDntoQfhp2jo7WPbIGt4qX3n5xMYrFuaNrQqEMMQ+Gsa
	g+f1IDEi2WfbjvpJYDv8jYc+Lrt04vEK4VF/b2O5vQo8gehglvxNLL6g5sA03ZLUmmWbuOv
	a+Y5eLYdfyvYeOmO9ElMH/B8Y1vdHNNX5BiyEm7w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

[ General description per its product manual: ]
  The IT8768E-I is a highly integrated Super I/O using the Low Pin
  Count Interface. The device’s LPC interface complies with Intel
  "LPC Interface Specification Rev. 1.1”. The IT8768E-I is ACPI &
  LANDesk compliant.

  Integrated in the IT8768E-I are five logical devices, which can
  be individually enabled or disabled via software configuration
  registers, and four 16C550standard compatible enhanced UARTs
  perofrmacing asynchronous communication. The devices also provide
  GPIO port controlling up to 12 GPIO pins.

  The IT8768E-I utilizes power-saving circuitry to reduce power
  consumption, and once a logical device is disabled, the inputs
  are inhibited with the clock disabled and the outputs are
  tri-stated. The device requires a single 24/48 MHz clock input
  and operates with +3.3V power supply. The IT8768E-I is available
  in 48-pin LQFP.

It has been determined that this chip is currently employed within
YIHUA STS-320 intelligent teller terminals utilizing
PCBA F21-2401 D2000 MB VerA LF motherboards.

Add a driver to support it.

[ Kernel logs without this driver: ]
  [    1.016170] EFI Variables Facility v0.08 2004-May-17
  [    1.034039] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
  [    1.035215] serial 0000:06:00.0: enabling device (0000 -> 0002)
  [    1.035649] 0000:06:00.0: ttyS0 at MMIO 0x64100000 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.035812] 0000:06:00.0: ttyS1 at MMIO 0x64100400 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.035966] 0000:06:00.0: ttyS2 at MMIO 0x64100800 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.036119] 0000:06:00.0: ttyS3 at MMIO 0x64100c00 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.036271] 0000:06:00.0: ttyS4 at MMIO 0x64101000 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.036425] 0000:06:00.0: ttyS5 at MMIO 0x64101400 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.036576] 0000:06:00.0: ttyS6 at MMIO 0x64101800 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.036727] 0000:06:00.0: ttyS7 at MMIO 0x64101c00 (irq = 31, base_baud = 7812500) is a XR17V35X

[ Kernel logs with this driver: ]
  [    1.017777] EFI Variables Facility v0.08 2004-May-17
  [    1.036036] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
  [    1.037286] ITES0001:00: ttyS0 at MMIO 0x20000130 (irq = 0, base_baud = 115200) is a 16550A
  [    1.037444] ITES0001:01: ttyS1 at MMIO 0x20000138 (irq = 0, base_baud = 115200) is a 16550A
  [    1.037607] ITES0001:02: ttyS2 at MMIO 0x20000140 (irq = 0, base_baud = 115200) is a 16550A
  [    1.037759] ITES0001:03: ttyS3 at MMIO 0x20000148 (irq = 0, base_baud = 115200) is a 16550A
  [    1.037906] ITES0001:04: ttyS4 at MMIO 0x20000150 (irq = 0, base_baud = 115200) is a 16550A
  [    1.038056] serial 0000:06:00.0: enabling device (0000 -> 0002)
  [    1.038438] 0000:06:00.0: ttyS5 at MMIO 0x64100000 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.038595] 0000:06:00.0: ttyS6 at MMIO 0x64100400 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.038749] 0000:06:00.0: ttyS7 at MMIO 0x64100800 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.038907] 0000:06:00.0: ttyS8 at MMIO 0x64100c00 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.039059] 0000:06:00.0: ttyS9 at MMIO 0x64101000 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.039214] 0000:06:00.0: ttyS10 at MMIO 0x64101400 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.039367] 0000:06:00.0: ttyS11 at MMIO 0x64101800 (irq = 31, base_baud = 7812500) is a XR17V35X
  [    1.039519] 0000:06:00.0: ttyS12 at MMIO 0x64101c00 (irq = 31, base_baud = 7812500) is a XR17V35X

Reported-by: Zhuozhen He <hezhuozhen@uniontech.com>
Tested-by: Guowei Chen <chenguowei@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/tty/serial/8250/8250_it8768e.c | 138 +++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig        |   6 ++
 drivers/tty/serial/8250/Makefile       |   1 +
 3 files changed, 145 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_it8768e.c

diff --git a/drivers/tty/serial/8250/8250_it8768e.c b/drivers/tty/serial/8250/8250_it8768e.c
new file mode 100644
index 000000000000..c2c0aeed3918
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_it8768e.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Probe for 8250/16550-type iTE IT8768E serial ports.
+ *
+ * Based on drivers/char/serial.c which is in the history, by Linus Torvalds, Theodore Ts'o.
+ *
+ * Copyright (C) 2025 Uniontech Ltd.
+ * Author: WangYuli <wangyuli@uniontech.com>
+ */
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pnp.h>
+#include <linux/serial_core.h>
+#include <linux/string.h>
+
+#include <asm/byteorder.h>
+
+#include "8250.h"
+
+struct it8768e_data {
+	struct uart_8250_port uart;
+	int line;
+};
+
+static int it8768e_probe(struct platform_device *pdev)
+{
+	struct it8768e_data *data;
+	struct resource *res;
+	void *__iomem sio_base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "memory resource not found\n");
+		return -EINVAL;
+	}
+
+	sio_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!sio_base) {
+		dev_err(&pdev->dev, "devm_ioremap error\n");
+		return -ENOMEM;
+	}
+
+	data = devm_kcalloc(&pdev->dev, 1,
+			sizeof(struct it8768e_data),
+			GFP_KERNEL);
+	if (!data) {
+		dev_err(&pdev->dev, "Failed to alloc private mem struct.\n");
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&data->uart.port.lock);
+	data->uart.port.dev = &pdev->dev;
+	data->uart.port.regshift = 0;
+	data->uart.port.iotype = UPIO_MEM;
+	data->uart.port.type = PORT_16550A;
+	data->uart.port.membase = sio_base;
+	data->uart.port.mapbase = res->start;
+	data->uart.port.uartclk = 1843200;
+	data->uart.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SKIP_TEST;
+
+	data->line = serial8250_register_8250_port(&data->uart);
+	if (data->line < 0) {
+		dev_err(&pdev->dev,
+			"unable to resigter 8250 port (MEM%llx): %d\n",
+			(unsigned long long)res->start, 0);
+		return data->line;
+	}
+
+	dev_set_drvdata(&pdev->dev, data);
+	return 0;
+}
+
+static void it8768e_remove(struct platform_device *pdev)
+{
+	struct it8768e_data *data = dev_get_drvdata(&pdev->dev);
+
+	if (!data)
+		return;
+
+	del_timer(&data->uart.timer);
+	serial8250_unregister_port(data->line);
+}
+
+#ifdef CONFIG_PM
+static int it8768e_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct it8768e_data *data = dev_get_drvdata(&pdev->dev);
+
+	if (!data)
+		return -ENODEV;
+
+	serial8250_suspend_port(data->line);
+	return 0;
+}
+
+static int it8768e_resume(struct platform_device *pdev)
+{
+	struct it8768e_data *data = dev_get_drvdata(&pdev->dev);
+
+	if (!data)
+		return -ENODEV;
+
+	serial8250_resume_port(data->line);
+
+	return 0;
+}
+#else
+#define it8768e_suspend NULL
+#define it8768e_resume NULL
+#endif /* PM */
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id it8768e_acpi_ids[] = {
+	{ .id = "ITES0001" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, it8768e_acpi_ids);
+#else
+#define it8768e_acpi_ids NULL
+#endif /* ACPI */
+
+static struct platform_driver it8768e_driver = {
+	.probe	= it8768e_probe,
+	.remove = it8768e_remove,
+	.suspend = it8768e_suspend,
+	.resume	 = it8768e_resume,
+	.driver = {
+		.name = "it8768e",
+		.acpi_match_table = it8768e_acpi_ids,
+	},
+};
+module_platform_driver(it8768e_driver);
+
+MODULE_AUTHOR("WangYuli");
+MODULE_DESCRIPTION("8250 uart driver for iTE IT8768E");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 55d26d16df9b..72e7f33d61d6 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -569,6 +569,12 @@ config SERIAL_8250_BCM7271
 	  including DMA support and high accuracy BAUD rates, say
 	  Y to this option. If unsure, say N.
 
+config SERIAL_8250_IT8768E
+	tristate "8250 support for iTE IT8768E uart"
+	depends on SERIAL_8250
+	help
+	  This option is used for iTE IT8768E serial ports.
+
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 1516de629b61..97bbf05a49bd 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_SERIAL_8250_HP300)		+= 8250_hp300.o
 obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_IOC3)		+= 8250_ioc3.o
+obj-$(CONFIG_SERIAL_8250_IT8768E)	+= 8250_it8768e.o
 obj-$(CONFIG_SERIAL_8250_LPC18XX)	+= 8250_lpc18xx.o
 obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
-- 
2.47.1

