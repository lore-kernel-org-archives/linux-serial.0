Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5E1E521;
	Fri, 20 Sep 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847077; cv=none; b=NfVA5RPHeNpr4gH2yDRHMG3l4rz1lf81BTmV7ScRkcIzSRROFeg+Hpa0n35qpWnC8CXw6aHZ6QLaIRPzu99ZzpIw+14jR2YXTMAPCC6jarOzGNxBjTr93SA2cgYzUrQ2kFTbpO5TjQNR10X4Vc8RZbOgA8XZ3gEAAB4u+1+86NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847077; c=relaxed/simple;
	bh=fNcqIZINSyW+JPIfzlbqlSq/4aL6iT1F4ezJEhbY3nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QaicI1B/yEJRlq8O8EB/WPlxc7suebudiwCosT5mSdhq2B6/r8OO1oQLKlgrVk36ZdndEt1K6LIQLtirYAy/MCTmEQjDoH1ibQHY0j9qyLA4lymMUkCsALi4FrckAtDdZfT6dPC4jCZ8rALckPiUUrHAUF14Aec78tFnVXIK6qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnGkxcx5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnGkxcx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726847076; x=1758383076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fNcqIZINSyW+JPIfzlbqlSq/4aL6iT1F4ezJEhbY3nk=;
  b=AnGkxcx5FEuTOJpjW1CymIK6VIPO8+TgUl+6LjsO7FJZoTOfj1wRm64F
   wzB1Dy5eE5VD0lOYz30H04d1rVWDekent0r4s567moHAhY65/4tRI614q
   cxTV8VeFJFsPO3P8nLqRjQrgQw1N0J2C5HhMTUJgELef75FrP+fnMK8dE
   a2+wwqAwLdLhtd9K5kBN7RoIVzV4Cwhgkprj/VkACWgr5ecEe0RNpy/R5
   tSOuV5hkN46lIBo4T8cFHnpuW70D1FGrM3mrZT5XdJ5VQc8e7YyHgXQBA
   hKlmelAjz92RRUJTEEiq7hUV9AqVswcFs8VvllngrlXnzGtog5UfRRDn/
   A==;
X-CSE-ConnectionGUID: XQ/lm3tBTf6Gem1Sbg3esg==
X-CSE-MsgGUID: JE2lBPIvROa+TjKljZ5AYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="25686953"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25686953"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:44:35 -0700
X-CSE-ConnectionGUID: XZlebMGSTBmRTJhcX+DO0w==
X-CSE-MsgGUID: MwPH0EQnR42ZPGb6+5We2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70493941"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 20 Sep 2024 08:44:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 819911C2; Fri, 20 Sep 2024 18:44:32 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Parker Newman <pnewman@connecttech.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_exar: Group CTI EEPROM offsets by device
Date: Fri, 20 Sep 2024 18:43:24 +0300
Message-ID: <20240920154430.3323820-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not obvious from the first glance that the list of the CTI EEPROM
offsets covers three different models, let's group them accordingly for
better readability.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Parker, feel free to append this one to your v3 as a last patch.

 drivers/tty/serial/8250/8250_exar.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index b7a75db15249..072eb2bff01a 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -179,11 +179,13 @@
 
 /* CTI EEPROM offsets */
 #define CTI_EE_OFF_XR17C15X_OSC_FREQ	0x04  /* 2 words */
-#define CTI_EE_OFF_XR17V25X_OSC_FREQ	0x08  /* 2 words */
 #define CTI_EE_OFF_XR17C15X_PART_NUM	0x0A  /* 4 words */
-#define CTI_EE_OFF_XR17V25X_PART_NUM	0x0E  /* 4 words */
 #define CTI_EE_OFF_XR17C15X_SERIAL_NUM	0x0E  /* 1 word */
+
+#define CTI_EE_OFF_XR17V25X_OSC_FREQ	0x08  /* 2 words */
+#define CTI_EE_OFF_XR17V25X_PART_NUM	0x0E  /* 4 words */
 #define CTI_EE_OFF_XR17V25X_SERIAL_NUM	0x12  /* 1 word */
+
 #define CTI_EE_OFF_XR17V35X_SERIAL_NUM	0x11  /* 2 word */
 #define CTI_EE_OFF_XR17V35X_BRD_FLAGS	0x13  /* 1 word */
 #define CTI_EE_OFF_XR17V35X_PORT_FLAGS	0x14  /* 1 word */
-- 
2.43.0.rc1.1336.g36b5255a03ac

