From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: RE: Serial custom speed deprecated?
Date: Thu, 24 Aug 2006 14:19:28 +0100
Message-ID: <1156425568.3007.138.camel@localhost.localdomain>
References: <033001c6c77a$a7d8ab10$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50886 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751266AbWHXM6E (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Aug 2006 08:58:04 -0400
In-Reply-To: <033001c6c77a$a7d8ab10$294b82ce@stuartm>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: 'David Woodhouse' <dwmw2@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

Ar Iau, 2006-08-24 am 08:41 -0400, ysgrifennodd Stuart MacDonald:
> The easiest thing is likely to add a new ioctl to serial_core.c
> specifically for setting the baud rate. It takes an integer baud rate
> and returns success or error. It will need to be able to call a

It should take a pair, a send rate and a receive rate. We need that to
cover some corner cases.

> Hm, after some thought I think the core won't actually end up doing
> anything except dispatching. So the better way is to add ioctls to the
> subdrivers directly.

Actually to do this right we have to make a decision or two

The POSIX way of handling this requires the speeds are in the termios
structure "somewhere". We can't easily implement cfgetispeed/cfgetospeed
unless we grow the termios structure in the kernel and issue 3 new
ioctls (keeping the others as trivial translations) and then bumping
glibc and the kernel to do the right thing.

The alternative is that we provide an extra pair of speed ioctls and
glibc does the magic to hide this lot while providing a termios with the
new fields itself.

Whichever way we go glibc already has the fields present and the
libc<->application API appears to be unchanged by this.

I'd rather we went the way of extending our termios to include c_ispeed,
c_ospeed values. The code isn't hard for the remapping of the old ones
and it avoids extra ioctls and the corner case races between two speed
sets that occur if they are two ioctls.


Alan
