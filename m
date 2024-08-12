Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAE2187324;
	Mon, 12 Aug 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477751; cv=none; b=Vxg/LD4Zd/9RV8IN1Ahlr3c4GD8jeBJI/z6tQgDsi6JLeBqtyRGBpbNJsbSlyK8KROr6yTABsBcF0cTvZmgo7Vn5krq9OdB5cTl8nj2FBSwyywQEJynTWv4OpY1/e9B+8Ve/SMMomrBSsqJExooOeFZeqxRMkuVwJgt3sWFlVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477751; c=relaxed/simple;
	bh=4f2n6tDGiE+OAUIB4DKYZtverVwdklVZKXNEQN+AMCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pL43+sivgMi2MHL4w30I40dTetX6+QbjwcxauFeVFUrbzwKYEoTaCsVAjhkfQb295VE40eF0eMzds1mH9/AhQbwwbZm5tZ9QeBGRSbKjdUuCOJYeyI2Te11inB3D/jE1AmQNuf53vXhb4Kv+7/yPyazXdZqdk6zktoxV9vJE4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRpozE+m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRpozE+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723477750; x=1755013750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4f2n6tDGiE+OAUIB4DKYZtverVwdklVZKXNEQN+AMCo=;
  b=JRpozE+mr2KhjZpQclyBMnwDDLwUM2MkzQGSwtXoEYzd7fkHjLunZlFr
   A1OZEQevxDOdGfGXJxeQ/BHW8T2M+HeQ41QoBEg8FuGNjmcBhwE7nXEiZ
   7WDdfl3ZFK+1V/Y5zG/VgN+Ah5BNOCwStGAHKJRoLCcNfiEtsjMmXTJDZ
   nk9buktZZV30Zks2L2MPPlZNF/Msun2vHRxEZGuHDUYweTuY5j6PYD27P
   9Faa0QZSk9s2fzDAQXeqt6HzkcFWel1syRk/QKgYJq3oi5Sk8BG+xfNJa
   iyQ2FKSSdZj1ZbHu1C2Axz/PXKqipKQmIdOsseMkQFpLYJi4BupU6iyrZ
   g==;
X-CSE-ConnectionGUID: 6+5KQFliRemg4df7iMw3yg==
X-CSE-MsgGUID: 0OPoz2aSSSqQLV+kttzfHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="46998253"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="46998253"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:49:08 -0700
X-CSE-ConnectionGUID: DL9kg1V8TH2p83PYWilVzQ==
X-CSE-MsgGUID: /OFnkct1QHuvkTj5584ABQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="62959180"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 12 Aug 2024 08:49:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 074736D3; Mon, 12 Aug 2024 18:49:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 6/7] serial: 8250_platform: Refactor serial8250_probe()
Date: Mon, 12 Aug 2024 18:47:08 +0300
Message-ID: <20240812154901.1068407-7-andriy.shevchenko@linux.intel.com>
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

Make it clear that it supports two cases, pure platform device and ACPI.
With this in mind, split serial8250_probe() to two functions and rename
the ACPI case accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_platform.c | 43 ++++++++++++++++---------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 4a26bab8c9bd..f4a0731ff134 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -105,7 +105,7 @@ void __init serial8250_isa_init_ports(void)
 /*
  * Generic 16550A platform devices
  */
-static int serial8250_platform_probe(struct platform_device *pdev)
+static int serial8250_probe_acpi(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct uart_8250_port uart = { };
@@ -157,25 +157,11 @@ static int serial8250_platform_probe(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * Register a set of serial devices attached to a platform device.  The
- * list is terminated with a zero flags entry, which means we expect
- * all entries to have at least UPF_BOOT_AUTOCONF set.
- */
-static int serial8250_probe(struct platform_device *dev)
+static int serial8250_probe_platform(struct platform_device *dev, struct plat_serial8250_port *p)
 {
-	struct plat_serial8250_port *p = dev_get_platdata(&dev->dev);
 	struct uart_8250_port uart;
 	int ret, i, irqflag = 0;
 
-	/*
-	 * Probe platform UART devices defined using standard hardware
-	 * discovery mechanism like ACPI or DT. Support only ACPI based
-	 * serial device for now.
-	 */
-	if (!p && has_acpi_companion(&dev->dev))
-		return serial8250_platform_probe(dev);
-
 	memset(&uart, 0, sizeof(uart));
 
 	if (share_irqs)
@@ -219,6 +205,31 @@ static int serial8250_probe(struct platform_device *dev)
 	return 0;
 }
 
+/*
+ * Register a set of serial devices attached to a platform device.  The
+ * list is terminated with a zero flags entry, which means we expect
+ * all entries to have at least UPF_BOOT_AUTOCONF set.
+ */
+static int serial8250_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct plat_serial8250_port *p;
+
+	p = dev_get_platdata(dev);
+	if (p)
+		return serial8250_probe_platform(pdev, p);
+
+	/*
+	 * Probe platform UART devices defined using standard hardware
+	 * discovery mechanism like ACPI or DT. Support only ACPI based
+	 * serial device for now.
+	 */
+	if (has_acpi_companion(dev))
+		return serial8250_probe_acpi(pdev);
+
+	return 0;
+}
+
 /*
  * Remove serial ports registered against a platform device.
  */
-- 
2.43.0.rc1.1336.g36b5255a03ac

