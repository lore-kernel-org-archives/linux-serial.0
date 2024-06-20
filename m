Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE2351016;
	Thu, 20 Jun 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887570; cv=none; b=uIlU+zx+tYwovJgAzEUwh7wYnzfUgq+CjcPwQcfDW9eRBpAFD5EUpOF//6Nihw/acMm1f/UlyTcc6rOxAH3MsoB07gYIcxdRhTbnwUqiN3/JV9OFsmJTfTI6wk8y6XSTx0zx02H5cj+1jadXy3F/6/uULw0mMX26uFmLr6j7dg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887570; c=relaxed/simple;
	bh=dRvHz07AuwR9uE2bzGqCPI1tGZ4hBQrYmbiU4GczRC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQ1M9wel5C+xeBZCsDHw/WsW8+Pnotw9SuFREfien2ssziCOqsLSfmGAU4FGKf6kt090bwkEvnxqJyzmVMBg6lknB7gy40uS8hoxCBiH+o7PWM+MmT9vMYtIZ6rKcIhgZhMcHz9ydmS2ju8iPVhzIY+4+YDhsBEb44ZqyQzCBaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0zhj8kc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0zhj8kc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718887569; x=1750423569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dRvHz07AuwR9uE2bzGqCPI1tGZ4hBQrYmbiU4GczRC8=;
  b=F0zhj8kclp8jOrHXjE/s+oM9HV6hi7PTKQZWfoBLdufTlk8AyHXs/co6
   2zUp+nLg0s8SEYMqWxCSV6HIUIIjgSPNyNcSn3xU+Chfaq6uZMxBTCUwb
   hBsuE/5LX4u3zxLRvHmBM1fDb6tPnd5QirfNF+9rP1YvHiF969QU/Y7LX
   m/eP62RArTv/uiOl8ICwXTHNjvUflLIJKwaZFXkoIdrei7vX50a1IsQM7
   uFAs94dovWuu1w+5AexeqVcIIR3UFbD92Y/njT1QmLsjnVeOzUDSNX43n
   9thU0L+VH6fJgiD0Vts8+UiZ8AUncOuKCY5Os/+0xKe3gRnF74yqNzDjt
   Q==;
X-CSE-ConnectionGUID: 8KCHWjqdTPK4snxH+QhNHw==
X-CSE-MsgGUID: Xb8/vI+5QbOqzvCDsCWGoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="26985648"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="26985648"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 05:46:08 -0700
X-CSE-ConnectionGUID: PzqiClnJQKekorXeJd1UhA==
X-CSE-MsgGUID: WyAjNsV3SI2yUpebpf9rEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42888510"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO tlindgre-MOBL1.intel.com) ([10.245.247.35])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 05:46:04 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Fixes for console command line ordering
Date: Thu, 20 Jun 2024 15:45:25 +0300
Message-ID: <20240620124541.164931-1-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Recent changes to add support for DEVNAME:0.0 style consoles caused a
regression with the preferred console order where the last console on
the kernel command line is no longer the preferred console.

The following four changes fix the issue using Petr's suggestion that
does not involve calling __add_preferred_console() later on again, and
adds the deferred consoles to the console_cmdline[] directly to be
updated when the console is ready.

We revert the earlier printk related changes, and then add back the
DEVNAME:0.0 functionality based on Petr's code snippet. And we end up
reducing the code quite a bit too this way.

And we also revert all the unusable serial core console quirk handling,
it does not do anything for the legacy "ttyS" named consoles. And then
we add a minimal serial_base_match_and_update_preferred_console().

The reason we want DEVNAME:0.0 style consoles is it helps addressing the
console based on the connected serial port controller device rather than
using the hardcoded ttyS addressing. And that helps with issues related
to the console moving around after togging the HSUART option in the BIOS,
or when new ports are enabled in devicetree and aliases are not updated.

Regards,

Tony

Changes since v3:

- Revert the unusable serial core console quirk handling

- Add a minimal patch for serial_base_match_and_update_preferred_console()

Changes since v2:

- Use match_devname_and_update_preferred_console() naming and update
  the comments

- Add a patch to rename the serial functions to use match and update
  naming

- Use ttyname instad of chardev in console_setup()

- Split variables per-line in console_setup()

- Initialize idx to -1 for devname in console_setup()

- Add pr_info() statement when a preferred console is associated with
  a devname

Changes since v1:

- Revert the problem causing printk changes and switch to using the
  solution based on Petr's suggestion and code snippet

Tony Lindgren (4):
  printk: Revert add_preferred_console_match() related commits
  printk: Add match_devname_and_update_preferred_console()
  serial: core: Revert unusable console quirk handling
  serial: core: Add serial_base_match_and_update_preferred_console()

 drivers/tty/serial/8250/8250_core.c  |   5 -
 drivers/tty/serial/serial_base.h     |  22 +---
 drivers/tty/serial/serial_base_bus.c | 116 +++------------------
 drivers/tty/serial/serial_core.c     |   2 +-
 include/linux/printk.h               |   5 +-
 kernel/printk/Makefile               |   2 +-
 kernel/printk/conopt.c               | 146 ---------------------------
 kernel/printk/console_cmdline.h      |   7 +-
 kernel/printk/printk.c               | 122 ++++++++++++++++------
 9 files changed, 112 insertions(+), 315 deletions(-)
 delete mode 100644 kernel/printk/conopt.c


base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
-- 
2.45.2

