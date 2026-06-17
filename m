Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E918D2FFFB5;
	Wed, 17 Jun 2026 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688321; cv=none; b=n3FAuKa9gRf4U7Ejity/VYjgPxOYyZeHylhhIshBV1UVZS7P9p3hWY9MeTlYsubTEJCEwMD969CQ35DY1j8MpIeMznK/KU595ts8mYfZcSw60B1x5mTXq6KyFxllExI/kXXWZs+trplvdRlG9jNUr/GsCh7/+wCHUay/PGXY2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688321; c=relaxed/simple;
	bh=++GZ1ZcBZI03vgxpChGuyfRr6JkD6L5IQ/hgSCagSK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+0JWJPjZIg4oqHE2c5nSw/vqufGVfCcJrquPwIPb6JmiU+9lS0zvGaAtoy34aRdn4BldP/lO4JUZAiNJZ29FFfQfDu4XvjC322d+gv3TLOWRgrxkdAK/p2nzQmEJW6Ars5GxIyblI9zzN2LVvyU/b/aDVLkHPIFKfOQfsdGsWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUUg9834; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUUg9834"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781688320; x=1813224320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=++GZ1ZcBZI03vgxpChGuyfRr6JkD6L5IQ/hgSCagSK8=;
  b=iUUg9834x0HqwG2/eMN9W7dCZSJ8aeAbFm5zhlk0R40UX59JV2NLWl6A
   B2B6bCWVAOY4feLqmXHyzfnbEkif4PJuv6RG1yaPS3rwFA1nPfywSZCF2
   1asvJMNW5MoXaIL7Iubcl2ZLQyn+GKdqRtPFdytd6VqvEiboEA8VMDTNe
   vsc3HbPEAxVaC4IpqluXsJ5EQaOV1xpcqtOtAd8eLiMjdmi1TXRJHtsFA
   UOumZLlo5XoE5ihSKw/5ldspyxTDJNmLg+9YAXB3szVLu6+oaKB9ctgdt
   EtQySFAEMgBzXysPK1i2dCNTYExzE5zcVctVMHjIEC0jFVT9fKG3UaETY
   w==;
X-CSE-ConnectionGUID: Cu0EYrXWSYONWCMK2V2wCg==
X-CSE-MsgGUID: YbGCV7eIRAmSf/dmAong8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="70008926"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="70008926"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:25:19 -0700
X-CSE-ConnectionGUID: XLLi0GIYSvOf5y7kK9y1tA==
X-CSE-MsgGUID: 7DW/FK5EQyKcKDm8pHWKkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="249920281"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 17 Jun 2026 02:25:18 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 95FBF95; Wed, 17 Jun 2026 11:25:16 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serdev: acpi: Free resource list at appropriate time
Date: Wed, 17 Jun 2026 11:25:15 +0200
Message-ID: <20260617092515.2649521-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do unneeded "double free" (emptying an empty list) in one case.

This is not a critical issue at all, the fix just makes code robust
against any possible future changes in the flow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serdev/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index e9d044a331b0..7500efcdfc21 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -651,11 +651,11 @@ static int acpi_serdev_do_lookup(struct acpi_device *adev,
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list,
 				     acpi_serdev_parse_resource, lookup);
-	acpi_dev_free_resource_list(&resource_list);
-
 	if (ret < 0)
 		return -EINVAL;
 
+	acpi_dev_free_resource_list(&resource_list);
+
 	return 0;
 }
 
-- 
2.50.1

