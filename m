From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 08/10] drivers: tty: n_gsm: use setup_timer() helper.
Date: Fri, 22 Sep 2017 13:56:50 +0530
Message-ID: <1506068812-8496-9-git-send-email-allen.lkml@gmail.com>
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
 drivers/tty/n_gsm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0a3c966..33530d8 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1646,9 +1646,7 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 	}
 
 	skb_queue_head_init(&dlci->skb_list);
-	init_timer(&dlci->t1);
-	dlci->t1.function = gsm_dlci_t1;
-	dlci->t1.data = (unsigned long)dlci;
+	setup_timer(&dlci->t1, gsm_dlci_t1, (unsigned long)dlci);
 	tty_port_init(&dlci->port);
 	dlci->port.ops = &gsm_port_ops;
 	dlci->gsm = gsm;
-- 
2.7.4
