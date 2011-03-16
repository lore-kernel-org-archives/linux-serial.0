From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 50/76] tty: move a number of tty drivers from drivers/char/ to drivers/tty/
Date: Wed, 16 Mar 2011 14:12:20 -0700
Message-ID: <1300309966-5745-50-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32781 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264Ab1CPVOm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:42 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>

As planned by Arnd Bergmann, this moves the following drivers from
drivers/char/ to drivers/tty/ as that's where they really belong:
	amiserial
	nozomi
	synclink
	rocket
	cyclades
	moxa
	mxser
	isicom
	bfin_jtag_comm

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/Kconfig                   |  172 --------------------------------
 drivers/char/Makefile                  |   11 --
 drivers/tty/Kconfig                    |  171 +++++++++++++++++++++++++++++++
 drivers/tty/Makefile                   |   13 +++
 drivers/{char => tty}/amiserial.c      |    0
 drivers/{char => tty}/bfin_jtag_comm.c |    0
 drivers/{char => tty}/cyclades.c       |    0
 drivers/{char => tty}/isicom.c         |    0
 drivers/{char => tty}/moxa.c           |    0
 drivers/{char => tty}/moxa.h           |    0
 drivers/{char => tty}/mxser.c          |    0
 drivers/{char => tty}/mxser.h          |    0
 drivers/{char => tty}/nozomi.c         |    0
 drivers/{char => tty}/rocket.c         |    0
 drivers/{char => tty}/rocket.h         |    0
 drivers/{char => tty}/rocket_int.h     |    0
 drivers/{char => tty}/synclink.c       |    0
 drivers/{char => tty}/synclink_gt.c    |    0
 drivers/{char => tty}/synclinkmp.c     |    0
 19 files changed, 184 insertions(+), 183 deletions(-)
 rename drivers/{char => tty}/amiserial.c (100%)
 rename drivers/{char => tty}/bfin_jtag_comm.c (100%)
 rename drivers/{char => tty}/cyclades.c (100%)
 rename drivers/{char => tty}/isicom.c (100%)
 rename drivers/{char => tty}/moxa.c (100%)
 rename drivers/{char => tty}/moxa.h (100%)
 rename drivers/{char => tty}/mxser.c (100%)
 rename drivers/{char => tty}/mxser.h (100%)
 rename drivers/{char => tty}/nozomi.c (100%)
 rename drivers/{char => tty}/rocket.c (100%)
 rename drivers/{char => tty}/rocket.h (100%)
 rename drivers/{char => tty}/rocket_int.h (100%)
 rename drivers/{char => tty}/synclink.c (100%)
 rename drivers/{char => tty}/synclink_gt.c (100%)
 rename drivers/{char => tty}/synclinkmp.c (100%)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 9b9ab86..1adfac6 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -15,36 +15,6 @@ config DEVKMEM
 	  kind of kernel debugging operations.
 	  When in doubt, say "N".
 
-config BFIN_JTAG_COMM
-	tristate "Blackfin JTAG Communication"
-	depends on BLACKFIN
-	help
-	  Add support for emulating a TTY device over the Blackfin JTAG.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_jtag_comm.
-
-config BFIN_JTAG_COMM_CONSOLE
-	bool "Console on Blackfin JTAG"
-	depends on BFIN_JTAG_COMM=y
-
-config SERIAL_NONSTANDARD
-	bool "Non-standard serial port support"
-	depends on HAS_IOMEM
-	---help---
-	  Say Y here if you have any non-standard serial boards -- boards
-	  which aren't supported using the standard "dumb" serial driver.
-	  This includes intelligent serial boards such as Cyclades,
-	  Digiboards, etc. These are usually used for systems that need many
-	  serial ports because they serve many terminals or dial-in
-	  connections.
-
-	  Note that the answer to this question won't directly affect the
-	  kernel: saying N will just cause the configurator to skip all
-	  the questions about non-standard serial boards.
-
-	  Most people can say N here.
-
 config COMPUTONE
 	tristate "Computone IntelliPort Plus serial support"
 	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
@@ -60,50 +30,6 @@ config COMPUTONE
 	  To compile this driver as module, choose M here: the
 	  module will be called ip2.
 
-config ROCKETPORT
-	tristate "Comtrol RocketPort support"
-	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
-	help
-	  This driver supports Comtrol RocketPort and RocketModem PCI boards.   
-          These boards provide 2, 4, 8, 16, or 32 high-speed serial ports or
-          modems.  For information about the RocketPort/RocketModem  boards
-          and this driver read <file:Documentation/serial/rocket.txt>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called rocket.
-
-	  If you want to compile this driver into the kernel, say Y here.  If
-          you don't have a Comtrol RocketPort/RocketModem card installed, say N.
-
-config CYCLADES
-	tristate "Cyclades async mux support"
-	depends on SERIAL_NONSTANDARD && (PCI || ISA)
-	select FW_LOADER
-	---help---
-	  This driver supports Cyclades Z and Y multiserial boards.
-	  You would need something like this to connect more than two modems to
-	  your Linux box, for instance in order to become a dial-in server.
-
-	  For information about the Cyclades-Z card, read
-	  <file:Documentation/serial/README.cycladesZ>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called cyclades.
-
-	  If you haven't heard about it, it's safe to say N.
-
-config CYZ_INTR
-	bool "Cyclades-Z interrupt mode operation (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && CYCLADES
-	help
-	  The Cyclades-Z family of multiport cards allows 2 (two) driver op
-	  modes: polling and interrupt. In polling mode, the driver will check
-	  the status of the Cyclades-Z ports every certain amount of time
-	  (which is called polling cycle and is configurable). In interrupt
-	  mode, it will use an interrupt line (IRQ) in order to check the
-	  status of the Cyclades-Z ports. The default op mode is polling. If
-	  unsure, say N.
-
 config DIGIEPCA
 	tristate "Digiboard Intelligent Async Support"
 	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
@@ -119,94 +45,6 @@ config DIGIEPCA
 	  To compile this driver as a module, choose M here: the
 	  module will be called epca.
 
-config MOXA_INTELLIO
-	tristate "Moxa Intellio support"
-	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
-	select FW_LOADER
-	help
-	  Say Y here if you have a Moxa Intellio multiport serial card.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called moxa.
-
-config MOXA_SMARTIO
-	tristate "Moxa SmartIO support v. 2.0"
-	depends on SERIAL_NONSTANDARD && (PCI || EISA || ISA)
-	help
-	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
-	  want to help develop a new version of this driver.
-
-	  This is upgraded (1.9.1) driver from original Moxa drivers with
-	  changes finally resulting in PCI probing.
-
-	  This driver can also be built as a module. The module will be called
-	  mxser. If you want to do that, say M here.
-
-config ISI
-	tristate "Multi-Tech multiport card support (EXPERIMENTAL)"
-	depends on SERIAL_NONSTANDARD && PCI
-	select FW_LOADER
-	help
-	  This is a driver for the Multi-Tech cards which provide several
-	  serial ports.  The driver is experimental and can currently only be
-	  built as a module. The module will be called isicom.
-	  If you want to do that, choose M here.
-
-config SYNCLINK
-	tristate "Microgate SyncLink card support"
-	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
-	help
-	  Provides support for the SyncLink ISA and PCI multiprotocol serial
-	  adapters. These adapters support asynchronous and HDLC bit
-	  synchronous communication up to 10Mbps (PCI adapter).
-
-	  This driver can only be built as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called synclink.  If you want to do that, say M
-	  here.
-
-config SYNCLINKMP
-	tristate "SyncLink Multiport support"
-	depends on SERIAL_NONSTANDARD && PCI
-	help
-	  Enable support for the SyncLink Multiport (2 or 4 ports)
-	  serial adapter, running asynchronous and HDLC communications up
-	  to 2.048Mbps. Each ports is independently selectable for
-	  RS-232, V.35, RS-449, RS-530, and X.21
-
-	  This driver may be built as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called synclinkmp.  If you want to do that, say M
-	  here.
-
-config SYNCLINK_GT
-	tristate "SyncLink GT/AC support"
-	depends on SERIAL_NONSTANDARD && PCI
-	help
-	  Support for SyncLink GT and SyncLink AC families of
-	  synchronous and asynchronous serial adapters
-	  manufactured by Microgate Systems, Ltd. (www.microgate.com)
-
-config N_HDLC
-	tristate "HDLC line discipline support"
-	depends on SERIAL_NONSTANDARD
-	help
-	  Allows synchronous HDLC communications with tty device drivers that
-	  support synchronous HDLC such as the Microgate SyncLink adapter.
-
-	  This driver can be built as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called n_hdlc. If you want to do that, say M
-	  here.
-
-config N_GSM
-	tristate "GSM MUX line discipline support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	depends on NET
-	help
-	  This line discipline provides support for the GSM MUX protocol and
-	  presents the mux as a set of 61 individual tty devices.
-
 config RISCOM8
 	tristate "SDL RISCom/8 card support"
 	depends on SERIAL_NONSTANDARD
@@ -296,16 +134,6 @@ config ISTALLION
 	  To compile this driver as a module, choose M here: the
 	  module will be called istallion.
 
-config NOZOMI
-	tristate "HSDPA Broadband Wireless Data Card - Globe Trotter"
-	depends on PCI && EXPERIMENTAL
-	help
-	  If you have a HSDPA driver Broadband Wireless Data Card -
-	  Globe Trotter PCMCIA card, say Y here.
-
-	  To compile this driver as a module, choose M here, the module
-	  will be called nozomi.
-
 config A2232
 	tristate "Commodore A2232 serial support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && ZORRO && BROKEN
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 5bc765d..f5dc7c9 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -5,29 +5,18 @@
 obj-y				+= mem.o random.o
 obj-$(CONFIG_TTY_PRINTK)	+= ttyprintk.o
 obj-y				+= misc.o
-obj-$(CONFIG_BFIN_JTAG_COMM)	+= bfin_jtag_comm.o
 obj-$(CONFIG_MVME147_SCC)	+= generic_serial.o vme_scc.o
 obj-$(CONFIG_MVME162_SCC)	+= generic_serial.o vme_scc.o
 obj-$(CONFIG_BVME6000_SCC)	+= generic_serial.o vme_scc.o
-obj-$(CONFIG_ROCKETPORT)	+= rocket.o
 obj-$(CONFIG_SERIAL167)		+= serial167.o
-obj-$(CONFIG_CYCLADES)		+= cyclades.o
 obj-$(CONFIG_STALLION)		+= stallion.o
 obj-$(CONFIG_ISTALLION)		+= istallion.o
-obj-$(CONFIG_NOZOMI)		+= nozomi.o
 obj-$(CONFIG_DIGIEPCA)		+= epca.o
 obj-$(CONFIG_SPECIALIX)		+= specialix.o
-obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
 obj-$(CONFIG_A2232)		+= ser_a2232.o generic_serial.o
 obj-$(CONFIG_ATARI_DSP56K)	+= dsp56k.o
-obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
 obj-$(CONFIG_COMPUTONE)		+= ip2/
 obj-$(CONFIG_RISCOM8)		+= riscom8.o
-obj-$(CONFIG_ISI)		+= isicom.o
-obj-$(CONFIG_SYNCLINK)		+= synclink.o
-obj-$(CONFIG_SYNCLINKMP)	+= synclinkmp.o
-obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
-obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
 obj-$(CONFIG_SX)		+= sx.o generic_serial.o
 obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 9cfbdb3..3fd7199 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -147,4 +147,175 @@ config LEGACY_PTY_COUNT
 	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
 	  architectures and 24 bytes on 64-bit architectures.
 
+config BFIN_JTAG_COMM
+	tristate "Blackfin JTAG Communication"
+	depends on BLACKFIN
+	help
+	  Add support for emulating a TTY device over the Blackfin JTAG.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called bfin_jtag_comm.
+
+config BFIN_JTAG_COMM_CONSOLE
+	bool "Console on Blackfin JTAG"
+	depends on BFIN_JTAG_COMM=y
+
+config SERIAL_NONSTANDARD
+	bool "Non-standard serial port support"
+	depends on HAS_IOMEM
+	---help---
+	  Say Y here if you have any non-standard serial boards -- boards
+	  which aren't supported using the standard "dumb" serial driver.
+	  This includes intelligent serial boards such as Cyclades,
+	  Digiboards, etc. These are usually used for systems that need many
+	  serial ports because they serve many terminals or dial-in
+	  connections.
+
+	  Note that the answer to this question won't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about non-standard serial boards.
+
+	  Most people can say N here.
+
+config ROCKETPORT
+	tristate "Comtrol RocketPort support"
+	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
+	help
+	  This driver supports Comtrol RocketPort and RocketModem PCI boards.   
+          These boards provide 2, 4, 8, 16, or 32 high-speed serial ports or
+          modems.  For information about the RocketPort/RocketModem  boards
+          and this driver read <file:Documentation/serial/rocket.txt>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rocket.
+
+	  If you want to compile this driver into the kernel, say Y here.  If
+          you don't have a Comtrol RocketPort/RocketModem card installed, say N.
+
+config CYCLADES
+	tristate "Cyclades async mux support"
+	depends on SERIAL_NONSTANDARD && (PCI || ISA)
+	select FW_LOADER
+	---help---
+	  This driver supports Cyclades Z and Y multiserial boards.
+	  You would need something like this to connect more than two modems to
+	  your Linux box, for instance in order to become a dial-in server.
+
+	  For information about the Cyclades-Z card, read
+	  <file:Documentation/serial/README.cycladesZ>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cyclades.
+
+	  If you haven't heard about it, it's safe to say N.
+
+config CYZ_INTR
+	bool "Cyclades-Z interrupt mode operation (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && CYCLADES
+	help
+	  The Cyclades-Z family of multiport cards allows 2 (two) driver op
+	  modes: polling and interrupt. In polling mode, the driver will check
+	  the status of the Cyclades-Z ports every certain amount of time
+	  (which is called polling cycle and is configurable). In interrupt
+	  mode, it will use an interrupt line (IRQ) in order to check the
+	  status of the Cyclades-Z ports. The default op mode is polling. If
+	  unsure, say N.
+
+config MOXA_INTELLIO
+	tristate "Moxa Intellio support"
+	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
+	select FW_LOADER
+	help
+	  Say Y here if you have a Moxa Intellio multiport serial card.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called moxa.
+
+config MOXA_SMARTIO
+	tristate "Moxa SmartIO support v. 2.0"
+	depends on SERIAL_NONSTANDARD && (PCI || EISA || ISA)
+	help
+	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
+	  want to help develop a new version of this driver.
+
+	  This is upgraded (1.9.1) driver from original Moxa drivers with
+	  changes finally resulting in PCI probing.
+
+	  This driver can also be built as a module. The module will be called
+	  mxser. If you want to do that, say M here.
+
+config SYNCLINK
+	tristate "Microgate SyncLink card support"
+	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
+	help
+	  Provides support for the SyncLink ISA and PCI multiprotocol serial
+	  adapters. These adapters support asynchronous and HDLC bit
+	  synchronous communication up to 10Mbps (PCI adapter).
+
+	  This driver can only be built as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called synclink.  If you want to do that, say M
+	  here.
+
+config SYNCLINKMP
+	tristate "SyncLink Multiport support"
+	depends on SERIAL_NONSTANDARD && PCI
+	help
+	  Enable support for the SyncLink Multiport (2 or 4 ports)
+	  serial adapter, running asynchronous and HDLC communications up
+	  to 2.048Mbps. Each ports is independently selectable for
+	  RS-232, V.35, RS-449, RS-530, and X.21
+
+	  This driver may be built as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called synclinkmp.  If you want to do that, say M
+	  here.
+
+config SYNCLINK_GT
+	tristate "SyncLink GT/AC support"
+	depends on SERIAL_NONSTANDARD && PCI
+	help
+	  Support for SyncLink GT and SyncLink AC families of
+	  synchronous and asynchronous serial adapters
+	  manufactured by Microgate Systems, Ltd. (www.microgate.com)
+
+config NOZOMI
+	tristate "HSDPA Broadband Wireless Data Card - Globe Trotter"
+	depends on PCI && EXPERIMENTAL
+	help
+	  If you have a HSDPA driver Broadband Wireless Data Card -
+	  Globe Trotter PCMCIA card, say Y here.
+
+	  To compile this driver as a module, choose M here, the module
+	  will be called nozomi.
+
+config ISI
+	tristate "Multi-Tech multiport card support (EXPERIMENTAL)"
+	depends on SERIAL_NONSTANDARD && PCI
+	select FW_LOADER
+	help
+	  This is a driver for the Multi-Tech cards which provide several
+	  serial ports.  The driver is experimental and can currently only be
+	  built as a module. The module will be called isicom.
+	  If you want to do that, choose M here.
+
+config N_HDLC
+	tristate "HDLC line discipline support"
+	depends on SERIAL_NONSTANDARD
+	help
+	  Allows synchronous HDLC communications with tty device drivers that
+	  support synchronous HDLC such as the Microgate SyncLink adapter.
+
+	  This driver can be built as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called n_hdlc. If you want to do that, say M
+	  here.
+
+config N_GSM
+	tristate "GSM MUX line discipline support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on NET
+	help
+	  This line discipline provides support for the GSM MUX protocol and
+	  presents the mux as a set of 61 individual tty devices.
 
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 3962772..e549da3 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -11,3 +11,16 @@ obj-$(CONFIG_R3964)		+= n_r3964.o
 obj-y				+= vt/
 obj-$(CONFIG_HVC_DRIVER)	+= hvc/
 obj-y				+= serial/
+
+# tty drivers
+obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
+obj-$(CONFIG_BFIN_JTAG_COMM)	+= bfin_jtag_comm.o
+obj-$(CONFIG_CYCLADES)		+= cyclades.o
+obj-$(CONFIG_ISI)		+= isicom.o
+obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
+obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
+obj-$(CONFIG_NOZOMI)		+= nozomi.o
+obj-$(CONFIG_ROCKETPORT)	+= rocket.o
+obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
+obj-$(CONFIG_SYNCLINKMP)	+= synclinkmp.o
+obj-$(CONFIG_SYNCLINK)		+= synclink.o
diff --git a/drivers/char/amiserial.c b/drivers/tty/amiserial.c
similarity index 100%
rename from drivers/char/amiserial.c
rename to drivers/tty/amiserial.c
diff --git a/drivers/char/bfin_jtag_comm.c b/drivers/tty/bfin_jtag_comm.c
similarity index 100%
rename from drivers/char/bfin_jtag_comm.c
rename to drivers/tty/bfin_jtag_comm.c
diff --git a/drivers/char/cyclades.c b/drivers/tty/cyclades.c
similarity index 100%
rename from drivers/char/cyclades.c
rename to drivers/tty/cyclades.c
diff --git a/drivers/char/isicom.c b/drivers/tty/isicom.c
similarity index 100%
rename from drivers/char/isicom.c
rename to drivers/tty/isicom.c
diff --git a/drivers/char/moxa.c b/drivers/tty/moxa.c
similarity index 100%
rename from drivers/char/moxa.c
rename to drivers/tty/moxa.c
diff --git a/drivers/char/moxa.h b/drivers/tty/moxa.h
similarity index 100%
rename from drivers/char/moxa.h
rename to drivers/tty/moxa.h
diff --git a/drivers/char/mxser.c b/drivers/tty/mxser.c
similarity index 100%
rename from drivers/char/mxser.c
rename to drivers/tty/mxser.c
diff --git a/drivers/char/mxser.h b/drivers/tty/mxser.h
similarity index 100%
rename from drivers/char/mxser.h
rename to drivers/tty/mxser.h
diff --git a/drivers/char/nozomi.c b/drivers/tty/nozomi.c
similarity index 100%
rename from drivers/char/nozomi.c
rename to drivers/tty/nozomi.c
diff --git a/drivers/char/rocket.c b/drivers/tty/rocket.c
similarity index 100%
rename from drivers/char/rocket.c
rename to drivers/tty/rocket.c
diff --git a/drivers/char/rocket.h b/drivers/tty/rocket.h
similarity index 100%
rename from drivers/char/rocket.h
rename to drivers/tty/rocket.h
diff --git a/drivers/char/rocket_int.h b/drivers/tty/rocket_int.h
similarity index 100%
rename from drivers/char/rocket_int.h
rename to drivers/tty/rocket_int.h
diff --git a/drivers/char/synclink.c b/drivers/tty/synclink.c
similarity index 100%
rename from drivers/char/synclink.c
rename to drivers/tty/synclink.c
diff --git a/drivers/char/synclink_gt.c b/drivers/tty/synclink_gt.c
similarity index 100%
rename from drivers/char/synclink_gt.c
rename to drivers/tty/synclink_gt.c
diff --git a/drivers/char/synclinkmp.c b/drivers/tty/synclinkmp.c
similarity index 100%
rename from drivers/char/synclinkmp.c
rename to drivers/tty/synclinkmp.c
-- 
1.7.4.1

