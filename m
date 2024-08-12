Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09917DE16;
	Mon, 12 Aug 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473324; cv=none; b=dLLJ+STFdGqPa9XbKNBC8xaDn/r11TGKKpTxP8upaDE446x99ZQ4nBLOrrCy4EaZuvQjQJBFloZFUtCWgH7klMoiwwrpE6FO0bO0VODWFQ6uFA5RmGvJIX0vYNFuIoYPRAiqXuQ0wIvccc0zpgd77d+roy4jqbDBCrbuO6stqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473324; c=relaxed/simple;
	bh=tX0m5QDjLh6ZQGlkWAS+et//rPaZnf4Njh/KWLdYqZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8oZff6/NJ0e+ISLEDwZ9UllI2SnncI+Mel1h9UK3XofsP9SNIlvfuDRyGXUlegdYS5il6MZ1RTv7Nmgv51q2WQGoHH2Z9OKd2eE29UURt/ZWHgn5AEp4L1xTk2c64a17C4UI4mTulpAjcBXquzhJnFe9JpnFpA4SisRl6XryLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFXiPqqH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFXiPqqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723473323; x=1755009323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tX0m5QDjLh6ZQGlkWAS+et//rPaZnf4Njh/KWLdYqZY=;
  b=HFXiPqqHzeeB1ZK3J7UrJ/rsWJN4aqZHm6W+aaaPx3PvSdsSNH8gDWx7
   kuPKn00B9a8A0go0M/7II/9JkyET3uaAvHaL7zHrubJG8uYBdF3r7gzfw
   dTALO0bJrQwssTdU+ZhTU2pXxN25iSDOfPEiIgNO/NshMplhOF8MsMEtU
   qXm/ern27wx3CgCE3OFVs3OdTYyVuRdUsGfHUmEhZ09QlKcTbMv7M8n6f
   e99BrrDxxXUqJxkNfjMz+tBk3EJMwW8DKb7JA4rIvFY37U++eku5RsXHJ
   +RXjdz/NORnuaUATYgKz54DyOzt+kLG91TVL8fzCYOUu9VPAtbtEUrn67
   w==;
X-CSE-ConnectionGUID: Akg2kluEQpGXg0ro/FY/Kw==
X-CSE-MsgGUID: HiamngvOTUu2HFUCjnaVDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32977358"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="32977358"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 07:35:22 -0700
X-CSE-ConnectionGUID: 1ojTV89YTd6u9U4L20gaYw==
X-CSE-MsgGUID: olL4LqfKRL+oeb1lof9fQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="89114390"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 12 Aug 2024 07:35:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7498B178; Mon, 12 Aug 2024 17:35:17 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH v1 1/1] serial: 8250_bcm2835aux: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 12 Aug 2024 17:35:14 +0300
Message-ID: <20240812143514.953612-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SIMPLE_DEV_PM_OPS() is deprecated, replace it with the
DEFINE_SIMPLE_DEV_PM_OPS() for setting the driver's PM routines.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 36e2bb34d82b..829abef2564d 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -245,9 +245,7 @@ static int bcm2835aux_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops bcm2835aux_dev_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(bcm2835aux_suspend, bcm2835aux_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(bcm2835aux_dev_pm_ops, bcm2835aux_suspend, bcm2835aux_resume);
 
 static struct platform_driver bcm2835aux_serial_driver = {
 	.driver = {
-- 
2.43.0.rc1.1336.g36b5255a03ac

