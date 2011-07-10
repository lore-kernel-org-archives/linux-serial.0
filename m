From: Edwin van Vliet <edwin@cheatah.nl>
Subject: [PATCH] drivers/tty/serial/crisv10: fix double assignment
Date: Mon, 11 Jul 2011 01:37:31 +0200
Message-ID: <1310341051-27057-1-git-send-email-edwin@cheatah.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: starvik@axis.com, jesper.nilsson@axis.com
Cc: alan@linux.intel.com, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Edwin van Vliet <edwin@cheatah.nl>
List-Id: linux-serial@vger.kernel.org

Struct member dma_in_enabled was assigned twice in a row.

Signed-off-by: Edwin van Vliet <edwin@cheatah.nl>
---
 drivers/tty/serial/crisv10.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 225123b..0c55181 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -330,7 +330,6 @@ static struct e100_serial rs_table[] = {
 	  .dma_in_irq_description = "serial 1 dma rec",
 #else
 	  .dma_in_enabled = 0,
-	  .dma_in_enabled = 0,
 	  .dma_in_nbr = UINT_MAX,
 	  .dma_in_irq_nbr = 0,
 	  .dma_in_irq_flags = 0,
-- 
1.7.5.4
