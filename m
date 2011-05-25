From: leitao@linux.vnet.ibm.com
Subject: [PATCH] 8250: Fix capabilities when changing the port type
Date: Wed, 25 May 2011 11:48:18 -0300
Message-ID: <1306334898-16399-1-git-send-email-leitao@linux.vnet.ibm.com>
References: <20110519234918.GB25169@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp03.br.ibm.com ([32.104.18.24]:41261 "EHLO
	e24smtp03.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678Ab1EYOsq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 May 2011 10:48:46 -0400
Received: from /spool/local
	by e24smtp03.br.ibm.com with XMail ESMTP
	for <linux-serial@vger.kernel.org> from <leitao@linux.vnet.ibm.com>;
	Wed, 25 May 2011 11:48:40 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p4PEo3St1368254
	for <linux-serial@vger.kernel.org>; Wed, 25 May 2011 11:50:05 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4PCmWuu031769
	for <linux-serial@vger.kernel.org>; Wed, 25 May 2011 09:48:32 -0300
In-Reply-To: <20110519234918.GB25169@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de
Cc: linux-serial@vger.kernel.org, scottk@digi.com, Breno Leitao <leitao@linux.vnet.ibm.com>, Michael Reed <mreed@linux.vnet.ibm.com>

When changing the port type, the capabilities flags should be changed
also, otherwise the capabilities will not correspond to the port type,
which make set_sleep() crash on rmmod.

This patch just assign the correct capabilites when the port changes.

Signed-off-by: Breno Leitao <leitao@linux.vnet.ibm.com>
CC: Michael Reed <mreed@linux.vnet.ibm.com>
---
 drivers/tty/serial/8250.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 6611535..060ce5c 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -3281,7 +3281,7 @@ void serial8250_unregister_port(int line)
 	if (serial8250_isa_devs) {
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
 		uart->port.type = PORT_UNKNOWN;
-		uart->port.dev = &serial8250_isa_devs->dev;
+		uart->capabilities = uart_config[uart->port.type].flags;
 		uart_add_one_port(&serial8250_reg, &uart->port);
 	} else {
 		uart->port.dev = NULL;
-- 
1.7.1

