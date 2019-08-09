From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 04/13] serial: lpc32xx_hs: allow compile-testing
Date: Fri,  9 Aug 2019 16:40:30 +0200
Message-ID: <20190809144043.476786-5-arnd@arndb.de>
References: <20190809144043.476786-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190809144043.476786-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: soc@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>, linux-serial@vger.kernel.org, Sylvain Lemieux <slemieux.tyco@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The only thing that prevents building this driver on other
platforms is the mach/hardware.h include, which is not actually
used here at all, so remove the line and allow CONFIG_COMPILE_TEST.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/Kconfig      | 3 ++-
 drivers/tty/serial/lpc32xx_hs.c | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3083dbae35f7..518aac902e4b 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -739,7 +739,8 @@ config SERIAL_PNX8XXX_CONSOLE
 
 config SERIAL_HS_LPC32XX
 	tristate "LPC32XX high speed serial port support"
-	depends on ARCH_LPC32XX && OF
+	depends on ARCH_LPC32XX || COMPILE_TEST
+	depends on OF
 	select SERIAL_CORE
 	help
 	  Support for the LPC32XX high speed serial ports (up to 900kbps).
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index f4e27d0ad947..7f14cd8fac47 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -25,8 +25,6 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
-#include <mach/platform.h>
-#include <mach/hardware.h>
 
 /*
  * High Speed UART register offsets
-- 
2.20.0
