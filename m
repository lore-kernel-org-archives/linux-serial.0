From: Alan Stern <stern@rowland.harvard.edu>
Subject: Lockdep violation in the serial driver
Date: Fri, 27 Jul 2007 17:33:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707271726080.2810-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54794 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S935269AbXG0VdV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 17:33:21 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

I want to make some changes to the Power Management core, and one of
the side effects will be to make it illegal for a driver to acquire a
mutex within its suspend() or resume() method if that mutex was locked
while the device was registered.

Unfortunately the serial core does exactly that.  In 
drivers/serial/serial_core.c the uart_add_one_port() routine holds 
state->mutex while calling tty_register_device(), and the same mutex is 
acquired by uart_suspend_port() and uart_resume_port().

Can anybody suggest a way around this?  Does the mutex really need to 
be locked at all these times?  Can it be released before calling 
tty_register_device()?  Or could two separate mutexes be used?

Thanks,

Alan Stern

