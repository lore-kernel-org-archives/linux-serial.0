From: Rob Herring <robh@kernel.org>
Subject: [PATCH 1/9] tty: serial_core: add tty NULL check to uart_tx_stopped
Date: Fri,  9 Sep 2016 17:37:02 -0500
Message-ID: <20160909223711.26238-2-robh@kernel.org>
References: <20160909223711.26238-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Commit 761ed4a94582 ("tty: serial_core: convert uart_close to use
tty_port_close") created a case where a port used for a console does not
get shutdown on tty closing. Then a call to uart_tx_stopped() segfaults
because the tty is NULL. This could be fixed to restore old behavior,
but we also want to allow tty_ports to work without a tty attached. So
this change to allow a NULL tty_struct is needed either way.

Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
Reported-by: kernel test robot <xiaolong.ye@intel.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 include/linux/serial_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index cdba6f144f72..378d80a8dd43 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -412,7 +412,7 @@ int uart_resume_port(struct uart_driver *reg, struct uart_port *port);
 static inline int uart_tx_stopped(struct uart_port *port)
 {
 	struct tty_struct *tty = port->state->port.tty;
-	if (tty->stopped || port->hw_stopped)
+	if ((tty && tty->stopped) || port->hw_stopped)
 		return 1;
 	return 0;
 }
-- 
2.9.3
