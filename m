Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099CB149C4A;
	Tue,  1 Jul 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377326; cv=none; b=VopDRPOBFDsVy6yIK5kXowM4OIiPpYCDw0IU1WgFptm408xy3xpVnhszFXnLSnxC0a4mti5x53r5na6Tc2mn5oHVWBlq7Oxl+71MPRM25XBo8a5n2vG1Ig4gnDWqHt5Iy4QXsJX2JYLEx3yHA7ziLpmZKrStFMUNxUmTkoueOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377326; c=relaxed/simple;
	bh=ZvBmRJCbf4BqcFDviY6wG5SRoxs4TwMRkF6Krn1jX2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHw0c54PvXMO1H2sil65R+2kHxY++F7AJbIn3vl4lpmja0lh3BXp6WAvxGl5sAd5VoXDXmtNBqEGCshyU1wp2M5qL+hIZ5S5pAG6hsyPu3WgsWWG3KOP9ycIceuYIpJkzrX+CxQyfFV25lvChOJEjDBpTorEmuXDGFWMhg79kHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Raceko7F; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Raceko7F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751377325; x=1782913325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZvBmRJCbf4BqcFDviY6wG5SRoxs4TwMRkF6Krn1jX2M=;
  b=Raceko7F5jRq22ByR5bVvvuVZQXNbG1QM5nDNk+/izFyicRhWypIo6ha
   +r1o1CkMHjfzUVKO6t4S9LGroZkhjU20LrW838jha4fTGJA31HX7u56Rj
   BxCRBWW4jg59OvmxSJEeqyYaexY0wkgmHn+t9fFcz96OwjLcIZ+e4Wj1c
   TDmQji9r5oCMb4XsC9+6j6JRjkHmR78s1+IkM7vKseUxL5uT3PTsgbgJM
   retvWvk+iX3aYBSjx3uBW4IOJ3EUfsHLipaFF1tgV8mo6xY45CseZrhu7
   W8cvgFEE8e6mHGLs9eQXxh8rSmw14humtmIRp+YhTe1sm9tPi9AXKyOUa
   w==;
X-CSE-ConnectionGUID: qvMWPT/aQcqrtcQusfPX2g==
X-CSE-MsgGUID: /1WevgExRRGnSBtuTNokhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57419909"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57419909"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:42:04 -0700
X-CSE-ConnectionGUID: hXhPQhIYSMiQrftxilxcNw==
X-CSE-MsgGUID: Z8lAHxDtQ9mtolWAB8bVDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153858497"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 01 Jul 2025 06:42:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4C6C315B; Tue, 01 Jul 2025 16:42:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] serial: 8520_ce4100: Reuse mem_serial_in() in ce4100_mem_serial_in()
Date: Tue,  1 Jul 2025 16:41:38 +0300
Message-ID: <20250701134200.2621898-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In one place in ce4100_mem_serial_in() the code may be replaced with
mem_serial_in() call. Do it so and collapse two conditionals into one.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: fixed condition (Jiri)

 drivers/tty/serial/8250/8250_ce4100.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ce4100.c b/drivers/tty/serial/8250/8250_ce4100.c
index 3dd88f372a51..81dfb2adbabd 100644
--- a/drivers/tty/serial/8250/8250_ce4100.c
+++ b/drivers/tty/serial/8250/8250_ce4100.c
@@ -35,13 +35,8 @@ static u32 ce4100_mem_serial_in(struct uart_port *p, unsigned int offset)
 {
 	u32 ret, ier, lsr;
 
-	if (offset != UART_IIR)
-		return mem_serial_in(p, offset);
-
-	offset <<= p->regshift;
-
-	ret = readl(p->membase + offset);
-	if (!(ret & UART_IIR_NO_INT))
+	ret = mem_serial_in(p, offset);
+	if (offset != UART_IIR || !(ret & UART_IIR_NO_INT))
 		return ret;
 
 	/* see if the TX interrupt should have really set */
-- 
2.47.2

