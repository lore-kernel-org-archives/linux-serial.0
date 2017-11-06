From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v11 2/5] serdev: Introduce devm_serdev_device_open()
Date: Mon,  6 Nov 2017 07:29:32 -0800
Message-ID: <20171106152935.16920-3-andrew.smirnov@gmail.com>
References: <20171106152935.16920-1-andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171106152935.16920-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, cphealy@gmail.com, Guenter Roeck <linux@roeck-us.net>, Lucas Stach <l.stach@pengutronix.de>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Johan Hovold <johan@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

Add code implementing managed version of serdev_device_open() for
serdev device drivers that "open" the device during driver's lifecycle
only once (e.g. opened in .probe() and closed in .remove()).

Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Cc: cphealy@gmail.com
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 Documentation/driver-model/devres.txt |  3 +++
 drivers/tty/serdev/core.c             | 27 +++++++++++++++++++++++++++
 include/linux/serdev.h                |  1 +
 3 files changed, 31 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 69f08c0f23a8..e9c6b5cfeec1 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -383,6 +383,9 @@ RESET
   devm_reset_control_get()
   devm_reset_controller_register()
 
+SERDEV
+  devm_serdev_device_open()
+
 SLAVE DMA ENGINE
   devm_acpi_dma_controller_register()
 
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index f500f6a2ca88..5074b6a7d533 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -116,6 +116,33 @@ void serdev_device_close(struct serdev_device *serdev)
 }
 EXPORT_SYMBOL_GPL(serdev_device_close);
 
+static void devm_serdev_device_release(struct device *dev, void *dr)
+{
+	serdev_device_close(*(struct serdev_device **)dr);
+}
+
+int devm_serdev_device_open(struct device *dev, struct serdev_device *serdev)
+{
+	struct serdev_device **dr;
+	int ret;
+
+	dr = devres_alloc(devm_serdev_device_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = serdev_device_open(serdev);
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
+
+	*dr = serdev;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_serdev_device_open);
+
 void serdev_device_write_wakeup(struct serdev_device *serdev)
 {
 	complete(&serdev->write_comp);
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index e69402d4a8ae..9929063bd45d 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -193,6 +193,7 @@ static inline int serdev_controller_receive_buf(struct serdev_controller *ctrl,
 
 int serdev_device_open(struct serdev_device *);
 void serdev_device_close(struct serdev_device *);
+int devm_serdev_device_open(struct device *, struct serdev_device *);
 unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
 void serdev_device_set_flow_control(struct serdev_device *, bool);
 int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
-- 
2.13.6
