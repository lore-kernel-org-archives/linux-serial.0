From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/4] drivers/tty: make serial/lantic.c driver explicitly non-modular
Date: Tue, 21 Jul 2015 22:02:16 -0400
Message-ID: <1437530538-5078-3-git-send-email-paul.gortmaker@windriver.com>
References: <1437530538-5078-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437530538-5078-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Kconfig for this option is currently:

config SERIAL_LANTIQ
    bool "Lantiq serial driver"

...meaning that it currently is not being built as a module by anyone.
Lets remove the couple traces of modularity, so that when reading the
driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We delete the MODULE_DESCRIPTION and LICENSE tags since they are
not adding any new information above and beyond what is at the top
of the file.  Also note that MODULE_DEVICE_TABLE is a no-op for
non-modular code, so we remove that as well.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/lantiq.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 4ccc0397664c..b88832e8ee82 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -21,7 +21,6 @@
  */
 
 #include <linux/slab.h>
-#include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/console.h>
@@ -740,7 +739,6 @@ static const struct of_device_id ltq_asc_match[] = {
 	{ .compatible = DRVNAME },
 	{},
 };
-MODULE_DEVICE_TABLE(of, ltq_asc_match);
 
 static struct platform_driver lqasc_driver = {
 	.driver		= {
@@ -764,8 +762,4 @@ init_lqasc(void)
 
 	return ret;
 }
-
-module_init(init_lqasc);
-
-MODULE_DESCRIPTION("Lantiq serial port driver");
-MODULE_LICENSE("GPL");
+device_initcall(init_lqasc);
-- 
2.2.1
