From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH v2 3/5] serial: small Makefile reordering
Date: Sat,  1 Apr 2017 18:21:17 -0400
Message-ID: <20170401222119.25106-4-nicolas.pitre@linaro.org>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170401222119.25106-1-nicolas.pitre@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Move 21285 entry down alongside other UART drivers to be more consistent
with the rest of the file. It is kept before 8250 though, to preserve the
existing link ordering between those two.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/tty/serial/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 2d6288bc45..53c03e0051 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -3,7 +3,6 @@
 #
 
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o
-obj-$(CONFIG_SERIAL_21285) += 21285.o
 
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
 obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
@@ -17,6 +16,8 @@ obj-$(CONFIG_SERIAL_SUNZILOG) += sunzilog.o
 obj-$(CONFIG_SERIAL_SUNSU) += sunsu.o
 obj-$(CONFIG_SERIAL_SUNSAB) += sunsab.o
 
+obj-$(CONFIG_SERIAL_21285) += 21285.o
+
 # Now bring in any enabled 8250/16450/16550 type drivers.
 obj-$(CONFIG_SERIAL_8250) += 8250/
 
-- 
2.9.3
