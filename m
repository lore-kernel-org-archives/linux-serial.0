Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41F18E29;
	Tue, 13 Aug 2024 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537217; cv=none; b=I7Gs3y27QzMUgHhk/dVRH2+HHevkBq6HtUdVzEUGV3FvbSaYbOC8Tjv/0iWZmd1GOcVfEjz4zoWzXOY7G+sXBkdnXkNXQYI6B/OXopB9EabseFT+vj4H87GyCpHapHWvOpk3rON9bX72RmDSXMlMvcZw9pZ0llmz0hzR8hjNOOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537217; c=relaxed/simple;
	bh=k0wWO84T3G2KXqLOeqWQvKS+xPlgf/sdldpOl2wRm/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=heDQuO/roN9V/7BCBWLk67T0QN/Caw40kiE1go/zWnhql/dcI1FvdjO7Tbcp5cBtO32D7AXv8ukMs1bz8cJ2O/ar+4ireOX62CkwxSwpzJxSHFL6bapb0LF86ZUhxIJsGxXBMg4EpT+uamliZ3EOdZtJitobzk3depKkw90zCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y76eEaoD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y76eEaoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723537216; x=1755073216;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k0wWO84T3G2KXqLOeqWQvKS+xPlgf/sdldpOl2wRm/Q=;
  b=Y76eEaoDh2zFPfaoyOdvbqnoBjawwgQQYf4/00ZLCJCgWuhX8rIOX5lF
   WBMj99iZ+FGUAUSOTgTJyvuBjhVH90urlFZ1cC1gq0f8uSjF2pDPaSK6I
   C4wyOM5WioN9BNWv3tTHSG1og3BxpPSBIU83oAaaNm2Mk96SlOq1UwRnW
   BF0LBMD/RvnGeurnAyMxth4AgbNeKxT3opl8LUfPwp/0BjzNXjYQHN5/n
   1Qh5efCAbfxIo9E0phXJtdKxjTePMZ1WAWbMN6qzhr0e1/84OtlPWnviL
   ywU7nv8IBpmSLXOzL9n9n2k/3XtgAHPHSYzHU6xBo430RXIXn94TmlVNv
   Q==;
X-CSE-ConnectionGUID: UFLcF4K9Smmxy2PkUXdkJA==
X-CSE-MsgGUID: oANi12d8QuOJACuR1D4/LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="25549018"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="25549018"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:20:16 -0700
X-CSE-ConnectionGUID: NDKVixBiTjezY2HhuE5Uqw==
X-CSE-MsgGUID: m0ajqOPKRPeuEbShamisaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="62750806"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 13 Aug 2024 01:20:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 178FF86D; Tue, 13 Aug 2024 11:20:12 +0300 (EEST)
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
	Scott Branden <sbranden@broadcom.com>
Subject: [PATCH v2 1/1] serial: 8250_bcm2835aux: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Tue, 13 Aug 2024 11:19:04 +0300
Message-ID: <20240813081954.1408792-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definition of the PM operations opens code the existing macro,
replace it with the DEFINE_SIMPLE_DEV_PM_OPS() for setting the driver's
PM routines.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed the copy'n'pasted commit message text (Stefan)
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

