Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7150F14F9EA
	for <linux-serial@vger.kernel.org>; Tue, 30 Jul 2024 05:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316349; cv=none; b=KP6JAtZ67XI1tNLbGA7LgVJJb4s+r5SoB0AiptWcWsVkgIXP9R5IP+RDIvq7GLbSxCeRYqgkX9M0Hn6NBLxY5GHv8LZa3bZKWEamad5Ex/Vm/zkP/zCyuPYgvmcuJqfvZBPRECanSq1bV128NtxH3kzlSAy7bbyjGO8QkaLMfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316349; c=relaxed/simple;
	bh=bme4o/4I0sgLcFj7XGElo3gb53rFuL8XYo4QvTtxmvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3OTqjWk+E2DMzuUzmygF84i1UDHvbxCyR3hPup8Lk0O/tCfvto7RiMEqavjt749+QDpQGtGOUD6zeM4tg2LXIZgKeMYDrCvNY5CQGHLH6Nyom3y2I8lBpzz5B9Lzar6FXtU0TnVvwZuXhcpDnDF79pspIBF0qwuHKWhgG1ye+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OVHIQH/r; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OVHIQH/r"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2cb4b6ecb3dso2563335a91.3
        for <linux-serial@vger.kernel.org>; Mon, 29 Jul 2024 22:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722316346; x=1722921146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TT6aLVW/zdodnhT+XtKZ6i2hFkw9MF/DUQGOLynubkI=;
        b=OVHIQH/rKzwUq7b4vEx/+heu2xuxrHIWvwD7yg400MhvHR0S7UyeRd/rt9OZMgho+f
         Zkz/53RsAX1UbEOsS5Jo3i9SIWy0TI5tp7imHyiqkp8/VYteOPpZe8xqBOqZu93ZZQ9J
         IZMQc6hKZ6RAvYqNeNR2aHe5FQwBqori+MhAQQpu244xQVcNJrY04ozkfzIXqwE6d0H/
         ICRtfVBOibjAlYg9qPxpTs5nabYavatyQSG6rGqpZD8QE3OABDFpO5p6alhVF7rq1Plz
         xK9fRSWQ0dnwCwnWeYnq9fPVrbNgJ7GdYuRWHCJXAMOXu2PmsJEDlMbC9+J8uKCdwDwi
         ngmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722316346; x=1722921146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT6aLVW/zdodnhT+XtKZ6i2hFkw9MF/DUQGOLynubkI=;
        b=NDM3Gxqm+GvKOm7VchXmjt7UWIW5nWpL2o458ld5r6KVtlQZ3tmfs5lSlO7eP41y6m
         zaWEG9zIKj++zEyLxyyAe0ewYb7vUQZsJ4fvJM8rwOzG+liPbsCGR4yVwLADx6PwRDbr
         x7jEVIY5+NabCoJlJauwIoBdjnEN9Vv563dTkN6YTfgqkCIMamZGNbtbipYtyEgCUBNh
         IiN3+zqbLUB3cpuOngjkPJSAIB/umC4ufUGWTA01hshDQ3ndWO0gGjf7CbmnkeX+Aq0R
         MNOR0fDBIN5oB399WpcAn5dUDmtqtmP93uUCPGQF0Nc1hONJ7JiueOVS+t7HsChRdaMR
         8YZA==
X-Forwarded-Encrypted: i=1; AJvYcCUQVxFsX2QZkDZsAUcWSq8Goav7x2Ihh1U0hCdnRH/UQuMHO2bVkVQWPxA8yKnO04zxYKgfv0ZzCO0VIUESfsQf3im3om9uDQA8IPDg
X-Gm-Message-State: AOJu0YyGziH9fJrRgXru3fMNnlu6kpRagfmVrigxhhUBkQjlBeugOngi
	O1M/DSsHiRnYBJ12Xr3hPqQKF8RBmuv41YU+abONjcj5h2/ypjZ7XRs7yojHBFU=
X-Google-Smtp-Source: AGHT+IFMHivNH4RMDotuWrEigk/566gljKmvKgYSaYrdZAxDrTLZ78PUztPHx2BFQsrKbEtPpLVQaw==
X-Received: by 2002:a17:90a:1787:b0:2c9:75c6:32dc with SMTP id 98e67ed59e1d1-2cf7e09a8b8mr8383256a91.1.1722316345586;
        Mon, 29 Jul 2024 22:12:25 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb74e8957sm11497728a91.39.2024.07.29.22.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 22:12:25 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH] serial: 8250_platform: Enable generic 16550A platform devices
Date: Tue, 30 Jul 2024 10:42:18 +0530
Message-ID: <20240730051218.767580-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, 8250_platform driver is used only for devices with fixed
serial ports (plat_serial8250_port). Extend this driver for any generic
16550A platform devices which can be probed using standard hardware
discovery mechanisms like ACPI.

This is required in particular for RISC-V which has non-PNP generic
16550A compatible UART that needs to be enumerated as ACPI platform
device.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/tty/serial/8250/8250_platform.c | 77 +++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index d5c8d851348d..bdfb16bed4f2 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -6,7 +6,9 @@
  *	      PNP 8250/16550 ports
  *	      "serial8250" platform devices
  */
+#include <linux/acpi.h>
 #include <linux/array_size.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/once.h>
@@ -100,6 +102,65 @@ void __init serial8250_isa_init_ports(void)
 	DO_ONCE(__serial8250_isa_init_ports);
 }
 
+/*
+ * Generic 16550A platform devices
+ */
+static int serial8250_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uart_8250_port uart = { 0 };
+	struct resource *regs;
+	unsigned char iotype;
+	int ret, line;
+
+	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (regs) {
+		uart.port.iobase = regs->start;
+		iotype = UPIO_PORT;
+	} else {
+		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!regs) {
+			dev_err(dev, "no registers defined\n");
+			return -EINVAL;
+		}
+
+		uart.port.mapbase = regs->start;
+		uart.port.mapsize = resource_size(regs);
+		uart.port.flags = UPF_IOREMAP;
+		iotype = UPIO_MEM;
+	}
+
+	/* Default clock frequency*/
+	uart.port.uartclk = 1843200;
+	uart.port.type = PORT_16550A;
+	uart.port.dev = &pdev->dev;
+	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
+	ret = uart_read_and_validate_port_properties(&uart.port);
+	/* no interrupt -> fall back to polling */
+	if (ret == -ENXIO)
+		ret = 0;
+	if (ret)
+		return ret;
+
+	if (uart.port.mapbase) {
+		uart.port.membase = devm_ioremap(dev, uart.port.mapbase, uart.port.mapsize);
+		if (!uart.port.membase)
+			return -ENOMEM;
+	}
+
+	/*
+	 * The previous call may not set iotype correctly when reg-io-width
+	 * property is absent and it doesn't support IO port resource.
+	 */
+	uart.port.iotype = iotype;
+
+	line = serial8250_register_8250_port(&uart);
+	if (line < 0)
+		return -ENODEV;
+
+	return 0;
+}
+
 /*
  * Register a set of serial devices attached to a platform device.  The
  * list is terminated with a zero flags entry, which means we expect
@@ -110,6 +171,15 @@ static int serial8250_probe(struct platform_device *dev)
 	struct plat_serial8250_port *p = dev_get_platdata(&dev->dev);
 	struct uart_8250_port uart;
 	int ret, i, irqflag = 0;
+	struct fwnode_handle *fwnode = dev_fwnode(&dev->dev);
+
+	/*
+	 * Probe platform UART devices defined using standard hardware
+	 * discovery mechanism like ACPI or DT. Support only ACPI based
+	 * serial device for now.
+	 */
+	if (!p && is_acpi_node(fwnode))
+		return serial8250_platform_probe(dev);
 
 	memset(&uart, 0, sizeof(uart));
 
@@ -198,6 +268,12 @@ static int serial8250_resume(struct platform_device *dev)
 	return 0;
 }
 
+static const struct acpi_device_id acpi_platform_serial_table[] = {
+	{ "RSCV0003", 0 }, // RISC-V Generic 16550A UART
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, acpi_platform_serial_table);
+
 static struct platform_driver serial8250_isa_driver = {
 	.probe		= serial8250_probe,
 	.remove_new	= serial8250_remove,
@@ -205,6 +281,7 @@ static struct platform_driver serial8250_isa_driver = {
 	.resume		= serial8250_resume,
 	.driver		= {
 		.name	= "serial8250",
+		.acpi_match_table = ACPI_PTR(acpi_platform_serial_table),
 	},
 };
 
-- 
2.43.0

