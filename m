From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: New serial card development
Date: Fri, 19 Oct 2012 17:21:58 -0400
Message-ID: <20121019212158.GB4721@thunk.org>
References: <5074703E.408@commtech-fastcom.com>
 <20121014093704.GA6207@thunk.org>
 <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
 <20121016002608.64b33de5@pyramind.ukuu.org.uk>
 <20121016023226.GA17446@thunk.org>
 <CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from li9-11.members.linode.com ([67.18.176.11]:56359 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746Ab2JSVWF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Oct 2012 17:22:05 -0400
Content-Disposition: inline
In-Reply-To: <CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Wed, Oct 17, 2012 at 03:24:06PM -0500, Matt Schulte wrote:
> 
> What I would need to have happen is for a flag to be set that says
> "enable 9-bit mode transmit" or something.  When set, the first byte
> of data of a given write will go out with mark parity, then the rest
> of the bytes will have space parity.  The one byte with mark is the
> address byte.

Why not just have a userspace library routine which simply uses
tcgetattr/tcsetattr to toggle a bit (probably a new bit in c_cflag) in
struct termios, issue the single byte write, and then toggle the bit
back?

If you really want to implement a special case "the first byte should
treated differently from the rest", that gets problemtic for a number
of reasons.  First of all, it's just a lot more kernel code; you'd
probably need to implement a new line displine, and secondly, if
userspace sends too much data so that it can't fit in the kernel
buffer, you might get a partial write.  In which case, when you send a
second write call to send the rest of the data, you'd have to go
through extra work to make sure the first byte of that second,
follow-up byte doesn't have the high 9th bit set.

Of course, you could hack in even more changes to make the write
system call behave entirely differently in your magic "9th bit mode",
where the write system call becomes a "all or nothing" sort of thing,
but that's even more evil hackery that almost certainly would be
rejected with extreme prejudice by the kernel maintainers.

In Linux, system calls are fast, so using some extra ioctl's to toggle
the termios structure is probably the way to go.  It's also much more
general since it doesn't presume a very specific protocol (i.e., your
magic multi-drop protocol).

> In the receive direction I would need to optionally enable a station
> address which the chip will use to verify all incoming data and will
> reject anything that is not of the appropriate address.

For the receive direction, my suggestion is to encode it as an
extension for how PARMRK does things, and then leave the parsing of
the address bits to userspace.  Otherwise you'll end up needing to
make the kernel know what are "appropriate" addresses, which again is
a lot of very protocol specific knowledge that you would have to push
into the kernel.

Alan's advice to get your card working as a basic serial card is very
good one.  Get basic functionality working, and then you can add the
support for the extra bits later....

						- Ted
