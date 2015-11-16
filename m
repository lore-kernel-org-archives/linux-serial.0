From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/6] serial: fsl-lpuart: move SERIAL_EARLYCON dependency to
 console
Date: Mon, 16 Nov 2015 16:48:10 +0100
Message-ID: <1447688894-2936779-3-git-send-email-arnd@arndb.de>
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
Cc: Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The newly added earlycon support for lpuart adds a
'select SERIAL_EARLYCON' statement for the tty driver, but that
only uses earlycon when console support is present, and otherwise
results in a pointless build error:

drivers/built-in.o: In function `setup_earlycon':
:(.init.text+0x2c4c): undefined reference to `uart_parse_earlycon'

This changes the Kconfig statement to only select the earlycon
code if the console is also enabled, like all the other drivers
do already.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 1d59b382f1c4 ("serial: fsl_lpuart: add earlycon support")
Cc: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 1aec4404062d..dbb8ac6afd40 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1539,13 +1539,13 @@ config SERIAL_FSL_LPUART
 	tristate "Freescale lpuart serial port support"
 	depends on HAS_DMA
 	select SERIAL_CORE
-	select SERIAL_EARLYCON
 	help
 	  Support for the on-chip lpuart on some Freescale SOCs.
 
 config SERIAL_FSL_LPUART_CONSOLE
 	bool "Console on Freescale lpuart serial port"
 	depends on SERIAL_FSL_LPUART=y
+	select SERIAL_EARLYCON
 	select SERIAL_CORE_CONSOLE
 	help
 	  If you have enabled the lpuart serial port on the Freescale SoCs,
-- 
2.1.0.rc2
