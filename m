Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77503BB38;
	Mon, 19 Feb 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355200; cv=none; b=XJmc/4+EcFeE7SPrc2AoQOVeP2Ft/3OGoqEjo5I8xSk+YR2Mc2qWpZaJ2Whpfu3TkL3GVH89pkIJkxscbRnINS++FPdn5WyqZ4RHVrJIep/TqSyDWd3xOUCq16ifWXZw/zMyyeJfNVFfaGKZuqQfR6fT3J5CQYgjMM1okL7NLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355200; c=relaxed/simple;
	bh=DCAxzfXqTax5T11aXU0gJP0t0VjNv7GMA3otlVXbuV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er4f8b6cazcqhxqk5l/qQUODQe3M9gkMf60MF1Aa6PKRa/F4gEzAprKOqhThwKobgPDchZlFz6az/WrdxlZEBAJv6gaLF+GlNLzY9PrK2ymkQGajaPAk6XuAKGqj5/zIYaBHrzLKmvtMY9b8wJzGMZwUxtvZGdjy2QU782IuAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbelpyT0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbelpyT0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708355199; x=1739891199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DCAxzfXqTax5T11aXU0gJP0t0VjNv7GMA3otlVXbuV0=;
  b=NbelpyT08Fn9zO5T7boXSV3UD+RCUzalRxnq00otNEaIzmBIpoOHi3wR
   qMBZ4nWjeeA4xJGjHXqTQM6TczDOfU0c1dWJ/zvqYkXt7WxKJZQyLsnPk
   7UqJAe336U8yIqASBGaUkc3RBIKMyoLhBStqC7aCNrrI5ih4jk93QD6Cd
   0RJXIKe6XwGavlodwip8JEHtJNdXPbbuEbFbogwyyBT0lQJs1h9Wg0ymZ
   TcXdjqo15xb86cxQUfqHW2oR2KehnLiwDRoQfMhcShK7FgiY1N8Rp4QGF
   Hclp+LfxulRIyeYYeAO9N/AvAiPOK7o4F6Yno6XiCmwb/W6VV3HGhnx3p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2543808"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2543808"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 07:06:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936302996"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936302996"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 07:06:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3BB8F499; Mon, 19 Feb 2024 17:06:29 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 7/7] serial: 8250_exar: Don't use "proxy" headers
Date: Mon, 19 Feb 2024 17:05:03 +0200
Message-ID: <20240219150627.2101198-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240219150627.2101198-1-andriy.shevchenko@linux.intel.com>
References: <20240219150627.2101198-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index cf1abe2fc28a..2df2c9ea7b34 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -6,20 +6,24 @@
  *
  *  Copyright (C) 2017 Sudip Mukherjee, All Rights Reserved.
  */
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/property.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/tty.h>
-#include <linux/delay.h>
 
 #include <asm/byteorder.h>
 
-- 
2.43.0.rc1.1.gbec44491f096

