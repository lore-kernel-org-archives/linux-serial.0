From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH -next] tty/serial: atmel: Include module.h to fix build failure
Date: Sat,  9 Jan 2016 10:15:35 -0800
Message-ID: <1452363335-2535-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: linux-serial@vger.kernel.org

If serial/atmel_serial.c is compiled with devicetree enabled, the
following build error is observed.

drivers/tty/serial/atmel_serial.c:192:1: warning:
	data definition has no type or storage class
drivers/tty/serial/atmel_serial.c:192:1: error:
	type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
drivers/tty/serial/atmel_serial.c:192:1: warning:
	parameter names (without types) in function declaration

MODULE_DEVICE_TABLE is used to specify devicetree compatibilities.

Fixes: c39dfebc7798 ("drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular")
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/tty/serial/atmel_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 50e785a0ea73..71c385b09db8 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -22,6 +22,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
  */
+#include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
-- 
2.1.4
