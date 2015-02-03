From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 2/2] tty: serial: 8250_core: Check that port->line is >=0
Date: Tue,  3 Feb 2015 11:01:48 +0100
Message-ID: <7904178c3dfbf08191514c8436e66d711455a17c.1422957699.git.michal.simek@xilinx.com>
References: <d237c6e90cbd2f106a4125816b02d0541fa4cefe.1422957699.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d237c6e90cbd2f106a4125816b02d0541fa4cefe.1422957699.git.michal.simek@xilinx.com>
In-Reply-To: <d237c6e90cbd2f106a4125816b02d0541fa4cefe.1422957699.git.michal.simek@xilinx.com>
References: <d237c6e90cbd2f106a4125816b02d0541fa4cefe.1422957699.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-serial@vger.kernel.org

Add one more checking condition which was originally added by:
"tty: serial: 8250_core: use the ->line argument as a hint in
serial8250_find_match_or_unused()"
(sha1: 59b3e898ddfc81a65975043b5eb44103cc29ff6e)

port->line can be setup by DT driver to -1 which needs to
be also checked.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Change commit message description
- Do not sign patches - Greg reported problem with it

I have similar patch to 59b3e898ddfc81a65975043b5eb44103cc29ff6e
in xilinx tree for a while and port->line can be -1.

The second part of this also should be (what other drivers do)
reading aliases via of_alias_get_id() in of_serial.c:of_platform_serial_probe()
which setup port.line.
---
 drivers/tty/serial/8250/8250_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 65e52c9109e2..aab765177763 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -3512,7 +3512,8 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
 
 	/* try line number first if still available */
 	i = port->line;
-	if (i < nr_uarts && serial8250_ports[i].port.type == PORT_UNKNOWN &&
+	if (i >= 0 && i < nr_uarts &&
+	    serial8250_ports[i].port.type == PORT_UNKNOWN &&
 			serial8250_ports[i].port.iobase == 0)
 		return &serial8250_ports[i];
 	/*
-- 
1.8.2.3
