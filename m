From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH] serial: 8250: remove Kconfig indirection
Date: Sun, 12 Apr 2015 17:37:24 +0200
Message-ID: <1428853044-5954-1-git-send-email-valentinrothberg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, geert@linux-m68k.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: linux-serial@vger.kernel.org

Remove CONFIG_SERIAL_DETECT_IRQ and CONFIG_SERIAL_MANY_PORTS, and
substitute all references to the proper 8250 Kconfig options.  Now, the
actual Kconfig dependencies are not hidden when reading the code and
static analyzers are less confused.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
I detected this issue with ./scripts/checkkconfigsymbols.py
---
 arch/alpha/include/asm/serial.h     | 2 +-
 arch/m68k/include/asm/serial.h      | 2 +-
 arch/mn10300/include/asm/serial.h   | 4 ++--
 arch/x86/include/asm/serial.h       | 2 +-
 drivers/tty/serial/8250/8250_core.c | 8 --------
 5 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/alpha/include/asm/serial.h b/arch/alpha/include/asm/serial.h
index 9d263e8d8ccc..22909b83f473 100644
--- a/arch/alpha/include/asm/serial.h
+++ b/arch/alpha/include/asm/serial.h
@@ -13,7 +13,7 @@
 #define BASE_BAUD ( 1843200 / 16 )
 
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
-#ifdef CONFIG_SERIAL_DETECT_IRQ
+#ifdef CONFIG_SERIAL_8250_DETECT_IRQ
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
 #define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
 #else
diff --git a/arch/m68k/include/asm/serial.h b/arch/m68k/include/asm/serial.h
index 7267536adbcc..06d0cb19b4e1 100644
--- a/arch/m68k/include/asm/serial.h
+++ b/arch/m68k/include/asm/serial.h
@@ -17,7 +17,7 @@
 #define BASE_BAUD ( 1843200 / 16 )
 
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
-#ifdef CONFIG_SERIAL_DETECT_IRQ
+#ifdef CONFIG_SERIAL_8250_DETECT_IRQ
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
 #define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
 #else
diff --git a/arch/mn10300/include/asm/serial.h b/arch/mn10300/include/asm/serial.h
index 23a799293599..c1990218f18c 100644
--- a/arch/mn10300/include/asm/serial.h
+++ b/arch/mn10300/include/asm/serial.h
@@ -13,7 +13,7 @@
 #define _ASM_SERIAL_H
 
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
-#ifdef CONFIG_SERIAL_DETECT_IRQ
+#ifdef CONFIG_SERIAL_8250_DETECT_IRQ
 #define STD_COM_FLAGS	(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
 #define STD_COM4_FLAGS	(ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
 #else
@@ -21,7 +21,7 @@
 #define STD_COM4_FLAGS	ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
+#ifdef CONFIG_SERIAL_8250_MANY_PORTS
 #define FOURPORT_FLAGS	ASYNC_FOURPORT
 #define ACCENT_FLAGS	0
 #define BOCA_FLAGS	0
diff --git a/arch/x86/include/asm/serial.h b/arch/x86/include/asm/serial.h
index 8378b8c9109c..bb658211edad 100644
--- a/arch/x86/include/asm/serial.h
+++ b/arch/x86/include/asm/serial.h
@@ -11,7 +11,7 @@
 #define BASE_BAUD (1843200/16)
 
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
-#ifdef CONFIG_SERIAL_DETECT_IRQ
+#ifdef CONFIG_SERIAL_8250_DETECT_IRQ
 # define STD_COMX_FLAGS	(UPF_BOOT_AUTOCONF |	UPF_SKIP_TEST	| UPF_AUTO_IRQ)
 # define STD_COM4_FLAGS	(UPF_BOOT_AUTOCONF |	0		| UPF_AUTO_IRQ)
 #else
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 1aa349a97172..80c721948caf 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -85,14 +85,6 @@ static unsigned int skip_txen_test; /* force skip of txen test at init time */
 #define BOTH_EMPTY 	(UART_LSR_TEMT | UART_LSR_THRE)
 
 
-#ifdef CONFIG_SERIAL_8250_DETECT_IRQ
-#define CONFIG_SERIAL_DETECT_IRQ 1
-#endif
-#ifdef CONFIG_SERIAL_8250_MANY_PORTS
-#define CONFIG_SERIAL_MANY_PORTS 1
-#endif
-
-
 #include <asm/serial.h>
 /*
  * SERIAL_PORT_DFNS tells us about built-in ports that have no
-- 
2.1.0
