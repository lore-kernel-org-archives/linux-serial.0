From: "Aubrey Li" <aubreylee@gmail.com>
Subject: [BUG]: 2.6.19.2: Weird serial core issue
Date: Wed, 31 Jan 2007 18:49:25 +0800
Message-ID: <6d6a94c50701310249o2b2c8024i4d3f28ec1601246a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:22323 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbXAaKt0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Jan 2007 05:49:26 -0500
Received: by wx-out-0506.google.com with SMTP id h31so169336wxd
        for <linux-serial@vger.kernel.org>; Wed, 31 Jan 2007 02:49:25 -0800 (PST)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org

I insert one printk into drivers/serial/serial_core.c:
uart_set_termios() to describe the issue.
static void uart_set_termios(struct tty_struct *tty, struct termios
*old_termios)
{
 ----snip----
        unsigned int cflag = tty->termios->c_cflag;

        BUG_ON(!kernel_locked());
+++printk("new_termios flag: 0x%x, old_termios flag: 0x%x\n");
+++             cflag, old_termios->c_cflag);

----snip ----
}

When I telnet my board and run the following command:
---- root:~> stty -F /dev/ttyS0 -crtscts

I got the following result from the console of my board:
---- root:~>new_termios flag: 0x1cb1, old_termios flag: 0x80001cb1

That's correct. CRTSCTS flag is clear

But when I type "ENTER" key on the console, I got:
----root:~>new_termios flag: 0x80001cb1, old_termios flag: 0x1cb1

The CRTSCTS flag is set back. But I didn't set it back, I just type "ENTER".
I guess, Is it a serial core bug?

-Aubrey
