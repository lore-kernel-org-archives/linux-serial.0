From: "Daniel Laird" <daniel.j.laird@nxp.com>
Subject: [PATCH] Allow PNX8XXX serial when PNX833x is selected.
Date: Sat, 26 Jul 2008 09:43:44 +0100
Message-ID: <64660ef00807260143i26aa0d1bn90eb5dc5de9f7504@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: linux-serial@vger.kernel.org
Cc: linux-mips@linux-mips.org
List-Id: linux-serial@vger.kernel.org

This enables support for the serial console on PNX833x.
Same block as PNX8550 just need to unhide config option.

 Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Daniel Laird <daniel.j.laird@nxp.com>

--- a.updated/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -975,7 +975,7 @@

 config SERIAL_PNX8XXX
 	bool "Enable PNX8XXX SoCs' UART Support"
-	depends on MIPS && SOC_PNX8550
+	depends on MIPS && (SOC_PNX8550 || SOC_PNX833X)
 	select SERIAL_CORE
 	help
 	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
