From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/9] tty_port: make tty_port_register_device wrap tty_port_register_device_attr
Date: Mon, 16 Jan 2017 16:54:30 -0600
Message-ID: <20170116225436.17505-4-robh@kernel.org>
References: <20170116225436.17505-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116225436.17505-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

tty_register_device is just a wrapper for tty_register_device_attr with
NULL passed for drvdata and attr_grp. So similarly make
tty_port_register_device a wrapper of tty_port_register_device_attr so that
additions don't have to be made in both functions.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-By: Sebastian Reichel <sre@kernel.org>
---
v2:
- no change

 drivers/tty/tty_port.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 606d9e5bf28f..1d8804843103 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -67,8 +67,7 @@ struct device *tty_port_register_device(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device)
 {
-	tty_port_link_device(port, driver, index);
-	return tty_register_device(driver, index, device);
+	return tty_port_register_device_attr(port, driver, index, device, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(tty_port_register_device);

--
2.10.1
