Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719E17741;
	Wed,  3 Jul 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001192; cv=none; b=cVeNH2RWsuG+A9A2SGGY8LtGzY0XTTb5Q6u5Z8kbO9aIJkxQ9LbLqGsLu1HKtjozt5gNc6YFWKDMEortbFMzyTv987fC8QlVkdSbM8K8sDympcUpl9iZNn4vPtTp0xGpv5v1PBrbIVBtsvDssSrycuOHiInTpgZ9N3xCF6qs1lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001192; c=relaxed/simple;
	bh=+1vQzUvu3r9PEMJ7qsiZPsHa2RvNRoThVCOWZ8xnLC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Grs3Z6xwqDg/dhNCQ/1Wj08B+lKPVX5Xofrg/NSzzCWlwyDnx4hrpbrZ6Q3F1LnrnIzRlXGxix9bXl2CVA6gvlna54V0bSB3sWIaYWu11bMtQmdDUeiBIeAxHajm1SrnmONawj2PFHmJYJI/yil05ET80R8saToyIDCNUtxuE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tco+SJkO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tco+SJkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720001191; x=1751537191;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+1vQzUvu3r9PEMJ7qsiZPsHa2RvNRoThVCOWZ8xnLC4=;
  b=Tco+SJkOqpDl/ojFg3cXLv6gimAfOXyPkXuy3HFDMrf7Xfn2R3Db3rDH
   PX7+wznvakjkD5orDit3QGLdtyWLgc6EV6jwn0tw3HMD5jN6uj4mZjFtA
   AB//zdkWxn0NpSdpQO+He/C8J7+GBC7NIR4CkMNLarukluI9MJUBYcdP1
   IcpsD07kJEUuZnrhoxwGr9zliwRnyyDO6f0ZqupFz/+Ps39oRr4GlUnjd
   bS+iINKzsltZY8ohzVHBpVKV1ZZ7QIsm8saDgAmai70r1wtX14NHSsEco
   nkmxmcjFEvuuyr67k4cP/E8NE5SZCUczJIFb5yWEgUo3kao4Cn9j5j2Kd
   A==;
X-CSE-ConnectionGUID: 8JoZAv8MQ3qzL/bmUR72TQ==
X-CSE-MsgGUID: K954mPpSRwuoO684ySdajQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="21093758"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="21093758"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:06:30 -0700
X-CSE-ConnectionGUID: ZZWx7fBsTOaHwVmIQaiOEg==
X-CSE-MsgGUID: iHSAQsCkS66N/RAEVx7mag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="69384958"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO tlindgre-MOBL1.intel.com) ([10.245.244.185])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:06:25 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add back DEVNAME:0.0 console handling
Date: Wed,  3 Jul 2024 13:06:07 +0300
Message-ID: <20240703100615.118762-1-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Here are the changes to add back the DEVNAME:0.0 style kernel command
line console handling.

The earlier attempt to add DEVNAME:0.0 style console handling caused a
regression to the kernel command line console ordering, and we reverted
the whole series. The fixes would have been too intrusive for the
v6.10-rc series as discussed in [0] below.

These patches are based on v6.10-rc6, and essentially the same as in [0].
Because of the rebase, I've left out Petr's Reviewed-by and Tested-by tags.

Compared to the original DEVNAME:0.0 patch series [1], things are much
simplified. We now have rewritten the printk deferred console handling
thanks to Petr, and have renamed the serial functions accordingly. And as
we are not deferring ttyS named consoles, the serial core console quirk
handling been been left out.

Regards,

Tony

[0] https://lore.kernel.org/linux-serial/20240620124541.164931-1-tony.lindgren@linux.intel.com/
[1] https://lore.kernel.org/linux-serial/20240327110021.59793-1-tony@atomide.com/

Tony Lindgren (3):
  printk: Add match_devname_and_update_preferred_console()
  serial: core: Add serial_base_match_and_update_preferred_console()
  Documentation: kernel-parameters: Add DEVNAME:0.0 format for serial
    ports

 .../admin-guide/kernel-parameters.txt         |  19 ++++
 drivers/tty/serial/serial_base.h              |  16 +++
 drivers/tty/serial/serial_base_bus.c          |  37 +++++++
 drivers/tty/serial/serial_core.c              |   4 +
 include/linux/printk.h                        |   4 +
 kernel/printk/console_cmdline.h               |   1 +
 kernel/printk/printk.c                        | 103 +++++++++++++++---
 7 files changed, 169 insertions(+), 15 deletions(-)


base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
-- 
2.45.2

