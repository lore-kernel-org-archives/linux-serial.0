From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 42/76] tty: move Kconfig entries into drivers/tty from drivers/char
Date: Wed, 16 Mar 2011 14:12:12 -0700
Message-ID: <1300309966-5745-42-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33074 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab1CPVOQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:16 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>

The Kconfig options for the drivers/tty/ files still were hanging around
in the "big" drivers/char/Kconfig file, so move them to the proper
location under drivers/tty and drivers/tty/hvc/

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/Kconfig    |  254 +----------------------------------------------
 drivers/tty/Kconfig     |  150 ++++++++++++++++++++++++++++
 drivers/tty/hvc/Kconfig |  105 +++++++++++++++++++
 3 files changed, 257 insertions(+), 252 deletions(-)
 create mode 100644 drivers/tty/Kconfig
 create mode 100644 drivers/tty/hvc/Kconfig

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 17f9b96..9b9ab86 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -4,89 +4,7 @@
 
 menu "Character devices"
 
-config VT
-	bool "Virtual terminal" if EXPERT
-	depends on !S390
-	select INPUT
-	default y
-	---help---
-	  If you say Y here, you will get support for terminal devices with
-	  display and keyboard devices. These are called "virtual" because you
-	  can run several virtual terminals (also called virtual consoles) on
-	  one physical terminal. This is rather useful, for example one
-	  virtual terminal can collect system messages and warnings, another
-	  one can be used for a text-mode user session, and a third could run
-	  an X session, all in parallel. Switching between virtual terminals
-	  is done with certain key combinations, usually Alt-<function key>.
-
-	  The setterm command ("man setterm") can be used to change the
-	  properties (such as colors or beeping) of a virtual terminal. The
-	  man page console_codes(4) ("man console_codes") contains the special
-	  character sequences that can be used to change those properties
-	  directly. The fonts used on virtual terminals can be changed with
-	  the setfont ("man setfont") command and the key bindings are defined
-	  with the loadkeys ("man loadkeys") command.
-
-	  You need at least one virtual terminal device in order to make use
-	  of your keyboard and monitor. Therefore, only people configuring an
-	  embedded system would want to say N here in order to save some
-	  memory; the only way to log into such a system is then via a serial
-	  or network connection.
-
-	  If unsure, say Y, or else you won't be able to do much with your new
-	  shiny Linux system :-)
-
-config CONSOLE_TRANSLATIONS
-	depends on VT
-	default y
-	bool "Enable character translations in console" if EXPERT
-	---help---
-	  This enables support for font mapping and Unicode translation
-	  on virtual consoles.
-
-config VT_CONSOLE
-	bool "Support for console on virtual terminal" if EXPERT
-	depends on VT
-	default y
-	---help---
-	  The system console is the device which receives all kernel messages
-	  and warnings and which allows logins in single user mode. If you
-	  answer Y here, a virtual terminal (the device used to interact with
-	  a physical terminal) can be used as system console. This is the most
-	  common mode of operations, so you should say Y here unless you want
-	  the kernel messages be output only to a serial port (in which case
-	  you should say Y to "Console on serial port", below).
-
-	  If you do say Y here, by default the currently visible virtual
-	  terminal (/dev/tty0) will be used as system console. You can change
-	  that with a kernel command line option such as "console=tty3" which
-	  would use the third virtual terminal as system console. (Try "man
-	  bootparam" or see the documentation of your boot loader (lilo or
-	  loadlin) about how to pass options to the kernel at boot time.)
-
-	  If unsure, say Y.
-
-config HW_CONSOLE
-	bool
-	depends on VT && !S390 && !UML
-	default y
-
-config VT_HW_CONSOLE_BINDING
-       bool "Support for binding and unbinding console drivers"
-       depends on HW_CONSOLE
-       default n
-       ---help---
-         The virtual terminal is the device that interacts with the physical
-         terminal through console drivers. On these systems, at least one
-         console driver is loaded. In other configurations, additional console
-         drivers may be enabled, such as the framebuffer console. If more than
-         1 console driver is enabled, setting this to 'y' will allow you to
-         select the console driver that will serve as the backend for the
-         virtual terminals.
-
-	 See <file:Documentation/console/console.txt> for more
-	 information. For framebuffer console users, please refer to
-	 <file:Documentation/fb/fbcon.txt>.
+source "drivers/tty/Kconfig"
 
 config DEVKMEM
 	bool "/dev/kmem virtual device support"
@@ -428,71 +346,6 @@ config SGI_MBCS
 
 source "drivers/tty/serial/Kconfig"
 
-config UNIX98_PTYS
-	bool "Unix98 PTY support" if EXPERT
-	default y
-	---help---
-	  A pseudo terminal (PTY) is a software device consisting of two
-	  halves: a master and a slave. The slave device behaves identical to
-	  a physical terminal; the master device is used by a process to
-	  read data from and write data to the slave, thereby emulating a
-	  terminal. Typical programs for the master side are telnet servers
-	  and xterms.
-
-	  Linux has traditionally used the BSD-like names /dev/ptyxx for
-	  masters and /dev/ttyxx for slaves of pseudo terminals. This scheme
-	  has a number of problems. The GNU C library glibc 2.1 and later,
-	  however, supports the Unix98 naming standard: in order to acquire a
-	  pseudo terminal, a process opens /dev/ptmx; the number of the pseudo
-	  terminal is then made available to the process and the pseudo
-	  terminal slave can be accessed as /dev/pts/<number>. What was
-	  traditionally /dev/ttyp2 will then be /dev/pts/2, for example.
-
-	  All modern Linux systems use the Unix98 ptys.  Say Y unless
-	  you're on an embedded system and want to conserve memory.
-
-config DEVPTS_MULTIPLE_INSTANCES
-	bool "Support multiple instances of devpts"
-	depends on UNIX98_PTYS
-	default n
-	---help---
-	  Enable support for multiple instances of devpts filesystem.
-	  If you want to have isolated PTY namespaces (eg: in containers),
-	  say Y here.  Otherwise, say N. If enabled, each mount of devpts
-	  filesystem with the '-o newinstance' option will create an
-	  independent PTY namespace.
-
-config LEGACY_PTYS
-	bool "Legacy (BSD) PTY support"
-	default y
-	---help---
-	  A pseudo terminal (PTY) is a software device consisting of two
-	  halves: a master and a slave. The slave device behaves identical to
-	  a physical terminal; the master device is used by a process to
-	  read data from and write data to the slave, thereby emulating a
-	  terminal. Typical programs for the master side are telnet servers
-	  and xterms.
-
-	  Linux has traditionally used the BSD-like names /dev/ptyxx
-	  for masters and /dev/ttyxx for slaves of pseudo
-	  terminals. This scheme has a number of problems, including
-	  security.  This option enables these legacy devices; on most
-	  systems, it is safe to say N.
-
-
-config LEGACY_PTY_COUNT
-	int "Maximum number of legacy PTY in use"
-	depends on LEGACY_PTYS
-	range 0 256
-	default "256"
-	---help---
-	  The maximum number of legacy PTYs that can be used at any one time.
-	  The default is 256, and should be more than enough.  Embedded
-	  systems may want to reduce this to save memory.
-
-	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
-	  architectures and 24 bytes on 64-bit architectures.
-
 config TTY_PRINTK
 	bool "TTY driver to output user messages via printk"
 	depends on EXPERT
@@ -612,93 +465,7 @@ config PPDEV
 
 	  If unsure, say N.
 
-config HVC_DRIVER
-	bool
-	help
-	  Generic "hypervisor virtual console" infrastructure for various
-	  hypervisors (pSeries, iSeries, Xen, lguest).
-	  It will automatically be selected if one of the back-end console drivers
-	  is selected.
-
-config HVC_IRQ
-	bool
-
-config HVC_CONSOLE
-	bool "pSeries Hypervisor Virtual Console support"
-	depends on PPC_PSERIES
-	select HVC_DRIVER
-	select HVC_IRQ
-	help
-	  pSeries machines when partitioned support a hypervisor virtual
-	  console. This driver allows each pSeries partition to have a console
-	  which is accessed via the HMC.
-
-config HVC_ISERIES
-	bool "iSeries Hypervisor Virtual Console support"
-	depends on PPC_ISERIES
-	default y
-	select HVC_DRIVER
-	select HVC_IRQ
-	select VIOPATH
-	help
-	  iSeries machines support a hypervisor virtual console.
-
-config HVC_RTAS
-	bool "IBM RTAS Console support"
-	depends on PPC_RTAS
-	select HVC_DRIVER
-	help
-	  IBM Console device driver which makes use of RTAS
-
-config HVC_BEAT
-	bool "Toshiba's Beat Hypervisor Console support"
-	depends on PPC_CELLEB
-	select HVC_DRIVER
-	help
-	  Toshiba's Cell Reference Set Beat Console device driver
-
-config HVC_IUCV
-	bool "z/VM IUCV Hypervisor console support (VM only)"
-	depends on S390
-	select HVC_DRIVER
-	select IUCV
-	default y
-	help
-	  This driver provides a Hypervisor console (HVC) back-end to access
-	  a Linux (console) terminal via a z/VM IUCV communication path.
-
-config HVC_XEN
-	bool "Xen Hypervisor Console support"
-	depends on XEN
-	select HVC_DRIVER
-	select HVC_IRQ
-	default y
-	help
-	  Xen virtual console device driver
-
-config HVC_UDBG
-       bool "udbg based fake hypervisor console"
-       depends on PPC && EXPERIMENTAL
-       select HVC_DRIVER
-       default n
-
-config HVC_DCC
-       bool "ARM JTAG DCC console"
-       depends on ARM
-       select HVC_DRIVER
-       help
-         This console uses the JTAG DCC on ARM to create a console under the HVC
-	 driver. This console is used through a JTAG only on ARM. If you don't have
-	 a JTAG then you probably don't want this option.
-
-config HVC_BFIN_JTAG
-	bool "Blackfin JTAG console"
-	depends on BLACKFIN
-	select HVC_DRIVER
-	help
-	 This console uses the Blackfin JTAG to create a console under the
-	 the HVC driver.  If you don't have JTAG, then you probably don't
-	 want this option.
+source "drivers/tty/hvc/Kconfig"
 
 config VIRTIO_CONSOLE
 	tristate "Virtio console"
@@ -716,23 +483,6 @@ config VIRTIO_CONSOLE
 	  the port which can be used by udev scripts to create a
 	  symlink to the device.
 
-config HVCS
-	tristate "IBM Hypervisor Virtual Console Server support"
-	depends on PPC_PSERIES && HVC_CONSOLE
-	help
-	  Partitionable IBM Power5 ppc64 machines allow hosting of
-	  firmware virtual consoles from one Linux partition by
-	  another Linux partition.  This driver allows console data
-	  from Linux partitions to be accessed through TTY device
-	  interfaces in the device tree of a Linux partition running
-	  this driver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called hvcs.  Additionally, this module
-	  will depend on arch specific APIs exported from hvcserver.ko
-	  which will also be compiled when this driver is built as a
-	  module.
-
 config IBM_BSR
 	tristate "IBM POWER Barrier Synchronization Register support"
 	depends on PPC_PSERIES
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
new file mode 100644
index 0000000..9cfbdb3
--- /dev/null
+++ b/drivers/tty/Kconfig
@@ -0,0 +1,150 @@
+config VT
+	bool "Virtual terminal" if EXPERT
+	depends on !S390
+	select INPUT
+	default y
+	---help---
+	  If you say Y here, you will get support for terminal devices with
+	  display and keyboard devices. These are called "virtual" because you
+	  can run several virtual terminals (also called virtual consoles) on
+	  one physical terminal. This is rather useful, for example one
+	  virtual terminal can collect system messages and warnings, another
+	  one can be used for a text-mode user session, and a third could run
+	  an X session, all in parallel. Switching between virtual terminals
+	  is done with certain key combinations, usually Alt-<function key>.
+
+	  The setterm command ("man setterm") can be used to change the
+	  properties (such as colors or beeping) of a virtual terminal. The
+	  man page console_codes(4) ("man console_codes") contains the special
+	  character sequences that can be used to change those properties
+	  directly. The fonts used on virtual terminals can be changed with
+	  the setfont ("man setfont") command and the key bindings are defined
+	  with the loadkeys ("man loadkeys") command.
+
+	  You need at least one virtual terminal device in order to make use
+	  of your keyboard and monitor. Therefore, only people configuring an
+	  embedded system would want to say N here in order to save some
+	  memory; the only way to log into such a system is then via a serial
+	  or network connection.
+
+	  If unsure, say Y, or else you won't be able to do much with your new
+	  shiny Linux system :-)
+
+config CONSOLE_TRANSLATIONS
+	depends on VT
+	default y
+	bool "Enable character translations in console" if EXPERT
+	---help---
+	  This enables support for font mapping and Unicode translation
+	  on virtual consoles.
+
+config VT_CONSOLE
+	bool "Support for console on virtual terminal" if EXPERT
+	depends on VT
+	default y
+	---help---
+	  The system console is the device which receives all kernel messages
+	  and warnings and which allows logins in single user mode. If you
+	  answer Y here, a virtual terminal (the device used to interact with
+	  a physical terminal) can be used as system console. This is the most
+	  common mode of operations, so you should say Y here unless you want
+	  the kernel messages be output only to a serial port (in which case
+	  you should say Y to "Console on serial port", below).
+
+	  If you do say Y here, by default the currently visible virtual
+	  terminal (/dev/tty0) will be used as system console. You can change
+	  that with a kernel command line option such as "console=tty3" which
+	  would use the third virtual terminal as system console. (Try "man
+	  bootparam" or see the documentation of your boot loader (lilo or
+	  loadlin) about how to pass options to the kernel at boot time.)
+
+	  If unsure, say Y.
+
+config HW_CONSOLE
+	bool
+	depends on VT && !S390 && !UML
+	default y
+
+config VT_HW_CONSOLE_BINDING
+       bool "Support for binding and unbinding console drivers"
+       depends on HW_CONSOLE
+       default n
+       ---help---
+         The virtual terminal is the device that interacts with the physical
+         terminal through console drivers. On these systems, at least one
+         console driver is loaded. In other configurations, additional console
+         drivers may be enabled, such as the framebuffer console. If more than
+         1 console driver is enabled, setting this to 'y' will allow you to
+         select the console driver that will serve as the backend for the
+         virtual terminals.
+
+	 See <file:Documentation/console/console.txt> for more
+	 information. For framebuffer console users, please refer to
+	 <file:Documentation/fb/fbcon.txt>.
+
+config UNIX98_PTYS
+	bool "Unix98 PTY support" if EXPERT
+	default y
+	---help---
+	  A pseudo terminal (PTY) is a software device consisting of two
+	  halves: a master and a slave. The slave device behaves identical to
+	  a physical terminal; the master device is used by a process to
+	  read data from and write data to the slave, thereby emulating a
+	  terminal. Typical programs for the master side are telnet servers
+	  and xterms.
+
+	  Linux has traditionally used the BSD-like names /dev/ptyxx for
+	  masters and /dev/ttyxx for slaves of pseudo terminals. This scheme
+	  has a number of problems. The GNU C library glibc 2.1 and later,
+	  however, supports the Unix98 naming standard: in order to acquire a
+	  pseudo terminal, a process opens /dev/ptmx; the number of the pseudo
+	  terminal is then made available to the process and the pseudo
+	  terminal slave can be accessed as /dev/pts/<number>. What was
+	  traditionally /dev/ttyp2 will then be /dev/pts/2, for example.
+
+	  All modern Linux systems use the Unix98 ptys.  Say Y unless
+	  you're on an embedded system and want to conserve memory.
+
+config DEVPTS_MULTIPLE_INSTANCES
+	bool "Support multiple instances of devpts"
+	depends on UNIX98_PTYS
+	default n
+	---help---
+	  Enable support for multiple instances of devpts filesystem.
+	  If you want to have isolated PTY namespaces (eg: in containers),
+	  say Y here.  Otherwise, say N. If enabled, each mount of devpts
+	  filesystem with the '-o newinstance' option will create an
+	  independent PTY namespace.
+
+config LEGACY_PTYS
+	bool "Legacy (BSD) PTY support"
+	default y
+	---help---
+	  A pseudo terminal (PTY) is a software device consisting of two
+	  halves: a master and a slave. The slave device behaves identical to
+	  a physical terminal; the master device is used by a process to
+	  read data from and write data to the slave, thereby emulating a
+	  terminal. Typical programs for the master side are telnet servers
+	  and xterms.
+
+	  Linux has traditionally used the BSD-like names /dev/ptyxx
+	  for masters and /dev/ttyxx for slaves of pseudo
+	  terminals. This scheme has a number of problems, including
+	  security.  This option enables these legacy devices; on most
+	  systems, it is safe to say N.
+
+
+config LEGACY_PTY_COUNT
+	int "Maximum number of legacy PTY in use"
+	depends on LEGACY_PTYS
+	range 0 256
+	default "256"
+	---help---
+	  The maximum number of legacy PTYs that can be used at any one time.
+	  The default is 256, and should be more than enough.  Embedded
+	  systems may want to reduce this to save memory.
+
+	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
+	  architectures and 24 bytes on 64-bit architectures.
+
+
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
new file mode 100644
index 0000000..6f2c980
--- /dev/null
+++ b/drivers/tty/hvc/Kconfig
@@ -0,0 +1,105 @@
+config HVC_DRIVER
+	bool
+	help
+	  Generic "hypervisor virtual console" infrastructure for various
+	  hypervisors (pSeries, iSeries, Xen, lguest).
+	  It will automatically be selected if one of the back-end console drivers
+	  is selected.
+
+config HVC_IRQ
+	bool
+
+config HVC_CONSOLE
+	bool "pSeries Hypervisor Virtual Console support"
+	depends on PPC_PSERIES
+	select HVC_DRIVER
+	select HVC_IRQ
+	help
+	  pSeries machines when partitioned support a hypervisor virtual
+	  console. This driver allows each pSeries partition to have a console
+	  which is accessed via the HMC.
+
+config HVC_ISERIES
+	bool "iSeries Hypervisor Virtual Console support"
+	depends on PPC_ISERIES
+	default y
+	select HVC_DRIVER
+	select HVC_IRQ
+	select VIOPATH
+	help
+	  iSeries machines support a hypervisor virtual console.
+
+config HVC_RTAS
+	bool "IBM RTAS Console support"
+	depends on PPC_RTAS
+	select HVC_DRIVER
+	help
+	  IBM Console device driver which makes use of RTAS
+
+config HVC_BEAT
+	bool "Toshiba's Beat Hypervisor Console support"
+	depends on PPC_CELLEB
+	select HVC_DRIVER
+	help
+	  Toshiba's Cell Reference Set Beat Console device driver
+
+config HVC_IUCV
+	bool "z/VM IUCV Hypervisor console support (VM only)"
+	depends on S390
+	select HVC_DRIVER
+	select IUCV
+	default y
+	help
+	  This driver provides a Hypervisor console (HVC) back-end to access
+	  a Linux (console) terminal via a z/VM IUCV communication path.
+
+config HVC_XEN
+	bool "Xen Hypervisor Console support"
+	depends on XEN
+	select HVC_DRIVER
+	select HVC_IRQ
+	default y
+	help
+	  Xen virtual console device driver
+
+config HVC_UDBG
+       bool "udbg based fake hypervisor console"
+       depends on PPC && EXPERIMENTAL
+       select HVC_DRIVER
+       default n
+
+config HVC_DCC
+       bool "ARM JTAG DCC console"
+       depends on ARM
+       select HVC_DRIVER
+       help
+         This console uses the JTAG DCC on ARM to create a console under the HVC
+	 driver. This console is used through a JTAG only on ARM. If you don't have
+	 a JTAG then you probably don't want this option.
+
+config HVC_BFIN_JTAG
+	bool "Blackfin JTAG console"
+	depends on BLACKFIN
+	select HVC_DRIVER
+	help
+	 This console uses the Blackfin JTAG to create a console under the
+	 the HVC driver.  If you don't have JTAG, then you probably don't
+	 want this option.
+
+config HVCS
+	tristate "IBM Hypervisor Virtual Console Server support"
+	depends on PPC_PSERIES && HVC_CONSOLE
+	help
+	  Partitionable IBM Power5 ppc64 machines allow hosting of
+	  firmware virtual consoles from one Linux partition by
+	  another Linux partition.  This driver allows console data
+	  from Linux partitions to be accessed through TTY device
+	  interfaces in the device tree of a Linux partition running
+	  this driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hvcs.  Additionally, this module
+	  will depend on arch specific APIs exported from hvcserver.ko
+	  which will also be compiled when this driver is built as a
+	  module.
+
-- 
1.7.4.1

