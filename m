Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37774A59;
	Thu, 13 Jun 2024 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283111; cv=none; b=eTxVkw/GrXs4kIhEAGgnx13ad3QKO6364kPpByiVhO+z/Pf/XjLdj1RAmwZYwj0SssGEo6e0QJ0PyRpJV9iR5Cehj+tF3g67BiOqEVOOHbmI02MANBd0FiwU80tClvDRLLLFWSj5PDJsIETdmwm4XBvhd7mI3avmF/EmusvdDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283111; c=relaxed/simple;
	bh=6LyP3wfrLYixy1o5n4KlFW881ICG5LISMvh5fSrySvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGoYMuM8Eqoo5s9cAfGP2M7+TolpyOPICc66xgIEQOmtxNPyVtkZ4L0XtXP9bqncks3dIEQpm4vVk+LwpmH/wpPnhp4gh2MIILJ8x07lt6mQqy2QfG78Bj5Fz+9GxZtOgRMGayoIn3IVdhZE4jr7vDpH+6wwPsknr61ZwzhjvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NU8dWS3l; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NU8dWS3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718283110; x=1749819110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6LyP3wfrLYixy1o5n4KlFW881ICG5LISMvh5fSrySvY=;
  b=NU8dWS3lDO09/5hQsWy5CIgTaeS/MmkLGYs8HG+jmwTJFmXiQObSW44Y
   4RBwwS05P94hHh74D8EvixndGWrwanTrGi1+B5u53HjvSDGUsLJGRoCkg
   N/WePmo9P18TRr+kaCpd2AW2Qc2xciJKux7ScSauW8whXi7jW77ji1OIW
   8df1i45eB0IKdPO5KgmGWX3zSveak4xG8nho5KAMArHu+3JqsdlZvUFb4
   WEHCoGKJ566TPe5WqBDR82AdHTm2z9+5L4VpIvD/LOj+XJq4IWGTcVrqg
   GoojBGOTUtufYOZRRg2XhVXpn4SIxXAsQ/Jo7v1zU7XhEI5kQ7VS/RR/2
   Q==;
X-CSE-ConnectionGUID: gn7wHnkqTr6/BE3Gs21IRw==
X-CSE-MsgGUID: ubegmo4KQKKtHN3nARB+gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18025197"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="18025197"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 05:51:49 -0700
X-CSE-ConnectionGUID: LjmylnObTAS6rHywtdaOZQ==
X-CSE-MsgGUID: WMrWvny2QF+/4uxTwWbXPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="44574623"
Received: from unknown (HELO tlindgre-MOBL1.intel.com) ([10.245.247.210])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 05:51:46 -0700
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
Subject: [PATCH v2 0/2] Fixes for console command line ordering
Date: Thu, 13 Jun 2024 15:51:06 +0300
Message-ID: <20240613125113.219700-1-tony.lindgren@linux.intel.com>
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

The following two changes fix the issue using Petr's suggestion that does
not involve calling __add_preferred_console() later on again, and adds
the deferred consoles to the console_cmdline[] directly to be updated
when the console is ready.

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

Changes since v1:

- Revert the problem causing printk changes and switch to using the
  solution based on Petr's suggestion and code snippet

Tony Lindgren (2):
  printk: Revert add_preferred_console_match() related commits
  printk: Add update_preferred_console()

 drivers/tty/serial/serial_base_bus.c |   2 +-
 include/linux/printk.h               |   3 +-
 kernel/printk/Makefile               |   2 +-
 kernel/printk/conopt.c               | 146 ---------------------------
 kernel/printk/console_cmdline.h      |   7 +-
 kernel/printk/printk.c               |  96 ++++++++++++------
 6 files changed, 69 insertions(+), 187 deletions(-)
 delete mode 100644 kernel/printk/conopt.c


base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.45.2

