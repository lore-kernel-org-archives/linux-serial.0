From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: New serial card development
Date: Tue, 23 Oct 2012 18:06:57 +0000 (UTC)
Message-ID: <k66mc1$cml$1@ger.gmane.org>
References: <5074703E.408@commtech-fastcom.com>
 <20121014093704.GA6207@thunk.org>
 <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
 <20121016002608.64b33de5@pyramind.ukuu.org.uk>
 <20121016023226.GA17446@thunk.org>
 <CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
 <20121019212158.GB4721@thunk.org>
 <CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46370 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756722Ab2JWSHM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 14:07:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1TQiso-0004uP-2j
	for linux-serial@vger.kernel.org; Tue, 23 Oct 2012 20:07:18 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 23 Oct 2012 20:07:18 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 23 Oct 2012 20:07:18 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2012-10-23, Matt Schulte <matts@commtech-fastcom.com> wrote:
> On Fri, Oct 19, 2012 at 4:21 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>> On Wed, Oct 17, 2012 at 03:24:06PM -0500, Matt Schulte wrote:
>>>
>>> What I would need to have happen is for a flag to be set that says
>>> "enable 9-bit mode transmit" or something.  When set, the first byte
>>> of data of a given write will go out with mark parity, then the rest
>>> of the bytes will have space parity.  The one byte with mark is the
>>> address byte.
>
>> Why not just have a userspace library routine which simply uses
>> tcgetattr/tcsetattr to toggle a bit (probably a new bit in c_cflag) in
>> struct termios, issue the single byte write, and then toggle the bit
>> back?

Can it be guaranteed that it's going to be fast enough at high
baud-rates to prevent any gap between the first byte and subsequent
bytes?

>> In Linux, system calls are fast, so using some extra ioctl's to toggle
>> the termios structure is probably the way to go.  It's also much more
>> general since it doesn't presume a very specific protocol (i.e., your
>> magic multi-drop protocol).
>
> Also this isn't a magic protocol, it is a very old protocol that is
> apparently still in use today because I have several customers still
> asking for it.

It's been pretty much a standard in the microctroller world for a
_long_ time.  I remember 9-bit HW support with special interrupt on
the "address" byte from almost 30 years ago: when I first worked with
the Intel 8051 in 1983, it had 9-bit support in it's UART (and we used
it).

I now work for a company that has manufactured PC serial boards for
25+ years, and we still get regular requests for that feature (and our
boards do support it -- though our Linux driver does not).

-- 
Grant Edwards               grant.b.edwards        Yow! I guess you guys got
                                  at               BIG MUSCLES from doing too
                              gmail.com            much STUDYING!

