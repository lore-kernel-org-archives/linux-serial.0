From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: Change Kconfig entry for CLPS711X-target
Date: Tue, 31 Jul 2012 18:29:08 +0400
Message-ID: <1343744948-9473-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp26.mail.ru ([94.100.176.179]:38769 "EHLO smtp26.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab2GaO3Q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 Jul 2012 10:29:16 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>

This trivial patch adds a short description for SERIAL_CLPS711X Kconfig
entry, removes excess dependence on the ARM-platform (this is done
globally for the platform), allows the driver to be compiled by default
and removes unnecessary description about GRUB and LILO, because these
bootloaders do not supported this platform.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/Kconfig |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4ecef98..0300493 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -160,10 +160,12 @@ config SERIAL_KS8695_CONSOLE
 
 config SERIAL_CLPS711X
 	tristate "CLPS711X serial port support"
-	depends on ARM && ARCH_CLPS711X
+	depends on ARCH_CLPS711X
 	select SERIAL_CORE
+	default y
 	help
-	  ::: To be written :::
+	  This enables the driver for the on-chip UARTs of the Cirrus
+	  Logic EP711x/EP721x/EP731x processors.
 
 config SERIAL_CLPS711X_CONSOLE
 	bool "Support for console on CLPS711X serial port"
@@ -173,9 +175,7 @@ config SERIAL_CLPS711X_CONSOLE
 	  Even if you say Y here, the currently visible virtual console
 	  (/dev/tty0) will still be used as the system console by default, but
 	  you can alter that using a kernel command line option such as
-	  "console=ttyCL1". (Try "man bootparam" or see the documentation of
-	  your boot loader (lilo or loadlin) about how to pass options to the
-	  kernel at boot time.)
+	  "console=ttyCL1".
 
 config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
-- 
1.7.3.4

