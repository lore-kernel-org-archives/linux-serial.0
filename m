From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/3] TTY: msm_serial, remove unneeded console set
Date: Tue, 12 Jul 2011 22:43:19 +0200
Message-ID: <1310503400-28447-2-git-send-email-jslaby@suse.cz>
References: <1310503400-28447-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310503400-28447-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

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
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>
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
1.7.6
