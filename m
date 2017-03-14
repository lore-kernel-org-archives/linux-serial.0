From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 2/2] serdev: Add minimal bus locking API
Date: Tue, 14 Mar 2017 06:48:19 -0700
Message-ID: <20170314134819.19476-3-andrew.smirnov@gmail.com>
References: <20170314134819.19476-1-andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170314134819.19476-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, cphealy@gmail.com, Guenter Roeck <linux@roeck-us.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add minimal bus locking API which is useful for serial devices that
implement request-reply protocol

Cc: cphealy@gmail.com
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/tty/serdev/core.c |  1 +
 include/linux/serdev.h    | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 759e834..20ca231 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -269,6 +269,7 @@ struct serdev_device *serdev_device_alloc(struct serdev_controller *ctrl)
 	serdev->dev.type = &serdev_device_type;
 	init_completion(&serdev->write_wakeup);
 	mutex_init(&serdev->write_lock);
+	mutex_init(&serdev->bus_lock);
 	return serdev;
 }
 EXPORT_SYMBOL_GPL(serdev_device_alloc);
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 8f7aa35..6b73a79 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -48,6 +48,7 @@ struct serdev_device {
 	const struct serdev_device_ops *ops;
 	struct completion write_wakeup;
 	struct mutex write_lock;
+	struct mutex bus_lock;
 };
 
 static inline struct serdev_device *to_serdev_device(struct device *d)
@@ -55,6 +56,16 @@ static inline struct serdev_device *to_serdev_device(struct device *d)
 	return container_of(d, struct serdev_device, dev);
 }
 
+static inline void serdev_device_bus_lock(struct serdev_device *serdev)
+{
+	mutex_lock(&serdev->bus_lock);
+}
+
+static inline void serdev_device_bus_unlock(struct serdev_device *serdev)
+{
+	mutex_unlock(&serdev->bus_lock);
+}
+
 /**
  * struct serdev_device_driver - serdev slave device driver
  * @driver:	serdev device drivers should initialize name field of this
-- 
2.9.3
