From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v8 1/5] serdev: Make .remove in struct serdev_device_driver optional
Date: Wed, 18 Oct 2017 10:01:32 -0700
Message-ID: <20171018170136.12347-2-andrew.smirnov@gmail.com>
References: <20171018170136.12347-1-andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018170136.12347-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, cphealy@gmail.com, Guenter Roeck <linux@roeck-us.net>, Lucas Stach <l.stach@pengutronix.de>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Using devres infrastructure it is possible to wirte a serdev driver
that doesn't have any code that needs to be called as a part of
.remove. Add code to make .remove optional.

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
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/tty/serdev/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index c68fb3a8ea1c..f500f6a2ca88 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -252,8 +252,8 @@ static int serdev_drv_probe(struct device *dev)
 static int serdev_drv_remove(struct device *dev)
 {
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
-
-	sdrv->remove(to_serdev_device(dev));
+	if (sdrv->remove)
+		sdrv->remove(to_serdev_device(dev));
 	return 0;
 }
 
-- 
2.13.5
