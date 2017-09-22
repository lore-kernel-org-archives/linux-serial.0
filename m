From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 05/10] drivers: tty: pnx8xxx: use setup_timer() helper.
Date: Fri, 22 Sep 2017 13:56:47 +0530
Message-ID: <1506068812-8496-6-git-send-email-allen.lkml@gmail.com>
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
 drivers/tty/serial/pnx8xxx_uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index dab2668..a05508a 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -666,9 +666,8 @@ static void __init pnx8xxx_init_ports(void)
 	first = 0;
 
 	for (i = 0; i < NR_PORTS; i++) {
-		init_timer(&pnx8xxx_ports[i].timer);
-		pnx8xxx_ports[i].timer.function = pnx8xxx_timeout;
-		pnx8xxx_ports[i].timer.data     = (unsigned long)&pnx8xxx_ports[i];
+		setup_timer(&pnx8xxx_ports[i].timer, pnx8xxx_timeout,
+			    (unsigned long)&pnx8xxx_ports[i]);
 		pnx8xxx_ports[i].port.ops = &pnx8xxx_pops;
 	}
 }
-- 
2.7.4
