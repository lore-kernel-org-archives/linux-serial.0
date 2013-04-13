From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/2] tty: serial: ralink: fix SERIAL_8250_RT288X dependency
Date: Sat, 13 Apr 2013 11:39:32 +0200
Message-ID: <1365845973-16164-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:39564 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412Ab3DMJng (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Apr 2013 05:43:36 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, John Crispin <blogic@openwrt.org>

With every Ralink SoC that we add, we would need to extend the dependency. In
order to make life easier we make the symbol depend on MIPS & RALINK and then
select it from within arch/mips/ralink/.

Signed-off-by: John Crispin <blogic@openwrt.org>
---

These 2 patches in this series should be merged via the mips tree. Patch 1/2
requires an Ack from the tty maintainer.

 drivers/tty/serial/8250/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 80fe91e..24ea3c8 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -295,8 +295,8 @@ config SERIAL_8250_EM
 	  If unsure, say N.
 
 config SERIAL_8250_RT288X
-	bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
-	depends on SERIAL_8250 && (SOC_RT288X || SOC_RT305X || SOC_RT3883)
+	bool
+	depends on SERIAL_8250 && MIPS && RALINK
 	help
 	  If you have a Ralink RT288x/RT305x SoC based board and want to use the
 	  serial port, say Y to this option. The driver can handle up to 2 serial
-- 
1.7.10.4

