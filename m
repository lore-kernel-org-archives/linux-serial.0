Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA401156649;
	Fri, 24 Jan 2025 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737735342; cv=none; b=puL/UHZhNXp9pAIaundeeEh47K/09DdWa+aQXr648v1g1BCv5ihgRdkdPKcbtToq7nCJs7tTSv/nqgl57umggdvaja2DVSeeVnRdQQ4pXCk5fhqT/NOIYKjAxxn0kywR/ZcezBw9V39R5BPIIT5zF2oVTecYKWWIhbDRbqX31cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737735342; c=relaxed/simple;
	bh=TH7L4mKRjhmX6jD3uQeFxt0u43d3bbDHQ6dNoerFiWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMa4f7dBcqkn7xtbi4ZXryt81MNfU5/On9CWNaEz4ZWObvaHUUr0xtia9UGR2x5I2Xz5XOyW5hlCCIT2XbqrsfCmjWy/8seXbpr5cc1rSO2iho0VC81wRSJNNWgJRSIEmJ9dzCNjaBAxozpbkgV1agEhi3cFm2ynALxkootKEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1NMyrke; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1NMyrke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737735341; x=1769271341;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TH7L4mKRjhmX6jD3uQeFxt0u43d3bbDHQ6dNoerFiWM=;
  b=k1NMyrkerxxYOZtep9s+dsKPRE3u19PNhF4a3psJJgaQ9HBjMzrmwOFU
   FacHz2yp6bGfcGEKzuKzao/F3NAnZqvCv5BgHEyPp1bU15B9ea4zCLgDN
   +6vyUkO1XCszzi4vpPXPUe+cuQXN4m5zcF+pBFEx7dPNtrw0wQglG+RyI
   2we4uuvKzGNuMYSSqZEcE+g1J4cxQ0LIdDgjLAcw4fNjlXWIaDbSH4yyc
   nI8SV9zFPf0QFPpnZpTbVMNIGt71bdDh3/vWLaNxkQJjwRCMyAkxMgKFZ
   Qyvw5djY6WFBWCIHkjnn47vZcDk0cjKPo22fSe9lxLHJigpiW1/9lgTOg
   Q==;
X-CSE-ConnectionGUID: KZ/pcS5GRmakjwqEV7h1ug==
X-CSE-MsgGUID: RyZ95C4SR3u3M4MU8KOhwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="48858229"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="48858229"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 08:15:40 -0800
X-CSE-ConnectionGUID: 5K407B0+QRO3ih/WMTZ6tg==
X-CSE-MsgGUID: m+yXepOoTSyaQu7aabkHqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107659122"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 24 Jan 2025 08:15:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9AEC5197; Fri, 24 Jan 2025 18:15:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 0/6] serial: port: Fix UPIO_PORT iotype handling
Date: Fri, 24 Jan 2025 18:10:45 +0200
Message-ID: <20250124161530.398361-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It appears that the conversion to use uart_read_and_validate_port_properties()
broke 8250_of driver for the cases when UPIO_PORT is required.

Looking at the code there is an opportunity to clean up it a bit as well,
hence this mini-series.

Patches 1 and 2 (and 1 is most important) are the fixes to the helper function
followed by patch 3 that makes code robust against possible future changes in
the same area.

The top three patches are post-fix cleanups.

This is done in a series, but can be split to fix-series + cleanup-series for
the routing to the current and next Linux kernel releases. It's also possible
to route all of them as fixes as they are toughly linked to each other and have
not much code changes overall.

Andy Shevchenko (6):
  serial: port: Assign ->iotype correctly when ->iobase is set
  serial: port: Always update ->iotype in __uart_read_properties()
  serial: port: Make ->iotype validation global in
    __uart_read_properties()
  serial: 8250_of: Remove unneeded ->iotype assignment
  serial: 8250_platform: Remove unneeded ->iotype assignment
  serial: 8250_pnp: Remove unneeded ->iotype assignment

 drivers/tty/serial/8250/8250_of.c       |  1 -
 drivers/tty/serial/8250/8250_platform.c |  9 ---------
 drivers/tty/serial/8250/8250_pnp.c      | 10 ----------
 drivers/tty/serial/serial_port.c        | 12 +++++++-----
 4 files changed, 7 insertions(+), 25 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac

