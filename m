From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] 8250: uniphier: allow modular build with 8250 console
Date: Wed, 13 Jan 2016 23:33:59 +0100
Message-ID: <3965359.aMgb8o9MaG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, peter@hurleysoftware.com
List-Id: linux-serial@vger.kernel.org

The recently added uniphier 8250 port driver supports early console
probing, and it supports being built as a module, but the combination
of the two fails to link:

ERROR: "early_serial8250_setup" [drivers/tty/serial/8250/8250_uniphier.ko] undefined!

Given that earlycon support in a loadable module makes no sense,
making that code conditional on 'MODULE' is a correct solution.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b8d20e06eaad ("serial: 8250_uniphier: add earlycon support")

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index bab6b3ae2540..1b7bd26555b7 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -35,7 +35,7 @@ struct uniphier8250_priv {
 	spinlock_t atomic_write_lock;
 };
 
-#ifdef CONFIG_SERIAL_8250_CONSOLE
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
 static int __init uniphier_early_console_setup(struct earlycon_device *device,
 					       const char *options)
 {
