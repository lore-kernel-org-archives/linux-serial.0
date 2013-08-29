From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] tty: ar933x_uart: allow to build the driver as a module
Date: Thu, 29 Aug 2013 11:37:19 +0200
Message-ID: <1377769039-26265-1-git-send-email-juhosg@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:36112 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060Ab3H2JhY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Aug 2013 05:37:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>

Change the SERIAL_AR933X Kconfig option from
'bool' to 'tristate' in order to allow to build
the driver as a module. Also extend the help text
of the option to reflect that.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
The patch is agains the 'tty-next' branch of the
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tree
---
 drivers/tty/serial/Kconfig |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3c598e3..cc4c868 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1401,13 +1401,16 @@ config SERIAL_XILINX_PS_UART_CONSOLE
 	  Enable a Xilinx PS UART port to be the system console.
 
 config SERIAL_AR933X
-	bool "AR933X serial port support"
+	tristate "AR933X serial port support"
 	depends on HAVE_CLK && SOC_AR933X
 	select SERIAL_CORE
 	help
 	  If you have an Atheros AR933X SOC based board and want to use the
 	  built-in UART of the SoC, say Y to this option.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called ar933x_uart.
+
 config SERIAL_AR933X_CONSOLE
 	bool "Console on AR933X serial port"
 	depends on SERIAL_AR933X=y
-- 
1.7.10
