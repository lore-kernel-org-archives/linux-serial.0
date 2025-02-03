Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E5820409A;
	Mon,  3 Feb 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738584902; cv=none; b=DCEUOH/KMT6VYMxKC9jTKeKu2v+xP5PoBj9Oxm8dFVi8dx4tg4Ag7+txcErzvV9QFuxz3CYC27NV1aTiP3tRF+yXbZEui2eDMQyBfP+MB/+zV6bOFm6D7I/oTaNT42fChGF4n187CAUatDq8H7u7GKw+uWWXS5nIKs7PGILKr/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738584902; c=relaxed/simple;
	bh=lqc3zB6vI0LJONekYhakIlxb9SFepqtDVxf0DOFBaL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OZt62gLI+CPP7fnC+ycxUKgr2ECBYc/j3Asoxrd6iABUfOn/5poFZHQnHYjfsuJ8f0R0sQ9ogCw/VPM9rntWnM8sXlWHvDdKJUeZVCgzTh/Jwme1PVE/3TiruLUABeHFpIXSuWFSOrGmeKnsbLwZ2tjTdf3tXGiXjGqHOk2MYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAvobK5D; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAvobK5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738584900; x=1770120900;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lqc3zB6vI0LJONekYhakIlxb9SFepqtDVxf0DOFBaL0=;
  b=JAvobK5DZcsEBkXBwPQqzT6T3MZ5XJ6ktcjx/yawC+MFn7mDnzFlCgbh
   S8UKjyKX/QUrc3F3Swijp/PTMBzsi8iApAimxnHjvpmYldesoTvzZCmvF
   6cvK//aMstYVYIeti/q9q2TeZH/T7Gbrb+ODx5+b+ouuI/mtMFkoLTOcC
   ZXAx7THg/LT8dinkaDC+jlMGnoNypnHAvekjXXdHHcI9BhVrwKCsIN1gh
   Meai+dNRdf2m4k9SNOH9hjLdggFC9zsGKbCdy8CI8roePZIrNxcesKijo
   CyMmfm65LB9BnRbu1qCC+IkTHBcCubrn7PhQQrdzazxS33zmLqOLkwyLX
   w==;
X-CSE-ConnectionGUID: 9YorPoulTFmsfcrC6icCPA==
X-CSE-MsgGUID: 8XX82/PQRWWlKdA96pxYBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39104871"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="39104871"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 04:15:00 -0800
X-CSE-ConnectionGUID: iSakkgi1QBSbCTPAKqc7Ng==
X-CSE-MsgGUID: wnKc12D7ToOZn4py1LDM9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110169111"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 03 Feb 2025 04:14:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4F75123F; Mon, 03 Feb 2025 14:14:57 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_dw: Drop unneeded NULL checks in dw8250_quirks()
Date: Mon,  3 Feb 2025 14:14:56 +0200
Message-ID: <20250203121456.3182891-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since platform data is being provided for all supported hardware,
no need to NULL check for it. Drop unneeded checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 6afcf27db3b8..ac3987513564 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -459,8 +459,8 @@ static void dw8250_prepare_rx_dma(struct uart_8250_port *p)
 
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
-	unsigned int quirks = data->pdata ? data->pdata->quirks : 0;
-	u32 cpr_value = data->pdata ? data->pdata->cpr_value : 0;
+	unsigned int quirks = data->pdata->quirks;
+	u32 cpr_value = data->pdata->cpr_value;
 
 	if (quirks & DW_UART_QUIRK_CPR_VALUE)
 		data->data.cpr_value = cpr_value;
-- 
2.43.0.rc1.1336.g36b5255a03ac

