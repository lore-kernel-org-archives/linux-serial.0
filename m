Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E231474C3;
	Mon, 12 Aug 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477747; cv=none; b=CC98rkvobU+5haxstl0PE1MwkfYBK1bZnUdEBMT47gbDzK9VPH5t8vJta2QwjSu7iVQHC/etK40D4cC4en+0FWYak84eN9kcQ/ef5FmNNKf0osYL1XYZ/Z/64EFhbat9c6aARI5ohXXIcSzFBHS6WwcXxBqA6pNmczRcolBUHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477747; c=relaxed/simple;
	bh=QLYD+X6576Kj5K4QL4b16JOYtspAfRDomvmS6wFuHdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVs2JgtzmuZH9q+j1rbEjIutLByAwfifC4W5pl/P2JyJK2C6P9WVOBHq4kdF6iE6qgHVIrd1rFiBIsnvs+XXd2peq6EmQms/lqK3QWNrHJPtLTGEtwpFpEz7gy5ZlblxNQ7BlYjT/OVu2f5PPEpsrkrPhFy3e+xMXf/Y3l0Emdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MR7KRmL8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MR7KRmL8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723477746; x=1755013746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLYD+X6576Kj5K4QL4b16JOYtspAfRDomvmS6wFuHdk=;
  b=MR7KRmL8LyeFsKDieiHATVvavsKjFodRWABFS78IU6v5uAASuHYzwc4P
   Gs46IfpI81vubofOPz4fYs7tUxRTCMxfUWWDJrmVYqcwCVL6rPkiYOaTF
   V+YzS6BA789UPd7qVfn6wXBSys+w/dMw3/kmZfyvo2xgrDnWNrrPwxA9Q
   sevsiCxE/lR5fre/GiIVp99JaEM2OLlN763vE420FynY67sgSFayZfT7x
   f2MFoFN7IL06xj82JvOZTvz1ev7EVLhv2vSRCnWzn2eUtVh0/Ix3b+6Ki
   /hmt6NuuqJktBzxf97KThMz+F6nmmg3gqi8q6We6ggt4kigBGAn0siYaM
   g==;
X-CSE-ConnectionGUID: 5JsgLmSlSsKETnDUG3p+Jg==
X-CSE-MsgGUID: ClZhDoiZTtysz3J88WWW2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="46998236"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="46998236"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:49:06 -0700
X-CSE-ConnectionGUID: wu/d1wQQTSi3QFwEC2sPpw==
X-CSE-MsgGUID: 59tjK9wqQWe6sHcKnjtDBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="62959168"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 12 Aug 2024 08:49:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B698F15B; Mon, 12 Aug 2024 18:49:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 1/7] serial: 8250_platform: Remove duplicate mapping
Date: Mon, 12 Aug 2024 18:47:03 +0300
Message-ID: <20240812154901.1068407-2-andriy.shevchenko@linux.intel.com>
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

UPF_IOREMAP is for serial core to map the resource on behalf of the
driver. No need to perform this explicitly in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_platform.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 73002faaae4b..a0e71b03015a 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -142,12 +142,6 @@ static int serial8250_platform_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (uart.port.mapbase) {
-		uart.port.membase = devm_ioremap(dev, uart.port.mapbase, uart.port.mapsize);
-		if (!uart.port.membase)
-			return -ENOMEM;
-	}
-
 	/*
 	 * The previous call may not set iotype correctly when reg-io-width
 	 * property is absent and it doesn't support IO port resource.
-- 
2.43.0.rc1.1336.g36b5255a03ac

