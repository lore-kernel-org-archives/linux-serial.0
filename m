From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] mips: make loongsoon serial driver explicitly modular
Date: Wed, 22 Jan 2014 10:17:51 -0500
Message-ID: <1390403871-16809-1-git-send-email-paul.gortmaker@windriver.com>
References: <52df9ab1.ahF1zl0PTutzrviC%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:42448 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932142AbaAVPSK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Jan 2014 10:18:10 -0500
In-Reply-To: <52df9ab1.ahF1zl0PTutzrviC%fengguang.wu@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: fengguang.wu@intel.com
Cc: linux-serial@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org

The file looks as if it is non-modular, but it piggy-backs
off CONFIG_SERIAL_8250 which is tristate.  If set to "=m"
we will get this after the init/module header cleanup:

arch/mips/loongson/common/serial.c:76:1: error: data definition has no type or storage class [-Werror]
arch/mips/loongson/common/serial.c:76:1: error: type defaults to 'int' in declaration of 'device_initcall' [-Werror=implicit-int]
arch/mips/loongson/common/serial.c:76:1: error: parameter names (without types) in function declaration [-Werror]
arch/mips/loongson/common/serial.c:58:19: error: 'serial_init' defined but not used [-Werror=unused-function]
cc1: all warnings being treated as errors
make[3]: *** [arch/mips/loongson/common/serial.o] Error 1

Make it clearly modular, and add a module_exit function,
so that we avoid the above breakage.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[patch added to init cleanup series:
   http://git.kernel.org/cgit/linux/kernel/git/paulg/init.git/  ]

 arch/mips/loongson/common/serial.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
index 5f2b78a..4d0922f 100644
--- a/arch/mips/loongson/common/serial.c
+++ b/arch/mips/loongson/common/serial.c
@@ -11,7 +11,7 @@
  */
 
 #include <linux/io.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/serial_8250.h>
 
 #include <asm/bootinfo.h>
@@ -72,5 +72,10 @@ static int __init serial_init(void)
 
 	return platform_device_register(&uart8250_device);
 }
+module_init(serial_init);
 
-device_initcall(serial_init);
+static void __init serial_exit(void)
+{
+	platform_device_unregister(&uart8250_device);
+}
+module_exit(serial_exit);
-- 
1.8.5.1

