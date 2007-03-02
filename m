From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: should RTS init in serial core be tied to CRTSCTS
Date: Thu, 1 Mar 2007 19:03:02 -0500
Message-ID: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:45302 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422642AbXCBADD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Mar 2007 19:03:03 -0500
Received: by an-out-0708.google.com with SMTP id b33so549144ana
        for <linux-serial@vger.kernel.org>; Thu, 01 Mar 2007 16:03:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk@arm.linux.org.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Robin Getz <rgetz@blackfin.uclinux.org>

the console= bootcmd allows for controlling of the initial state of
flow control by adding/omitting the 'r' suffix ... however, the
uart_startup() function in serial_core.c always calls down into the
serial driver with TIOCM_RTS:
static int uart_startup(...) {
...
            /*
             * Setup the RTS and DTR signals once the
             * port is open and ready to respond.
             */
            if (info->tty->termios->c_cflag & CBAUD)
                uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
...

shouldnt TIOCM_RTS be passed down only when the 'r' is appended to the
boot cmdline ?  perhaps like this:
uart_set_mctrl(port, (info->flags & UIF_CTS_FLOW ? TIOCM_RTS : 0) | TIOCM_DTR);
assuming too that TIOCM_DTR should always be set ...
-mike
