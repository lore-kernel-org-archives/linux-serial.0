From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 07/10] drivers: tty: sa1100: use setup_timer() helper.
Date: Fri, 22 Sep 2017 13:56:49 +0530
Message-ID: <1506068812-8496-8-git-send-email-allen.lkml@gmail.com>
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
 drivers/tty/serial/sa1100.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index fd3d132..75bd1e0 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -640,9 +640,8 @@ static void __init sa1100_init_ports(void)
 		sa1100_ports[i].port.fifosize  = 8;
 		sa1100_ports[i].port.line      = i;
 		sa1100_ports[i].port.iotype    = UPIO_MEM;
-		init_timer(&sa1100_ports[i].timer);
-		sa1100_ports[i].timer.function = sa1100_timeout;
-		sa1100_ports[i].timer.data     = (unsigned long)&sa1100_ports[i];
+		setup_timer(&sa1100_ports[i].timer, sa1100_timeout,
+			    (unsigned long)&sa1100_ports[i]);
 	}
 
 	/*
-- 
2.7.4
