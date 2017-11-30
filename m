From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/5] tty: serial: sh-sci: Hide serial console config question
Date: Thu, 30 Nov 2017 14:11:59 +0100
Message-ID: <1512047522-16312-3-git-send-email-geert+renesas@glider.be>
References: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Most users will want to use a serial console.

Hence make that the default, unless CONFIG_EXPERT is enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index bd96046d7f94bac0..0c75562d620feb82 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -768,9 +768,10 @@ config SERIAL_SH_SCI_NR_UARTS
 	default "18" if ARCH_RENESAS
 
 config SERIAL_SH_SCI_CONSOLE
-	bool "Support for console on SuperH SCI(F)"
+	bool "Support for console on SuperH SCI(F)" if EXPERT
 	depends on SERIAL_SH_SCI=y
 	select SERIAL_CORE_CONSOLE
+	default y
 
 config SERIAL_SH_SCI_EARLYCON
 	bool "Support for early console on SuperH SCI(F)"
-- 
2.7.4

