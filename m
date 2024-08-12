Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C9186E48;
	Mon, 12 Aug 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477750; cv=none; b=SoL0cdJPrZMSydaitKyY305UM2J6sqWq+JiiqhYDf+a7NZ7v8OhFXC5GV17CkDe3A7BBKuV3SglvMYsVNzagLSnGNVpFgbKSDnnfo20Z68RbBGLfRIX6UHCUE767Xc4yP/zTZiPDunY4YBSjlXnNm39qE04OZFtT2BFk2VoOJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477750; c=relaxed/simple;
	bh=/uuspCGzw0/Czr7dXMEqBLtRtDHoVsJNY8Ej51BqTjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLuad+53+pT8CZBoDwURfDK/ISg/B1P4B+HxFR8flTbkghFRiQvC5Zqji62A9EaMLWUVjRck0gy4LtY4SL53BXsirrGB53fVAE/xsWpwXMOwDywyS/kQf7BPOX8FyPmLvnIjdlxzdUG97PNB1yI2q4gG5DqafATejB/joO0mdTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFQ1+Ats; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFQ1+Ats"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723477750; x=1755013750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/uuspCGzw0/Czr7dXMEqBLtRtDHoVsJNY8Ej51BqTjc=;
  b=oFQ1+Atsvx8NP5zmLV8lKNiJ5GB1x1yUDdIlDEJOIeRqTil38McDFU+f
   /gXcUeRjJYbUciU7r1ACZ6MlaLlmD0Kq8UlRa9o1Hz4LKRVRrbULknUo+
   Zbr+Ppz6IbnhNF/1727iheuuRIuJzn4shVDLuRnb0eC4NZ2sayZusErmG
   t6AuRtrCfQAjMDXh4ZjTILXm/8Q59GFba6lN/ivHngcLktGlqgUjdhyD8
   qRED5AiKrwa9uV2wsqNcHvDjb1ZvCMylIF6E96izMA5Pg5w4tDm/4/hr2
   CMO6xka3E9OECV2QzaN5PNJ7fS0fWESA0tZh0CJ29yj77ELmav/LPoeBC
   Q==;
X-CSE-ConnectionGUID: rUcNXz2ETPOFX9M5p6eCxA==
X-CSE-MsgGUID: qH8m83SKQdmxXIS4s3wROQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="46998250"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="46998250"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:49:06 -0700
X-CSE-ConnectionGUID: VAVfEBMHTOCHmrP/WpaHPA==
X-CSE-MsgGUID: 940jORz9T8yoGkFu/w7jCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="62959171"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 12 Aug 2024 08:49:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E77E51F8; Mon, 12 Aug 2024 18:49:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 4/7] serial: 8250_platform: Tidy up ACPI ID table
Date: Mon, 12 Aug 2024 18:47:06 +0300
Message-ID: <20240812154901.1068407-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240812154901.1068407-1-andriy.shevchenko@linux.intel.com>
References: <20240812154901.1068407-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tidy up ACPI ID table:
- remove explicit driver_data initializer
- drop comma in the terminator entry
- use C comment style

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 937eea3ebdea..38c083e90a7d 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -261,8 +261,8 @@ static int serial8250_resume(struct platform_device *dev)
 }
 
 static const struct acpi_device_id acpi_platform_serial_table[] = {
-	{ "RSCV0003", 0 }, // RISC-V Generic 16550A UART
-	{ },
+	{ "RSCV0003" }, /* RISC-V Generic 16550A UART */
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, acpi_platform_serial_table);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac

