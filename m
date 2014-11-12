From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH/RFC 1/8] tty: Fallback to use dynamic major number
Date: Wed, 12 Nov 2014 00:46:26 -0800
Message-ID: <1415781993-7755-2-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:51401 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbaKLIrH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 03:47:07 -0500
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

From: Tushar Behera <tushar.behera@linaro.org>

In a multi-platform scenario, the hard-coded major/minor numbers in
serial drivers may conflict with each other. A typical scenario is
observed with amba-pl011 and samsung-uart drivers, both of these
drivers use same set of major/minor numbers. If both of these drivers
are enabled, probe of samsung-uart driver fails because the desired
node is busy.

The issue is fixed by adding a fallback in driver core, so that we can
use dynamic major number in case device node allocation fails for
hard-coded major/minor number.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
[cernekee: fix checkpatch warnings]
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/tty_io.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 0508a1d..a6d4d9a 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3365,6 +3365,22 @@ int tty_register_driver(struct tty_driver *driver)
 	dev_t dev;
 	struct device *d;
 
+	if (driver->major) {
+		dev = MKDEV(driver->major, driver->minor_start);
+		error = register_chrdev_region(dev, driver->num, driver->name);
+		/* In case of error, fall back to dynamic allocation */
+		if (error < 0) {
+			pr_warn("Default device node (%d:%d) for %s is busy, using dynamic major number\n",
+				driver->major, driver->minor_start,
+				driver->name);
+			driver->major = 0;
+		}
+	}
+
+	/*
+	 * Don't replace the following check with an else to above if statement,
+	 * as it may also be called as a fallback.
+	 */
 	if (!driver->major) {
 		error = alloc_chrdev_region(&dev, driver->minor_start,
 						driver->num, driver->name);
@@ -3372,9 +3388,6 @@ int tty_register_driver(struct tty_driver *driver)
 			driver->major = MAJOR(dev);
 			driver->minor_start = MINOR(dev);
 		}
-	} else {
-		dev = MKDEV(driver->major, driver->minor_start);
-		error = register_chrdev_region(dev, driver->num, driver->name);
 	}
 	if (error < 0)
 		goto err;
-- 
2.1.1

