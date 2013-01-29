From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: set_termios() function not getting called
Date: Tue, 29 Jan 2013 21:43:03 +0000 (UTC)
Message-ID: <ke9fp7$2lh$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44610 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab3A2VnX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Jan 2013 16:43:23 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1U0Ixt-0005rG-L9
	for linux-serial@vger.kernel.org; Tue, 29 Jan 2013 22:43:37 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 29 Jan 2013 22:43:37 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 29 Jan 2013 22:43:37 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I'm having problems getting xon/xoff flow control in the new rp2.c
driver working.  

The problem is that the driver's set_termios() function is not getting
called when the user-space application calls tcsetattr() to change
IXON, IXOFF, IXANY, c_cc[VSTOP], or c_cc[VSTART].

According to Documentation/serial/driver:

  set_termios(port,termios,oldtermios)
        Change the port parameters, including word length, parity, stop
        bits. 
       
        [...]

        Other flags may be used (eg, xon/xoff characters) if your
        hardware supports hardware "soft" flow control.

My hardware supports xon/xoff flow control, so how do I use other
flags?

It looks like serial_core.c is hiding some termios changes from
low-level drivers:

  1193  static void uart_set_termios(struct tty_struct *tty,
  1194                                                  struct ktermios *old_termios)
  1195  {
  1196          struct uart_state *state = tty->driver_data;
  1197          unsigned long flags;
  1198          unsigned int cflag = tty->termios->c_cflag;
  1199  
  1200  
  1201          /*
  1202           * These are the bits that are used to setup various
  1203           * flags in the low level driver. We can ignore the Bfoo
  1204           * bits in c_cflag; c_[io]speed will always be set
  1205           * appropriately by set_termios() in tty_ioctl.c
  1206           */
  1207  #define RELEVANT_IFLAG(iflag)   ((iflag) & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
  1208          if ((cflag ^ old_termios->c_cflag) == 0 &&
  1209              tty->termios->c_ospeed == old_termios->c_ospeed &&
  1210              tty->termios->c_ispeed == old_termios->c_ispeed &&
  1211              RELEVANT_IFLAG(tty->termios->c_iflag ^ old_termios->c_iflag) == 0) {
  1212                  return;
  1213          }
  
When I look at omap-serial.c, it looks like it's trying to handle
IXANY, IXON and IXOFF the same way I am -- but I don't get notified
when they change.

I don't understand...

-- 
Grant Edwards               grant.b.edwards        Yow! If I am elected no one
                                  at               will ever have to do their
                              gmail.com            laundry again!

