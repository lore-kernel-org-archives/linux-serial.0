Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFDF194A60;
	Mon, 26 May 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748258764; cv=none; b=CI1ryyElwqxZphzGX8X3qJT158Va/ZFnEDvbcC6vfC/+nUYjiv0oVy8Py6ODRqrHLVjHNZDk+INYcDCcE+2fMiqpUs+rgNYpDk1ST3+kFkRS66qQiMASJsFHHvBqPf+OT+Nv/b6Hd2lpKPBqWVJv+N2foDXYqWodK5XA5QDAbI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748258764; c=relaxed/simple;
	bh=cNykbtFCy/zbGufd3BDVlaJfGLUg3tqp11zRdKmxSHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ArscMLRdU7h3dbrCAICLNtd9dWwt803mv0EjJqkzBINguVuNxsPox7ssgtsz+vk2nVyPsglrfgq1GlX2Ya94ArJUXhR04/aC1bsuPfZjb1mn2OZoROwUjrUlnkDpJJbyA+i8HkyPfvpUUVfcLbkVgubh92F21zqV3Tog/c6UCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 0206C1011CB;
	Mon, 26 May 2025 11:25:57 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Staudt <max@enpas.org>
Subject: [PATCH v1] tty: Register device *after* creating the cdev for a tty
Date: Mon, 26 May 2025 20:25:23 +0900
Message-Id: <20250526112523.23122-1-max@enpas.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change makes the tty device file available only after the tty's
backing character device is ready.

Since 6a7e6f78c235975cc14d4e141fa088afffe7062c, the class device is
registered before the cdev is created, and userspace may pick it up,
yet open() will fail because the backing cdev doesn't exist yet.
Userspace is racing the bottom half of tty_register_device_attr() here,
specifically the call to tty_cdev_add().

dev_set_uevent_suppress() was used to work around this, but this fails
on embedded systems that rely on bare devtmpfs rather than udev.
On such systems, the device file is created as part of device_add(),
and userspace can pick it up via inotify, irrespective of uevent
suppression.

So let's undo the existing patch, and create the cdev first, and only
afterwards register the class device in the kernel's device tree.

However, this restores the original race of the cdev existing before the
class device is registered, and an attempt to open it during this time
will lead to tty->dev being assigned NULL by alloc_tty_struct().

alloc_tty_struct() is called via tty_init_dev() when the tty is firstly
opened, and is entered with tty_mutex held, so let's lock the critical
section in tty_register_device_attr() with the same global mutex.
This guarantees that tty->dev can be assigned a sane value.

Fixes: 6a7e6f78c235 ("tty: close race between device register and open")
Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/tty/tty_io.c | 59 +++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ca9b7d7bad2b..94768509e2d2 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3245,6 +3245,7 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 	struct ktermios *tp;
 	struct device *dev;
 	int retval;
+	bool cdev_added = false;
 
 	if (index >= driver->num) {
 		pr_err("%s: Attempt to register invalid tty line number (%d)\n",
@@ -3257,23 +3258,7 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 	else
 		tty_line_name(driver, index, name);
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	dev->devt = devt;
-	dev->class = &tty_class;
-	dev->parent = device;
-	dev->release = tty_device_create_release;
-	dev_set_name(dev, "%s", name);
-	dev->groups = attr_grp;
-	dev_set_drvdata(dev, drvdata);
-
-	dev_set_uevent_suppress(dev, 1);
-
-	retval = device_register(dev);
-	if (retval)
-		goto err_put;
+	mutex_lock(&tty_mutex);
 
 	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
 		/*
@@ -3288,19 +3273,49 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 
 		retval = tty_cdev_add(driver, devt, index, 1);
 		if (retval)
-			goto err_del;
+			goto err_unlock;
+
+		cdev_added = true;
+	}
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		retval = -ENOMEM;
+		goto err_del_cdev;
 	}
 
-	dev_set_uevent_suppress(dev, 0);
-	kobject_uevent(&dev->kobj, KOBJ_ADD);
+	dev->devt = devt;
+	dev->class = &tty_class;
+	dev->parent = device;
+	dev->release = tty_device_create_release;
+	dev_set_name(dev, "%s", name);
+	dev->groups = attr_grp;
+	dev_set_drvdata(dev, drvdata);
+
+	retval = device_register(dev);
+	if (retval)
+		goto err_put;
+
+	mutex_unlock(&tty_mutex);
 
 	return dev;
 
-err_del:
-	device_del(dev);
 err_put:
+	/*
+	 * device_register() calls device_add(), after which
+	 * we must use put_device() instead of kfree().
+	 */
 	put_device(dev);
 
+err_del_cdev:
+	if (cdev_added) {
+		cdev_del(driver->cdevs[index]);
+		driver->cdevs[index] = NULL;
+	}
+
+err_unlock:
+	mutex_unlock(&tty_mutex);
+
 	return ERR_PTR(retval);
 }
 EXPORT_SYMBOL_GPL(tty_register_device_attr);
-- 
2.39.5

