From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 53/76] tty: move obsolete and broken generic_serial drivers to drivers/staging/generic_serial/
Date: Wed, 16 Mar 2011 14:12:23 -0700
Message-ID: <1300309966-5745-53-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32957 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754935Ab1CPVOx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:53 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>

As planned by Arnd Bergmann, this moves the following drivers to the
drivers/staging/generic_serial directory where they will be removed
after 2.6.41 if no one steps up to claim them.
	generic_serial
	rio
	ser_a2232
	sx
	vme_scc

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/Kconfig                               |   44 -------------------
 drivers/char/Makefile                              |    6 ---
 drivers/staging/Kconfig                            |    2 +
 drivers/staging/Makefile                           |    1 +
 drivers/staging/generic_serial/Kconfig             |   45 ++++++++++++++++++++
 drivers/staging/generic_serial/Makefile            |    6 +++
 drivers/staging/generic_serial/TODO                |    6 +++
 .../generic_serial}/generic_serial.c               |    0
 .../{char => staging/generic_serial}/rio/Makefile  |    0
 .../{char => staging/generic_serial}/rio/board.h   |    0
 .../{char => staging/generic_serial}/rio/cirrus.h  |    0
 .../{char => staging/generic_serial}/rio/cmdblk.h  |    0
 .../{char => staging/generic_serial}/rio/cmdpkt.h  |    0
 .../{char => staging/generic_serial}/rio/daemon.h  |    0
 .../{char => staging/generic_serial}/rio/errors.h  |    0
 .../{char => staging/generic_serial}/rio/func.h    |    0
 .../{char => staging/generic_serial}/rio/host.h    |    0
 .../{char => staging/generic_serial}/rio/link.h    |    0
 .../generic_serial}/rio/linux_compat.h             |    0
 drivers/{char => staging/generic_serial}/rio/map.h |    0
 .../{char => staging/generic_serial}/rio/param.h   |    0
 .../{char => staging/generic_serial}/rio/parmmap.h |    0
 drivers/{char => staging/generic_serial}/rio/pci.h |    0
 drivers/{char => staging/generic_serial}/rio/phb.h |    0
 drivers/{char => staging/generic_serial}/rio/pkt.h |    0
 .../{char => staging/generic_serial}/rio/port.h    |    0
 .../{char => staging/generic_serial}/rio/protsts.h |    0
 drivers/{char => staging/generic_serial}/rio/rio.h |    0
 .../generic_serial}/rio/rio_linux.c                |    0
 .../generic_serial}/rio/rio_linux.h                |    0
 .../generic_serial}/rio/rioboard.h                 |    0
 .../{char => staging/generic_serial}/rio/rioboot.c |    0
 .../{char => staging/generic_serial}/rio/riocmd.c  |    0
 .../{char => staging/generic_serial}/rio/rioctrl.c |    0
 .../{char => staging/generic_serial}/rio/riodrvr.h |    0
 .../{char => staging/generic_serial}/rio/rioinfo.h |    0
 .../{char => staging/generic_serial}/rio/rioinit.c |    0
 .../{char => staging/generic_serial}/rio/riointr.c |    0
 .../generic_serial}/rio/rioioctl.h                 |    0
 .../generic_serial}/rio/rioparam.c                 |    0
 .../generic_serial}/rio/rioroute.c                 |    0
 .../generic_serial}/rio/riospace.h                 |    0
 .../generic_serial}/rio/riotable.c                 |    0
 .../{char => staging/generic_serial}/rio/riotty.c  |    0
 .../{char => staging/generic_serial}/rio/route.h   |    0
 drivers/{char => staging/generic_serial}/rio/rup.h |    0
 .../{char => staging/generic_serial}/rio/unixrup.h |    0
 .../{char => staging/generic_serial}/ser_a2232.c   |    0
 .../{char => staging/generic_serial}/ser_a2232.h   |    0
 .../generic_serial}/ser_a2232fw.ax                 |    0
 .../{char => staging/generic_serial}/ser_a2232fw.h |    0
 drivers/{char => staging/generic_serial}/sx.c      |    0
 drivers/{char => staging/generic_serial}/sx.h      |    0
 .../{char => staging/generic_serial}/sxboards.h    |    0
 .../{char => staging/generic_serial}/sxwindow.h    |    0
 drivers/{char => staging/generic_serial}/vme_scc.c |    0
 56 files changed, 60 insertions(+), 50 deletions(-)
 create mode 100644 drivers/staging/generic_serial/Kconfig
 create mode 100644 drivers/staging/generic_serial/Makefile
 create mode 100644 drivers/staging/generic_serial/TODO
 rename drivers/{char => staging/generic_serial}/generic_serial.c (100%)
 rename drivers/{char => staging/generic_serial}/rio/Makefile (100%)
 rename drivers/{char => staging/generic_serial}/rio/board.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/cirrus.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/cmdblk.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/cmdpkt.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/daemon.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/errors.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/func.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/host.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/link.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/linux_compat.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/map.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/param.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/parmmap.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/pci.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/phb.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/pkt.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/port.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/protsts.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/rio.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/rio_linux.c (100%)
 rename drivers/{char => staging/generic_serial}/rio/rio_linux.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/rioboard.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/rioboot.c (100%)
 rename drivers/{char => staging/generic_serial}/rio/riocmd.c (100%)
 rename drivers/{char => staging/generic_serial}/rio/rioctrl.c (100%)
 rename drivers/{char => staging/generic_serial}/rio/riodrvr.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/rioinfo.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/rioinit.c (100%)
 rename drivers/{char => staging/generic_serial}/rio/riointr.c (100%)
 rename drivers/{char => staging/generic_serial}/rio/rioioctl.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/rioparam.c (100%)
 rename drivers/{char => staging/generic_serial}/rio/rioroute.c (100%)
 rename drivers/{char => staging/generic_serial}/rio/riospace.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/riotable.c (100%)
 rename drivers/{char => staging/generic_serial}/rio/riotty.c (100%)
 rename drivers/{char => staging/generic_serial}/rio/route.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/rup.h (100%)
 rename drivers/{char => staging/generic_serial}/rio/unixrup.h (100%)
 rename drivers/{char => staging/generic_serial}/ser_a2232.c (100%)
 rename drivers/{char => staging/generic_serial}/ser_a2232.h (100%)
 rename drivers/{char => staging/generic_serial}/ser_a2232fw.ax (100%)
 rename drivers/{char => staging/generic_serial}/ser_a2232fw.h (100%)
 rename drivers/{char => staging/generic_serial}/sx.c (100%)
 rename drivers/{char => staging/generic_serial}/sx.h (100%)
 rename drivers/{char => staging/generic_serial}/sxboards.h (100%)
 rename drivers/{char => staging/generic_serial}/sxwindow.h (100%)
 rename drivers/{char => staging/generic_serial}/vme_scc.c (100%)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 7b8cf02..04f8b2d 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -15,34 +15,6 @@ config DEVKMEM
 	  kind of kernel debugging operations.
 	  When in doubt, say "N".
 
-config SX
-	tristate "Specialix SX (and SI) card support"
-	depends on SERIAL_NONSTANDARD && (PCI || EISA || ISA) && BROKEN
-	help
-	  This is a driver for the SX and SI multiport serial cards.
-	  Please read the file <file:Documentation/serial/sx.txt> for details.
-
-	  This driver can only be built as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called sx. If you want to do that, say M here.
-
-config RIO
-	tristate "Specialix RIO system support"
-	depends on SERIAL_NONSTANDARD && BROKEN
-	help
-	  This is a driver for the Specialix RIO, a smart serial card which
-	  drives an outboard box that can support up to 128 ports.  Product
-	  information is at <http://www.perle.com/support/documentation.html#multiport>.
-	  There are both ISA and PCI versions.
-
-config RIO_OLDPCI
-	bool "Support really old RIO/PCI cards"
-	depends on RIO
-	help
-	  Older RIO PCI cards need some initialization-time configuration to
-	  determine the IRQ and some control addresses.  If you have a RIO and
-	  this doesn't seem to work, try setting this to Y.
-
 config STALDRV
 	bool "Stallion multiport serial support"
 	depends on SERIAL_NONSTANDARD
@@ -55,22 +27,6 @@ config STALDRV
 	  in this case.  If you have never heard about all this, it's safe to
 	  say N.
 
-config A2232
-	tristate "Commodore A2232 serial support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && ZORRO && BROKEN
-	---help---
-	  This option supports the 2232 7-port serial card shipped with the
-	  Amiga 2000 and other Zorro-bus machines, dating from 1989.  At
-	  a max of 19,200 bps, the ports are served by a 6551 ACIA UART chip
-	  each, plus a 8520 CIA, and a master 6502 CPU and buffer as well. The
-	  ports were connected with 8 pin DIN connectors on the card bracket,
-	  for which 8 pin to DB25 adapters were supplied. The card also had
-	  jumpers internally to toggle various pinning configurations.
-
-	  This driver can be built as a module; but then "generic_serial"
-	  will also be built as a module. This has to be loaded before
-	  "ser_a2232". If you want to do this, answer M here.
-
 config SGI_SNSC
 	bool "SGI Altix system controller communication support"
 	depends on (IA64_SGI_SN2 || IA64_GENERIC)
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 48bb8ac..3ca1f62 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -5,13 +5,7 @@
 obj-y				+= mem.o random.o
 obj-$(CONFIG_TTY_PRINTK)	+= ttyprintk.o
 obj-y				+= misc.o
-obj-$(CONFIG_MVME147_SCC)	+= generic_serial.o vme_scc.o
-obj-$(CONFIG_MVME162_SCC)	+= generic_serial.o vme_scc.o
-obj-$(CONFIG_BVME6000_SCC)	+= generic_serial.o vme_scc.o
-obj-$(CONFIG_A2232)		+= ser_a2232.o generic_serial.o
 obj-$(CONFIG_ATARI_DSP56K)	+= dsp56k.o
-obj-$(CONFIG_SX)		+= sx.o generic_serial.o
-obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
 obj-$(CONFIG_MSPEC)		+= mspec.o
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index fb1fc4e..58e4a8e 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -43,6 +43,8 @@ if !STAGING_EXCLUDE_BUILD
 
 source "drivers/staging/tty/Kconfig"
 
+source "drivers/staging/generic_serial/Kconfig"
+
 source "drivers/staging/et131x/Kconfig"
 
 source "drivers/staging/slicoss/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index f498e34..ff7372d 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -4,6 +4,7 @@
 obj-$(CONFIG_STAGING)		+= staging.o
 
 obj-y += tty/
+obj-y += generic_serial/
 obj-$(CONFIG_ET131X)		+= et131x/
 obj-$(CONFIG_SLICOSS)		+= slicoss/
 obj-$(CONFIG_VIDEO_GO7007)	+= go7007/
diff --git a/drivers/staging/generic_serial/Kconfig b/drivers/staging/generic_serial/Kconfig
new file mode 100644
index 0000000..795daea
--- /dev/null
+++ b/drivers/staging/generic_serial/Kconfig
@@ -0,0 +1,45 @@
+config A2232
+	tristate "Commodore A2232 serial support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && ZORRO && BROKEN
+	---help---
+	  This option supports the 2232 7-port serial card shipped with the
+	  Amiga 2000 and other Zorro-bus machines, dating from 1989.  At
+	  a max of 19,200 bps, the ports are served by a 6551 ACIA UART chip
+	  each, plus a 8520 CIA, and a master 6502 CPU and buffer as well. The
+	  ports were connected with 8 pin DIN connectors on the card bracket,
+	  for which 8 pin to DB25 adapters were supplied. The card also had
+	  jumpers internally to toggle various pinning configurations.
+
+	  This driver can be built as a module; but then "generic_serial"
+	  will also be built as a module. This has to be loaded before
+	  "ser_a2232". If you want to do this, answer M here.
+
+config SX
+	tristate "Specialix SX (and SI) card support"
+	depends on SERIAL_NONSTANDARD && (PCI || EISA || ISA) && BROKEN
+	help
+	  This is a driver for the SX and SI multiport serial cards.
+	  Please read the file <file:Documentation/serial/sx.txt> for details.
+
+	  This driver can only be built as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called sx. If you want to do that, say M here.
+
+config RIO
+	tristate "Specialix RIO system support"
+	depends on SERIAL_NONSTANDARD && BROKEN
+	help
+	  This is a driver for the Specialix RIO, a smart serial card which
+	  drives an outboard box that can support up to 128 ports.  Product
+	  information is at <http://www.perle.com/support/documentation.html#multiport>.
+	  There are both ISA and PCI versions.
+
+config RIO_OLDPCI
+	bool "Support really old RIO/PCI cards"
+	depends on RIO
+	help
+	  Older RIO PCI cards need some initialization-time configuration to
+	  determine the IRQ and some control addresses.  If you have a RIO and
+	  this doesn't seem to work, try setting this to Y.
+
+
diff --git a/drivers/staging/generic_serial/Makefile b/drivers/staging/generic_serial/Makefile
new file mode 100644
index 0000000..ffc90c8
--- /dev/null
+++ b/drivers/staging/generic_serial/Makefile
@@ -0,0 +1,6 @@
+obj-$(CONFIG_MVME147_SCC)	+= generic_serial.o vme_scc.o
+obj-$(CONFIG_MVME162_SCC)	+= generic_serial.o vme_scc.o
+obj-$(CONFIG_BVME6000_SCC)	+= generic_serial.o vme_scc.o
+obj-$(CONFIG_A2232)		+= ser_a2232.o generic_serial.o
+obj-$(CONFIG_SX)		+= sx.o generic_serial.o
+obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
diff --git a/drivers/staging/generic_serial/TODO b/drivers/staging/generic_serial/TODO
new file mode 100644
index 0000000..8875645
--- /dev/null
+++ b/drivers/staging/generic_serial/TODO
@@ -0,0 +1,6 @@
+These are a few tty/serial drivers that either do not build,
+or work if they do build, or if they seem to work, are for obsolete
+hardware, or are full of unfixable races and no one uses them anymore.
+
+If no one steps up to adopt any of these drivers, they will be removed
+in the 2.6.41 release.
diff --git a/drivers/char/generic_serial.c b/drivers/staging/generic_serial/generic_serial.c
similarity index 100%
rename from drivers/char/generic_serial.c
rename to drivers/staging/generic_serial/generic_serial.c
diff --git a/drivers/char/rio/Makefile b/drivers/staging/generic_serial/rio/Makefile
similarity index 100%
rename from drivers/char/rio/Makefile
rename to drivers/staging/generic_serial/rio/Makefile
diff --git a/drivers/char/rio/board.h b/drivers/staging/generic_serial/rio/board.h
similarity index 100%
rename from drivers/char/rio/board.h
rename to drivers/staging/generic_serial/rio/board.h
diff --git a/drivers/char/rio/cirrus.h b/drivers/staging/generic_serial/rio/cirrus.h
similarity index 100%
rename from drivers/char/rio/cirrus.h
rename to drivers/staging/generic_serial/rio/cirrus.h
diff --git a/drivers/char/rio/cmdblk.h b/drivers/staging/generic_serial/rio/cmdblk.h
similarity index 100%
rename from drivers/char/rio/cmdblk.h
rename to drivers/staging/generic_serial/rio/cmdblk.h
diff --git a/drivers/char/rio/cmdpkt.h b/drivers/staging/generic_serial/rio/cmdpkt.h
similarity index 100%
rename from drivers/char/rio/cmdpkt.h
rename to drivers/staging/generic_serial/rio/cmdpkt.h
diff --git a/drivers/char/rio/daemon.h b/drivers/staging/generic_serial/rio/daemon.h
similarity index 100%
rename from drivers/char/rio/daemon.h
rename to drivers/staging/generic_serial/rio/daemon.h
diff --git a/drivers/char/rio/errors.h b/drivers/staging/generic_serial/rio/errors.h
similarity index 100%
rename from drivers/char/rio/errors.h
rename to drivers/staging/generic_serial/rio/errors.h
diff --git a/drivers/char/rio/func.h b/drivers/staging/generic_serial/rio/func.h
similarity index 100%
rename from drivers/char/rio/func.h
rename to drivers/staging/generic_serial/rio/func.h
diff --git a/drivers/char/rio/host.h b/drivers/staging/generic_serial/rio/host.h
similarity index 100%
rename from drivers/char/rio/host.h
rename to drivers/staging/generic_serial/rio/host.h
diff --git a/drivers/char/rio/link.h b/drivers/staging/generic_serial/rio/link.h
similarity index 100%
rename from drivers/char/rio/link.h
rename to drivers/staging/generic_serial/rio/link.h
diff --git a/drivers/char/rio/linux_compat.h b/drivers/staging/generic_serial/rio/linux_compat.h
similarity index 100%
rename from drivers/char/rio/linux_compat.h
rename to drivers/staging/generic_serial/rio/linux_compat.h
diff --git a/drivers/char/rio/map.h b/drivers/staging/generic_serial/rio/map.h
similarity index 100%
rename from drivers/char/rio/map.h
rename to drivers/staging/generic_serial/rio/map.h
diff --git a/drivers/char/rio/param.h b/drivers/staging/generic_serial/rio/param.h
similarity index 100%
rename from drivers/char/rio/param.h
rename to drivers/staging/generic_serial/rio/param.h
diff --git a/drivers/char/rio/parmmap.h b/drivers/staging/generic_serial/rio/parmmap.h
similarity index 100%
rename from drivers/char/rio/parmmap.h
rename to drivers/staging/generic_serial/rio/parmmap.h
diff --git a/drivers/char/rio/pci.h b/drivers/staging/generic_serial/rio/pci.h
similarity index 100%
rename from drivers/char/rio/pci.h
rename to drivers/staging/generic_serial/rio/pci.h
diff --git a/drivers/char/rio/phb.h b/drivers/staging/generic_serial/rio/phb.h
similarity index 100%
rename from drivers/char/rio/phb.h
rename to drivers/staging/generic_serial/rio/phb.h
diff --git a/drivers/char/rio/pkt.h b/drivers/staging/generic_serial/rio/pkt.h
similarity index 100%
rename from drivers/char/rio/pkt.h
rename to drivers/staging/generic_serial/rio/pkt.h
diff --git a/drivers/char/rio/port.h b/drivers/staging/generic_serial/rio/port.h
similarity index 100%
rename from drivers/char/rio/port.h
rename to drivers/staging/generic_serial/rio/port.h
diff --git a/drivers/char/rio/protsts.h b/drivers/staging/generic_serial/rio/protsts.h
similarity index 100%
rename from drivers/char/rio/protsts.h
rename to drivers/staging/generic_serial/rio/protsts.h
diff --git a/drivers/char/rio/rio.h b/drivers/staging/generic_serial/rio/rio.h
similarity index 100%
rename from drivers/char/rio/rio.h
rename to drivers/staging/generic_serial/rio/rio.h
diff --git a/drivers/char/rio/rio_linux.c b/drivers/staging/generic_serial/rio/rio_linux.c
similarity index 100%
rename from drivers/char/rio/rio_linux.c
rename to drivers/staging/generic_serial/rio/rio_linux.c
diff --git a/drivers/char/rio/rio_linux.h b/drivers/staging/generic_serial/rio/rio_linux.h
similarity index 100%
rename from drivers/char/rio/rio_linux.h
rename to drivers/staging/generic_serial/rio/rio_linux.h
diff --git a/drivers/char/rio/rioboard.h b/drivers/staging/generic_serial/rio/rioboard.h
similarity index 100%
rename from drivers/char/rio/rioboard.h
rename to drivers/staging/generic_serial/rio/rioboard.h
diff --git a/drivers/char/rio/rioboot.c b/drivers/staging/generic_serial/rio/rioboot.c
similarity index 100%
rename from drivers/char/rio/rioboot.c
rename to drivers/staging/generic_serial/rio/rioboot.c
diff --git a/drivers/char/rio/riocmd.c b/drivers/staging/generic_serial/rio/riocmd.c
similarity index 100%
rename from drivers/char/rio/riocmd.c
rename to drivers/staging/generic_serial/rio/riocmd.c
diff --git a/drivers/char/rio/rioctrl.c b/drivers/staging/generic_serial/rio/rioctrl.c
similarity index 100%
rename from drivers/char/rio/rioctrl.c
rename to drivers/staging/generic_serial/rio/rioctrl.c
diff --git a/drivers/char/rio/riodrvr.h b/drivers/staging/generic_serial/rio/riodrvr.h
similarity index 100%
rename from drivers/char/rio/riodrvr.h
rename to drivers/staging/generic_serial/rio/riodrvr.h
diff --git a/drivers/char/rio/rioinfo.h b/drivers/staging/generic_serial/rio/rioinfo.h
similarity index 100%
rename from drivers/char/rio/rioinfo.h
rename to drivers/staging/generic_serial/rio/rioinfo.h
diff --git a/drivers/char/rio/rioinit.c b/drivers/staging/generic_serial/rio/rioinit.c
similarity index 100%
rename from drivers/char/rio/rioinit.c
rename to drivers/staging/generic_serial/rio/rioinit.c
diff --git a/drivers/char/rio/riointr.c b/drivers/staging/generic_serial/rio/riointr.c
similarity index 100%
rename from drivers/char/rio/riointr.c
rename to drivers/staging/generic_serial/rio/riointr.c
diff --git a/drivers/char/rio/rioioctl.h b/drivers/staging/generic_serial/rio/rioioctl.h
similarity index 100%
rename from drivers/char/rio/rioioctl.h
rename to drivers/staging/generic_serial/rio/rioioctl.h
diff --git a/drivers/char/rio/rioparam.c b/drivers/staging/generic_serial/rio/rioparam.c
similarity index 100%
rename from drivers/char/rio/rioparam.c
rename to drivers/staging/generic_serial/rio/rioparam.c
diff --git a/drivers/char/rio/rioroute.c b/drivers/staging/generic_serial/rio/rioroute.c
similarity index 100%
rename from drivers/char/rio/rioroute.c
rename to drivers/staging/generic_serial/rio/rioroute.c
diff --git a/drivers/char/rio/riospace.h b/drivers/staging/generic_serial/rio/riospace.h
similarity index 100%
rename from drivers/char/rio/riospace.h
rename to drivers/staging/generic_serial/rio/riospace.h
diff --git a/drivers/char/rio/riotable.c b/drivers/staging/generic_serial/rio/riotable.c
similarity index 100%
rename from drivers/char/rio/riotable.c
rename to drivers/staging/generic_serial/rio/riotable.c
diff --git a/drivers/char/rio/riotty.c b/drivers/staging/generic_serial/rio/riotty.c
similarity index 100%
rename from drivers/char/rio/riotty.c
rename to drivers/staging/generic_serial/rio/riotty.c
diff --git a/drivers/char/rio/route.h b/drivers/staging/generic_serial/rio/route.h
similarity index 100%
rename from drivers/char/rio/route.h
rename to drivers/staging/generic_serial/rio/route.h
diff --git a/drivers/char/rio/rup.h b/drivers/staging/generic_serial/rio/rup.h
similarity index 100%
rename from drivers/char/rio/rup.h
rename to drivers/staging/generic_serial/rio/rup.h
diff --git a/drivers/char/rio/unixrup.h b/drivers/staging/generic_serial/rio/unixrup.h
similarity index 100%
rename from drivers/char/rio/unixrup.h
rename to drivers/staging/generic_serial/rio/unixrup.h
diff --git a/drivers/char/ser_a2232.c b/drivers/staging/generic_serial/ser_a2232.c
similarity index 100%
rename from drivers/char/ser_a2232.c
rename to drivers/staging/generic_serial/ser_a2232.c
diff --git a/drivers/char/ser_a2232.h b/drivers/staging/generic_serial/ser_a2232.h
similarity index 100%
rename from drivers/char/ser_a2232.h
rename to drivers/staging/generic_serial/ser_a2232.h
diff --git a/drivers/char/ser_a2232fw.ax b/drivers/staging/generic_serial/ser_a2232fw.ax
similarity index 100%
rename from drivers/char/ser_a2232fw.ax
rename to drivers/staging/generic_serial/ser_a2232fw.ax
diff --git a/drivers/char/ser_a2232fw.h b/drivers/staging/generic_serial/ser_a2232fw.h
similarity index 100%
rename from drivers/char/ser_a2232fw.h
rename to drivers/staging/generic_serial/ser_a2232fw.h
diff --git a/drivers/char/sx.c b/drivers/staging/generic_serial/sx.c
similarity index 100%
rename from drivers/char/sx.c
rename to drivers/staging/generic_serial/sx.c
diff --git a/drivers/char/sx.h b/drivers/staging/generic_serial/sx.h
similarity index 100%
rename from drivers/char/sx.h
rename to drivers/staging/generic_serial/sx.h
diff --git a/drivers/char/sxboards.h b/drivers/staging/generic_serial/sxboards.h
similarity index 100%
rename from drivers/char/sxboards.h
rename to drivers/staging/generic_serial/sxboards.h
diff --git a/drivers/char/sxwindow.h b/drivers/staging/generic_serial/sxwindow.h
similarity index 100%
rename from drivers/char/sxwindow.h
rename to drivers/staging/generic_serial/sxwindow.h
diff --git a/drivers/char/vme_scc.c b/drivers/staging/generic_serial/vme_scc.c
similarity index 100%
rename from drivers/char/vme_scc.c
rename to drivers/staging/generic_serial/vme_scc.c
-- 
1.7.4.1

