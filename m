From: Abhijit Lamsoge <abhijitelinux@gmail.com>
Subject: Re: Serial Core crash in tty_open
Date: Thu, 29 May 2014 15:09:30 +0530
Message-ID: <CAKnSG-Y-wPmgHQY193NHot0pFV22v-rynOgn5RBCXE0L4f7sew@mail.gmail.com>
References: <CAKnSG-bhcO6x309aiE2nwgBjXU=0u=3dXH-GgKQvjK=6S-q1JA@mail.gmail.com>
	<CAKnSG-bX89qBe-TJUAJBTBGS1Y9sq3sc4L9GBrwKpxUxE2QHKw@mail.gmail.com>
	<20140528143726.GD24698@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:38960 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055AbaE2Jjc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 May 2014 05:39:32 -0400
Received: by mail-la0-f45.google.com with SMTP id gl10so38913lab.32
        for <linux-serial@vger.kernel.org>; Thu, 29 May 2014 02:39:30 -0700 (PDT)
In-Reply-To: <20140528143726.GD24698@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

Hi Greg,
Thanks for your reply.
I have modified my driver to work,
the struct tty_driver has a back pointer to original tty_driver structure.
Which had to be initialized to the port variable of original
tty_driver structure, after tty_init_port and before
tty_register_driver(my_driver), for my_drv->nr numbers, after all
uart_register and basic structure initialization is successful.
The back pointer I believe is added sometime after 3.0 Kernel, because
of which the port initialization handling needed to be done in driver
writers code, as contrary to my earlier code, where it must have been
taken care by serial core.
Thanks again for motivation.
For any further bugs, I will keep posting.

Abhijit

On Wed, May 28, 2014 at 8:07 PM, Greg KH <greg@kroah.com> wrote:
> On Wed, May 28, 2014 at 02:34:07PM +0530, Abhijit Lamsoge wrote:
>> Hi All,
>> Crash Starts here.
>>
>>  1498.722292] ------------[ cut here ]------------
>> [ 1498.722305] WARNING: CPU: 3 PID: 5029 at
>> /build/buildd/linux-3.13.0/drivers/tty/tty_io.c:1474
>> tty_init_dev+0x1d0/0x1e0()
>> [ 1498.722308] tty_init_dev:  driver does not set tty->port. This will
>> crash the kernel later. Fix the driver!
>
> Doesn't this explain the issue well enough?
>
