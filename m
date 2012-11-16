From: kbuild test robot <fengguang.wu@intel.com>
Subject: [tty:tty-next 109/109] drivers/staging/sb105x/sb_pci_mp.h:22:25:
 fatal error: asm/segment.h: No such file or directory
Date: Sat, 17 Nov 2012 03:45:46 +0800
Message-ID: <50a697ea.Oi9WrmVx2ul6/tYw%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27049 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983Ab2KPTqa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Nov 2012 14:46:30 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   68a81291ff6650f3ff409ebfc58ef97dfe85a2e4
commit: 68a81291ff6650f3ff409ebfc58ef97dfe85a2e4 [109/109] staging: Add SystemBase Multi-2/PCI driver
config: make ARCH=powerpc allmodconfig

All error/warnings:

In file included from drivers/staging/sb105x/sb_pci_mp.c:1:0:
drivers/staging/sb105x/sb_pci_mp.h:22:25: fatal error: asm/segment.h: No such file or directory
compilation terminated.

vim +22 drivers/staging/sb105x/sb_pci_mp.h

68a81291 Steven Rostedt 2012-11-16  16  #include <linux/pci.h>
68a81291 Steven Rostedt 2012-11-16  17  #include <linux/circ_buf.h>
68a81291 Steven Rostedt 2012-11-16  18  
68a81291 Steven Rostedt 2012-11-16  19  #include <asm/uaccess.h>
68a81291 Steven Rostedt 2012-11-16  20  #include <asm/io.h>
68a81291 Steven Rostedt 2012-11-16  21  #include <asm/irq.h>
68a81291 Steven Rostedt 2012-11-16 @22  #include <asm/segment.h>
68a81291 Steven Rostedt 2012-11-16  23  #include <asm/serial.h>
68a81291 Steven Rostedt 2012-11-16  24  #include <linux/interrupt.h>
68a81291 Steven Rostedt 2012-11-16  25  

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
