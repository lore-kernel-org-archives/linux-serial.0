From: Daniel J Laird <daniel.j.laird@nxp.com>
Subject: [PATCH] Enabling PNX8XXX serial for NXP devices other than PNX8550.
Date: Mon, 3 Nov 2008 16:28:06 +0100
Message-ID: <C13DBBE85AD6974B85C118C35890CA5F13B22CBA46@EU1RDCRDC1WX029.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Language: en-US
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
List-Id: linux-serial@vger.kernel.org

NXP PNX83XX SOCs use the same serial IP block as PNX8550 yet cannot select it
due to KConfig dependencies.  This patch enables support for PNX8550 and PNX83XX SoCs.

Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Signed-off-by: daniel.j.laird <daniel.j.laird@nxp.com>

diff -urN linux.git.orig/drivers/serial/Kconfig linux.git.new/drivers/serial/Kconfig
--- linux.git.orig/drivers/serial/Kconfig	2008-10-27 14:40:31.000000000 +0000
+++ linux.git.new/drivers/serial/Kconfig	2008-11-03 15:01:54.000000000 +0000
@@ -959,10 +959,10 @@
 
 config SERIAL_PNX8XXX
 	bool "Enable PNX8XXX SoCs' UART Support"
-	depends on MIPS && SOC_PNX8550
+	depends on MIPS && (SOC_PNX8550 || SOC_PNX833X)
 	select SERIAL_CORE
 	help
-	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
+	  If you have a MIPS-based NXP SoC such as PNX8550 or PNX8330/2/5
 	  and you want to use serial ports, say Y.  Otherwise, say N.
 
 config SERIAL_PNX8XXX_CONSOLE
@@ -970,7 +970,7 @@
 	depends on SERIAL_PNX8XXX
 	select SERIAL_CORE_CONSOLE
 	help
-	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
+	  If you have a MIPS-based NXP SoC such as PNX8550 or PNX8330/2/5
 	  and you want to use serial console, say Y. Otherwise, say N.
 
 config SERIAL_CORE
