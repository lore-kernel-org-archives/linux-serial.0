Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3276E181334;
	Tue, 14 May 2024 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713662; cv=none; b=Ent6coGtWNtYN0B/FobG6QW2u05depDh5ACw+wYDTKGiPE57U753BXsLKyFHV96Wd/hWvOlC0aadcpoGeApVVeV60fpx41B45WRg68vHcDxOT7uM8ujXNjFI9J8AGJw5by/yvIZWnniKQNi8CYBZ85gAayQQ+2XLYO/kIZVGsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713662; c=relaxed/simple;
	bh=GPfOGPBwuJ7d6QGXIRtIUDFcv8BCupl/0fECOFpb2B8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nh1l0oQ3AgkTDeLjTXuo605UHF6DSz5Q9FdoQdoKMbgEdSck/IcMd3iYG1I4ZY1E6qV068jBEYBo9ifndzcoZ+S5Ec/ff0rEtjeELUBEcB7mTm4gSgQOxjVvHYcfMB5fMm0/K28qqHerp9V9x0e/8fwC4xkelD419zaVwoiKZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFbQGN0H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFbQGN0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715713660; x=1747249660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GPfOGPBwuJ7d6QGXIRtIUDFcv8BCupl/0fECOFpb2B8=;
  b=aFbQGN0HGvKJYlZ4Y1uJK57fYYdMWDA9bpkURw4Qtp8Fw7NOBDEifnTv
   R1nagvar3Nxius1o4TUGDRyED3WTTFY8RZ2xqUlBozQTsVu6xcm32D6YJ
   3IwoNL3VnKKIB9SR0EGzqY51Gp0L+0SU8pEMQJr59w+cDpea0Bz2aBq/j
   i8avbTmSPg89sggvWCKYsBmK3CNheUfkbpcjebAaTnug1MsYKqq2yr/D5
   RuHBbj7/PGXo7tW84YnsaAAqugfxeu79PiDgAhtaPGaKZ1vrzd9re1ZIH
   behrFTxcuOtBMQoVesQf7UC3C7Usmrm590xdTLiY846QXFClWvNVuFsQm
   Q==;
X-CSE-ConnectionGUID: p2nIZ09xReacCVE/6GK+4Q==
X-CSE-MsgGUID: OwS+ZH60Tjm+4SKkBlZeuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11570863"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11570863"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 12:07:39 -0700
X-CSE-ConnectionGUID: +gQC/yFeTI6PruSHGMDMTQ==
X-CSE-MsgGUID: csmr+VY/REy7uDGOODztNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="61604414"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 14 May 2024 12:07:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3BEC6452; Tue, 14 May 2024 22:07:35 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vamshi Gajjela <vamshigajjela@google.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v1 0/2] serial: 8250_dw: Fix console on Intel Galileo
Date: Tue, 14 May 2024 22:05:52 +0300
Message-ID: <20240514190730.2787071-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Console on Intel Galileo is broken. Here is the fix and one revert that
I prefer to have as part of the fix to prevent similar mistakes from
being made.

Andy Shevchenko (2):
  serial: 8250_dw: Don't use struct dw8250_data outside of 8250_dw
  serial: 8250_dw: Revert "Move definitions to the shared header"

 drivers/tty/serial/8250/8250_dw.c    | 36 ++++++++++++++++++++++++++--
 drivers/tty/serial/8250/8250_dwlib.c |  3 +--
 drivers/tty/serial/8250/8250_dwlib.h | 33 +------------------------
 3 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac

