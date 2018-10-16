From: <shubhrajyoti.datta@gmail.com>
Subject: [LINUX PATCHv3 9/9] serial-uartlite: Remove SERIAL_UARTLITE_NR_UARTS
Date: Tue, 16 Oct 2018 15:48:08 +0530
Message-ID: <1539685088-13465-10-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, jacmet@sunsite.dk, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Remove SERIAL_UARTLITE_NR_UARTS from Kconfig as it is unused.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 32886c3..dc34d43 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -543,15 +543,6 @@ config SERIAL_UARTLITE_CONSOLE
 	  console (the system console is the device which receives all kernel
 	  messages and warnings and which allows logins in single user mode).
 
-config SERIAL_UARTLITE_NR_UARTS
-	int "Maximum number of uartlite serial ports"
-	depends on SERIAL_UARTLITE
-	range 1 256
-	default 1
-	help
-	  Set this to the number of uartlites in your system, or the number
-	  you think you might implement.
-
 config SERIAL_SUNCORE
 	bool
 	depends on SPARC
-- 
2.1.1
