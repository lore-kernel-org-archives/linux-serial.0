From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] serdev: ttyport: check whether tty_init_dev() fails
Date: Wed, 8 Feb 2017 10:23:24 +0300
Message-ID: <20170208072324.GA12916@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

My static checker complains that we don't have any error handling here.
It's simple enough to add it.

Fixes: bed35c6dfa6a ("serdev: add a tty port controller driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 683320b81a2b..d05393594f15 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -97,6 +97,8 @@ static int ttyport_open(struct serdev_controller *ctrl)
 	struct ktermios ktermios;
 
 	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
+	if (IS_ERR(tty))
+		return PTR_ERR(tty);
 	serport->tty = tty;
 
 	serport->port->client_ops = &client_ops;
