From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] staging: evict abandoned 68360serial.c driver from 3.4
Date: Tue, 27 Mar 2012 19:07:11 -0400
Message-ID: <1332889631-21316-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:58443 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab2C0XHz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Mar 2012 19:07:55 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Jiri Slaby <jslaby@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Cox <alan@linux.intel.com>

commit 3a0db7215c88077b61a673215756ec4a0dc0c7a5

    "TTY: serial, move 68360 driver to staging"

did so because the driver had remained broken since 2008.  It also
added this text to the TODO file:

   "If no one steps up to adopt any of these drivers, they will
    be removed in the 3.4 release."

A quick search on the internet doesn't reveal anyone actively
trying to update/fix this driver, so follow through on the above
and remove it from the pending 3.4 release.

Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[ commit 3a0db72 was present in v3.2 in case people were wondering.
  Geert - I know you'd said "uClinux" wrt. 3a0db72, but I left you
  on the CC since the CONFIG_M68360 dependency comes from m68k. ]

 drivers/staging/Kconfig              |    2 -
 drivers/staging/Makefile             |    1 -
 drivers/staging/serial/68360serial.c | 2979 ----------------------------------
 drivers/staging/serial/Kconfig       |   16 -
 drivers/staging/serial/Makefile      |    1 -
 drivers/staging/serial/TODO          |    6 -
 6 files changed, 0 insertions(+), 3005 deletions(-)
 delete mode 100644 drivers/staging/serial/68360serial.c
 delete mode 100644 drivers/staging/serial/Kconfig
 delete mode 100644 drivers/staging/serial/Makefile
 delete mode 100644 drivers/staging/serial/TODO

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 97d412d..4c99b4c 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -24,8 +24,6 @@ menuconfig STAGING
 
 if STAGING
 
-source "drivers/staging/serial/Kconfig"
-
 source "drivers/staging/et131x/Kconfig"
 
 source "drivers/staging/slicoss/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index ffe7d44..74662ce 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -3,7 +3,6 @@
 # fix for build system bug...
 obj-$(CONFIG_STAGING)		+= staging.o
 
-obj-y				+= serial/
 obj-y				+= media/
 obj-$(CONFIG_ET131X)		+= et131x/
 obj-$(CONFIG_SLICOSS)		+= slicoss/
diff --git a/drivers/staging/serial/68360serial.c b/drivers/staging/serial/68360serial.c
deleted file mode 100644
index daf0b1d..0000000
diff --git a/drivers/staging/serial/Kconfig b/drivers/staging/serial/Kconfig
deleted file mode 100644
index 9489688..0000000
diff --git a/drivers/staging/serial/Makefile b/drivers/staging/serial/Makefile
deleted file mode 100644
index 37a6a0b..0000000
diff --git a/drivers/staging/serial/TODO b/drivers/staging/serial/TODO
deleted file mode 100644
index a19cda8..0000000
-- 
1.7.9.1

