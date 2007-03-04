From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Sun, 4 Mar 2007 11:20:44 -0500
Message-ID: <200703041120.45211.rgetz@blackfin.uclinux.org>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933010AbXCDQUE@vger.kernel.org>
In-Reply-To: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: rmk@arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu 1 Mar 2007 19:03, Mike Frysinger pondered:
> the console= bootcmd allows for controlling of the initial state of
> flow control by adding/omitting the 'r' suffix ... however, the
> uart_startup() function in serial_core.c always calls down into the
> serial driver with TIOCM_RTS:
> static int uart_startup(...) {
> ...
>             /*
>              * Setup the RTS and DTR signals once the
>              * port is open and ready to respond.
>              */
>             if (info->tty->termios->c_cflag & CBAUD)
>                 uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
> ...
>
> shouldnt TIOCM_RTS be passed down only when the 'r' is appended to the
> boot cmdline ?  perhaps like this:
> uart_set_mctrl(port, (info->flags & UIF_CTS_FLOW ? TIOCM_RTS : 0) |
> TIOCM_DTR); assuming too that TIOCM_DTR should always be set ...

This would help a similar problem I am having. Simply using a serial console 
with Flow control enabled, turns flow control on. 

If the application wants the capability to turn Flow control on later, without 
booting with it on, the current code does not allow this...

Was this the intended use the the 'console=...r'?

Thanks
-Robin
