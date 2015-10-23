From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] serial: 8250_ingenic: allow to be independent of SERIAL_8250_CONSOLE
Date: Fri, 23 Oct 2015 22:31:16 +0900
Message-ID: <1445607076-14135-2-git-send-email-yamada.masahiro@socionext.com>
References: <1445607076-14135-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445607076-14135-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Paul Burton <paul.burton@imgtec.com>, Peter Hurley <peter@hurleysoftware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiri Slaby <jslaby@suse.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joachim Eastwood <manabian@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, John Crispin <blogic@openwrt.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-serial@vger.kernel.org

This UART driver should not depend on the console.  They should be
orthogonal.

Surround the earlycon code with CONFIG_SERIAL_EARLYCON conditional
and rip off "depends on SERIAL_8250_CONSOLE".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Currently, SERIAL_8250_FSL also depends on SERIAL_8250_CONSOLE,
but I doubt its necessity.


 drivers/tty/serial/8250/8250_ingenic.c | 2 ++
 drivers/tty/serial/8250/Kconfig        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 7c1e4be..44633ee 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -34,6 +34,7 @@ struct ingenic_uart_data {
 
 #define UART_FCR_UME	BIT(4)
 
+#ifdef CONFIG_SERIAL_EARLYCON
 static struct earlycon_device *early_device;
 
 static uint8_t __init early_in(struct uart_port *port, int offset)
@@ -126,6 +127,7 @@ OF_EARLYCON_DECLARE(jz4775_uart, "ingenic,jz4775-uart",
 EARLYCON_DECLARE(jz4780_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4780_uart, "ingenic,jz4780-uart",
 		    ingenic_early_console_setup);
+#endif /* CONFIG_SERIAL_EARLYCON */
 
 static void ingenic_uart_serial_out(struct uart_port *p, int offset, int value)
 {
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 960da95..6f62934 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -360,7 +360,7 @@ config SERIAL_8250_UNIPHIER
 
 config SERIAL_8250_INGENIC
 	bool "Support for Ingenic SoC serial ports"
-	depends on SERIAL_8250_CONSOLE && OF_FLATTREE
+	depends on OF_FLATTREE
 	select LIBFDT
 	help
 	  If you have a system using an Ingenic SoC and wish to make use of
-- 
1.9.1
