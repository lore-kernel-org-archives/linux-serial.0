From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4/4] serial: 8250_ingenic: drop #if conditional surrounding earlycon code
Date: Mon,  6 Jun 2016 18:41:03 +0900
Message-ID: <1465206063-1018-5-git-send-email-yamada.masahiro@socionext.com>
References: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Paul Burton <paul.burton@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Anton Wuerfel <anton.wuerfel@fau.de>, Scott Wood <scottwood@freescale.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Martin Sperl <kernel@martin.sperl.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mathieu OTHACEHE <m.othacehe@gmail.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Mans Rullgard <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

The #if defined(CONFIG_SERIAL_EARLYCON) && !defined(MODULE)
conditional has been added to the OF_EARLYCON_DECLARE() define.

The same conditional can be dropped from 8250_ingenic.c because
the unused symbols will be marked as __maybe_unsed.
Also, the Kconfig dependency can become much simpler.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_ingenic.c | 2 --
 drivers/tty/serial/8250/Kconfig        | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index b0677f6..4d9dc10 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -48,7 +48,6 @@ static const struct of_device_id of_match[];
 #define UART_MCR_MDCE	BIT(7)
 #define UART_MCR_FCM	BIT(6)
 
-#if defined(CONFIG_SERIAL_EARLYCON) && !defined(MODULE)
 static struct earlycon_device *early_device;
 
 static uint8_t __init early_in(struct uart_port *port, int offset)
@@ -141,7 +140,6 @@ OF_EARLYCON_DECLARE(jz4775_uart, "ingenic,jz4775-uart",
 EARLYCON_DECLARE(jz4780_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4780_uart, "ingenic,jz4780-uart",
 		    ingenic_early_console_setup);
-#endif /* CONFIG_SERIAL_EARLYCON */
 
 static void ingenic_uart_serial_out(struct uart_port *p, int offset, int value)
 {
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index b5a0f2e..7c6f7af 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -396,7 +396,7 @@ config SERIAL_8250_UNIPHIER
 config SERIAL_8250_INGENIC
 	tristate "Support for Ingenic SoC serial ports"
 	depends on SERIAL_8250
-	depends on (OF_FLATTREE && SERIAL_8250_CONSOLE) || !SERIAL_EARLYCON
+	depends on OF_FLATTREE
 	depends on MIPS || COMPILE_TEST
 	help
 	  If you have a system using an Ingenic SoC and wish to make use of
-- 
1.9.1
