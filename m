From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 4/8] serial: Fix ASYNC_* => UPF_* flags misuse
Date: Sun, 10 Jan 2016 20:23:58 -0800
Message-ID: <1452486242-7297-5-git-send-email-peter@hurleysoftware.com>
References: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The UPF_* flags are the correct values to use for struct uart_port
and struct old_serial_port/SERIAL_PORT_DFNS.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 arch/alpha/include/asm/serial.h      |  8 ++++----
 arch/frv/include/asm/serial.h        |  2 +-
 arch/m68k/include/asm/serial.h       |  8 ++++----
 arch/mips/pmcs-msp71xx/msp_serial.c  |  2 +-
 arch/mn10300/include/asm/serial.h    | 10 +++++-----
 arch/xtensa/platforms/xt2000/setup.c |  2 +-
 drivers/tty/serial/serial_ks8695.c   |  2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/alpha/include/asm/serial.h b/arch/alpha/include/asm/serial.h
index 22909b8..e31557f 100644
--- a/arch/alpha/include/asm/serial.h
+++ b/arch/alpha/include/asm/serial.h
@@ -14,11 +14,11 @@
 
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
 #ifdef CONFIG_SERIAL_8250_DETECT_IRQ
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
-#define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
+#define STD_COM_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_AUTO_IRQ)
+#define STD_COM4_FLAGS (UPF_BOOT_AUTOCONF | UPF_AUTO_IRQ)
 #else
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
-#define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
+#define STD_COM_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST)
+#define STD_COM4_FLAGS UPF_BOOT_AUTOCONF
 #endif
 
 #define SERIAL_PORT_DFNS			\
diff --git a/arch/frv/include/asm/serial.h b/arch/frv/include/asm/serial.h
index dbb8259..bce0d0d 100644
--- a/arch/frv/include/asm/serial.h
+++ b/arch/frv/include/asm/serial.h
@@ -13,6 +13,6 @@
  */
 #define BASE_BAUD 0
 
-#define STD_COM_FLAGS		ASYNC_BOOT_AUTOCONF
+#define STD_COM_FLAGS		UPF_BOOT_AUTOCONF
 
 #define SERIAL_PORT_DFNS
diff --git a/arch/m68k/include/asm/serial.h b/arch/m68k/include/asm/serial.h
index 06d0cb1..6d44970 100644
--- a/arch/m68k/include/asm/serial.h
+++ b/arch/m68k/include/asm/serial.h
@@ -18,11 +18,11 @@
 
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
 #ifdef CONFIG_SERIAL_8250_DETECT_IRQ
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
-#define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
+#define STD_COM_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_AUTO_IRQ)
+#define STD_COM4_FLAGS (UPF_BOOT_AUTOCONF | UPF_AUTO_IRQ)
 #else
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
-#define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
+#define STD_COM_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST)
+#define STD_COM4_FLAGS UPF_BOOT_AUTOCONF
 #endif
 
 #ifdef CONFIG_ISA
diff --git a/arch/mips/pmcs-msp71xx/msp_serial.c b/arch/mips/pmcs-msp71xx/msp_serial.c
index d304be2..8e6e8db 100644
--- a/arch/mips/pmcs-msp71xx/msp_serial.c
+++ b/arch/mips/pmcs-msp71xx/msp_serial.c
@@ -110,7 +110,7 @@ void __init msp_serial_setup(void)
 	up.uartclk	= uartclk;
 	up.regshift	= 2;
 	up.iotype	= UPIO_MEM;
-	up.flags	= ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	up.flags	= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
 	up.type		= PORT_16550A;
 	up.line		= 0;
 	up.serial_out	= msp_serial_out;
diff --git a/arch/mn10300/include/asm/serial.h b/arch/mn10300/include/asm/serial.h
index c199021..594ebff 100644
--- a/arch/mn10300/include/asm/serial.h
+++ b/arch/mn10300/include/asm/serial.h
@@ -14,15 +14,15 @@
 
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
 #ifdef CONFIG_SERIAL_8250_DETECT_IRQ
-#define STD_COM_FLAGS	(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
-#define STD_COM4_FLAGS	(ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
+#define STD_COM_FLAGS	(UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_AUTO_IRQ)
+#define STD_COM4_FLAGS	(UPF_BOOT_AUTOCONF | UPF_AUTO_IRQ)
 #else
-#define STD_COM_FLAGS	(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
-#define STD_COM4_FLAGS	ASYNC_BOOT_AUTOCONF
+#define STD_COM_FLAGS	(UPF_BOOT_AUTOCONF | UPF_SKIP_TEST)
+#define STD_COM4_FLAGS	UPF_BOOT_AUTOCONF
 #endif
 
 #ifdef CONFIG_SERIAL_8250_MANY_PORTS
-#define FOURPORT_FLAGS	ASYNC_FOURPORT
+#define FOURPORT_FLAGS	UPF_FOURPORT
 #define ACCENT_FLAGS	0
 #define BOCA_FLAGS	0
 #define HUB6_FLAGS	0
diff --git a/arch/xtensa/platforms/xt2000/setup.c b/arch/xtensa/platforms/xt2000/setup.c
index 8767896..5f4bd71 100644
--- a/arch/xtensa/platforms/xt2000/setup.c
+++ b/arch/xtensa/platforms/xt2000/setup.c
@@ -113,7 +113,7 @@ void platform_heartbeat(void)
 }
 
 //#define RS_TABLE_SIZE 2
-//#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST)
+//#define STD_COM_FLAGS (UPF_BOOT_AUTOCONF|UPF_SKIP_TEST)
 
 #define _SERIAL_PORT(_base,_irq)					\
 {									\
diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
index b4decf8..57f1523 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -554,7 +554,7 @@ static struct uart_port ks8695uart_ports[SERIAL_KS8695_NR] = {
 		.uartclk	= KS8695_CLOCK_RATE * 16,
 		.fifosize	= 16,
 		.ops		= &ks8695uart_pops,
-		.flags		= ASYNC_BOOT_AUTOCONF,
+		.flags		= UPF_BOOT_AUTOCONF,
 		.line		= 0,
 	}
 };
-- 
2.7.0
