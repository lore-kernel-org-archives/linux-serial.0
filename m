From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] tty: serial/8250: remove console dependency for mediatek
Date: Tue, 19 May 2015 22:11:09 +0200
Message-ID: <2421682.546VBfrkgn@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-serial@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

If the mediatek serial port driver is built-in, but serial
console is disabled in Kconfig (e.g. when the serial driver
itself is a loadable module), we get this build error:

drivers/built-in.o: In function `early_mtk8250_setup':
undefined reference to `early_serial8250_setup'

To avoid that problem, this patch encloses the early_mtk8250_setup
function in #ifdef CONFIG_SERIAL_8250_CONSOLE, the same symbol
that guards the early_serial8250_setup function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 4488c2bdb7ba..78883ca64ddd 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -305,6 +305,7 @@ static struct platform_driver mtk8250_platform_driver = {
 };
 module_platform_driver(mtk8250_platform_driver);
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
 static int __init early_mtk8250_setup(struct earlycon_device *device,
 					const char *options)
 {
@@ -317,6 +318,7 @@ static int __init early_mtk8250_setup(struct earlycon_device *device,
 }
 
 OF_EARLYCON_DECLARE(mtk8250, "mediatek,mt6577-uart", early_mtk8250_setup);
+#endif
 
 MODULE_AUTHOR("Matthias Brugger");
 MODULE_LICENSE("GPL");
