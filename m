Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A44187335;
	Mon, 12 Aug 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477751; cv=none; b=q8RjZsEGcfeKxQpvryZIt8f6Rjc2/IAinqrTIS9Q6OcYzBfiZuu0R8Inl5il90Z+MBveiYQqhcAQJqfuLe79Div7AcpHaKIHbSn1u9qQxoLXZ7tmRUTfRQ7fTSFFWSJUxL7vQV+Iodog5BntnIahn47nqM0Bq6BY9ZmA0O+TPXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477751; c=relaxed/simple;
	bh=v1aKmaKDjfQ1nkB08b03HKu7SColpuAKnONgllNWMKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBjJ9856YjEBfYyQcWM7oqYUYdfH6TugEbY7M7WQVZwsXWfv5JYxBJXiTXPx6gHSZ+ypDgmerBPFoeecDIv5v7bcn4v/mp9VYt5RTW/P3QrqtNappYRnnQbr8yPV2SZXa3MfiIFjJllTS7x5cubjAnQs5yyA0ik5QEmPKga/uhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUmMqlbU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUmMqlbU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723477750; x=1755013750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v1aKmaKDjfQ1nkB08b03HKu7SColpuAKnONgllNWMKk=;
  b=mUmMqlbU1gXDKfKtBi23tCe1geUAnxWLUSOj419G/kkn309s2IcJMBox
   7XLX07lb0kjwdx1Bu0J1G0JacQh28eMh6IeVXgCCWfbbUl5kytbcne8Yx
   O4IY3XH4DUAJDGcLXrVZIUyKvT+1Vv7N0DYXV9UYGU/EcNsVEBPZZs8p7
   zqy+t7T6fK3Wd5XS7buwE/85SaCfmmM2mHeHwh6EXy9305IHMl2Z1G2A7
   SstEA11xgp4Ts8ab7TIcRuPzfXTFV6z4qFGFTE3MPk92mJipvvXWFNv78
   1spNDxDRvr4M5EeXvGESro/FDQpOhQutY9hlUhGJhK1PDwBQ9rtIU3QEj
   w==;
X-CSE-ConnectionGUID: vAGsGFJ1TV2a8fxkb8Olrg==
X-CSE-MsgGUID: VQh6X89iQWGcWED08+IQng==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="46998258"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="46998258"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:49:08 -0700
X-CSE-ConnectionGUID: Ly4jLttLSSi9EMzABno8zw==
X-CSE-MsgGUID: F5frStfRQe+xFBu2N06K3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="62959181"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 12 Aug 2024 08:49:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EF6DD45C; Mon, 12 Aug 2024 18:49:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 5/7] serial: 8250_platform: Switch to use platform_get_mem_or_io()
Date: Mon, 12 Aug 2024 18:47:07 +0300
Message-ID: <20240812154901.1068407-6-andriy.shevchenko@linux.intel.com>
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

Switch to use new platform_get_mem_or_io() instead of home grown analogue.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_platform.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 38c083e90a7d..4a26bab8c9bd 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -113,21 +113,23 @@ static int serial8250_platform_probe(struct platform_device *pdev)
 	unsigned char iotype;
 	int ret, line;
 
-	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (regs) {
+	regs = platform_get_mem_or_io(pdev, 0);
+	if (!regs)
+		return dev_err_probe(dev, -EINVAL, "no registers defined\n");
+
+	switch (resource_type(regs)) {
+	case IORESOURCE_IO:
 		uart.port.iobase = regs->start;
 		iotype = UPIO_PORT;
-	} else {
-		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!regs) {
-			dev_err(dev, "no registers defined\n");
-			return -EINVAL;
-		}
-
+		break;
+	case IORESOURCE_MEM:
 		uart.port.mapbase = regs->start;
 		uart.port.mapsize = resource_size(regs);
 		uart.port.flags = UPF_IOREMAP;
 		iotype = UPIO_MEM;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	/* Default clock frequency*/
-- 
2.43.0.rc1.1336.g36b5255a03ac

