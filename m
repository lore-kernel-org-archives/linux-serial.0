From: Michael Reed <mreed@linux.vnet.ibm.com>
Subject: [PATCH][RESEND] 8250: Fix capabilities when changing the port type
Date: Tue, 31 May 2011 12:06:29 -0500
Message-ID: <1306861589-17617-2-git-send-email-mreed@linux.vnet.ibm.com>
References: <1306861589-17617-1-git-send-email-mreed@linux.vnet.ibm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:52678 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757841Ab1EaRHp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 May 2011 13:07:45 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4VGreZq013702
	for <linux-serial@vger.kernel.org>; Tue, 31 May 2011 10:53:40 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id p4VH7VSP027868
	for <linux-serial@vger.kernel.org>; Tue, 31 May 2011 11:07:32 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4VB6auP002689
	for <linux-serial@vger.kernel.org>; Tue, 31 May 2011 05:06:38 -0600
In-Reply-To: <1306861589-17617-1-git-send-email-mreed@linux.vnet.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Breno Leitao <leitao@linux.vnet.ibm.com>, Michael Reed <mreed@linux.vnet.ibm.com>

When changing the port type, the capabilities flags should be
changed also, otherwise the capabilities will not correspond
to the port type, which make set_sleep() crash on rmmod.
This patch just assign the correct capabilites when the port
changes.

Signed-off-by: Breno Leitao <leitao@linux.vnet.ibm.com>
CC: Michael Reed <mreed@linux.vnet.ibm.com>
---
 drivers/tty/serial/8250.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 6611535..8e771cb 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -3282,6 +3282,7 @@ void serial8250_unregister_port(int line)
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
 		uart->port.type = PORT_UNKNOWN;
 		uart->port.dev = &serial8250_isa_devs->dev;
+		uart->capabilities = uart_config[uart->port.type].flags;
 		uart_add_one_port(&serial8250_reg, &uart->port);
 	} else {
 		uart->port.dev = NULL;
-- 
1.7.1

