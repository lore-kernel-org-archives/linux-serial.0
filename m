From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH 1/4] drivers/tty/serial/crisv10.c: remove dead #ifdef block
Date: Sat, 11 Apr 2015 15:56:00 +0200
Message-ID: <1428760563-13413-2-git-send-email-valentinrothberg@gmail.com>
References: <1428760563-13413-1-git-send-email-valentinrothberg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428760563-13413-1-git-send-email-valentinrothberg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: starvik@axis.com, jesper.nilsson@axis.com, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, pebolle@tiscali.nl
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: linux-serial@vger.kernel.org

ETRAX_EXTERN_PB6CLK_ENABLED is not defined in Kconfig.  The affected
 #ifdef block has not been compiled for years, so remove it entirely.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
 drivers/tty/serial/crisv10.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 0c1825b0b41d..771314d2b7a3 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -2867,19 +2867,6 @@ change_speed(struct e100_serial *info)
 			*R_SERIAL_PRESCALE = divisor;
 			info->baud = SERIAL_PRESCALE_BASE/divisor;
 		}
-#ifdef CONFIG_ETRAX_EXTERN_PB6CLK_ENABLED
-		else if ((info->baud_base==CONFIG_ETRAX_EXTERN_PB6CLK_FREQ/8 &&
-			  info->custom_divisor == 1) ||
-			 (info->baud_base==CONFIG_ETRAX_EXTERN_PB6CLK_FREQ &&
-			  info->custom_divisor == 8)) {
-				/* ext_clk selected */
-				alt_source =
-					IO_STATE(R_ALT_SER_BAUDRATE, ser0_rec, extern) |
-					IO_STATE(R_ALT_SER_BAUDRATE, ser0_tr, extern);
-				DBAUD(printk("using external baudrate: %lu\n", CONFIG_ETRAX_EXTERN_PB6CLK_FREQ/8));
-				info->baud = CONFIG_ETRAX_EXTERN_PB6CLK_FREQ/8;
-			}
-#endif
 		else
 		{
 			/* Bad baudbase, we don't support using timer0
-- 
2.1.0
