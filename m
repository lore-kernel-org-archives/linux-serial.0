From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] kgdb: depends on VT
Date: Mon, 11 Jan 2016 18:31:08 +0100
Message-ID: <1452533468-16022-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jason.wessel@windriver.com
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

With VT=n, the kernel build fails with:
drivers/built-in.o: In function `kgdboc_pre_exp_handler':
kgdboc.c:(.text+0x7b5aa): undefined reference to `fg_console'
kgdboc.c:(.text+0x7b5ce): undefined reference to `vc_cons'
kgdboc.c:(.text+0x7b5d5): undefined reference to `vc_cons'

kgdboc.o is built when KGDB_SERIAL_CONSOLE is set. So make
KGDB_SERIAL_CONSOLE depend on HW_CONSOLE which includes those symbols.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: "Jim Davis" <jim.epost@gmail.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: <kgdb-bugreport@lists.sourceforge.net>
Cc: <linux-serial@vger.kernel.org>
---
 lib/Kconfig.kgdb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index c635a107a7de..533f912638ed 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -22,7 +22,7 @@ config KGDB_SERIAL_CONSOLE
 	tristate "KGDB: use kgdb over the serial console"
 	select CONSOLE_POLL
 	select MAGIC_SYSRQ
-	depends on TTY
+	depends on TTY && HW_CONSOLE
 	default y
 	help
 	  Share a serial console with kgdb. Sysrq-g must be used
-- 
2.7.0
