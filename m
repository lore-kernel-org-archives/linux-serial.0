From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/4] drivers/tty: make serial/suncore.c driver explicitly non-modular
Date: Tue, 21 Jul 2015 22:02:17 -0400
Message-ID: <1437530538-5078-4-git-send-email-paul.gortmaker@windriver.com>
References: <1437530538-5078-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437530538-5078-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Kconfig for this driver is currently:

config SERIAL_SUNCORE
        bool

...meaning that it currently is not being built as a module by
anyone.  Lets remove the modular and unused code here, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't swap module.h for init.h since this file has init.h already.

We leave some tags like MODULE_LICENSE for documentation purposes, and
for the "git blame" value.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: sparclinux@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/suncore.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/suncore.c b/drivers/tty/serial/suncore.c
index 6e4ac8db2d79..127472bd6a7c 100644
--- a/drivers/tty/serial/suncore.c
+++ b/drivers/tty/serial/suncore.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2002 David S. Miller (davem@redhat.com)
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/console.h>
 #include <linux/tty.h>
@@ -234,14 +233,10 @@ static int __init suncore_init(void)
 {
 	return 0;
 }
+device_initcall(suncore_init);
 
-static void __exit suncore_exit(void)
-{
-}
-
-module_init(suncore_init);
-module_exit(suncore_exit);
-
+#if 0 /* ..def MODULE ; never supported as such */
 MODULE_AUTHOR("Eddie C. Dost, David S. Miller");
 MODULE_DESCRIPTION("Sun serial common layer");
 MODULE_LICENSE("GPL");
+#endif
-- 
2.2.1
