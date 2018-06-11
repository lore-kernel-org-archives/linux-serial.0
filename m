From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 17/24] serdev: Mark controllers compatible with ttyport
Date: Mon, 11 Jun 2018 13:52:33 +0200
Message-ID: <20180611115240.32606-18-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

This allows us to treat differently this controllers, by creating a tty
compatibility layer.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/serdev-ttyport.c | 1 +
 include/linux/serdev.h              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 4acc5f41dc67..ae961260e4a4 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -276,6 +276,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
 	serport->tty_drv = drv;
 
 	ctrl->ops = &ctrl_ops;
+	ctrl->is_ttyport = true;
 
 	old_ops = port->client_ops;
 	port->client_ops = &client_ops;
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index bb3b9599c652..07d63933bdb9 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -116,6 +116,7 @@ struct serdev_controller {
 	unsigned int		nr;
 	struct serdev_device	*serdev;
 	const struct serdev_controller_ops *ops;
+	bool			is_ttyport;
 };
 
 static inline struct serdev_controller *to_serdev_controller(struct device *d)
-- 
2.17.1
