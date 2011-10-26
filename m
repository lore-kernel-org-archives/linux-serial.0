From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 52/79] TTY: serial, move 68360 driver to staging
Date: Wed, 26 Oct 2011 14:12:57 +0200
Message-ID: <1319631204-23262-52-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32806 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932917Ab1JZMNw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:52 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

This driver has been broken at least since 2008. At that time,
a88487c79b (Fix compile errors in SGI console drivers) broke this
driver completely.

And since nobody noticed for the past 3 years, move it into staging. I
think this will rot there and we will throw it away completely after
some time. Or maybe someone will volunteer to fix it ;).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/Kconfig                       |    2 ++
 drivers/staging/Makefile                      |    1 +
 drivers/{tty => staging}/serial/68360serial.c |    0
 drivers/staging/serial/Kconfig                |   16 ++++++++++++++++
 drivers/staging/serial/Makefile               |    1 +
 drivers/staging/serial/TODO                   |    6 ++++++
 drivers/tty/serial/Kconfig                    |   17 -----------------
 drivers/tty/serial/Makefile                   |    1 -
 8 files changed, 26 insertions(+), 18 deletions(-)
 rename drivers/{tty => staging}/serial/68360serial.c (100%)
 create mode 100644 drivers/staging/serial/Kconfig
 create mode 100644 drivers/staging/serial/Makefile
 create mode 100644 drivers/staging/serial/TODO

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 06c9081..bd3d1cc 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -24,6 +24,8 @@ menuconfig STAGING
 
 if STAGING
 
+source "drivers/staging/serial/Kconfig"
+
 source "drivers/staging/et131x/Kconfig"
 
 source "drivers/staging/slicoss/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index f3c5e33..d480a94 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -3,6 +3,7 @@
 # fix for build system bug...
 obj-$(CONFIG_STAGING)		+= staging.o
 
+obj-y				+= serial/
 obj-$(CONFIG_ET131X)		+= et131x/
 obj-$(CONFIG_SLICOSS)		+= slicoss/
 obj-$(CONFIG_VIDEO_GO7007)	+= go7007/
diff --git a/drivers/tty/serial/68360serial.c b/drivers/staging/serial/68360serial.c
similarity index 100%
rename from drivers/tty/serial/68360serial.c
rename to drivers/staging/serial/68360serial.c
diff --git a/drivers/staging/serial/Kconfig b/drivers/staging/serial/Kconfig
new file mode 100644
index 0000000..9489688
--- /dev/null
+++ b/drivers/staging/serial/Kconfig
@@ -0,0 +1,16 @@
+config SERIAL_68360_SMC
+	bool "68360 SMC uart support"
+	depends on M68360
+	help
+	  This driver supports the SMC serial ports of the Motorola 68360 CPU.
+
+config SERIAL_68360_SCC
+	bool "68360 SCC uart support"
+	depends on M68360
+	help
+	  This driver supports the SCC serial ports of the Motorola 68360 CPU.
+
+config SERIAL_68360
+	bool
+	depends on SERIAL_68360_SMC || SERIAL_68360_SCC
+	default y
diff --git a/drivers/staging/serial/Makefile b/drivers/staging/serial/Makefile
new file mode 100644
index 0000000..37a6a0b
--- /dev/null
+++ b/drivers/staging/serial/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SERIAL_68360) += 68360serial.o
diff --git a/drivers/staging/serial/TODO b/drivers/staging/serial/TODO
new file mode 100644
index 0000000..a19cda8
--- /dev/null
+++ b/drivers/staging/serial/TODO
@@ -0,0 +1,6 @@
+These are a few serial drivers that either do not build, or do not work if they
+do build, or if they seem to work, are for obsolete hardware, or are full of
+unfixable races and no one uses them anymore.
+
+If no one steps up to adopt any of these drivers, they will be removed
+in the 3.4 release.
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 8ee3a66..5f479da 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1042,23 +1042,6 @@ config SERIAL_MCF_CONSOLE
 	help
 	  Enable a ColdFire internal serial port to be the system console.
 
-config SERIAL_68360_SMC
-	bool "68360 SMC uart support"
-	depends on M68360
-	help
-	  This driver supports the SMC serial ports of the Motorola 68360 CPU.
-
-config SERIAL_68360_SCC
-	bool "68360 SCC uart support"
-	depends on M68360
-	help
-	  This driver supports the SCC serial ports of the Motorola 68360 CPU.
-
-config SERIAL_68360
-	bool
-	depends on SERIAL_68360_SMC || SERIAL_68360_SCC
-	default y
-
 config SERIAL_PMACZILOG
 	tristate "Mac or PowerMac z85c30 ESCC support"
 	depends on (M68K && MAC) || (PPC_OF && PPC_PMAC)
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 7b59958..e10cf5b 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -50,7 +50,6 @@ obj-$(CONFIG_SERIAL_MAX3107_AAVA) += max3107-aava.o
 obj-$(CONFIG_SERIAL_IP22_ZILOG) += ip22zilog.o
 obj-$(CONFIG_SERIAL_MUX) += mux.o
 obj-$(CONFIG_SERIAL_68328) += 68328serial.o
-obj-$(CONFIG_SERIAL_68360) += 68360serial.o
 obj-$(CONFIG_SERIAL_MCF) += mcf.o
 obj-$(CONFIG_SERIAL_PMACZILOG) += pmac_zilog.o
 obj-$(CONFIG_SERIAL_DZ) += dz.o
-- 
1.7.7

