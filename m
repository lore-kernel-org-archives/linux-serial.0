From: Jaeden Amero <jaeden.amero@ni.com>
Subject: [PATCH] compat_ioctl: Avoid using undefined RS-485 IOCTLs
Date: Mon, 24 Sep 2012 10:39:45 -0500
Message-ID: <1348501185-23657-2-git-send-email-jaeden.amero@ni.com>
References: <20120922005021.GM5959@localhost>
 <1348501185-23657-1-git-send-email-jaeden.amero@ni.com>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1348501185-23657-1-git-send-email-jaeden.amero@ni.com>
Sender: linux-next-owner@vger.kernel.org
To: fengguang.wu@intel.com
Cc: linux-next@vger.kernel.org, sfr@canb.auug.org.au, gregkh@linuxfoundation.org, alan@linux.intel.com, kernel-janitors@vger.kernel.org, linux-serial@vger.kernel.org, Jaeden Amero <jaeden.amero@ni.com>
List-Id: linux-serial@vger.kernel.org

Wrap the use of TIOCSRS485 and TIOCGRS485 in #ifdef so that we avoid
adding undefined IOCTLs to the ioctl pointer list as compatible
ioctls.

This change was motivated by a build error on a MIPS build.

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
tty-next
head:   ac57e7f38ea6fe7358cd0b7a2f2d21aef5ab70cd
commit: 84c3b84860440a9e3a3666c14112f41311b8f623 [10/16] compat_ioctl:
  Add RS-485 IOCTLs to the list
config: mips-fuloong2e_defconfig

All related error/warning messages:

fs/compat_ioctl.c:869:1: error: 'TIOCSRS485' undeclared here (not in a
  function)
fs/compat_ioctl.c:870:1: error: 'TIOCGRS485' undeclared here (not in a
  function)

vim +869 fs/compat_ioctl.c
863 COMPATIBLE_IOCTL(TIOCSPGRP)
864 COMPATIBLE_IOCTL(TIOCGPGRP)
865 COMPATIBLE_IOCTL(TIOCGPTN)
866 COMPATIBLE_IOCTL(TIOCSPTLCK)
867 COMPATIBLE_IOCTL(TIOCSERGETLSR)
868 COMPATIBLE_IOCTL(TIOCSIG)
> 869 COMPATIBLE_IOCTL(TIOCSRS485)
870 COMPATIBLE_IOCTL(TIOCGRS485)
871 #ifdef TCGETS2
872 COMPATIBLE_IOCTL(TCGETS2)

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Jaeden Amero <jaeden.amero@ni.com>
---
 fs/compat_ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 85dfebfe6820856dc3154dfd178acb6fca63bbe9..59f8db4a39a78338b2c7a148122a04e11e026caf 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -866,8 +866,12 @@ COMPATIBLE_IOCTL(TIOCGPTN)
 COMPATIBLE_IOCTL(TIOCSPTLCK)
 COMPATIBLE_IOCTL(TIOCSERGETLSR)
 COMPATIBLE_IOCTL(TIOCSIG)
+#ifdef TIOCSRS485
 COMPATIBLE_IOCTL(TIOCSRS485)
+#endif
+#ifdef TIOCGRS485
 COMPATIBLE_IOCTL(TIOCGRS485)
+#endif
 #ifdef TCGETS2
 COMPATIBLE_IOCTL(TCGETS2)
 COMPATIBLE_IOCTL(TCSETS2)
-- 
1.7.12
