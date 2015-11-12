From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] serial: 8250_mid: Add missing dependency
Date: Thu, 12 Nov 2015 15:21:23 +0200
Message-ID: <1447334483-126186-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

8250_mid uses rational_best_approximation() function, so the
driver needs to select CONFIG_RATIONAL option.

This fixes build error when CONFIG_RATIONAL is not enabled:

drivers/built-in.o: In function `mid8250_set_termios':
8250_mid.c:(.text+0x10169a): undefined reference to `rational_best_approximation'

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index e6f5e12..6412f14 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -373,6 +373,7 @@ config SERIAL_8250_MID
 	depends on SERIAL_8250 && PCI
 	select HSU_DMA if SERIAL_8250_DMA
 	select HSU_DMA_PCI if X86_INTEL_MID
+	select RATIONAL
 	help
 	  Selecting this option will enable handling of the extra features
 	  present on the UART found on Intel Medfield SOC and various other
-- 
2.6.2
