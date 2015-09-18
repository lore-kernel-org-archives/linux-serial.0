From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 1/4] tty: serial: apbuart: Fix module autoload for OF
 platform driver
Date: Fri, 18 Sep 2015 20:02:44 +0200
Message-ID: <20150918180244.GA30731@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/tty/serial/apbuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index f3af317..75eb083 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -581,6 +581,7 @@ static const struct of_device_id apbuart_match[] = {
 	 },
 	{},
 };
+MODULE_DEVICE_TABLE(of, apbuart_match);
 
 static struct platform_driver grlib_apbuart_of_driver = {
 	.probe = apbuart_probe,
-- 
2.4.6
