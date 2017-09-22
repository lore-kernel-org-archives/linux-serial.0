From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 06/10] drivers: tty: 8250: use setup_timer() helper.
Date: Fri, 22 Sep 2017 13:56:48 +0530
Message-ID: <1506068812-8496-7-git-send-email-allen.lkml@gmail.com>
References: <1506068812-8496-1-git-send-email-allen.lkml@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506068812-8496-1-git-send-email-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, Allen Pais <allen.lkml@gmail.com>
List-Id: linux-serial@vger.kernel.org

    Use setup_timer function instead of initializing timer with the
    function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index d29b512a..00d4b11 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -525,8 +525,7 @@ static void __init serial8250_isa_init_ports(void)
 			base_ops = port->ops;
 		port->ops = &univ8250_port_ops;
 
-		init_timer(&up->timer);
-		up->timer.function = serial8250_timeout;
+		setup_timer(&up->timer, serial8250_timeout, 0UL);
 
 		up->ops = &univ8250_driver_ops;
 
-- 
2.7.4
