Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90922FDE6;
	Fri, 21 Mar 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581292; cv=none; b=BZPXvoIOV/YkUR9x3WtYEwgpqKL7YzRksy7Nc4q69XtS2x/BaM0mpf3npAefgXt3nfutcNe9xGzDLFFm/3dkgZrng4du6vKvP4GIwtKFIkYF7zUVBauTj/iDstgkcIM2xDXxqiojSeUEnyIc+9OlDU4yKBHo3/Z14AmwWceklsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581292; c=relaxed/simple;
	bh=jWkJdSq1h2tHx5Zu75tcJ9csvWPk4JmJjyoMbLV9opc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGJyUKGSLAPer2RcQAHPw9emkOJbwOXbGSI3gzJofdHzwpcTmwPOr0Etgr8Y4/9hdXHC5Zg1hfdaAz/CevX8LVHWDa4QuQHOzoVpBmnGyYXJdUb05fKFaqOyUsqdIeJnfsDAq+/+c/39OCDVRf8E/oSG6pGEj5mJE9XJgvZgAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZaV2MwwL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZaV2MwwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742581291; x=1774117291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jWkJdSq1h2tHx5Zu75tcJ9csvWPk4JmJjyoMbLV9opc=;
  b=ZaV2MwwLj9yxLAqIvWbkoHS/VK/cSh0JmF25URUZdoIVj16tEIiDGrAr
   A7WlKbrsqM5UA8Mn22hPfVzSMvm+e+JcvETDGTxMEfz2FWV2rRf2mMjHT
   02HKPRzUT4A2kq4hciR9iKzuwxAn0h8UL+qEvkxsZzXxb+ln7q4CCFyR9
   rjcJCeTuvots+tSHCEnjT2hB4QQJwKrhWHyBA5aTMCnvJG7JnCzuzXulI
   0hKxuTxl5AjJHd7IKSKWJFJxmlzxSlpFu8WIfR9wwRwVoJ6fPhgjU3tHu
   spkfk6KxGTKbTke+ScJQXTPmcjKMZHJA+koYCDmTtxFV+ikCqBU07ZD9s
   w==;
X-CSE-ConnectionGUID: g8t3RbgkS4WwVoZZPpfhIw==
X-CSE-MsgGUID: 1zupwdBwR2SyxSFyl9Rncg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="44046751"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="44046751"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 11:21:28 -0700
X-CSE-ConnectionGUID: elBiN2NrSrqPFBVdHxDOLQ==
X-CSE-MsgGUID: ERlD2H01Qi2fZDqe+fdJVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123433904"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 21 Mar 2025 11:21:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D5D53663; Fri, 21 Mar 2025 20:21:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 4/7] serial: 8250_ni: Remove unneeded conditionals
Date: Fri, 21 Mar 2025 20:20:15 +0200
Message-ID: <20250321182119.454507-5-andriy.shevchenko@linux.intel.com>
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

It doesn't matter if the properties are supplied or not in
the struct ni16550_device_info as default in any case is 0.
Hence there is no need to check for them being set.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_ni.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index 2dc510c0a5ef..8bb8bb7bb4f2 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -275,7 +275,7 @@ static int ni16550_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct uart_8250_port uart = {};
 	unsigned int txfifosz, rxfifosz;
-	unsigned int prescaler = 0;
+	unsigned int prescaler;
 	struct ni16550_data *data;
 	const char *portmode;
 	bool rs232_property;
@@ -321,8 +321,7 @@ static int ni16550_probe(struct platform_device *pdev)
 	 * - static declaration in this driver (for older ACPI IDs)
 	 * - a "clock-frequency" ACPI
 	 */
-	if (info->uartclk)
-		uart.port.uartclk = info->uartclk;
+	uart.port.uartclk = info->uartclk;
 
 	ret = uart_read_port_properties(&uart.port);
 	if (ret)
@@ -340,11 +339,9 @@ static int ni16550_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	if (info->prescaler)
-		prescaler = info->prescaler;
+	prescaler = info->prescaler;
 	device_property_read_u32(dev, "clock-prescaler", &prescaler);
-
-	if (prescaler != 0) {
+	if (prescaler) {
 		uart.port.set_mctrl = ni16550_set_mctrl;
 		ni16550_config_prescaler(&uart, (u8)prescaler);
 	}
-- 
2.47.2

