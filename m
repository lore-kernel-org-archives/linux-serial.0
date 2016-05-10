From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: Make SERIAL_MPS2_UART depend on ARCH_MPS2
Date: Tue, 10 May 2016 20:56:10 +0200
Message-ID: <1462906570-27684-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-serial@vger.kernel.org

Enabling support for the UART on the ARM MPS2 platform only make sense
when compiling for the ARM MPS2 platform, unless compile-testing.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index b84810aa8621d8b1..3def7478ca44f573 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1457,7 +1457,7 @@ config SERIAL_MPS2_UART_CONSOLE
 
 config SERIAL_MPS2_UART
 	bool "MPS2 UART port"
-	depends on ARM || COMPILE_TEST
+	depends on ARCH_MPS2 || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  This driver support the UART ports on ARM MPS2.
-- 
1.9.1
