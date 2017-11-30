From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/5] tty: serial: sh-sci: Hide DMA config question
Date: Thu, 30 Nov 2017 14:12:01 +0100
Message-ID: <1512047522-16312-5-git-send-email-geert+renesas@glider.be>
References: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

On most Renesas ARM platforms, the SCIF serial ports can be used with
DMA, so most users will want DMA support to be enabled.

On SuperH platforms, SCI(F) serial ports cannot be used with DMA yet
(see also commit 219fb0c1436e4893 ("serial: sh-sci: Remove the platform
data dma slave rx/tx channel IDs")), so users will want it disabled to
reduce kernel size.

Hence follow the above rationale to configure the default, unless
CONFIG_EXPERT is enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 952a2c6a9da08fdd..4e6dfb0a762b5807 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -781,8 +781,9 @@ config SERIAL_SH_SCI_EARLYCON
 	default ARCH_RENESAS || H8300
 
 config SERIAL_SH_SCI_DMA
-	bool "DMA support"
+	bool "DMA support" if EXPERT
 	depends on SERIAL_SH_SCI && DMA_ENGINE
+	default ARCH_RENESAS
 
 config SERIAL_PNX8XXX
 	bool "Enable PNX8XXX SoCs' UART Support"
-- 
2.7.4
