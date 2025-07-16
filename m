Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B628D845;
	Wed, 16 Jul 2025 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659080; cv=none; b=ehrqnD9Bp2bJuHcieDL3Izfc7K73wtPR1bIkzwnE+ljXiNM6ysfpaYqWxYJLsAKxlINDIhg6WglgJYTXdrx367B7C3N6mq14nFS2f8nn0g1RGXs/O/AQ8XXnCXCxbRIrKM6M5/OcF0xz0ocagAjjXWMAHG1Y69rIJjF+A/zzynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659080; c=relaxed/simple;
	bh=70dnor/nTD+LjKVjPMg3BV0opu9Xv/9P+qFJTnpt90w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UuktR7QdYOKv5/MMH9/r+1A9L4PPgF699y5AGFmUioGYN4N5hXnZYUQ+RfPLHZpIqXVhHgfZQ+SifIdfjcuv3LFTN4PcX6+5h9s8LHYgbMFbwP4YU++ZKjyEAgtXC3rMwWmvmjKxE2XlSdZkn6zoHbdhd4xcA/w96efrj8eV6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzNiHclz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzNiHclz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752659079; x=1784195079;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=70dnor/nTD+LjKVjPMg3BV0opu9Xv/9P+qFJTnpt90w=;
  b=MzNiHclzRTKqjWnfsfayCQgGUPJOJoDeTZuifEnGvYDD6y+OnXD6TUHh
   J8Uxw34Bw9amP3h8SN8tOQMBQPWUpDTGGQ5zzOE+iUCSQE1QW4fafBAI9
   l7vFAiIPfx4q4+KkQNdApqOclkE8+JJ2PgajLmcadYFchV31XFSpZMpfe
   wJnfE3OuXMkV1delqT/d8LmpL6yrg7tc1OuoZP+ys8ce5Ee8FMp2sTD1m
   RF+UT9CbTCsz6gNGAkCWjZe2ICe7uWiuGnZupObAzmIqe41RvqCm3wFpJ
   y6rRAXev0Pwttj42GeVR8jpQsT1yEhBdoToQHvzCYVT8/eK/E7lsypsJW
   A==;
X-CSE-ConnectionGUID: EDPC3rrrTomCNVI+VkMxVw==
X-CSE-MsgGUID: dP6jM9zUSxCeTrXwGFRHbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54605666"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54605666"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:44:38 -0700
X-CSE-ConnectionGUID: r84Ue1x+TqqT7f1gLzea7A==
X-CSE-MsgGUID: DC39NBUpRmyecJF4o7yc5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157125367"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jul 2025 02:44:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 744FF15E; Wed, 16 Jul 2025 12:44:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v1 1/1] serial: 8250_ce4100: Fix CONFIG_SERIAL_8250=n build
Date: Wed, 16 Jul 2025 12:44:33 +0300
Message-ID: <20250716094433.1611477-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On i386, when

  CONFIG_X86_INTEL_CE=y
  # CONFIG_SERIAL_8250 is not set

will try to compile the driver and use the stub simultaneously.
This breaks the build. Fix it by making sure that the driver
compiles only when CONFIG_SERIAL_8250 is also enabled.

Fixes: acc902de05b2 ("serial: 8250: Move CE4100 quirks to a module under 8250 driver")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/r/cdf4ee46-7bf8-4379-9245-fed9db72e7e8@infradead.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index e61dc3f4ca50..1d6633bbcd70 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -24,7 +24,9 @@ obj-$(CONFIG_SERIAL_8250_ASPEED_VUART)	+= 8250_aspeed_vuart.o
 obj-$(CONFIG_SERIAL_8250_BCM2835AUX)	+= 8250_bcm2835aux.o
 obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
 obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
+ifneq ($(CONFIG_SERIAL_8250),)
 obj-$(CONFIG_X86_INTEL_CE)		+= 8250_ce4100.o
+endif
 obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
-- 
2.47.2

