Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2661581FB;
	Fri,  3 May 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756785; cv=none; b=Pks86IWBN+jSGxxhp3610Z+j3/hdP1znYCpLLQk8e+JceTjZaNg/29Mv8e2SbCTYwUSm2qRA134mMXpu0AjZCTLyMecSe/ySIFRrwSvmUawDNaKKjsVWfTLsvMs1XHnTUvz3cy323IF1JgHc+kewXiuOuiEjuX/b9FR4i1OOeF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756785; c=relaxed/simple;
	bh=0VpPJMdPe+aSRC95rZ8nfI5XtCmL1qQshMgBSd3OLKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtGPzS+y/OKQI4xKq+uEKHpC1wtv/58GtlXmwRxJskITIGN5duik7XiD79t0HSj5DYFKMH14lK5RoBc/2fADm8tOxlD9NXvXOeO2fb2bJzNQrMnjGchyHhCcq/Do5A39soW9qdodgqvGku5r/KlVy3iyVGv2f3I+I6eMtPYtOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y37oYTX0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y37oYTX0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756784; x=1746292784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0VpPJMdPe+aSRC95rZ8nfI5XtCmL1qQshMgBSd3OLKA=;
  b=Y37oYTX0L5d+QYVQspM3YEfawBKWBHcaWOXPxK/5/zQZIEM3svxUoxw2
   AoSQ1rfF3Jli0y5bdmIba+dhitVszyucwxg1vznllL9v/RXL71fzANP4E
   lwmBOtDYObsjuSiiFNtNRGtydBWairhaORi1dt/wW7jiM+wv58kdzykrh
   3LlrPi6SHfiUhudiniyI7gnU6m0mFNG5URm/cQIPkrve5+hWfHzjhscj7
   3KwyscYMFwEufi2ekhYL60ckfUUKAJmBtJ0qsWw8aLqMy42iWjThsXKa0
   4/sxK+gM7k1V3sLG+UsRbmfoRHgQJ/vx4P6c0Ah9jpMbzRcAQBZo/y0ft
   g==;
X-CSE-ConnectionGUID: obqJYAdvQwOxKULMC+rv9Q==
X-CSE-MsgGUID: TtXohjfAQe2MZ1aT3nFD8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="35962097"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="35962097"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:41 -0700
X-CSE-ConnectionGUID: +xjUFJoCSuK7oSfxov+3Dg==
X-CSE-MsgGUID: 13uKQSYtSg2yXBTF5IIYBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28098199"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 03 May 2024 10:19:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4C29343A; Fri,  3 May 2024 20:19:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 04/13] serial: 8250_exar: Use PCI_SUBVENDOR_ID_IBM for subvendor ID
Date: Fri,  3 May 2024 20:15:56 +0300
Message-ID: <20240503171917.2921250-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use PCI_SUBVENDOR_ID_IBM for subvendor ID instead of vendor one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index ab0abc14ecf8..5405a1f463f1 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1752,7 +1752,7 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 	PCI_DEVICE_SUB(					\
 		PCI_VENDOR_ID_EXAR,			\
 		PCI_DEVICE_ID_EXAR_##devid,		\
-		PCI_VENDOR_ID_IBM,			\
+		PCI_SUBVENDOR_ID_IBM,			\
 		PCI_SUBDEVICE_ID_IBM_##sdevid), 0, 0,	\
 		(kernel_ulong_t)&bd			\
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac

