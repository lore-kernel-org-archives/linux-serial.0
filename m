Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5933B27C2
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624876; cv=none; b=GEwXWl4svNnBfHRhOB+wR09H307pdMKh6LfWRI0OHEc//zqsK9vOybwBUF4oWzxYZi1yoci7l2wgnDpxv6au+xttj3Q7UBH3loCmqOQpoEFlZKukk+OS5Lz0P5SsN1nExQ56Mz/fgna04+CCbI7en2uI3qfFq8QYlEP8/1YhJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624876; c=relaxed/simple;
	bh=7xErKyCd1leX9QcWY3ikH8rk4yU+ISbdLrB49x+KnM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rBeRCjR9lb6LQOWyOLXCmfy+mJgxz8n8RhXQi8c39UEDZgyw24H7aIToA1jzKqcy2SPKOlYNTLa8y5EUO8ziolkDB172lh6ltloYYTiv8i0yaeGB6Ezg00L3e+044PQHJaAzl5aVpoibIhkSfDyNrs0uzGCAvE6Q13NTHpQ0+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPDlTcep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPDlTcep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E4B1F000E9;
	Thu,  9 Jul 2026 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783624872;
	bh=wibVNwrRnS8Zz1lsaJAV1HQS6NAwo+TCtkPDE8PwZDQ=;
	h=From:Date:Subject:To:Cc;
	b=ZPDlTcepH96p0h26o/R7lXS214GYGY6t36bKZZYMoq1kO7FrS2aTx664Qn1HwpRLg
	 FIIDHyBE701WEhHLdCBfM5Nt1unGQx6Lde0xM/f18WDQVfubL/cYZ0AOAksGbsqrSr
	 GT3Lw5kOsFUJILD1fHdihfKeEKH8ZsOFucKSdQY3e8pdYRgOXBkv0rBXqWC2sTZH+w
	 22rJ56YlO1LX14QG2FKFA4A/+RsGDTprwlNYtDwP0dEvL0KFrbq/75NulqXGgNdEBK
	 GeGNV/2bmqdiYbGPRGpdvytpQp8jluK6N7u/Xdz9N0RwgQes1VjXfk0WFy+g6806/q
	 opqMB9I7AXs4w==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 09 Jul 2026 21:21:08 +0200
Subject: [PATCH v2] serial: 8250: handle ixp4xx register endianness
 correctly
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ixp4xx-serial-hackfix-v2-1-465fc8e4c54c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBCFr0Jm7Zi2+FdX3sOwqNMRKgRIi6SGc
 HdbPIDL7+V97y0Q2DsOcC0W8Dy74IY+gdoVQI3pa0ZnE4MS6iTOQqOL4yFGzJrpsDHUPl1EOpL
 VwhIZXUJyR88p3nbv1Y/D+/FimvJYbjQuTIP/bMezzL1/H7NEiWQlKW2Fkpfy1rLvudsPvoZqX
 dcvHBh9js0AAAA=
X-Change-ID: 20260709-ixp4xx-serial-hackfix-c5cd90dcca93
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

From: Arnd Bergmann <arnd@arndb.de>

Unlike modern SoCs that just work in both big-endian and little-endian
mode using the readl()/writel() or readb()/writeb() accessors, the
internal registers on ixp4xx behave like native-endian 32-bit registers
in both modes, which requires adjusting the register address
when using 8-bit access.

The existing dts files are written for big-endian kernels and 8-bit
access, which does not work with little-endian kernels.

Add a quirk that makes the 8250 OF driver:

1. Mask off any hardcoded offset.
2. Add the += 3 offset if and only if we are running on big endian.

This should work in all combinations of big-endian and little-endian
kernels with either variant of the DTS file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[linusw@kernel.org: Modified to just play with the offset]
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- Use PTR_ALIGN_DOWN(*,4) instead of the custom &= 3, which also
  works with a pointer which is an unsigned char *
- Fix to the earlycon code to do the same thing as the main
  serial port.
- Link to v1: https://patch.msgid.link/20260709-ixp4xx-serial-hackfix-v1-1-cd1c29d02183@kernel.org
---
 drivers/tty/serial/8250/8250_early.c | 19 ++++++++++++++++++-
 drivers/tty/serial/8250/8250_of.c    | 12 ++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index dc0371857ecb..44ec209f37c4 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -23,6 +23,7 @@
  *	console=uart8250,mmio32,0xff5e0000,115200n8
  */
 
+#include <linux/align.h>
 #include <linux/tty.h>
 #include <linux/init.h>
 #include <linux/console.h>
@@ -177,6 +178,23 @@ OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
 OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);
 OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);
 
+static int __init early_serial8250_xscale_setup(struct earlycon_device *device,
+					     const char *options)
+{
+	/*
+	 * Adjust for BE32 register accesses: drop any hardcoded
+	 * address for the big endian byte target, add it explicitly
+	 * if running on BE32.
+	 */
+	device->port.membase = PTR_ALIGN_DOWN(device->port.membase, 4);
+	if (IS_ENABLED(CONFIG_CPU_ENDIAN_BE32))
+		device->port.membase += 3;
+	device->port.regshift = 2;
+
+	return early_serial8250_setup(device, options);
+}
+OF_EARLYCON_DECLARE(uart, "intel,xscale-uart", early_serial8250_xscale_setup);
+
 static int __init early_serial8250_rs2_setup(struct earlycon_device *device,
 					     const char *options)
 {
@@ -184,7 +202,6 @@ static int __init early_serial8250_rs2_setup(struct earlycon_device *device,
 
 	return early_serial8250_setup(device, options);
 }
-OF_EARLYCON_DECLARE(uart, "intel,xscale-uart", early_serial8250_rs2_setup);
 OF_EARLYCON_DECLARE(uart, "mrvl,mmp-uart", early_serial8250_rs2_setup);
 OF_EARLYCON_DECLARE(uart, "mrvl,pxa-uart", early_serial8250_rs2_setup);
 
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 81644d40b09a..f0537fb6ef4f 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -5,6 +5,7 @@
  *    Copyright (C) 2006 Arnd Bergmann <arnd@arndb.de>, IBM Corp.
  */
 
+#include <linux/align.h>
 #include <linux/bits.h>
 #include <linux/console.h>
 #include <linux/math.h>
@@ -122,6 +123,17 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (ret)
 		goto err_pmruntime;
 
+	if (IS_ENABLED(CONFIG_CPU_XSCALE) && type == PORT_XSCALE) {
+		/*
+		 * Adjust for BE32 register accesses: drop any hardcoded
+		 * address for the big endian byte target, add it explicitly
+		 * if running on BE32.
+		 */
+		port->mapbase = PTR_ALIGN_DOWN(port->mapbase, 4);
+		if (IS_ENABLED(CONFIG_CPU_ENDIAN_BE32))
+			port->mapbase += 3;
+	}
+
 	/* Get clk rate through clk driver if present */
 	if (!port->uartclk) {
 		struct clk *bus_clk;

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260709-ixp4xx-serial-hackfix-c5cd90dcca93

Best regards,
--  
Linus Walleij <linusw@kernel.org>

