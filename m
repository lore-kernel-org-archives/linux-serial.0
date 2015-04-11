From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH 3/4] drivers/tty/serial/crisv10.c: remove dead #ifdef blocks
Date: Sat, 11 Apr 2015 15:56:02 +0200
Message-ID: <1428760563-13413-4-git-send-email-valentinrothberg@gmail.com>
References: <1428760563-13413-1-git-send-email-valentinrothberg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428760563-13413-1-git-send-email-valentinrothberg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: starvik@axis.com, jesper.nilsson@axis.com, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, pebolle@tiscali.nl
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: linux-serial@vger.kernel.org

ETRAX_SERIAL_PROC_ENTRY is not defined in Kconfig.  The affected #ifdef
block has not been compiled for years, and the embedded macro, PROCSTAT,
ended up as a NOOP.  Hence, remove the block and all calls to PROCSTAT.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
 drivers/tty/serial/crisv10.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 349f95ea4a0f..9ce6c1ce80b5 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -451,30 +451,6 @@ static struct e100_serial rs_table[] = {
 static struct fast_timer fast_timers[NR_PORTS];
 #endif
 
-#ifdef CONFIG_ETRAX_SERIAL_PROC_ENTRY
-#define PROCSTAT(x) x
-struct ser_statistics_type {
-	int overrun_cnt;
-	int early_errors_cnt;
-	int ser_ints_ok_cnt;
-	int errors_cnt;
-	unsigned long int processing_flip;
-	unsigned long processing_flip_still_room;
-	unsigned long int timeout_flush_cnt;
-	int rx_dma_ints;
-	int tx_dma_ints;
-	int rx_tot;
-	int tx_tot;
-};
-
-static struct ser_statistics_type ser_stat[NR_PORTS];
-
-#else
-
-#define PROCSTAT(x)
-
-#endif /* CONFIG_ETRAX_SERIAL_PROC_ENTRY */
-
 /* RS-485 */
 #if defined(CONFIG_ETRAX_RS485)
 #ifdef CONFIG_ETRAX_FAST_TIMER
@@ -1824,7 +1800,6 @@ static void receive_chars_dma(struct e100_serial *info)
 		 */
 		unsigned char data = info->ioport[REG_DATA];
 
-		PROCSTAT(ser_stat[info->line].errors_cnt++);
 		DEBUG_LOG(info->line, "#dERR: s d 0x%04X\n",
 			  ((rstat & SER_ERROR_MASK) << 8) | data);
 
@@ -1926,7 +1901,6 @@ tr_interrupt(int irq, void *dev_id)
 			/* Read jiffies_usec first,
 			 * we want this time to be as late as possible
 			 */
- 			PROCSTAT(ser_stat[info->line].tx_dma_ints++);
 			info->last_tx_active_usec = GET_JIFFIES_USEC();
 			info->last_tx_active = jiffies;
 			transmit_chars_dma(info);
@@ -2005,7 +1979,6 @@ static int force_eop_if_needed(struct e100_serial *info)
 	 */
 	if (!info->forced_eop) {
 		info->forced_eop = 1;
-		PROCSTAT(ser_stat[info->line].timeout_flush_cnt++);
 		TIMERD(DEBUG_LOG(info->line, "timeout EOP %i\n", info->line));
 		FORCE_EOP(info);
 	}
@@ -2357,7 +2330,6 @@ static void handle_ser_rx_interrupt(struct e100_serial *info)
 			DEBUG_LOG(info->line, "#iERR s d %04X\n",
 			          ((rstat & SER_ERROR_MASK) << 8) | data);
 		}
-		PROCSTAT(ser_stat[info->line].early_errors_cnt++);
 	} else { /* It was a valid byte, now let the DMA do the rest */
 		unsigned long curr_time_u = GET_JIFFIES_USEC();
 		unsigned long curr_time = jiffies;
@@ -2390,7 +2362,6 @@ static void handle_ser_rx_interrupt(struct e100_serial *info)
 		DINTR2(DEBUG_LOG(info->line, "ser_rx OK %d\n", info->line));
 		info->break_detected_cnt = 0;
 
-		PROCSTAT(ser_stat[info->line].ser_ints_ok_cnt++);
 	}
 	/* Restarting the DMA never hurts */
 	*info->icmdadr = IO_STATE(R_DMA_CH6_CMD, cmd, restart);
-- 
2.1.0
