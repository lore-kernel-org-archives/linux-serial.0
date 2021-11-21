Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E0AC433EF
	for <linux-serial@archiver.kernel.org>; Sun, 21 Nov 2021 17:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbhKURqd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 21 Nov 2021 12:46:33 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:45085 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbhKURqb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Nov 2021 12:46:31 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B88D7300002AA;
        Sun, 21 Nov 2021 18:43:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A8DE832478; Sun, 21 Nov 2021 18:43:24 +0100 (CET)
Date:   Sun, 21 Nov 2021 18:43:24 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Su Bao Cheng <baocheng_su@163.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        linux-serial@vger.kernel.org, chao.zeng@siemens.com
Subject: Re: [PATCH] Revert "serial: 8250: Don't touch RTS modem control
 while in rs485 mode"
Message-ID: <20211121174324.GA17258@wunner.de>
References: <20211027111644.1996921-1-baocheng.su@siemens.com>
 <20211027113938.GA9373@wunner.de>
 <e1a9b9bf-45a4-6e71-09f4-1ae730284778@163.com>
 <20211120171810.GA26621@wunner.de>
 <62d4b8ac-b9a4-3f3a-a5e3-7a3c21ed16f0@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d4b8ac-b9a4-3f3a-a5e3-7a3c21ed16f0@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 21, 2021 at 10:00:51AM +0100, Jan Kiszka wrote:
> Meanwhile reproduced myself, and now I believe your patch is broken in
> ignoring the internal call path to serial8250_set_mctrl, coming from
> uart_port_dtr_rts:
[...]
> This case is not triggered by userspace setting a custom RTS value but
> by the uart-internal machinery selecting it based on the rs485 mode,
> among other things. That path must not be intercepted and made
> conditional using the current MCR state but has to write the request
> value *as is*.

Thanks for the analysis and sorry for the breakage.  I'm proposing the
fix below.  Let me know if that works for you.

However I believe that omap_8250_startup() should be amended to not set
up->mcr = 0 unconditionally.  Rather, it should set the RTS bit if rs485
is enabled and RTS polarity is inverted (as seems to be the case on your
product).  Right now, even with the fix below you'll see a brief glitch
wherein RTS is asserted (so the transceiver's driver is enabled) and
immediately deasserted when opening the port.  This may disturb the
communication of other devices on the bus.  Do you agree?  If so, I can
prepare a separate fix for that.  Note that we may have never noticed
that without f45709df7731, so... ;)

Thanks,

Lukas

-- >8 --
Subject: [PATCH] serial: 8250: Fix RTS modem control while in rs485 mode

Commit f45709df7731 ("serial: 8250: Don't touch RTS modem control while
in rs485 mode") sought to prevent user space from interfering with rs485
communication by ignoring a TIOCMSET ioctl() which changes RTS polarity.

It did so in serial8250_do_set_mctrl(), which turns out to be too deep
in the call stack:  When a uart_port is opened, RTS polarity is set by
the rs485-aware function uart_port_dtr_rts().  It calls down to
serial8250_do_set_mctrl() and that particular RTS polarity change should
*not* be ignored.

The user-visible result is that on 8250_omap ports which use rs485 with
inverse polarity (RTS bit in MCR register is 1 to receive, 0 to send),
a newly opened port initially sets up RTS for sending instead of
receiving.  That's because omap_8250_startup() sets the cached value
up->mcr to 0 and omap_8250_restore_regs() subsequently writes it to the
MCR register.  Due to the commit, serial8250_do_set_mctrl() preserves
that incorrect register value:

do_sys_openat2
  do_filp_open
    path_openat
      vfs_open
        do_dentry_open
	  chrdev_open
	    tty_open
	      uart_open
	        tty_port_open
		  uart_port_activate
		    uart_startup
		      uart_port_startup
		        serial8250_startup
			  omap_8250_startup # up->mcr = 0
			uart_change_speed
			  serial8250_set_termios
			    omap_8250_set_termios
			      omap_8250_restore_regs
			        serial8250_out_MCR # up->mcr written
		  tty_port_block_til_ready
		    uart_dtr_rts
		      uart_port_dtr_rts
		        serial8250_set_mctrl
			  omap8250_set_mctrl
			    serial8250_do_set_mctrl # mcr[1] = 1 ignored

Fix by intercepting RTS changes from user space in uart_tiocmset()
instead.

Fixes: f45709df7731 ("serial: 8250: Don't touch RTS modem control while in rs485 mode")
Reported-by: Su Bao Cheng <baocheng.su@siemens.com>
Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Chao Zeng <chao.zeng@siemens.com>
Cc: stable@vger.kernel.org # v5.7+
---
 drivers/tty/serial/8250/8250_port.c | 7 -------
 drivers/tty/serial/serial_core.c    | 5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5775cbff8f6e..46e2079ad1aa 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2024,13 +2024,6 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned char mcr;
 
-	if (port->rs485.flags & SER_RS485_ENABLED) {
-		if (serial8250_in_MCR(up) & UART_MCR_RTS)
-			mctrl |= TIOCM_RTS;
-		else
-			mctrl &= ~TIOCM_RTS;
-	}
-
 	mcr = serial8250_TIOCM_to_MCR(mctrl);
 
 	mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1e738f265eea..6a38e9d7b87a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1075,6 +1075,11 @@ uart_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
 		goto out;
 
 	if (!tty_io_error(tty)) {
+		if (uport->rs485.flags & SER_RS485_ENABLED) {
+			set &= ~TIOCM_RTS;
+			clear &= ~TIOCM_RTS;
+		}
+
 		uart_update_mctrl(uport, set, clear);
 		ret = 0;
 	}
-- 
2.33.0

