From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] [48/50] SERIAL: SC26xx: Fix link error.
Date: Thu, 28 Jul 2011 16:44:53 -0700 (PDT)
Message-ID: <20110728234453.299DF2403FF@tassilo.jf.intel.com>
References: <20110728444.299940435@firstfloor.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110728444.299940435@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ralf@linux-mips.org, linux-serial@vger.kernel.org, linux-mips@linux-mips.org, alan@linux.intel.com, gregkh@suse.de, ak@linux.intel.com, linux-kernel@vger.kernel.org, stable@kernel.org
List-Id: linux-serial@vger.kernel.org

2.6.35-longterm review patch.  If anyone has any objections, please let me know.

------------------
From: Ralf Baechle <ralf@linux-mips.org>

[ upstream commit f2eb3cdf14457fccb14ae8c4d7d7cee088cd3957 ]

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
Cc: stable <stable@kernel.org>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Andi Kleen <ak@linux.intel.com>

Index: linux-2.6.35.y/drivers/serial/Kconfig
===================================================================
--- linux-2.6.35.y.orig/drivers/serial/Kconfig
+++ linux-2.6.35.y/drivers/serial/Kconfig
@@ -1417,7 +1417,7 @@ config SERIAL_SC26XX
 
 config SERIAL_SC26XX_CONSOLE
 	bool "Console on SC2681/SC2692 serial port"
-	depends on SERIAL_SC26XX
+	depends on SERIAL_SC26XX=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  Support for Console on SC2681/SC2692 serial ports.
