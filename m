From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 10/12] SERIAL: SC26xx: Fix link error.
Date: Mon, 27 Jun 2011 14:26:56 +0100
Message-ID: <f0b3d9a91be8dba5c45c14efebaa9c7800694f15.1309182743.git.ralf@linux-mips.org>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-serial@vger.kernel.org

Kconfig allows enabling console support for the SC26xx driver even when
it's configured as a module resulting in a:

ERROR: "uart_console_device" [drivers/tty/serial/sc26xx.ko] undefined!

modpost error since the driver was merged in
eea63e0e8a60d00485b47fb6e75d9aa2566b989b [SC26XX: New serial driver for
SC2681 uarts] in 2.6.25.  Fixed by only allowing console support to be
enabled if the driver is builtin.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/tty/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 636144c..b3692e6 100644
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
-- 
1.7.4.4
