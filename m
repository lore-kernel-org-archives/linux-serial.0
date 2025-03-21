Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863611E5B83;
	Fri, 21 Mar 2025 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581290; cv=none; b=s1KF2mZh4aHWZdOhqwY5c2PmUGYLei8LdTI5J6gY+M96nod6GgqvzJt1LVcXWzK6zsAnDjYTa3N6KAoov3eivvVC9lCwBdUyKqax5kK26rYs/72nel9fadPPeSbSjEwUJIyS00anEBJ996mqd8Kjfvc3sJPSHMmWiv2e5msxk6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581290; c=relaxed/simple;
	bh=J1ERQ49XFhRMmrZp0nFoXvG1e9ijz8mIl3/GdWKUuO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2JWvHFkc3T+1u/JQgjBpB+v7z0CdT19hzgoQkJUkK9pkiBTlwpG4y8LhtO4ZYlg+N0nB1MlX8b5Wh2+7aGVwryAoimPC/q67OtyM4g01Nj2bb+zl4bm4NVd49qnWyV5tVXM5kFVSBiHwht2bm1hWZUwL4/50F17c8A2gJwHASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0/cOQyX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0/cOQyX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742581289; x=1774117289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J1ERQ49XFhRMmrZp0nFoXvG1e9ijz8mIl3/GdWKUuO4=;
  b=b0/cOQyX0PcsR9/CWw0JAFRSTg3rK+Gi9IQpaOZJGrwhO6q8NYVt4b3+
   OaofwFvsvPZlmCURJGxlEoiaHTlgp8DDXelErEeNubJYz4lXfvX1yf5Tc
   CJZByrcRaAPLjaZHwlxxhz29U5WWfspjIvWrWPfi/GXNCvmCweZ+0PYfL
   UFcwWOhP8ORNdI/8YFoppkLceU6J/U865tmLnR397z/NnOqibh+zYCslt
   M4abLWm0h6lR7ujWAM9F17QgaAm67RvvBeWooVa0IFYiAEQZOXVy9mz5c
   dVqn2WdIWKoowMsbpyNefUMg6cTcmexhKHExbowVFGZMPsXEd7Xgs+xzj
   g==;
X-CSE-ConnectionGUID: WtSuJHUzR6CFhRv2pszoTg==
X-CSE-MsgGUID: Mh3ph7gTTFakdaRIBxT+jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="69212006"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="69212006"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 11:21:28 -0700
X-CSE-ConnectionGUID: x+E9T7JVQoKELHzKuE+3Dg==
X-CSE-MsgGUID: 6sBk/X3uQKG7LQNmG+EtvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="124423520"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 21 Mar 2025 11:21:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9BCB314B; Fri, 21 Mar 2025 20:21:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 0/7] serial: 8250_ni: Clean up the driver
Date: Fri, 21 Mar 2025 20:20:11 +0200
Message-ID: <20250321182119.454507-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The newly introduced driver inherited almost all same issues
that 8250_platform had and others. Clean up the driver accordingly.

Andy Shevchenko (7):
  serial: 8250_ni: Switch to use uart_read_port_properties()
  serial: 8250_ni: Remove duplicate mapping
  serial: 8250_ni: Switch to use platform_get_mem_or_io()
  serial: 8250_ni: Remove unneeded conditionals
  serial: 8250_ni: use serial_port_in()/serial_port_out() helpers
  serial: 8250_ni: Switch to use dev_err_probe()
  serial: 8250_ni: Tidy up ACPI ID table

 drivers/tty/serial/8250/8250_ni.c | 89 +++++++++++++------------------
 drivers/tty/serial/8250/Kconfig   |  2 +-
 2 files changed, 38 insertions(+), 53 deletions(-)

-- 
2.47.2

