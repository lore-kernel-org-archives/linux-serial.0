From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 2/4] tty: serial: cpm_uart: Fix module autoload for OF
 platform driver
Date: Fri, 18 Sep 2015 20:03:14 +0200
Message-ID: <20150918180314.GA30740@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabian Frederick <fabf@skynet.be>, Timur Tabi <timur@tabi.org>, Wolfram Sang <wsa@the-dreams.de>, Peter Korsgaard <peter@korsgaard.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 08431ad..d3e3d42 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1450,6 +1450,7 @@ static const struct of_device_id cpm_uart_match[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, cpm_uart_match);
 
 static struct platform_driver cpm_uart_driver = {
 	.driver = {
-- 
2.4.6
