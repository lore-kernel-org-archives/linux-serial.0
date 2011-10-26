From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 49/79] cris: fix a build error in drivers/tty/serial/crisv10.c
Date: Wed, 26 Oct 2011 14:12:54 +0200
Message-ID: <1319631204-23262-49-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32810 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab1JZMNx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:53 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: WANG Cong <xiyou.wangcong@gmail.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, stable <stable@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: WANG Cong <xiyou.wangcong@gmail.com>

This patch fixes the following build error:

drivers/tty/serial/crisv10.c:4453: error: 'if_ser0' undeclared (first use in this function): 2 errors in 2 logs
        v3.1-rc4/cris/cris-allmodconfig v3.1-rc4/cris/cris-allyesconfig
drivers/tty/serial/crisv10.c:4453: error: (Each undeclared identifier is reported only once: 2 errors in 2 logs
        v3.1-rc4/cris/cris-allmodconfig v3.1-rc4/cris/cris-allyesconfig
drivers/tty/serial/crisv10.c:4453: error: for each function it appears in.): 2 errors in 2 logs
        v3.1-rc4/cris/cris-allmodconfig v3.1-rc4/cris/cris-allyesconfig

"if_ser0" is a typo, it should be "if_serial_0".

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/crisv10.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 225123b..58be715 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -4450,7 +4450,7 @@ static int __init rs_init(void)
 
 #if defined(CONFIG_ETRAX_RS485)
 #if defined(CONFIG_ETRAX_RS485_ON_PA)
-	if (cris_io_interface_allocate_pins(if_ser0, 'a', rs485_pa_bit,
+	if (cris_io_interface_allocate_pins(if_serial_0, 'a', rs485_pa_bit,
 			rs485_pa_bit)) {
 		printk(KERN_CRIT "ETRAX100LX serial: Could not allocate "
 			"RS485 pin\n");
@@ -4459,7 +4459,7 @@ static int __init rs_init(void)
 	}
 #endif
 #if defined(CONFIG_ETRAX_RS485_ON_PORT_G)
-	if (cris_io_interface_allocate_pins(if_ser0, 'g', rs485_pa_bit,
+	if (cris_io_interface_allocate_pins(if_serial_0, 'g', rs485_pa_bit,
 			rs485_port_g_bit)) {
 		printk(KERN_CRIT "ETRAX100LX serial: Could not allocate "
 			"RS485 pin\n");
-- 
1.7.7

