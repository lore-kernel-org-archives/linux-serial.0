From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH 2/4] drivers/tty/serial/crisv10.c: remove dead #ifdef blocks
Date: Sat, 11 Apr 2015 15:56:01 +0200
Message-ID: <1428760563-13413-3-git-send-email-valentinrothberg@gmail.com>
References: <1428760563-13413-1-git-send-email-valentinrothberg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428760563-13413-1-git-send-email-valentinrothberg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: starvik@axis.com, jesper.nilsson@axis.com, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, pebolle@tiscali.nl
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: linux-serial@vger.kernel.org

ETRAX_RS485_{ON_PORT_G, LTC1387} are not defined in Kconfig.  The
affected #ifdef block have not been compiled for years, so remove them
entirely.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
 drivers/tty/serial/crisv10.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 771314d2b7a3..349f95ea4a0f 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -56,10 +56,6 @@ static char *serial_version = "$Revision: 1.25 $";
 #error "RX_TIMEOUT_TICKS == 0 not allowed, use 1"
 #endif
 
-#if defined(CONFIG_ETRAX_RS485_ON_PA) && defined(CONFIG_ETRAX_RS485_ON_PORT_G)
-#error "Disable either CONFIG_ETRAX_RS485_ON_PA or CONFIG_ETRAX_RS485_ON_PORT_G"
-#endif
-
 /*
  * All of the compatibilty code so we can compile serial.c against
  * older kernels is hidden in serial_compat.h
@@ -487,9 +483,6 @@ static struct fast_timer fast_timers_rs485[NR_PORTS];
 #if defined(CONFIG_ETRAX_RS485_ON_PA)
 static int rs485_pa_bit = CONFIG_ETRAX_RS485_ON_PA_BIT;
 #endif
-#if defined(CONFIG_ETRAX_RS485_ON_PORT_G)
-static int rs485_port_g_bit = CONFIG_ETRAX_RS485_ON_PORT_G_BIT;
-#endif
 #endif
 
 /* Info and macros needed for each ports extra control/status signals. */
@@ -1367,16 +1360,6 @@ e100_enable_rs485(struct tty_struct *tty, struct serial_rs485 *r)
 #if defined(CONFIG_ETRAX_RS485_ON_PA)
 	*R_PORT_PA_DATA = port_pa_data_shadow |= (1 << rs485_pa_bit);
 #endif
-#if defined(CONFIG_ETRAX_RS485_ON_PORT_G)
-	REG_SHADOW_SET(R_PORT_G_DATA,  port_g_data_shadow,
-		       rs485_port_g_bit, 1);
-#endif
-#if defined(CONFIG_ETRAX_RS485_LTC1387)
-	REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
-		       CONFIG_ETRAX_RS485_LTC1387_DXEN_PORT_G_BIT, 1);
-	REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
-		       CONFIG_ETRAX_RS485_LTC1387_RXEN_PORT_G_BIT, 1);
-#endif
 
 	info->rs485 = *r;
 
@@ -3712,16 +3695,6 @@ rs_close(struct tty_struct *tty, struct file * filp)
 #if defined(CONFIG_ETRAX_RS485_ON_PA)
 		*R_PORT_PA_DATA = port_pa_data_shadow &= ~(1 << rs485_pa_bit);
 #endif
-#if defined(CONFIG_ETRAX_RS485_ON_PORT_G)
-		REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
-			       rs485_port_g_bit, 0);
-#endif
-#if defined(CONFIG_ETRAX_RS485_LTC1387)
-		REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
-			       CONFIG_ETRAX_RS485_LTC1387_DXEN_PORT_G_BIT, 0);
-		REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
-			       CONFIG_ETRAX_RS485_LTC1387_RXEN_PORT_G_BIT, 0);
-#endif
 	}
 #endif
 
@@ -4250,15 +4223,6 @@ static int __init rs_init(void)
 		return -EBUSY;
 	}
 #endif
-#if defined(CONFIG_ETRAX_RS485_ON_PORT_G)
-	if (cris_io_interface_allocate_pins(if_serial_0, 'g', rs485_pa_bit,
-			rs485_port_g_bit)) {
-		printk(KERN_ERR "ETRAX100LX serial: Could not allocate "
-			"RS485 pin\n");
-		put_tty_driver(driver);
-		return -EBUSY;
-	}
-#endif
 #endif
 
 	/* Initialize the tty_driver structure */
-- 
2.1.0
