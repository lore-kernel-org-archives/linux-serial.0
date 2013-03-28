From: Fengguang Wu <fengguang.wu@intel.com>
Subject: make[2]: *** No rule to make target `drivers/serial/serial_core.c',
 needed by `Documentation/DocBook/kernel-api.xml'.
Date: Thu, 28 Mar 2013 09:00:12 +0800
Message-ID: <20130328010012.GA14108@localhost>
References: <5153256d.SyZXdcYq+1mLl7KI%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30826 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960Ab3C1BAQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Mar 2013 21:00:16 -0400
Content-Disposition: inline
In-Reply-To: <5153256d.SyZXdcYq+1mLl7KI%fengguang.wu@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: serial <linux-serial@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>


Hi Greg,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
head:   de55eb1d60d2ed0f1ba5e13226d91b3bfbe1c108
commit: ab4382d27412e7e3e7c936e8d50d8888dfac3df8 tty: move drivers/serial/ to drivers/tty/serial/
date:   2 years, 2 months ago
config: make ARCH=x86_64 allmodconfig

All error/warnings:

   make[2]: *** No rule to make target `kernel/sched/core.c', needed by `Documentation/DocBook/device-drivers.xml'.
   make[2]: *** No rule to make target `kernel/sched/cpupri.c', needed by `Documentation/DocBook/device-drivers.xml'.
   make[2]: *** No rule to make target `kernel/sched/fair.c', needed by `Documentation/DocBook/device-drivers.xml'.
   make[2]: *** No rule to make target `drivers/base/syscore.c', needed by `Documentation/DocBook/device-drivers.xml'.
   make[2]: *** No rule to make target `drivers/base/dma-buf.c', needed by `Documentation/DocBook/device-drivers.xml'.
   make[2]: *** No rule to make target `drivers/base/fence.c', needed by `Documentation/DocBook/device-drivers.xml'.
   make[2]: *** No rule to make target `include/linux/fence.h', needed by `Documentation/DocBook/device-drivers.xml'.
   make[2]: *** No rule to make target `drivers/base/reservation.c', needed by `Documentation/DocBook/device-drivers.xml'.
   make[2]: *** No rule to make target `include/linux/reservation.h', needed by `Documentation/DocBook/device-drivers.xml'.
   make[2]: *** No rule to make target `drivers/tty/serial/8250/8250.c', needed by `Documentation/DocBook/device-drivers.xml'.
   make[2]: *** No rule to make target `include/linux/hsi/hsi.h', needed by `Documentation/DocBook/device-drivers.xml'.
   make[2]: *** No rule to make target `drivers/hsi/hsi.c', needed by `Documentation/DocBook/device-drivers.xml'.
   make[2]: *** No rule to make target `arch/x86/include/asm/io_32.h', needed by `Documentation/DocBook/deviceiobook.xml'.
   make[2]: *** No rule to make target `drivers/gpu/drm/drm_dp_helper.c', needed by `Documentation/DocBook/drm.xml'.
   make[2]: *** No rule to make target `arch/x86/include/asm/atomic_32.h', needed by `Documentation/DocBook/kernel-api.xml'.
   make[2]: *** No rule to make target `block/blk-barrier.c', needed by `Documentation/DocBook/kernel-api.xml'.
   make[2]: *** No rule to make target `block/blktrace.c', needed by `Documentation/DocBook/kernel-api.xml'.
>> make[2]: *** No rule to make target `drivers/serial/serial_core.c', needed by `Documentation/DocBook/kernel-api.xml'.
>> make[2]: *** No rule to make target `drivers/serial/8250.c', needed by `Documentation/DocBook/kernel-api.xml'.
   make[2]: *** No rule to make target `drivers/net/wan/syncppp.c', needed by `Documentation/DocBook/networking.xml'.
   make[2]: *** No rule to make target `arch/powerpc/kernel/rio.c', needed by `Documentation/DocBook/rapidio.xml'.
   make[2]: Target `htmldocs' not remade because of errors.

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
