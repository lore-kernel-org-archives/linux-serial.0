From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/79] TTY: msm_serial, remove unneeded console set
Date: Wed, 26 Oct 2011 14:12:09 +0200
Message-ID: <1319631204-23262-4-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60919 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932816Ab1JZMN2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:28 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

It doesn't make sense to set console to uart_port in console->setup.
At that time the console is set by uart_add_one_port already.

The call chain looked like:
uart_add_one_port()
  uport->cons = drv->cons;   <= once
  uart_configure_port()
    register_console()
     console->setup()
       port->cons = co;      <= second time

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/msm_serial.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index e6ba838..29cbfd8 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -804,8 +804,6 @@ static int __init msm_console_setup(struct console *co, char *options)
 	if (unlikely(!port->membase))
 		return -ENXIO;
 
-	port->cons = co;
-
 	msm_init_clock(port);
 
 	if (options)
-- 
1.7.7

