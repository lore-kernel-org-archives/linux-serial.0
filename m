From: Sudhir Sreedharan <ssreedharan@mvista.com>
Subject: [PATCH] tty: serial: 8250_core: Do not call set_sleep for console port
Date: Thu,  9 Oct 2014 19:15:26 +0530
Message-ID: <1412862326-6147-1-git-send-email-ssreedharan@mvista.com>
References: <CAJJ77WtZKtDqxRQv4+zH6DDnBKq9RmsKT7DYe7d+H-ztjKNQ7A@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:40238 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbaJINqB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Oct 2014 09:46:01 -0400
Received: by mail-ig0-f177.google.com with SMTP id a13so4125786igq.10
        for <linux-serial@vger.kernel.org>; Thu, 09 Oct 2014 06:46:01 -0700 (PDT)
In-Reply-To: <CAJJ77WtZKtDqxRQv4+zH6DDnBKq9RmsKT7DYe7d+H-ztjKNQ7A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, khilman@kernel.org
Cc: linux-serial@vger.kernel.org, jslaby@suse.cz, linux-kernel@vger.kernel.org, olof@lixom.net, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, Sudhir Sreedharan <ssreedharan@mvista.com>

In ST16650V2 based serial uarts, while initalizing the PM state,
LCR registers are being initialized to 0 in serial8250_set_sleep().
If console port is already initialized and being used, this will
throws garbage in the console.

Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
---
 drivers/tty/serial/8250/8250_core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ca5cfdc..994aa25 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2618,6 +2618,9 @@ void serial8250_do_pm(struct uart_port *port, unsigned int state,
 {
 	struct uart_8250_port *p = up_to_u8250p(port);
 
+	if (port->cons && (port->cons->flags & CON_ENABLED) && (state == 0))
+		return;
+
 	serial8250_set_sleep(p, state != 0);
 }
 EXPORT_SYMBOL(serial8250_do_pm);
-- 
1.7.0.1

