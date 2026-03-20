Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1CA2ED846;
	Fri, 20 Mar 2026 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044512; cv=none; b=kJmq9jJI4qdCZU2f4FMbgNyuXZxJ5/HOwjsV7E2FX7zwt1O9YI6el3FHHYLhMcOT4bE94mPh6pmUpWvkRl9wDzXXUnmB6LkxVQ6dlSttzVvVB204oZe2l0c7w5tXWzmXO52gAQjsxBDKn91CPdxZB5KKys3enGuM4UFbFe8TInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044512; c=relaxed/simple;
	bh=FaZ0aLusP0pFPS2jA5Ih5uKpG/m0MxKuEKIdtPOd6v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WoAVTZFHnTor+VEOmhBfI1QPKWhev/uAE38YLnokudhBeMm3/sDeTp4Ep1nsvwe9YEQmcJC41Eo86zY9042dB7bCIkwvHiy/HxVtt9RUCwECydSlnHMD8JZ81jFrnPSMf4WASo7JTyZxV997FAxEkkKr+kBJNiOn3Tn/DLQftDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jP0/4k0G; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jP0/4k0G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774044511; x=1805580511;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FaZ0aLusP0pFPS2jA5Ih5uKpG/m0MxKuEKIdtPOd6v0=;
  b=jP0/4k0GqVjU9Ybi8t3Th3g8Xx/XrbW1H47FQmEeuBV42mq2uVsK9bR7
   Phg4zB2a8qmJ3+104ieIlzfSKackHFo8zHUhGQFz1uAYddTlWATkBzYUw
   sYrIQeYObiSqUmotY6p1IGe8pVZjCpFbTTlcQ2WLA8+RD+g/Y+jf62dce
   75pR4pwfprC+G8h6GBpEv/keN63E8FZHdzDlmJAX5Dwshc3sz0Uf3WhVr
   GWZ1/eBtjqGJk0yFt8bL9I0fnhi2jRWugA2pNPl45dEMMhXz4I20EaR0/
   oK6c+GXrImAzrLiGS/LidrpuP3f4tPnahlbsm+lGEwe1ZiDX1ahOD1K9G
   Q==;
X-CSE-ConnectionGUID: Mt7lTa8DQCWSSwEPtKq2lA==
X-CSE-MsgGUID: a7Mfs8MfTWS+TwOv7nxqCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74841436"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="74841436"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 15:08:31 -0700
X-CSE-ConnectionGUID: Ayl5QMB1Qv6Dm5vGfOljew==
X-CSE-MsgGUID: XAREnRUaTBCm/gJqTw/umA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="223398209"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 20 Mar 2026 15:08:29 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2620595; Fri, 20 Mar 2026 23:08:28 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: xilinx_uartps: Drop unused include
Date: Fri, 20 Mar 2026 23:08:27 +0100
Message-ID: <20260320220827.3237499-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver includes the legacy header <linux/gpio.h> but does
not use any symbols from it. Drop the inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/xilinx_uartps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index c593d20a1b5b..a072b75dbaf2 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -22,7 +22,6 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/reset.h>
-- 
2.50.1

