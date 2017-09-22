From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 01/10] drivers: tty: mux: use setup_timer() helper.
Date: Fri, 22 Sep 2017 13:56:43 +0530
Message-ID: <1506068812-8496-2-git-send-email-allen.lkml@gmail.com>
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
 drivers/tty/serial/mux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 2bff69e..a789837 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -576,8 +576,7 @@ static int __init mux_init(void)
 
 	if(port_cnt > 0) {
 		/* Start the Mux timer */
-		init_timer(&mux_timer);
-		mux_timer.function = mux_poll;
+		setup_timer(&mux_timer, mux_poll, 0UL);
 		mod_timer(&mux_timer, jiffies + MUX_POLL_DELAY);
 
 #ifdef CONFIG_SERIAL_MUX_CONSOLE
-- 
2.7.4
