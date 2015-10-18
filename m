From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] tty/serial: make early console depend on SERIAL_CORE=y
Date: Sun, 18 Oct 2015 18:06:48 -0400
Message-ID: <1445206009-12275-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On an powerpc allmodconfig build, the following is seen:

paul@builder:~/git/linux-head$ make O=../ppc-build -j30 > /dev/null
drivers/built-in.o: In function `.setup_earlycon':
(.init.text+0x5b00): undefined reference to `.uart_parse_earlycon'
make[1]: *** [vmlinux] Error 1

Since uart_parse_earlycon lives in serial_core.c we need to ensure
it is built in if early console is to be used.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[A google shows this cropped up in April of this year; I guess it wasn't
 completely fixed?
 http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/336954.html
 FWIW, I was testing on tty/tty-testing pulled today, from Greg  ]

 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 1aec4404062d..a646047e4051 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -9,6 +9,7 @@ menu "Serial drivers"
 
 config SERIAL_EARLYCON
 	bool
+	depends on SERIAL_CORE=y
 	help
 	  Support for early consoles with the earlycon parameter. This enables
 	  the console before standard serial driver is probed. The console is
-- 
2.6.1
