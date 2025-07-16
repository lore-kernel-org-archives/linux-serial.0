Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7E1C6FE1;
	Wed, 16 Jul 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675862; cv=none; b=kdeS3rr1fCs4ZuldPwR3KBK4YQNNM996W9ZetJMhc+9+kFOQWIr7Sh94HF4+mzKFAupppiHM+kq9T8eS9MM9IZkKA4xGFV6Z92BhFe32qYji2HY58Bg8Nai9C0atdVYyoWrDjQ2Npbk26u0+nqChF6VfEQvkHfmI/0qvJGeHa8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675862; c=relaxed/simple;
	bh=9iFiwZsbUWufy7CMKXd+dpYhODGLLoUtHQRWH2Oomkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tegROHqSg3XYLLgIphoIJAwSs6DaxwWF9iLYvpdEguIoevRmLdyJtopcjCsmB1aw3RoTbPWMHYjnDOXJ8l6iZ4at+xz0+MzE6TCUrgNRn4Og9xx3M4hQqkSTaiAkOkJ3rDNzMjZIFQfirckplOiF1GX1Y15vY7qG7osPuH6rWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dx8fYAvZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dx8fYAvZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752675861; x=1784211861;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9iFiwZsbUWufy7CMKXd+dpYhODGLLoUtHQRWH2Oomkc=;
  b=dx8fYAvZuo+S9BcqvsoPEp9fZWK3/twSiRrie4bvFHczZI8Wj8aZNxaT
   g4BdSytqe/NwtGSENnMdQQriZ6Y5fIeFe/lAzQdgr4LrPQmG37avMq0gO
   1AQ7qXuf9w3IeQV3hu1VVN0AHW4rAlG0I/UYxcUqaGEmZainH3t1CPDSb
   4oNsramPywvSHWmA5zT3Vo2c4xkqy9ZwnFv5D5Rrmn9DcCL7pVE6OBrTZ
   giYKBFiodQnLpQLtVCN9haRD8mgORqHKOF0/gDyiveqUaoUTE3ul4r5/8
   DO3RMqW8T7txlYahG9N/lyBOeRtYf2OrNSyHOlsffINZWqa/9jyMkX9u0
   g==;
X-CSE-ConnectionGUID: kcp8ro7uR9W4Ebj2Us2XKA==
X-CSE-MsgGUID: VYOIoswYTC2BLWMINbs4Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54139234"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54139234"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 07:24:19 -0700
X-CSE-ConnectionGUID: MHi3BTheTZOzWEU4voUW6A==
X-CSE-MsgGUID: M0IU6w7ZQm+yBXVNrxnY9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="157607494"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 16 Jul 2025 07:24:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A4E5DD5; Wed, 16 Jul 2025 17:24:16 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/1] serial: 8250_ce4100: Fix CONFIG_SERIAL_8250=n build
Date: Wed, 16 Jul 2025 17:23:29 +0300
Message-ID: <20250716142412.1667927-1-andriy.shevchenko@linux.intel.com>
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

it will try to compile the driver and use the stub simultaneously.
This breaks the build. Fix it by making sure that the driver
compiles only when CONFIG_SERIAL_8250 is also enabled.

On top of that ensure that CONFIG_SERIAL_8250 is actually set to 'y'
and not 'm' as the later makes no sense for this platform. The hook
may only be applied during early boot.

Fixes: acc902de05b2 ("serial: 8250: Move CE4100 quirks to a module under 8250 driver")
Fixes: 5ec6960f6f0c ("ce4100: Add errata fixes for UART on CE4100")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/r/cdf4ee46-7bf8-4379-9245-fed9db72e7e8@infradead.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: made the fix more readable (Jiri)

 drivers/tty/serial/8250/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index e61dc3f4ca50..513a0941c284 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -24,7 +24,9 @@ obj-$(CONFIG_SERIAL_8250_ASPEED_VUART)	+= 8250_aspeed_vuart.o
 obj-$(CONFIG_SERIAL_8250_BCM2835AUX)	+= 8250_bcm2835aux.o
 obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
 obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
+ifeq ($(CONFIG_SERIAL_8250),y)
 obj-$(CONFIG_X86_INTEL_CE)		+= 8250_ce4100.o
+endif
 obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
-- 
2.47.2

