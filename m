Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902E1922F5;
	Mon, 25 Nov 2024 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530792; cv=none; b=eX0L0Cchzuv3gH8U7OFU/Q9ZfBKvYty186avWFEMfPo7NZYt91u6i87ph5baYQBpVDuYG/sj1RQMKFdHYpOBs+Ubemln80PiUBF/t+0ZHxtcnLHjDAtxEK9S7lnlOkwsCfi7gW882IxQnZtpg4GPq5pEBJfEQcM9Ek9MiGQAu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530792; c=relaxed/simple;
	bh=j0MzW8N4RIWgvohxJXYYVBrXEirRN0kam6noNvvRWmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRLBx5CBKS3tQtjCnwYbsbE8vGLJn5zypf3JUg6Ool8zORKS3JY4+wqDsxnkbb/A80GdTLihHa5zI3d+HR0uaOTDwCRghQg6x0k7rghSPhRvEdEPrxvsgpu+r5wBVpnsi7zIgMJLs9AoMap6WF6nL2pVMHP2qe+AJ4FEloPnIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQTVPIzv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQTVPIzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732530791; x=1764066791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j0MzW8N4RIWgvohxJXYYVBrXEirRN0kam6noNvvRWmc=;
  b=AQTVPIzvTzXqzvyMqFz2O3aHXMTtT0mRot5uu+1+/5XKhCJ8dWcPqGRK
   cO4xrgThnPUcRU4SsqsmX4Ol7PPAsPeI/+EIFo9246RVjUOTpfjolefXJ
   HLzWtm20DlB99AKMz+iRKz0zu7sGOr8xV44U17AtTpUB396uLu9zcboAv
   nAuNqjLZIlb2CkGGQyVAU+XSFnOfpkpN2dem/+6UbwmVG3FTlmJHtOLAM
   OPxHxiQh+N5DOeMauHxWJejhi13Do71QzBx5iOTn/yXUI8ux+Ax7chFNO
   FYWwidgesbmmVjySuC2GQcpTuuHPUovUtrfsBAKolfdh4sqoP3kLSZULS
   w==;
X-CSE-ConnectionGUID: Mtfe3HbyQHuFfR6vwoUwJw==
X-CSE-MsgGUID: Uo+uYoovSq+B0mk8xwMGYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="32778202"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="32778202"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:33:10 -0800
X-CSE-ConnectionGUID: K/31OUoZSCiWeQiutuLWfg==
X-CSE-MsgGUID: YA0SqxxwTju74Iym4lU3tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91639163"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2024 02:33:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 49F32217; Mon, 25 Nov 2024 12:33:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_port: Assign UPIO_UNKNOWN instead of its direct value
Date: Mon, 25 Nov 2024 12:33:05 +0200
Message-ID: <20241125103305.1614986-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial8250_init_port() assings 0xFF for the unset or unknown port
IO type, use predefined constant for that instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4d63d80e78a9..1003516097df 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3249,7 +3249,7 @@ void serial8250_init_port(struct uart_8250_port *up)
 	port->ops = &serial8250_pops;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
-	up->cur_iotype = 0xFF;
+	up->cur_iotype = UPIO_UNKNOWN;
 }
 EXPORT_SYMBOL_GPL(serial8250_init_port);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac

