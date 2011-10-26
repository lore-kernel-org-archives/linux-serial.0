From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 51/79] cris: lower the printk level in cris serial driver
Date: Wed, 26 Oct 2011 14:12:56 +0200
Message-ID: <1319631204-23262-51-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32813 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932922Ab1JZMNx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:53 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: WANG Cong <xiyou.wangcong@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: WANG Cong <xiyou.wangcong@gmail.com>

KERN_CRIT is too high, replace those KERN_CRIT with KERN_ERR or KERN_WARNING.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/crisv10.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 58be715..a931524 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -1788,7 +1788,7 @@ static unsigned int handle_descr_data(struct e100_serial *info,
 	struct etrax_recv_buffer *buffer = phys_to_virt(descr->buf) - sizeof *buffer;
 
 	if (info->recv_cnt + recvl > 65536) {
-		printk(KERN_CRIT
+		printk(KERN_WARNING
 		       "%s: Too much pending incoming serial data! Dropping %u bytes.\n", __func__, recvl);
 		return 0;
 	}
@@ -3813,13 +3813,13 @@ rs_close(struct tty_struct *tty, struct file * filp)
 		 * one, we've got real problems, since it means the
 		 * serial port won't be shutdown.
 		 */
-		printk(KERN_CRIT
+		printk(KERN_ERR
 		       "rs_close: bad serial port count; tty->count is 1, "
 		       "info->count is %d\n", info->count);
 		info->count = 1;
 	}
 	if (--info->count < 0) {
-		printk(KERN_CRIT "rs_close: bad serial port count for ttyS%d: %d\n",
+		printk(KERN_ERR "rs_close: bad serial port count for ttyS%d: %d\n",
 		       info->line, info->count);
 		info->count = 0;
 	}
@@ -4452,7 +4452,7 @@ static int __init rs_init(void)
 #if defined(CONFIG_ETRAX_RS485_ON_PA)
 	if (cris_io_interface_allocate_pins(if_serial_0, 'a', rs485_pa_bit,
 			rs485_pa_bit)) {
-		printk(KERN_CRIT "ETRAX100LX serial: Could not allocate "
+		printk(KERN_ERR "ETRAX100LX serial: Could not allocate "
 			"RS485 pin\n");
 		put_tty_driver(driver);
 		return -EBUSY;
@@ -4461,7 +4461,7 @@ static int __init rs_init(void)
 #if defined(CONFIG_ETRAX_RS485_ON_PORT_G)
 	if (cris_io_interface_allocate_pins(if_serial_0, 'g', rs485_pa_bit,
 			rs485_port_g_bit)) {
-		printk(KERN_CRIT "ETRAX100LX serial: Could not allocate "
+		printk(KERN_ERR "ETRAX100LX serial: Could not allocate "
 			"RS485 pin\n");
 		put_tty_driver(driver);
 		return -EBUSY;
@@ -4494,7 +4494,7 @@ static int __init rs_init(void)
 		if (info->enabled) {
 			if (cris_request_io_interface(info->io_if,
 					info->io_if_description)) {
-				printk(KERN_CRIT "ETRAX100LX async serial: "
+				printk(KERN_ERR "ETRAX100LX async serial: "
 					"Could not allocate IO pins for "
 					"%s, port %d\n",
 					info->io_if_description, i);
-- 
1.7.7

