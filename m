From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: New serial card development
Date: Tue, 23 Oct 2012 11:27:10 -0500
Message-ID: <CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
References: <5074703E.408@commtech-fastcom.com> <20121014093704.GA6207@thunk.org>
 <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
 <20121016002608.64b33de5@pyramind.ukuu.org.uk> <20121016023226.GA17446@thunk.org>
 <CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com> <20121019212158.GB4721@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57829 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757212Ab2JWQ1c (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 12:27:32 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4464304vbb.19
        for <linux-serial@vger.kernel.org>; Tue, 23 Oct 2012 09:27:31 -0700 (PDT)
In-Reply-To: <20121019212158.GB4721@thunk.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Fri, Oct 19, 2012 at 4:21 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Wed, Oct 17, 2012 at 03:24:06PM -0500, Matt Schulte wrote:
>>
>> What I would need to have happen is for a flag to be set that says
>> "enable 9-bit mode transmit" or something.  When set, the first byte
>> of data of a given write will go out with mark parity, then the rest
>> of the bytes will have space parity.  The one byte with mark is the
>> address byte.
>
> Why not just have a userspace library routine which simply uses
> tcgetattr/tcsetattr to toggle a bit (probably a new bit in c_cflag) in
> struct termios, issue the single byte write, and then toggle the bit
> back?

> In Linux, system calls are fast, so using some extra ioctl's to toggle
> the termios structure is probably the way to go.  It's also much more
> general since it doesn't presume a very specific protocol (i.e., your
> magic multi-drop protocol).

The only reason that I could come up with as to why not to do that is
the probably delay between the first byte and the second byte.
Perhaps the system calls will be so quick that this delay won't be an
issue.  Other than that I think that a new bit in c_cflag would be a
pretty decent solution.

Also this isn't a magic protocol, it is a very old protocol that is
apparently still in use today because I have several customers still
asking for it.

>> In the receive direction I would need to optionally enable a station
>> address which the chip will use to verify all incoming data and will
>> reject anything that is not of the appropriate address.
>
> For the receive direction, my suggestion is to encode it as an
> extension for how PARMRK does things, and then leave the parsing of
> the address bits to userspace.  Otherwise you'll end up needing to
> make the kernel know what are "appropriate" addresses, which again is
> a lot of very protocol specific knowledge that you would have to push
> into the kernel.

The address is something that is decided by the user, it could
literally be anything.  All I need is a way to write a byte to the
appropriate UART register and a bit to turn it on and off.

> Alan's advice to get your card working as a basic serial card is very
> good one.  Get basic functionality working, and then you can add the
> support for the extra bits later....

I can see the logic in getting it working as a basic serial card
first.  I think at minimum I would still need to implement the extra
divisor calculations to get accurate bit rates.

So when it works as a basic serial card, I assume you would want me to
use the default PCI IDs to keep it more generic.  Then would I add my
own PCI IDs and refer them back to the generic port?

Matt
