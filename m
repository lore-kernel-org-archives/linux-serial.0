From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] serial: move Non-standard serial drivers menu to the Serial
 drivers menu
Date: Wed, 25 Sep 2019 18:16:28 -0700
Message-ID: <8e583967-4453-368b-6be5-a24df9b2b5dc@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Since Non-standard serial port drivers are also Serial drivers,
move the "Non-standard serial port support" menu to be under/in
the "Serial drivers" menu. With this move, the "Serial drivers"
menu contains (a) 8250/16550 support, (b) non-8250 support, and
(c) non-standard serial port support.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/tty/Kconfig        |  119 -----------------------------------
 drivers/tty/serial/Kconfig |  119 +++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 119 deletions(-)

--- lnx-53.orig/drivers/tty/Kconfig
+++ lnx-53/drivers/tty/Kconfig
@@ -151,125 +151,6 @@ config LEGACY_PTY_COUNT
 	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
 	  architectures and 24 bytes on 64-bit architectures.
 
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
-config ROCKETPORT
-	tristate "Comtrol RocketPort support"
-	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
-	help
-	  This driver supports Comtrol RocketPort and RocketModem PCI boards.   
-          These boards provide 2, 4, 8, 16, or 32 high-speed serial ports or
-          modems.  For information about the RocketPort/RocketModem  boards
-          and this driver read <file:Documentation/driver-api/serial/rocket.rst>.
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
-	  <file:Documentation/driver-api/serial/cyclades_z.rst>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called cyclades.
-
-	  If you haven't heard about it, it's safe to say N.
-
-config CYZ_INTR
-	bool "Cyclades-Z interrupt mode operation"
-	depends on CYCLADES && PCI
-	help
-	  The Cyclades-Z family of multiport cards allows 2 (two) driver op
-	  modes: polling and interrupt. In polling mode, the driver will check
-	  the status of the Cyclades-Z ports every certain amount of time
-	  (which is called polling cycle and is configurable). In interrupt
-	  mode, it will use an interrupt line (IRQ) in order to check the
-	  status of the Cyclades-Z ports. The default op mode is polling. If
-	  unsure, say N.
-
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
 config NOZOMI
 	tristate "HSDPA Broadband Wireless Data Card - Globe Trotter"
 	depends on PCI
--- lnx-53.orig/drivers/tty/serial/Kconfig
+++ lnx-53/drivers/tty/serial/Kconfig
@@ -1598,6 +1598,125 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
 	  receives all kernel messages and warnings and which allows logins in
 	  single user mode).
 
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
+          and this driver read <file:Documentation/driver-api/serial/rocket.rst>.
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
+	  <file:Documentation/driver-api/serial/cyclades_z.rst>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cyclades.
+
+	  If you haven't heard about it, it's safe to say N.
+
+config CYZ_INTR
+	bool "Cyclades-Z interrupt mode operation"
+	depends on CYCLADES && PCI
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
 endmenu
 
 config SERIAL_MCTRL_GPIO
