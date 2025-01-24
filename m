Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212B18EFCC;
	Fri, 24 Jan 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737735344; cv=none; b=nVuJGQ98feHxuuRHi1xYa9l8m+oIC7TwN9ajkF4X+/vkhU0ozJVOSaZskVLBtUBgqqm2Ey38FyfQu3EXqadD2jfdWyxw8vMjwE1DwdEKkca5fhsKKppDxS1aYue7iSv1Wj1HbHWHWPIbYXfmxt+7SvKgZ8+QZy3WrsGNr3l9soo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737735344; c=relaxed/simple;
	bh=bOqQp5iiDR5OhNeYoMcyqcEXriZiM/TUsJ5hvzAd7R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k65tBSkVFT0DRv3eqoE7kUcytoJu2T7DCpKgA+GF1Z4odSqE4UrXK3KDXG5qY1mUXfoDXtGXOlZaFylYG+HMu9ucJ8wj7PKNBfOec+E+bhm5Sf0EB0oDRfudgsc1O1KW3FTIcmlkPKWqg4oNzRYcw3ql6HRqtAp6oHyHBSWaL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBm1NU/3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBm1NU/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737735343; x=1769271343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bOqQp5iiDR5OhNeYoMcyqcEXriZiM/TUsJ5hvzAd7R8=;
  b=HBm1NU/3v5qyITGSotCRUzUytXK5OajKpLODdFu0Nfw60TxOb8WuKYSJ
   EONc0skGw8bhnaf3ZO1Vnq33sUIYBFmr8meOtphWIcMB0OjTY6S3sGVhh
   Eu/+HE2yVi1hw3BT/jhYNJC0nyOc0/+lnhzfPv/FkNDhEuOqOmUBfsjY1
   zaVtekac8E+1jJqt5HCdhLdSgs2t14y50Dy3th172CSo0MFkBdy/gSO+s
   XvTbj9vYDhQ4i5AI8CTflTf18drCR7UjdIg1Syg2GQ6rnA9sJE1dPRHu3
   NGcE/NkgIuHCuF94HbV2VKIQatyzO2k6Ew9fi80pSz+yRCuL0q6vE4t1z
   g==;
X-CSE-ConnectionGUID: 87spPD/ZRNut5DD8oXRi2g==
X-CSE-MsgGUID: zcurAo/bRfW9udnPBdYWpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="48858236"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="48858236"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 08:15:43 -0800
X-CSE-ConnectionGUID: IO3tEVMJSCa/FEvjSZFwKA==
X-CSE-MsgGUID: T5Q2yqycR2qkYqnxNoRmDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107659135"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 24 Jan 2025 08:15:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CC2BE1E9; Fri, 24 Jan 2025 18:15:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 5/6] serial: 8250_platform: Remove unneeded ->iotype assignment
Date: Fri, 24 Jan 2025 18:10:50 +0200
Message-ID: <20250124161530.398361-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20250124161530.398361-1-andriy.shevchenko@linux.intel.com>
References: <20250124161530.398361-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ->iobase is set the default will be UPIO_PORT for ->iotype after
the uart_read_and_validate_port_properties() call. Hence no need
to assign that explicitly. Otherwise it will be UPIO_MEM.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_platform.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 348b7fa2e94d..d8cbd8d87b0e 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -112,7 +112,6 @@ static int serial8250_probe_acpi(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct uart_8250_port uart = { };
 	struct resource *regs;
-	unsigned char iotype;
 	int ret, line;
 
 	regs = platform_get_mem_or_io(pdev, 0);
@@ -122,13 +121,11 @@ static int serial8250_probe_acpi(struct platform_device *pdev)
 	switch (resource_type(regs)) {
 	case IORESOURCE_IO:
 		uart.port.iobase = regs->start;
-		iotype = UPIO_PORT;
 		break;
 	case IORESOURCE_MEM:
 		uart.port.mapbase = regs->start;
 		uart.port.mapsize = resource_size(regs);
 		uart.port.flags = UPF_IOREMAP;
-		iotype = UPIO_MEM;
 		break;
 	default:
 		return -EINVAL;
@@ -147,12 +144,6 @@ static int serial8250_probe_acpi(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * The previous call may not set iotype correctly when reg-io-width
-	 * property is absent and it doesn't support IO port resource.
-	 */
-	uart.port.iotype = iotype;
-
 	line = serial8250_register_8250_port(&uart);
 	if (line < 0)
 		return line;
-- 
2.43.0.rc1.1336.g36b5255a03ac

