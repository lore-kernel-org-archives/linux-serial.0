Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2EC1C696;
	Tue, 18 Jun 2024 04:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718686517; cv=none; b=YxvyzJJIOnfQQF4AVNtCZxf6AT3zIZtSKSw3wToubA2QHphmIp2zCQKOQoMlkleS0r/1rxqUKIftGyLfZz06e8rvOBcYn5a43SSZhD5hxqZN1htRFi3zw8eUbGpP93ZaHZ6QKb5bCz+aOUPfuxCwQeaZQ6Z7E4YY5H4tRQhpuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718686517; c=relaxed/simple;
	bh=M2pVLyEHrFkHoZGKgszLowRO4AoCl7i5X5fclrLSq4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNV+CfpniZHAzl8UHSYxpYUruNXz8jnnzlowoP+RK6sGeFYTPdTNGtUYVEjSbbxeWv02JOUSzhAjPVe8BLro91dmD8JS00pL8d5K1WU69sD+5pfB2CoMoIrnO6xNWkeEU7oudFcejb195Z4AHDPE0U6lAZLoT1lMLahTdpVKTAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/0iehmD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/0iehmD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718686517; x=1750222517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M2pVLyEHrFkHoZGKgszLowRO4AoCl7i5X5fclrLSq4k=;
  b=P/0iehmDwLfNMuwMdl2QBYoHOxO1SQ1BQ0/+GzRCzqQGeeEIfUqRrrq6
   DNbHZRBwnuTcTEbKTM0x8V9c9EJZDdqSEy//YYvWMDoztB+cpvx7ONlg3
   wPZb8dtft/udQGDi0j2EN/bFEqpW+Df75elbk9A6PxGyXg7RGNlKW3tdc
   6gsO8eU9/qz3nxK9l9th0DfFKEhLQ5nvqIVf43ikgi6jFhMzR7eZusu8f
   bZonydyksXJOfIjRq8sGArgSyoJNiWYKcX3ml0KYv0T+mopobU/eixYQi
   KHu8gvI76RyVBrtE0STQA+o0Yni5x8Ps2QDFB4lJ/Zj0Kbe8Jcc0qOVgO
   A==;
X-CSE-ConnectionGUID: bWCl0/U4QquyO5dJxy0S1Q==
X-CSE-MsgGUID: um5jVC5WT/+Xbe4soyIESA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15774298"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="15774298"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 21:55:16 -0700
X-CSE-ConnectionGUID: fQg+R2LnRlyZEg7D5Egruw==
X-CSE-MsgGUID: K1HKFqHFTWm/kT3vQwHOGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41507373"
Received: from unknown (HELO tlindgre-MOBL1.intel.com) ([10.245.247.4])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 21:55:10 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Fixes for console command line ordering
Date: Tue, 18 Jun 2024 07:54:47 +0300
Message-ID: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
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

The following three changes fix the issue using Petr's suggestion that
does not involve calling __add_preferred_console() later on again, and
adds the deferred consoles to the console_cmdline[] directly to be
updated when the console is ready.

We revert the earlier printk related changes, and then add back the
DEVNAME:0.0 functionality based on Petr's code snippet. And we end up
reducing the code quite a bit too this way.

The reason we want DEVNAME:0.0 style consoles is it helps addressing the
console based on the connected serial port controller device rather than
using the hardcoded ttyS addressing. And that helps with issues related
to the console moving around after togging the HSUART option in the BIOS,
or when new ports are enabled in devicetree and aliases are not updated.

Regards,

Tony

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

Tony Lindgren (3):
  printk: Revert add_preferred_console_match() related commits
  printk: Add match_devname_and_update_preferred_console()
  serial: core: Rename preferred console handling for match and update

 drivers/tty/serial/8250/8250_core.c  |   4 +-
 drivers/tty/serial/serial_base.h     |   4 +-
 drivers/tty/serial/serial_base_bus.c |  23 +++--
 include/linux/printk.h               |   5 +-
 kernel/printk/Makefile               |   2 +-
 kernel/printk/conopt.c               | 146 ---------------------------
 kernel/printk/console_cmdline.h      |   7 +-
 kernel/printk/printk.c               | 122 ++++++++++++++++------
 8 files changed, 111 insertions(+), 202 deletions(-)
 delete mode 100644 kernel/printk/conopt.c


base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
-- 
2.45.2

