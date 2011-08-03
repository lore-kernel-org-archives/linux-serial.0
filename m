From: Greg KH <gregkh@suse.de>
Subject: [088/102] SERIAL: SC26xx: Fix link error.
Date: Wed, 03 Aug 2011 15:01:48 -0700
Message-ID: <20110803221252.928206230@clark.kroah.org>
References: <20110803221345.GA10346@kroah.com>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20110803221345.GA10346@kroah.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: stable-review@kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Ralf Baechle <ralf@linux-mips.org>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

3.0-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Ralf Baechle <ralf@linux-mips.org>

commit f2eb3cdf14457fccb14ae8c4d7d7cee088cd3957 upstream.

Kconfig allows enabling console support for the SC26xx driver even when
it's configured as a module resulting in a:

ERROR: "uart_console_device" [drivers/tty/serial/sc26xx.ko] undefined!

modpost error since the driver was merged in
eea63e0e8a60d00485b47fb6e75d9aa2566b989b [SC26XX: New serial driver for
SC2681 uarts] in 2.6.25.  Fixed by only allowing console support to be
enabled if the driver is builtin.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/tty/serial/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1419,7 +1419,7 @@ config SERIAL_SC26XX
 
 config SERIAL_SC26XX_CONSOLE
 	bool "Console on SC2681/SC2692 serial port"
-	depends on SERIAL_SC26XX
+	depends on SERIAL_SC26XX=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  Support for Console on SC2681/SC2692 serial ports.
