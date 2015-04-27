From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 1/3] ARM: common: edma: clear completion interrupts on stop
Date: Mon, 27 Apr 2015 13:52:15 +0200
Message-ID: <87wq0xaivk.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-serial@vger.kernel.org

When stopping a DMA transfer with interrupts disabled it is possible
that the DMA transfer completes before the events are cleared. In
this case the completion interrupt will be pending, causing a
completion callback after the transfer was stopped.

By clearing the completion interrupt for the stopping channel it is
ensured that no completion event will be generated after the stop.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/arm/common/edma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 5662a87..873dbfc 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1350,6 +1350,9 @@ void edma_stop(unsigned channel)
 		edma_shadow0_write_array(ctlr, SH_SECR, j, mask);
 		edma_write_array(ctlr, EDMA_EMCR, j, mask);
 
+		/* clear possibly pending completion interrupt */
+		edma_shadow0_write_array(ctlr, SH_ICR, j, mask);
+
 		pr_debug("EDMA: EER%d %08x\n", j,
 				edma_shadow0_read_array(ctlr, SH_EER, j));
 
-- 
1.7.10.4
