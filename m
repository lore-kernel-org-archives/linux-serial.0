From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 09/10] drivers: tty: sn_console: use setup_timer() helper.
Date: Fri, 22 Sep 2017 13:56:51 +0530
Message-ID: <1506068812-8496-10-git-send-email-allen.lkml@gmail.com>
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
 drivers/tty/serial/sn_console.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
index 9e0e658..81d506d2 100644
--- a/drivers/tty/serial/sn_console.c
+++ b/drivers/tty/serial/sn_console.c
@@ -687,9 +687,7 @@ static void __init sn_sal_switch_to_asynch(struct sn_cons_port *port)
 	 * timer to poll for input and push data from the console
 	 * buffer.
 	 */
-	init_timer(&port->sc_timer);
-	port->sc_timer.function = sn_sal_timer_poll;
-	port->sc_timer.data = (unsigned long)port;
+	setup_timer(&port->sc_timer, sn_sal_timer_poll, (unsigned long)port);
 
 	if (IS_RUNNING_ON_SIMULATOR())
 		port->sc_interrupt_timeout = 6;
-- 
2.7.4
