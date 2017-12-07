From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v14 1/5] serdev: Make .remove in struct serdev_device_driver optional
Date: Thu,  7 Dec 2017 08:27:31 -0800
Message-ID: <20171207162735.25873-2-andrew.smirnov@gmail.com>
References: <20171207162735.25873-1-andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207162735.25873-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, cphealy@gmail.com, Guenter Roeck <linux@roeck-us.net>, Lucas Stach <l.stach@pengutronix.de>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Johan Hovold <johan@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

Using devres infrastructure it is possible to write a serdev driver
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
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/tty/serdev/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 1bef39828ca7..34050b439c1f 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -268,8 +268,8 @@ static int serdev_drv_probe(struct device *dev)
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
2.14.3
