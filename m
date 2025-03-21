Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A222E406;
	Fri, 21 Mar 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581291; cv=none; b=LPVSNVFL+JF1T7ikA4LOrX+Tso/DKwJB+CmHQfP7GVhhfqU/LnGpNrlDEi6icvKgcqf7TAfuh/iQOFuN83kG4GkaMPVCn6+5WT4Ok4FndtxqVAn9cv0bNOv2dzYhv0rKHguI1MEHrCDMYhhhOjxbCmCkNiWvmEk4tEEuorwULNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581291; c=relaxed/simple;
	bh=Z11NZgntq6KJfRIsKInfFfPgwQUCX5OufzcP3Pi8Gb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0Bj3Y3PI2bV8VL+5BuB5R8Wg77v/pdOw9gR3kcEmzFBAqqkHmYd/saSsZ+AwYwZDPTyhEqFDs7fzSa8b6pMYtrV1aPT8WSpqUh5bqhMHibp4DEu6BeCY+QqWyyBM9jRU4L1l7Iww2VA/pdimq6RarcLxA/dmUxmU1rpGJJpk58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvpgrQwV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvpgrQwV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742581290; x=1774117290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z11NZgntq6KJfRIsKInfFfPgwQUCX5OufzcP3Pi8Gb0=;
  b=HvpgrQwVwJ828i64RE6qjXIipRpiZHG6lIh1apfw3z1P6i/gBFTKw1f/
   yNMVmRPPt2+fzqMFZMo12IR1rm2LSNr3EahkJOyB5g1/EEM7mFar84caX
   ITAZPP44hrZL6DUylAk7z8mjv7/2tEhM8+xcc88wyOCk3zUxMmPhbs+kF
   MtU3S8V1VmwhJEDNVS8ikapUGZIp8skGwOMoPsbJe1DvdZ+9Sx5MoSKFN
   i2Kn+QbLzUqAHBh5L4EBitbVGx2U35cDO9Fr4xKjuq08xn5gfqucJ+X2u
   mFUNyO1E5RJ+hlnSb8MJxUCZir0iu7j8c/khho7a+8uTVXu9/XjxNM3+j
   w==;
X-CSE-ConnectionGUID: ePQfS3q6TLKqq2+XZ4Iz5w==
X-CSE-MsgGUID: TsDttR0bTRyjVnNkBbSJJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="69212010"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="69212010"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 11:21:28 -0700
X-CSE-ConnectionGUID: H5I1NIKBRiefnbE5OVVBOQ==
X-CSE-MsgGUID: YkYHpO/aSZmnHaG5L0+3Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="124423521"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 21 Mar 2025 11:21:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id ADCD0AF; Fri, 21 Mar 2025 20:21:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/7] serial: 8250_ni: Switch to use uart_read_port_properties()
Date: Fri, 21 Mar 2025 20:20:12 +0200
Message-ID: <20250321182119.454507-2-andriy.shevchenko@linux.intel.com>
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

Since we have now a common helper to read port properties
use it instead of sparse home grown solution.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_ni.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index b10a42d2ad63..03e838f440be 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -285,7 +285,6 @@ static int ni16550_probe(struct platform_device *pdev)
 	const char *portmode;
 	bool rs232_property;
 	int ret;
-	int irq;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -293,10 +292,6 @@ static int ni16550_probe(struct platform_device *pdev)
 
 	spin_lock_init(&uart.port.lock);
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	ret = ni16550_get_regs(pdev, &uart.port);
 	if (ret < 0)
 		return ret;
@@ -307,10 +302,7 @@ static int ni16550_probe(struct platform_device *pdev)
 	info = device_get_match_data(dev);
 
 	uart.port.dev		= dev;
-	uart.port.irq		= irq;
-	uart.port.irqflags	= IRQF_SHARED;
-	uart.port.flags		= UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
-					| UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	uart.port.flags		= UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	uart.port.startup	= ni16550_port_startup;
 	uart.port.shutdown	= ni16550_port_shutdown;
 
@@ -332,12 +324,16 @@ static int ni16550_probe(struct platform_device *pdev)
 	/*
 	 * Declaration of the base clock frequency can come from one of:
 	 * - static declaration in this driver (for older ACPI IDs)
-	 * - a "clock-frquency" ACPI
+	 * - a "clock-frequency" ACPI
 	 */
 	if (info->uartclk)
 		uart.port.uartclk = info->uartclk;
-	if (device_property_read_u32(dev, "clock-frequency",
-				     &uart.port.uartclk)) {
+
+	ret = uart_read_port_properties(&uart.port);
+	if (ret)
+		return ret;
+
+	if (!uart.port.uartclk) {
 		data->clk = devm_clk_get_enabled(dev, NULL);
 		if (!IS_ERR(data->clk))
 			uart.port.uartclk = clk_get_rate(data->clk);
-- 
2.47.2

