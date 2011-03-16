From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 52/76] tty: move obsolete and broken tty drivers to drivers/staging/tty/
Date: Wed, 16 Mar 2011 14:12:22 -0700
Message-ID: <1300309966-5745-52-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32946 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754837Ab1CPVOw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:52 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>

As planned by Arnd Bergmann, this moves the following drivers to the
drivers/staging/tty/ directory where they will be removed after 2.6.41
if no one steps up to claim them.
	epca
	epca
	ip2
	istallion
	riscom8
	serial167
	specialix
	stallion

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/m68k/Kconfig                             |    8 --
 drivers/char/Kconfig                          |   79 ----------------------
 drivers/char/Makefile                         |    7 --
 drivers/staging/Kconfig                       |    2 +
 drivers/staging/Makefile                      |    1 +
 drivers/staging/tty/Kconfig                   |   87 +++++++++++++++++++++++++
 drivers/staging/tty/Makefile                  |    7 ++
 drivers/staging/tty/TODO                      |    6 ++
 drivers/{char => staging/tty}/epca.c          |    0
 drivers/{char => staging/tty}/epca.h          |    0
 drivers/{char => staging/tty}/epcaconfig.h    |    0
 drivers/{char => staging/tty}/ip2/Makefile    |    0
 drivers/{char => staging/tty}/ip2/i2cmd.c     |    0
 drivers/{char => staging/tty}/ip2/i2cmd.h     |    0
 drivers/{char => staging/tty}/ip2/i2ellis.c   |    0
 drivers/{char => staging/tty}/ip2/i2ellis.h   |    0
 drivers/{char => staging/tty}/ip2/i2hw.h      |    0
 drivers/{char => staging/tty}/ip2/i2lib.c     |    0
 drivers/{char => staging/tty}/ip2/i2lib.h     |    0
 drivers/{char => staging/tty}/ip2/i2pack.h    |    0
 drivers/{char => staging/tty}/ip2/ip2.h       |    0
 drivers/{char => staging/tty}/ip2/ip2ioctl.h  |    0
 drivers/{char => staging/tty}/ip2/ip2main.c   |    0
 drivers/{char => staging/tty}/ip2/ip2trace.h  |    0
 drivers/{char => staging/tty}/ip2/ip2types.h  |    0
 drivers/{char => staging/tty}/istallion.c     |    0
 drivers/{char => staging/tty}/riscom8.c       |    0
 drivers/{char => staging/tty}/riscom8.h       |    0
 drivers/{char => staging/tty}/riscom8_reg.h   |    0
 drivers/{char => staging/tty}/serial167.c     |    0
 drivers/{char => staging/tty}/specialix.c     |    0
 drivers/{char => staging/tty}/specialix_io8.h |    0
 drivers/{char => staging/tty}/stallion.c      |    0
 33 files changed, 103 insertions(+), 94 deletions(-)
 create mode 100644 drivers/staging/tty/Kconfig
 create mode 100644 drivers/staging/tty/Makefile
 create mode 100644 drivers/staging/tty/TODO
 rename drivers/{char => staging/tty}/epca.c (100%)
 rename drivers/{char => staging/tty}/epca.h (100%)
 rename drivers/{char => staging/tty}/epcaconfig.h (100%)
 rename drivers/{char => staging/tty}/ip2/Makefile (100%)
 rename drivers/{char => staging/tty}/ip2/i2cmd.c (100%)
 rename drivers/{char => staging/tty}/ip2/i2cmd.h (100%)
 rename drivers/{char => staging/tty}/ip2/i2ellis.c (100%)
 rename drivers/{char => staging/tty}/ip2/i2ellis.h (100%)
 rename drivers/{char => staging/tty}/ip2/i2hw.h (100%)
 rename drivers/{char => staging/tty}/ip2/i2lib.c (100%)
 rename drivers/{char => staging/tty}/ip2/i2lib.h (100%)
 rename drivers/{char => staging/tty}/ip2/i2pack.h (100%)
 rename drivers/{char => staging/tty}/ip2/ip2.h (100%)
 rename drivers/{char => staging/tty}/ip2/ip2ioctl.h (100%)
 rename drivers/{char => staging/tty}/ip2/ip2main.c (100%)
 rename drivers/{char => staging/tty}/ip2/ip2trace.h (100%)
 rename drivers/{char => staging/tty}/ip2/ip2types.h (100%)
 rename drivers/{char => staging/tty}/istallion.c (100%)
 rename drivers/{char => staging/tty}/riscom8.c (100%)
 rename drivers/{char => staging/tty}/riscom8.h (100%)
 rename drivers/{char => staging/tty}/riscom8_reg.h (100%)
 rename drivers/{char => staging/tty}/serial167.c (100%)
 rename drivers/{char => staging/tty}/specialix.c (100%)
 rename drivers/{char => staging/tty}/specialix_io8.h (100%)
 rename drivers/{char => staging/tty}/stallion.c (100%)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index bc9271b..a85e251 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -554,14 +554,6 @@ config MVME147_SCC
 	  This is the driver for the serial ports on the Motorola MVME147
 	  boards.  Everyone using one of these boards should say Y here.
 
-config SERIAL167
-	bool "CD2401 support for MVME166/7 serial ports"
-	depends on MVME16x
-	help
-	  This is the driver for the serial ports on the Motorola MVME166,
-	  167, and 172 boards.  Everyone using one of these boards should say
-	  Y here.
-
 config MVME162_SCC
 	bool "SCC support for MVME162 serial ports"
 	depends on MVME16x && BROKEN
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 1adfac6..7b8cf02 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -15,63 +15,6 @@ config DEVKMEM
 	  kind of kernel debugging operations.
 	  When in doubt, say "N".
 
-config COMPUTONE
-	tristate "Computone IntelliPort Plus serial support"
-	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
-	---help---
-	  This driver supports the entire family of Intelliport II/Plus
-	  controllers with the exception of the MicroChannel controllers and
-	  products previous to the Intelliport II. These are multiport cards,
-	  which give you many serial ports. You would need something like this
-	  to connect more than two modems to your Linux box, for instance in
-	  order to become a dial-in server. If you have a card like that, say
-	  Y here and read <file:Documentation/serial/computone.txt>.
-
-	  To compile this driver as module, choose M here: the
-	  module will be called ip2.
-
-config DIGIEPCA
-	tristate "Digiboard Intelligent Async Support"
-	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
-	---help---
-	  This is a driver for Digi International's Xx, Xeve, and Xem series
-	  of cards which provide multiple serial ports. You would need
-	  something like this to connect more than two modems to your Linux
-	  box, for instance in order to become a dial-in server. This driver
-	  supports the original PC (ISA) boards as well as PCI, and EISA. If
-	  you have a card like this, say Y here and read the file
-	  <file:Documentation/serial/digiepca.txt>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called epca.
-
-config RISCOM8
-	tristate "SDL RISCom/8 card support"
-	depends on SERIAL_NONSTANDARD
-	help
-	  This is a driver for the SDL Communications RISCom/8 multiport card,
-	  which gives you many serial ports. You would need something like
-	  this to connect more than two modems to your Linux box, for instance
-	  in order to become a dial-in server. If you have a card like that,
-	  say Y here and read the file <file:Documentation/serial/riscom8.txt>.
-
-	  Also it's possible to say M here and compile this driver as kernel
-	  loadable module; the module will be called riscom8.
-
-config SPECIALIX
-	tristate "Specialix IO8+ card support"
-	depends on SERIAL_NONSTANDARD
-	help
-	  This is a driver for the Specialix IO8+ multiport card (both the
-	  ISA and the PCI version) which gives you many serial ports. You
-	  would need something like this to connect more than two modems to
-	  your Linux box, for instance in order to become a dial-in server.
-
-	  If you have a card like that, say Y here and read the file
-	  <file:Documentation/serial/specialix.txt>. Also it's possible to say
-	  M here and compile this driver as kernel loadable module which will be
-	  called specialix.
-
 config SX
 	tristate "Specialix SX (and SI) card support"
 	depends on SERIAL_NONSTANDARD && (PCI || EISA || ISA) && BROKEN
@@ -112,28 +55,6 @@ config STALDRV
 	  in this case.  If you have never heard about all this, it's safe to
 	  say N.
 
-config STALLION
-	tristate "Stallion EasyIO or EC8/32 support"
-	depends on STALDRV && (ISA || EISA || PCI)
-	help
-	  If you have an EasyIO or EasyConnection 8/32 multiport Stallion
-	  card, then this is for you; say Y.  Make sure to read
-	  <file:Documentation/serial/stallion.txt>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called stallion.
-
-config ISTALLION
-	tristate "Stallion EC8/64, ONboard, Brumby support"
-	depends on STALDRV && (ISA || EISA || PCI)
-	help
-	  If you have an EasyConnection 8/64, ONboard, Brumby or Stallion
-	  serial multiport card, say Y here. Make sure to read
-	  <file:Documentation/serial/stallion.txt>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called istallion.
-
 config A2232
 	tristate "Commodore A2232 serial support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && ZORRO && BROKEN
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index f5dc7c9..48bb8ac 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -8,15 +8,8 @@ obj-y				+= misc.o
 obj-$(CONFIG_MVME147_SCC)	+= generic_serial.o vme_scc.o
 obj-$(CONFIG_MVME162_SCC)	+= generic_serial.o vme_scc.o
 obj-$(CONFIG_BVME6000_SCC)	+= generic_serial.o vme_scc.o
-obj-$(CONFIG_SERIAL167)		+= serial167.o
-obj-$(CONFIG_STALLION)		+= stallion.o
-obj-$(CONFIG_ISTALLION)		+= istallion.o
-obj-$(CONFIG_DIGIEPCA)		+= epca.o
-obj-$(CONFIG_SPECIALIX)		+= specialix.o
 obj-$(CONFIG_A2232)		+= ser_a2232.o generic_serial.o
 obj-$(CONFIG_ATARI_DSP56K)	+= dsp56k.o
-obj-$(CONFIG_COMPUTONE)		+= ip2/
-obj-$(CONFIG_RISCOM8)		+= riscom8.o
 obj-$(CONFIG_SX)		+= sx.o generic_serial.o
 obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 5c8fcfc..fb1fc4e 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -41,6 +41,8 @@ config STAGING_EXCLUDE_BUILD
 
 if !STAGING_EXCLUDE_BUILD
 
+source "drivers/staging/tty/Kconfig"
+
 source "drivers/staging/et131x/Kconfig"
 
 source "drivers/staging/slicoss/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index d538863..f498e34 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -3,6 +3,7 @@
 # fix for build system bug...
 obj-$(CONFIG_STAGING)		+= staging.o
 
+obj-y += tty/
 obj-$(CONFIG_ET131X)		+= et131x/
 obj-$(CONFIG_SLICOSS)		+= slicoss/
 obj-$(CONFIG_VIDEO_GO7007)	+= go7007/
diff --git a/drivers/staging/tty/Kconfig b/drivers/staging/tty/Kconfig
new file mode 100644
index 0000000..77103a0
--- /dev/null
+++ b/drivers/staging/tty/Kconfig
@@ -0,0 +1,87 @@
+config STALLION
+	tristate "Stallion EasyIO or EC8/32 support"
+	depends on STALDRV && (ISA || EISA || PCI)
+	help
+	  If you have an EasyIO or EasyConnection 8/32 multiport Stallion
+	  card, then this is for you; say Y.  Make sure to read
+	  <file:Documentation/serial/stallion.txt>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stallion.
+
+config ISTALLION
+	tristate "Stallion EC8/64, ONboard, Brumby support"
+	depends on STALDRV && (ISA || EISA || PCI)
+	help
+	  If you have an EasyConnection 8/64, ONboard, Brumby or Stallion
+	  serial multiport card, say Y here. Make sure to read
+	  <file:Documentation/serial/stallion.txt>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called istallion.
+
+config DIGIEPCA
+	tristate "Digiboard Intelligent Async Support"
+	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
+	---help---
+	  This is a driver for Digi International's Xx, Xeve, and Xem series
+	  of cards which provide multiple serial ports. You would need
+	  something like this to connect more than two modems to your Linux
+	  box, for instance in order to become a dial-in server. This driver
+	  supports the original PC (ISA) boards as well as PCI, and EISA. If
+	  you have a card like this, say Y here and read the file
+	  <file:Documentation/serial/digiepca.txt>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called epca.
+
+config RISCOM8
+	tristate "SDL RISCom/8 card support"
+	depends on SERIAL_NONSTANDARD
+	help
+	  This is a driver for the SDL Communications RISCom/8 multiport card,
+	  which gives you many serial ports. You would need something like
+	  this to connect more than two modems to your Linux box, for instance
+	  in order to become a dial-in server. If you have a card like that,
+	  say Y here and read the file <file:Documentation/serial/riscom8.txt>.
+
+	  Also it's possible to say M here and compile this driver as kernel
+	  loadable module; the module will be called riscom8.
+
+config SPECIALIX
+	tristate "Specialix IO8+ card support"
+	depends on SERIAL_NONSTANDARD
+	help
+	  This is a driver for the Specialix IO8+ multiport card (both the
+	  ISA and the PCI version) which gives you many serial ports. You
+	  would need something like this to connect more than two modems to
+	  your Linux box, for instance in order to become a dial-in server.
+
+	  If you have a card like that, say Y here and read the file
+	  <file:Documentation/serial/specialix.txt>. Also it's possible to say
+	  M here and compile this driver as kernel loadable module which will be
+	  called specialix.
+
+config COMPUTONE
+	tristate "Computone IntelliPort Plus serial support"
+	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
+	---help---
+	  This driver supports the entire family of Intelliport II/Plus
+	  controllers with the exception of the MicroChannel controllers and
+	  products previous to the Intelliport II. These are multiport cards,
+	  which give you many serial ports. You would need something like this
+	  to connect more than two modems to your Linux box, for instance in
+	  order to become a dial-in server. If you have a card like that, say
+	  Y here and read <file:Documentation/serial/computone.txt>.
+
+	  To compile this driver as module, choose M here: the
+	  module will be called ip2.
+
+config SERIAL167
+	bool "CD2401 support for MVME166/7 serial ports"
+	depends on MVME16x
+	help
+	  This is the driver for the serial ports on the Motorola MVME166,
+	  167, and 172 boards.  Everyone using one of these boards should say
+	  Y here.
+
diff --git a/drivers/staging/tty/Makefile b/drivers/staging/tty/Makefile
new file mode 100644
index 0000000..ac57c105
--- /dev/null
+++ b/drivers/staging/tty/Makefile
@@ -0,0 +1,7 @@
+obj-$(CONFIG_STALLION)		+= stallion.o
+obj-$(CONFIG_ISTALLION)		+= istallion.o
+obj-$(CONFIG_DIGIEPCA)		+= epca.o
+obj-$(CONFIG_SERIAL167)		+= serial167.o
+obj-$(CONFIG_SPECIALIX)		+= specialix.o
+obj-$(CONFIG_RISCOM8)		+= riscom8.o
+obj-$(CONFIG_COMPUTONE)		+= ip2/
diff --git a/drivers/staging/tty/TODO b/drivers/staging/tty/TODO
new file mode 100644
index 0000000..8875645
--- /dev/null
+++ b/drivers/staging/tty/TODO
@@ -0,0 +1,6 @@
+These are a few tty/serial drivers that either do not build,
+or work if they do build, or if they seem to work, are for obsolete
+hardware, or are full of unfixable races and no one uses them anymore.
+
+If no one steps up to adopt any of these drivers, they will be removed
+in the 2.6.41 release.
diff --git a/drivers/char/epca.c b/drivers/staging/tty/epca.c
similarity index 100%
rename from drivers/char/epca.c
rename to drivers/staging/tty/epca.c
diff --git a/drivers/char/epca.h b/drivers/staging/tty/epca.h
similarity index 100%
rename from drivers/char/epca.h
rename to drivers/staging/tty/epca.h
diff --git a/drivers/char/epcaconfig.h b/drivers/staging/tty/epcaconfig.h
similarity index 100%
rename from drivers/char/epcaconfig.h
rename to drivers/staging/tty/epcaconfig.h
diff --git a/drivers/char/ip2/Makefile b/drivers/staging/tty/ip2/Makefile
similarity index 100%
rename from drivers/char/ip2/Makefile
rename to drivers/staging/tty/ip2/Makefile
diff --git a/drivers/char/ip2/i2cmd.c b/drivers/staging/tty/ip2/i2cmd.c
similarity index 100%
rename from drivers/char/ip2/i2cmd.c
rename to drivers/staging/tty/ip2/i2cmd.c
diff --git a/drivers/char/ip2/i2cmd.h b/drivers/staging/tty/ip2/i2cmd.h
similarity index 100%
rename from drivers/char/ip2/i2cmd.h
rename to drivers/staging/tty/ip2/i2cmd.h
diff --git a/drivers/char/ip2/i2ellis.c b/drivers/staging/tty/ip2/i2ellis.c
similarity index 100%
rename from drivers/char/ip2/i2ellis.c
rename to drivers/staging/tty/ip2/i2ellis.c
diff --git a/drivers/char/ip2/i2ellis.h b/drivers/staging/tty/ip2/i2ellis.h
similarity index 100%
rename from drivers/char/ip2/i2ellis.h
rename to drivers/staging/tty/ip2/i2ellis.h
diff --git a/drivers/char/ip2/i2hw.h b/drivers/staging/tty/ip2/i2hw.h
similarity index 100%
rename from drivers/char/ip2/i2hw.h
rename to drivers/staging/tty/ip2/i2hw.h
diff --git a/drivers/char/ip2/i2lib.c b/drivers/staging/tty/ip2/i2lib.c
similarity index 100%
rename from drivers/char/ip2/i2lib.c
rename to drivers/staging/tty/ip2/i2lib.c
diff --git a/drivers/char/ip2/i2lib.h b/drivers/staging/tty/ip2/i2lib.h
similarity index 100%
rename from drivers/char/ip2/i2lib.h
rename to drivers/staging/tty/ip2/i2lib.h
diff --git a/drivers/char/ip2/i2pack.h b/drivers/staging/tty/ip2/i2pack.h
similarity index 100%
rename from drivers/char/ip2/i2pack.h
rename to drivers/staging/tty/ip2/i2pack.h
diff --git a/drivers/char/ip2/ip2.h b/drivers/staging/tty/ip2/ip2.h
similarity index 100%
rename from drivers/char/ip2/ip2.h
rename to drivers/staging/tty/ip2/ip2.h
diff --git a/drivers/char/ip2/ip2ioctl.h b/drivers/staging/tty/ip2/ip2ioctl.h
similarity index 100%
rename from drivers/char/ip2/ip2ioctl.h
rename to drivers/staging/tty/ip2/ip2ioctl.h
diff --git a/drivers/char/ip2/ip2main.c b/drivers/staging/tty/ip2/ip2main.c
similarity index 100%
rename from drivers/char/ip2/ip2main.c
rename to drivers/staging/tty/ip2/ip2main.c
diff --git a/drivers/char/ip2/ip2trace.h b/drivers/staging/tty/ip2/ip2trace.h
similarity index 100%
rename from drivers/char/ip2/ip2trace.h
rename to drivers/staging/tty/ip2/ip2trace.h
diff --git a/drivers/char/ip2/ip2types.h b/drivers/staging/tty/ip2/ip2types.h
similarity index 100%
rename from drivers/char/ip2/ip2types.h
rename to drivers/staging/tty/ip2/ip2types.h
diff --git a/drivers/char/istallion.c b/drivers/staging/tty/istallion.c
similarity index 100%
rename from drivers/char/istallion.c
rename to drivers/staging/tty/istallion.c
diff --git a/drivers/char/riscom8.c b/drivers/staging/tty/riscom8.c
similarity index 100%
rename from drivers/char/riscom8.c
rename to drivers/staging/tty/riscom8.c
diff --git a/drivers/char/riscom8.h b/drivers/staging/tty/riscom8.h
similarity index 100%
rename from drivers/char/riscom8.h
rename to drivers/staging/tty/riscom8.h
diff --git a/drivers/char/riscom8_reg.h b/drivers/staging/tty/riscom8_reg.h
similarity index 100%
rename from drivers/char/riscom8_reg.h
rename to drivers/staging/tty/riscom8_reg.h
diff --git a/drivers/char/serial167.c b/drivers/staging/tty/serial167.c
similarity index 100%
rename from drivers/char/serial167.c
rename to drivers/staging/tty/serial167.c
diff --git a/drivers/char/specialix.c b/drivers/staging/tty/specialix.c
similarity index 100%
rename from drivers/char/specialix.c
rename to drivers/staging/tty/specialix.c
diff --git a/drivers/char/specialix_io8.h b/drivers/staging/tty/specialix_io8.h
similarity index 100%
rename from drivers/char/specialix_io8.h
rename to drivers/staging/tty/specialix_io8.h
diff --git a/drivers/char/stallion.c b/drivers/staging/tty/stallion.c
similarity index 100%
rename from drivers/char/stallion.c
rename to drivers/staging/tty/stallion.c
-- 
1.7.4.1

