From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] tty: serial: fix typo "ARCH_S5P6450"
Date: Sat, 09 Mar 2013 23:16:44 +0100
Message-ID: <1362867404.3137.44.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Ben Dooks <ben-linux@fluff.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This could have been either ARCH_S5P64X0 or CPU_S5P6450. Looking at
commit 2555e663b367b8d555e76023f4de3f6338c28d6c ("ARM: S5P64X0: Add UART
serial support for S5P6450") - which added this typo - makes clear this
should be CPU_S5P6450.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Bravely untested.

 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index cf9210d..40ddbe4 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -218,7 +218,7 @@ config SERIAL_SAMSUNG_UARTS_4
 config SERIAL_SAMSUNG_UARTS
 	int
 	depends on PLAT_SAMSUNG
-	default 6 if ARCH_S5P6450
+	default 6 if CPU_S5P6450
 	default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
 	default 3
 	help
-- 
1.7.11.7
