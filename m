From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/4] serdev: fix tty-port client deregistration
Date: Tue, 11 Apr 2017 19:07:29 +0200
Message-ID: <20170411170731.4085-3-johan@kernel.org>
References: <20170411170731.4085-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170411170731.4085-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

The port client data must be set when registering the serdev controller
or client deregistration will fail (and the serdev devices are left
registered and allocated) if the port was never opened in between.

Make sure to clear the port client data on any probe errors to avoid a
use-after-free when the client is later deregistered unconditionally
(e.g. in a tty-port deregistration helper).

Also move port client operation initialisation to registration. Note
that the client ops must be restored on failed probe.

Fixes: bed35c6dfa6a ("serdev: add a tty port controller driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index d05393594f15..06e17faa6dfb 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -101,9 +101,6 @@ static int ttyport_open(struct serdev_controller *ctrl)
 		return PTR_ERR(tty);
 	serport->tty = tty;
 
-	serport->port->client_ops = &client_ops;
-	serport->port->client_data = ctrl;
-
 	if (tty->ops->open)
 		tty->ops->open(serport->tty, NULL);
 	else
@@ -181,6 +178,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
 					struct device *parent,
 					struct tty_driver *drv, int idx)
 {
+	const struct tty_port_client_operations *old_ops;
 	struct serdev_controller *ctrl;
 	struct serport *serport;
 	int ret;
@@ -199,15 +197,22 @@ struct device *serdev_tty_port_register(struct tty_port *port,
 
 	ctrl->ops = &ctrl_ops;
 
+	old_ops = port->client_ops;
+	port->client_ops = &client_ops;
+	port->client_data = ctrl;
+
 	ret = serdev_controller_add(ctrl);
 	if (ret)
-		goto err_controller_put;
+		goto err_reset_data;
 
 	dev_info(&ctrl->dev, "tty port %s%d registered\n", drv->name, idx);
 	return &ctrl->dev;
 
-err_controller_put:
+err_reset_data:
+	port->client_data = NULL;
+	port->client_ops = old_ops;
 	serdev_controller_put(ctrl);
+
 	return ERR_PTR(ret);
 }
 
-- 
2.12.2
