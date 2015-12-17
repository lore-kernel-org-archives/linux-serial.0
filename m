From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] serial: atmel: header file for MODULE_DEVICE_TABLE
Date: Thu, 17 Dec 2015 17:55:48 +0530
Message-ID: <1450355148-18996-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: linux-serial@vger.kernel.org

mips allmodconfig fails with the error:

drivers/tty/serial/atmel_serial.c:192:1: warning: data definition has no type or storage class
 MODULE_DEVICE_TABLE(of, atmel_serial_dt_ids);
 ^
drivers/tty/serial/atmel_serial.c:192:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
drivers/tty/serial/atmel_serial.c:192:1: warning: parameter names (without types) in function declaration

commit c39dfebc7798 has made the driver non-modular and removed the
header file and it is now compiled as a builtin driver. But since
CONFIG_OF is defined for mips so we need the definition of
MODULE_DEVICE_TABLE to compile successfully.

Fixes: c39dfebc7798 ("drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular")
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

build log with next-20151217 is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/97388463

Log contains another error with gpio, patch for that has been separately
submitted.

 drivers/tty/serial/atmel_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 50e785a..e9a2fa4 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -47,6 +47,7 @@
 #include <linux/err.h>
 #include <linux/irq.h>
 #include <linux/suspend.h>
+#include <linux/module.h>
 
 #include <asm/io.h>
 #include <asm/ioctls.h>
-- 
1.9.1
