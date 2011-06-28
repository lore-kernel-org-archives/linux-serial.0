From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/12] 8250: Fix capabilities when changing the port type
Date: Tue, 28 Jun 2011 09:03:42 -0700
Message-ID: <1309277029-1532-5-git-send-email-gregkh@suse.de>
References: <20110628153856.GB32710@kroah.com>
 <1309277029-1532-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:50244 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758934Ab1F1QD6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 12:03:58 -0400
In-Reply-To: <1309277029-1532-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: "leitao@linux.vnet.ibm.com" <leitao@linux.vnet.ibm.com>, Michael Reed <mreed@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: "leitao@linux.vnet.ibm.com" <leitao@linux.vnet.ibm.com>

When changing the port type, the capabilities flags should be changed
also, otherwise the capabilities will not correspond to the port type,
which make set_sleep() crash on rmmod.

This patch just assign the correct capabilites when the port changes.

Signed-off-by: Breno Leitao <leitao@linux.vnet.ibm.com>
CC: Michael Reed <mreed@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index b40f7b9..b4129f5 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -3318,6 +3318,7 @@ void serial8250_unregister_port(int line)
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
 		uart->port.type = PORT_UNKNOWN;
 		uart->port.dev = &serial8250_isa_devs->dev;
+		uart->capabilities = uart_config[uart->port.type].flags;
 		uart_add_one_port(&serial8250_reg, &uart->port);
 	} else {
 		uart->port.dev = NULL;
-- 
1.7.5.4

