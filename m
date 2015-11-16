From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/6] serial: mid8250: select CONFIG_RATIONAL
Date: Mon, 16 Nov 2015 16:48:11 +0100
Message-ID: <1447688894-2936779-4-git-send-email-arnd@arndb.de>
References: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The Intel MID support got split out from the PCI 8250 driver,
and that now causes a build error when no other driver selects
CONFIG_RATIONAL:

drivers/built-in.o: In function `mid8250_set_termios':
(.text+0x77418): undefined reference to `rational_best_approximation'

This adds an explicit 'select' like the combined driver had before.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: d9eda9bab237 ("serial: 8250_pci: Intel MID UART support to its own driver")
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index e6f5e12a2d83..6412f1455beb 100644
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
2.1.0.rc2
