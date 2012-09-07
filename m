From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] TTY: serial: move the dereference below the NULL test
Date: Fri, 7 Sep 2012 14:53:49 +0800
Message-ID: <CAPgLHd9k1SdAd8DMiVjNmUi9DeSvkbMMLzPMwL9rTTfXkFAhTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:42019 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab2IGGxt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Sep 2012 02:53:49 -0400
Received: by qaas11 with SMTP id s11so5802476qaa.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Sep 2012 23:53:49 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The dereference should be moved below the NULL test.

spatch with a semantic match is used to found this.
(http://coccinelle.lip6.fr/)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/ioc4_serial.c | 3 ++-
 drivers/tty/serial/ioc3_serial.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/ioc4_serial.c
index e16894f..1eb5234 100644
--- a/drivers/tty/serial/ioc4_serial.c
+++ b/drivers/tty/serial/ioc4_serial.c
@@ -2069,13 +2069,14 @@ static inline int do_read(struct uart_port *the_port, unsigned char *buf,
 	struct ioc4_port *port = get_ioc4_port(the_port, 0);
 	struct ring *inring;
 	struct ring_entry *entry;
-	struct hooks *hooks = port->ip_hooks;
+	struct hooks *hooks;
 	int byte_num;
 	char *sc;
 	int loop_counter;
 
 	BUG_ON(!(len >= 0));
 	BUG_ON(!port);
+	hooks = port->ip_hooks;
 
 	/* There is a nasty timing issue in the IOC4. When the rx_timer
 	 * expires or the rx_high condition arises, we take an interrupt.

diff --git a/drivers/tty/serial/ioc3_serial.c b/drivers/tty/serial/ioc3_serial.c
index 758ff310..5ac5289 100644
--- a/drivers/tty/serial/ioc3_serial.c
+++ b/drivers/tty/serial/ioc3_serial.c
@@ -1120,13 +1120,14 @@ static inline int do_read(struct uart_port *the_port, char *buf, int len)
 	struct ioc3_port *port = get_ioc3_port(the_port);
 	struct ring *inring;
 	struct ring_entry *entry;
-	struct port_hooks *hooks = port->ip_hooks;
+	struct port_hooks *hooks;
 	int byte_num;
 	char *sc;
 	int loop_counter;
 
 	BUG_ON(!(len >= 0));
 	BUG_ON(!port);
+	hooks = port->ip_hooks;
 
 	/* There is a nasty timing issue in the IOC3. When the rx_timer
 	 * expires or the rx_high condition arises, we take an interrupt.


