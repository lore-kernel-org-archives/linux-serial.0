Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537618454A;
	Mon, 12 Aug 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477749; cv=none; b=WSJFR8EaI7R3Q4X9lyxqMBriDp2gZpqoShS4l9KiITgv/z/P1cOn4p1xh41tVOVoVPkikEHyrDG5P8n69+c9hI9Ls0txFL+Ziw3U6BQZAO2SdFW9CITLQFOqDnsj0K7HtNxumyU45segQ/1PZTn7xwdynA/9NYl3ZHd32GX85Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477749; c=relaxed/simple;
	bh=5Kopdko6zXiOKrV9ZoEpPqmlwIIEK2D2CkanedEvgb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZbhduQXRYEvtoYUntfDLrXWTYqlQX1hDlzHLq713RBdy5I8lexwhqhdj9578pBK7ZW69JXPKBJC4QVsVa6LhnjAMmnpRPm3c7MCe9N2b98rxkNpdIJVcYfeNnW3/6Pnp275obMdNq0+ZM763hIMcj3ncSUMkBRE9dXaR9DxSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hobEbXls; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hobEbXls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723477748; x=1755013748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Kopdko6zXiOKrV9ZoEpPqmlwIIEK2D2CkanedEvgb4=;
  b=hobEbXlsHSNTAB8jU53pcoqb9eVgCvgT0EyOnId6/46RD3jFb73ogVTO
   omi+FY6U2SP4E6hKryPd/lbGI2SzEELoti0Vebdk2G3GndLFFGZ+5nkCi
   YMuqVe4yfQ6kYOG/UihvVXUkWnNLoqLspD6RkSneqEmQ3uAa/RLFstjj5
   bYrw+cFvPpIAX0OkrR9LytQBVs3wqBtwhAaB1V+21zriO34e9ybE21Fxi
   FVpid+vckJoWPemz+iSIXsAbE3nrfp23wOrIwQsWeOiMW7LqsFHTnxf1x
   ikE51yotuWf/WE7s+1xw4g0neqDaXLaF5PnsPS2u/Dpjfgy7arQN0Gdef
   A==;
X-CSE-ConnectionGUID: 8pRgTAd5SNmREqF1z6hqcw==
X-CSE-MsgGUID: pH0+5OuMRZ+LXNPt6cushg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="46998241"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="46998241"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:49:06 -0700
X-CSE-ConnectionGUID: jRPZp5AZRzmnAZqIztvv/g==
X-CSE-MsgGUID: YR/2uDm6S3WaFL0wamAYnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="62959169"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 12 Aug 2024 08:49:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CA726321; Mon, 12 Aug 2024 18:49:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 2/7] serial: 8250_platform: Don't shadow error from serial8250_register_8250_port()
Date: Mon, 12 Aug 2024 18:47:04 +0300
Message-ID: <20240812154901.1068407-3-andriy.shevchenko@linux.intel.com>
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

Don't shadow error from serial8250_register_8250_port() and return it as is.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index a0e71b03015a..ffa2b7b690d3 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -150,7 +150,7 @@ static int serial8250_platform_probe(struct platform_device *pdev)
 
 	line = serial8250_register_8250_port(&uart);
 	if (line < 0)
-		return -ENODEV;
+		return line;
 
 	return 0;
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac

