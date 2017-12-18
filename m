From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] tty: serial: sh-sci: Add default for number of ports for compile-testing
Date: Mon, 18 Dec 2017 09:50:57 +0100
Message-ID: <1513587057-24355-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

When compile-testing an allmodconfig kernel for a platform without
sh-sci serial ports, the SERIAL_SH_SCI_NR_UARTS symbol of type "int"
doesn't get assigned a numerical default value, but an empty string,
leading to a build failure:

   .config:3814:warning: symbol value '' invalid for SERIAL_SH_SCI_NR_UARTS
   ...
   make[3]: *** [silentoldconfig] Error 1

Fix this by explicitly providing a default value of 2, like before.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: f6731485a51978ca ("tty: serial: sh-sci: Hide number of ports config question")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4e6dfb0a762b5807..3682fd3e960cbd64 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -766,6 +766,7 @@ config SERIAL_SH_SCI_NR_UARTS
 	default "3" if H8300
 	default "10" if SUPERH
 	default "18" if ARCH_RENESAS
+	default "2"
 
 config SERIAL_SH_SCI_CONSOLE
 	bool "Support for console on SuperH SCI(F)" if EXPERT
-- 
2.7.4
