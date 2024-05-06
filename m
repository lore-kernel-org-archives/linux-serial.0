Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950D15A5;
	Mon,  6 May 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004195; cv=none; b=FZ5uu04oW6hsO+bWSf47VASTssytQSTOuiy+eexNquRBj0KdVfrRNbZE1cY9meUERrQpE6xvQeTzT8WqkBZAFJBnfNZiWViWtjW9nXUc6lHwqs4iZbdqI0QGZa7pmmHCKKHpaWmt9pwp/F+wf7OmLChiUeo8N17/lBnTef6VTVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004195; c=relaxed/simple;
	bh=Oko6qyl/DyMOeA6UjvXnQlMJ/N3qQuVxX7CEGCjb85Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Td2T6sDa2dGb4SEqTBoG7RL/D6pj2/CDZGC63hL2lZErPMZ4GvOQy0fjFWxaD2AoYV85F5Lxaj91MdcQwf/tvl+IFqXUqxu9JK1MBpmxMYOpoEwByY7X4/kh4PCqO+glICf+DB0Pe3DSkp67O/9cDPkKLQfLvgmrDP8hneXUZaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mR4Faqlp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mR4Faqlp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715004194; x=1746540194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oko6qyl/DyMOeA6UjvXnQlMJ/N3qQuVxX7CEGCjb85Y=;
  b=mR4FaqlpCTLG4a+NkdmPtX53ZNeXqnTNDfNv9ghZmY3hc2EDa8NOZ3qw
   iHvg6h+p0AUBEKyRd1IUgE94HoxAgzWtZ9HVWOae7lDT/kfXSs4WL/J6+
   aE+B62bMVYGr0Hx8TlYZIWE4FopgGGtbBut6lMModQxA5fFsq2LlZIBVa
   vVbgvayEGVvC7ENh+smn4jrfBk/0+RGq3FYMm6uS7yl2SBUjsyBpP7EM9
   gc0RmarFSI2H8BBtWym/Ebia6+j8b2g2c/rBm/h9e8BlMCsilOjeTRzf5
   qPMQMEn2DaoaFXtZssAuU1UI4XiKwrXathUROSDsJ0fcXAlZBCte7CND3
   Q==;
X-CSE-ConnectionGUID: RiFUW964TM28Pr4LM4rRKQ==
X-CSE-MsgGUID: ZI6dKZWtRViwBgMRuDIbYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="28275272"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28275272"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:03:13 -0700
X-CSE-ConnectionGUID: Em2rfz5ASzWtBWjdEmziDA==
X-CSE-MsgGUID: 5I9QPbpIRbecRTv+EFsAcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="32763370"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 06 May 2024 07:03:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A0649161; Mon, 06 May 2024 17:03:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Lindgren <tony@atomide.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	unil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 0/2] serial: 8250: Split out platform and RSA drivers
Date: Mon,  6 May 2024 17:00:57 +0300
Message-ID: <20240506140308.4040735-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split out RSA and platform drivers from 8250_core.c. After this
the core source code becomes indeed like a core library without
any specific drivers in it. It also helps with further development
of the platform driver part.

Andy Shevchenko (2):
  serial: 8250: Extract RSA bits
  serial: 8250: Extract platform driver

 drivers/tty/serial/8250/8250.h          |  29 +-
 drivers/tty/serial/8250/8250_core.c     | 464 +-----------------------
 drivers/tty/serial/8250/8250_platform.c | 339 +++++++++++++++++
 drivers/tty/serial/8250/8250_rsa.c      | 133 +++++++
 drivers/tty/serial/8250/Makefile        |   6 +-
 5 files changed, 513 insertions(+), 458 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_platform.c
 create mode 100644 drivers/tty/serial/8250/8250_rsa.c

-- 
2.43.0.rc1.1336.g36b5255a03ac

