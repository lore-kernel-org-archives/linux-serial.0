Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B33922FF4D;
	Fri, 21 Mar 2025 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581293; cv=none; b=UQylimB6CZfTzdcx/VaSWkNvAhs+KJ0ithetx7KS0uCNjHEf94TfOKxvCOEixSKdf55Ji1OTPseWBKCzpZwRdkLu2Xqx6LVoKy+rciYmjpCJDtfEx7pAG+RGY/FFnJt6Svyn63jc1yzpS5Pqz3yIFckWC5ySS50JsuFQCC1npkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581293; c=relaxed/simple;
	bh=fkjFFznByDQk57yAw7swZKyh1oSTDF5oWpguUFliF8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkLi2iwY4+1Vxu02J5fJnV0gs0zZmK5/vD0rYaeCNCEzkDNnzykQcMcW2DAfJy4eZ5v78N9FxoVr+c/gQAUUmDUVyRcdj8v93KLUg9ul2fYTkTZnwdVKjPo531DH42fKIc9YJL4v/YxHS4tmxEKKemKhilcJB0wOgtvU27DBDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGxmoQYl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGxmoQYl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742581292; x=1774117292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fkjFFznByDQk57yAw7swZKyh1oSTDF5oWpguUFliF8Q=;
  b=YGxmoQYlSnU1Nqn/HSaMESeGGgwDLaYp1NlrE/uZhSMSofaw510BRk8h
   7LsWCtQ18CwikUXKkr3PhkE//xBvjCVWieNiT0StKDXRgN+zP0tuK0ASy
   bme4jMpjYR5wTqwC4E7MdBPKtq9EyNLTuEq7oxbwVjKXTvnMluly2YsPi
   Dqxvyp/iysPfDBEFvRSUQJ+hI/yJa7un3QGW+QbFxG6X/nLMI9nFiI1GQ
   FPM909cCuA7dP4vjsLsk7xV57ORW4yIBoZ+usK6662qtbSInnw1iP9FAP
   B2jLGMT8FzrnyKiWrmFjuVpedbTQF4OypibV6X9E116vE8lHh3Ba2uaOI
   g==;
X-CSE-ConnectionGUID: saiQK/H+SDCg9lFCP7laNw==
X-CSE-MsgGUID: 7XTGZkJEQ62VTiIpLZxqsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="69212019"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="69212019"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 11:21:30 -0700
X-CSE-ConnectionGUID: ozzziGvsQfK3iT6AWnwjxQ==
X-CSE-MsgGUID: clLm38LWTUS8mKEJS4ahEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="124423525"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 21 Mar 2025 11:21:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0ACB1296; Fri, 21 Mar 2025 20:21:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 7/7] serial: 8250_ni: Tidy up ACPI ID table
Date: Fri, 21 Mar 2025 20:20:18 +0200
Message-ID: <20250321182119.454507-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250321182119.454507-1-andriy.shevchenko@linux.intel.com>
References: <20250321182119.454507-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tidy up ACPI ID table:
- drop ACPI_PTR() and hence replace acpi.h with mod_devicetable.h et al.
- drop comma in the terminator entry

With that done, extend compile test coverage.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_ni.c | 15 +++++++++------
 drivers/tty/serial/8250/Kconfig   |  2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index c66bfc56838e..b0e44fb00b3a 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -10,14 +10,18 @@
  * Copyright 2012-2023 National Instruments Corporation
  */
 
-#include <linux/acpi.h>
 #include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/property.h>
-#include <linux/clk.h>
+#include <linux/serial_core.h>
+#include <linux/types.h>
 
 #include "8250.h"
 
@@ -392,7 +396,6 @@ static void ni16550_remove(struct platform_device *pdev)
 	serial8250_unregister_port(data->line);
 }
 
-#ifdef CONFIG_ACPI
 /* NI 16550 RS-485 Interface */
 static const struct ni16550_device_info nic7750 = {
 	.uartclk = 33333333,
@@ -417,20 +420,20 @@ static const struct ni16550_device_info nic7a69 = {
 	.uartclk = 29629629,
 	.prescaler = 0x09,
 };
+
 static const struct acpi_device_id ni16550_acpi_match[] = {
 	{ "NIC7750",	(kernel_ulong_t)&nic7750 },
 	{ "NIC7772",	(kernel_ulong_t)&nic7772 },
 	{ "NIC792B",	(kernel_ulong_t)&nic792b },
 	{ "NIC7A69",	(kernel_ulong_t)&nic7a69 },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ni16550_acpi_match);
-#endif
 
 static struct platform_driver ni16550_driver = {
 	.driver = {
 		.name = "ni16550",
-		.acpi_match_table = ACPI_PTR(ni16550_acpi_match),
+		.acpi_match_table = ni16550_acpi_match,
 	},
 	.probe = ni16550_probe,
 	.remove = ni16550_remove,
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 9be9760886dc..63fedac1bbae 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -565,7 +565,7 @@ config SERIAL_8250_BCM7271
 config SERIAL_8250_NI
 	tristate "NI 16550 based serial port"
 	depends on SERIAL_8250
-	depends on (X86 && ACPI) || COMPILE_TEST
+	depends on X86 || COMPILE_TEST
 	help
 	  This driver supports the integrated serial ports on National
 	  Instruments (NI) controller hardware. This is required for all NI
-- 
2.47.2

