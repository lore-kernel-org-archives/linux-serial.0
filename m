From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] tty: serial: make crisv10 explicitly non-modular
Date: Mon, 31 Oct 2016 13:42:16 -0400
Message-ID: <20161031174216.900-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

arch/cris/arch-v10/drivers/Kconfig:config ETRAX_SERIAL
arch/cris/arch-v10/drivers/Kconfig:     bool "Serial-port support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-cris-kernel@axis.com
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/crisv10.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 315c84979b18..6450a38cb1aa 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -28,7 +28,6 @@ static char *serial_version = "$Revision: 1.25 $";
 #include <linux/bitops.h>
 #include <linux/seq_file.h>
 #include <linux/delay.h>
-#include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 
@@ -4098,7 +4097,7 @@ static void show_serial_version(void)
 	       &serial_version[11]); /* "$Revision: x.yy" */
 }
 
-/* rs_init inits the driver at boot (using the module_init chain) */
+/* rs_init inits the driver at boot (using the initcall chain) */
 
 static const struct tty_operations rs_ops = {
 	.open = rs_open,
@@ -4247,5 +4246,4 @@ static int __init rs_init(void)
 }
 
 /* this makes sure that rs_init is called during kernel boot */
-
-module_init(rs_init);
+device_initcall(rs_init);
-- 
2.8.4
