From: Leon Yu <chianglungyu@gmail.com>
Subject: [PATCH] tty: don't leak cdev in tty_cdev_add()
Date: Mon,  7 Sep 2015 13:08:37 +0000
Message-ID: <1441631317-6238-1-git-send-email-chianglungyu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Leon Yu <chianglungyu@gmail.com>, Richard Watts <rrw@kynesim.co.uk>
List-Id: linux-serial@vger.kernel.org

Commit a3a10ce3429e ("Avoid usb reset crashes by making tty_io cdevs truly
dynamic") which mixes using cdev_alloc() and cdev_init() is problematic.
Subsequent call to cdev_init() after cdev_alloc() sets kobj release method
from cdev_dynamic_release() to cdev_default_release() and thus makes it
impossible to free allocated cdev.

This patch also consolidates error path of cdev_add() as cdev can also leak
here if things went wrong.

Signed-off-by: Leon Yu <chianglungyu@gmail.com>
Fixes: a3a10ce3429e ("Avoid usb reset crashes by making tty_io cdevs truly dynamic")
---
 drivers/tty/tty_io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 02785d8..17b0272 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3151,13 +3151,18 @@ struct class *tty_class;
 static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
 		unsigned int index, unsigned int count)
 {
+	int err;
+
 	/* init here, since reused cdevs cause crashes */
 	driver->cdevs[index] = cdev_alloc();
 	if (!driver->cdevs[index])
 		return -ENOMEM;
-	cdev_init(driver->cdevs[index], &tty_fops);
+	driver->cdevs[index]->ops = &tty_fops;
 	driver->cdevs[index]->owner = driver->owner;
-	return cdev_add(driver->cdevs[index], dev, count);
+	err = cdev_add(driver->cdevs[index], dev, count);
+	if (err)
+		kobject_put(&driver->cdevs[index]->kobj);
+	return err;
 }
 
 /**
-- 
2.5.1
