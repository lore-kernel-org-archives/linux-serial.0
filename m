From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: [PATCH v7 0/11] KGDB/KDB FIQ (NMI) debugger
Date: Thu, 13 Sep 2012 08:01:33 -0700
Message-ID: <20120913150133.GA16238@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47194 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab2IMPEL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Sep 2012 11:04:11 -0400
Received: by pbbrr13 with SMTP id rr13so4087036pbb.19
        for <linux-serial@vger.kernel.org>; Thu, 13 Sep 2012 08:04:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
Cc: Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

Hi all,

Here comes the lucky v7:

- Per Alan Cox's suggestion added hangup method and removed a small
  leftover;
- Per Colin Cross' suggestion moved IRQ quiescing logic into
  poll_get_char routine. IIUC, Alan is less unhappy about it.  As a
  result, clear_irq() callback dropped.

These patches can be found in the following repo (based on tty-next):

	git://git.infradead.org/users/cbou/linux-nmi-kdb.git master

Old changelogs and rationale for these patches can be found here:

	v1-v5, rationale: http://lkml.org/lkml/2012/9/10/2
	v6: http://lkml.org/lkml/2012/9/10/2

Thanks,

--
 arch/arm/Kconfig                    |  19 ++
 arch/arm/common/vic.c               |  28 ++
 arch/arm/include/asm/hardware/vic.h |   2 +
 arch/arm/include/asm/kgdb.h         |   8 +
 arch/arm/kernel/Makefile            |   1 +
 arch/arm/kernel/entry-armv.S        | 167 +-----------
 arch/arm/kernel/entry-header.S      | 170 +++++++++++++
 arch/arm/kernel/kgdb_fiq.c          |  99 ++++++++
 arch/arm/kernel/kgdb_fiq_entry.S    |  87 +++++++
 arch/arm/mach-versatile/Makefile    |   1 +
 arch/arm/mach-versatile/kgdb_fiq.c  |  31 +++
 drivers/tty/serial/Kconfig          |  19 ++
 drivers/tty/serial/Makefile         |   1 +
 drivers/tty/serial/amba-pl011.c     |  73 +++++-
 drivers/tty/serial/kgdb_nmi.c       | 396 +++++++++++++++++++++++++++++
 drivers/tty/serial/kgdboc.c         |   6 +
 drivers/tty/serial/serial_core.c    |  17 ++
 include/linux/kdb.h                 |  29 ++-
 include/linux/kgdb.h                |  33 +++
 include/linux/serial_core.h         |   1 +
 kernel/debug/debug_core.c           |  36 ++-
 kernel/debug/kdb/kdb_main.c         |  29 +++
 22 files changed, 1060 insertions(+), 193 deletions(-)
