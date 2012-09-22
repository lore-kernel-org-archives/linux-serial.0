From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [tty:tty-next 10/16] fs/compat_ioctl.c:869:1: error: 'TIOCSRS485'
 undeclared here (not in a function)
Date: Sat, 22 Sep 2012 08:50:21 +0800
Message-ID: <20120922005021.GM5959@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32301 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864Ab2IVAu1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 20:50:27 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jaeden Amero <jaeden.amero@ni.com>
Cc: kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

Hi Jaeden,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   ac57e7f38ea6fe7358cd0b7a2f2d21aef5ab70cd
commit: 84c3b84860440a9e3a3666c14112f41311b8f623 [10/16] compat_ioctl: Add RS-485 IOCTLs to the list
config: mips-fuloong2e_defconfig

All related error/warning messages:

fs/compat_ioctl.c:869:1: error: 'TIOCSRS485' undeclared here (not in a function)
fs/compat_ioctl.c:870:1: error: 'TIOCGRS485' undeclared here (not in a function)

vim +869 fs/compat_ioctl.c
   863	COMPATIBLE_IOCTL(TIOCSPGRP)
   864	COMPATIBLE_IOCTL(TIOCGPGRP)
   865	COMPATIBLE_IOCTL(TIOCGPTN)
   866	COMPATIBLE_IOCTL(TIOCSPTLCK)
   867	COMPATIBLE_IOCTL(TIOCSERGETLSR)
   868	COMPATIBLE_IOCTL(TIOCSIG)
 > 869	COMPATIBLE_IOCTL(TIOCSRS485)
   870	COMPATIBLE_IOCTL(TIOCGRS485)
   871	#ifdef TCGETS2
   872	COMPATIBLE_IOCTL(TCGETS2)

---
0-DAY kernel build testing backend         Open Source Technology Centre
Fengguang Wu, Yuanhan Liu                              Intel Corporation
