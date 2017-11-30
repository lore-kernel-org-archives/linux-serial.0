From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/5] tty: serial: sh-sci: Hide number of ports config question
Date: Thu, 30 Nov 2017 14:11:58 +0100
Message-ID: <1512047522-16312-2-git-send-email-geert+renesas@glider.be>
References: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Auto-configure the maximum number of serial ports based on how many can
be present on the architecture:
  - 3 on H8/300,
  - 10 on SuperH,
  - 18 on Reneas ARM.

The default can still be overridden if CONFIG_EXPERT is enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index b788fee54249deff..bd96046d7f94bac0 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -761,9 +761,11 @@ config SERIAL_SH_SCI
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 
 config SERIAL_SH_SCI_NR_UARTS
-	int "Maximum number of SCI(F) serial ports"
+	int "Maximum number of SCI(F) serial ports" if EXPERT
 	depends on SERIAL_SH_SCI
-	default "2"
+	default "3" if H8300
+	default "10" if SUPERH
+	default "18" if ARCH_RENESAS
 
 config SERIAL_SH_SCI_CONSOLE
 	bool "Support for console on SuperH SCI(F)"
-- 
2.7.4
