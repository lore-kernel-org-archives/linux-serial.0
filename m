From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/5] tty: serial: sh-sci: Hide earlycon config question
Date: Thu, 30 Nov 2017 14:12:00 +0100
Message-ID: <1512047522-16312-4-git-send-email-geert+renesas@glider.be>
References: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Renesas H8/300 and ARM platforms use DT and support earlycon, so most
users want earlycon support to be enabled.

On SuperH platforms, earlycon is not yet supported.

Hence follow the above rationale to configure the default, unless
CONFIG_EXPERT is enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0c75562d620feb82..952a2c6a9da08fdd 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -774,10 +774,11 @@ config SERIAL_SH_SCI_CONSOLE
 	default y
 
 config SERIAL_SH_SCI_EARLYCON
-	bool "Support for early console on SuperH SCI(F)"
+	bool "Support for early console on SuperH SCI(F)" if EXPERT
 	depends on SERIAL_SH_SCI=y
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
+	default ARCH_RENESAS || H8300
 
 config SERIAL_SH_SCI_DMA
 	bool "DMA support"
-- 
2.7.4

