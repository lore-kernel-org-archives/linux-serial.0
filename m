Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE51186298;
	Mon, 12 Aug 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477749; cv=none; b=LA/XnK5dy83pCSTEQ0+cX6heBNAcVseDqVwdro6HoQ/0DWD3vVnoXkQEqB/MJ/xYR/Hk2tYelKNVLiqjZfRlm9Or4bPoCQoY/mNiMO1WGNCdFcdMJ1JFybz0ZV03p5OjDV14/WCPZHnUNyS57/P7mGXwUsmLpSCe1NSaSmfkSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477749; c=relaxed/simple;
	bh=nTJueB6tgQfuqsoeCX67y92PwedAzw7ogpVO79oK5Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4FoXfh4fXS6rqyBSqq9eyZt5VbFizBCT8b2k+/JsTY8mJb9NFRPgBuINqZrswNjNCMfqQNL7e9drCN1PA22h3otI4m+aVvE/eYSIFYiqwOE7hAtFjNsHvHu7/ae/Wen9QlIfS0hyGVBCuoF9EZxB/WH945zexCQvi2A88IbdYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LuGryWLQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LuGryWLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723477748; x=1755013748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nTJueB6tgQfuqsoeCX67y92PwedAzw7ogpVO79oK5Kc=;
  b=LuGryWLQ1uncwVDd45NBBKbvft85zNVUArrpR6h+MoGF1Pphex2hUXk4
   36/rBB7pZWDX+cZQ26i7sFtERfTn2wyA+fJ8AZIItB0F8z0BRRrad43In
   d1PFOvPc8O5XFG5O8tvJkuFN7LuTy+EtOErQnooA03Nt3SM25bZv0Yc1+
   8O79h+zPHuX/QcRB/K5wjA3uUrz//cgylrV6WqW7AlAdgfExwmt3Y3rXL
   NZivxA0Uj3tmmS0jcMDulvAq/ShkYWlCqHG7aaJc4DaHZkG/vIggHfC0X
   mnZHUOlIIGz+tFoFmV9Jjuk0c3lrmGTvpyhSj151AQJf4b/jFDFzIzHBB
   g==;
X-CSE-ConnectionGUID: /nsK80HeQemny4YLCGIaHA==
X-CSE-MsgGUID: YrVRa3D9SYOUSXmbVmVVdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21160808"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21160808"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:49:08 -0700
X-CSE-ConnectionGUID: bR+hjvaFQeiXfZ9FXCVycA==
X-CSE-MsgGUID: bPeC7LZGTNukLtjl9AZbIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58187005"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 12 Aug 2024 08:49:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1064B858; Mon, 12 Aug 2024 18:49:03 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 7/7] serial: 8250_platform: Unify comment style
Date: Mon, 12 Aug 2024 18:47:09 +0300
Message-ID: <20240812154901.1068407-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240812154901.1068407-1-andriy.shevchenko@linux.intel.com>
References: <20240812154901.1068407-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unify comment style and fix indentation in some cases.
While at it, add that it supports ACPI enumerated non-PNP devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_platform.c | 35 ++++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index f4a0731ff134..30b4d12ab05b 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -2,7 +2,9 @@
 /*
  *  Universal/legacy platform driver for 8250/16550-type serial ports
  *
- *  Supports: ISA-compatible 8250/16550 ports
+ *  Supports:
+ *	      ISA-compatible 8250/16550 ports
+ *	      ACPI 8250/16550 ports
  *	      PNP 8250/16550 ports
  *	      "serial8250" platform devices
  */
@@ -24,9 +26,9 @@
 
 /*
  * Configuration:
- *    share_irqs   Whether we pass IRQF_SHARED to request_irq().
+ * share_irqs:     Whether we pass IRQF_SHARED to request_irq().
  *                 This option is unsafe when used on edge-triggered interrupts.
- * skip_txen_test  Force skip of txen test at init time.
+ * skip_txen_test: Force skip of txen test at init time.
  */
 unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
 unsigned int skip_txen_test;
@@ -63,9 +65,9 @@ static void __init __serial8250_isa_init_ports(void)
 		nr_uarts = UART_NR;
 
 	/*
-	 * Set up initial isa ports based on nr_uart module param, or else
+	 * Set up initial ISA ports based on nr_uart module param, or else
 	 * default to CONFIG_SERIAL_8250_RUNTIME_UARTS. Note that we do not
-	 * need to increase nr_uarts when setting up the initial isa ports.
+	 * need to increase nr_uarts when setting up the initial ISA ports.
 	 */
 	for (i = 0; i < nr_uarts; i++)
 		serial8250_setup_port(i);
@@ -132,11 +134,12 @@ static int serial8250_probe_acpi(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Default clock frequency*/
+	/* default clock frequency */
 	uart.port.uartclk = 1843200;
 	uart.port.type = PORT_16550A;
 	uart.port.dev = &pdev->dev;
 	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
+
 	ret = uart_read_and_validate_port_properties(&uart.port);
 	/* no interrupt -> fall back to polling */
 	if (ret == -ENXIO)
@@ -206,8 +209,8 @@ static int serial8250_probe_platform(struct platform_device *dev, struct plat_se
 }
 
 /*
- * Register a set of serial devices attached to a platform device.  The
- * list is terminated with a zero flags entry, which means we expect
+ * Register a set of serial devices attached to a platform device.
+ * The list is terminated with a zero flags entry, which means we expect
  * all entries to have at least UPF_BOOT_AUTOCONF set.
  */
 static int serial8250_probe(struct platform_device *pdev)
@@ -292,7 +295,7 @@ static struct platform_driver serial8250_isa_driver = {
 
 /*
  * This "device" covers _all_ ISA 8250-compatible serial devices listed
- * in the table in include/asm/serial.h
+ * in the table in include/asm/serial.h.
  */
 struct platform_device *serial8250_isa_devs;
 
@@ -321,8 +324,7 @@ static int __init serial8250_init(void)
 	if (ret)
 		goto unreg_uart_drv;
 
-	serial8250_isa_devs = platform_device_alloc("serial8250",
-						    PLAT8250_DEV_LEGACY);
+	serial8250_isa_devs = platform_device_alloc("serial8250", PLAT8250_DEV_LEGACY);
 	if (!serial8250_isa_devs) {
 		ret = -ENOMEM;
 		goto unreg_pnp;
@@ -361,7 +363,7 @@ static void __exit serial8250_exit(void)
 	/*
 	 * This tells serial8250_unregister_port() not to re-register
 	 * the ports (thereby making serial8250_isa_driver permanently
-	 * in use.)
+	 * in use).
 	 */
 	serial8250_isa_devs = NULL;
 
@@ -394,12 +396,13 @@ MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
 
 #ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
 #ifndef MODULE
-/* This module was renamed to 8250_core in 3.7.  Keep the old "8250" name
- * working as well for the module options so we don't break people.  We
+/*
+ * This module was renamed to 8250_core in 3.7. Keep the old "8250" name
+ * working as well for the module options so we don't break people. We
  * need to keep the names identical and the convenient macros will happily
  * refuse to let us do that by failing the build with redefinition errors
- * of global variables.  So we stick them inside a dummy function to avoid
- * those conflicts.  The options still get parsed, and the redefined
+ * of global variables. So we stick them inside a dummy function to avoid
+ * those conflicts. The options still get parsed, and the redefined
  * MODULE_PARAM_PREFIX lets us keep the "8250." syntax alive.
  *
  * This is hacky.  I'm sorry.
-- 
2.43.0.rc1.1336.g36b5255a03ac

