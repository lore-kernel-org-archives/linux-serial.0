From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: New serial card development
Date: Tue, 23 Oct 2012 20:41:52 +0000 (UTC)
Message-ID: <k66veg$1h4$1@ger.gmane.org>
References: <20121014093704.GA6207@thunk.org>
 <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
 <20121016002608.64b33de5@pyramind.ukuu.org.uk>
 <20121016023226.GA17446@thunk.org>
 <CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
 <20121019212158.GB4721@thunk.org>
 <CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
 <k66mc1$cml$1@ger.gmane.org> <20121023192633.18849645@pyramind.ukuu.org.uk>
 <k66okv$811$1@ger.gmane.org> <20121023203102.GA28626@thunk.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57582 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964822Ab2JWUmH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 16:42:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1TQlIg-00060Q-My
	for linux-serial@vger.kernel.org; Tue, 23 Oct 2012 22:42:12 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 23 Oct 2012 22:42:10 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 23 Oct 2012 22:42:10 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2012-10-23, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, Oct 23, 2012 at 06:45:51PM +0000, Grant Edwards wrote:

>> FWIW, in some products we're planning that will require support for
>> various industrial serial protocols, I'm leaning towards abandoning
>> the tty driver approach and writing a stand-alone character device
>> driver.  The byte-stream oriented tty/line-discipline layer just
>> doesn't fit well when dealing with frame-oriented industrial protocols
>> that depend on things like 9th bit addressing and detecting
>> sub-millisecond inter-byte timeouts.  
>
> You might want to take a look at how the ppp line discipline (which
> is obviously highly packet oriented) works.  One advantage of doing
> things that way is if you have a multiport serial card, where some
> ports want to play this packet-oriented approach, and other cards
> might be connected to a traditional modem or terminal sort of device,
> you won't have to figure out how to share a PCI board between two
> different drivers, allocating one port to the traditional tty/serial
> driver, and another one to your new driver, etc.

Thanks for the suggestion.  I did look into line-disciplines briefly
quite a while back. Most of the information I found implied that
adding a line disciplilne wasn't something you could do at run-time by
loading a user-built module -- it would require recompiling parts of
the kernel.  Articles made statements about having to modify kernel
include files like tty.h. If that's wrong, then a line discipline
might be a good option.

-- 
Grant Edwards               grant.b.edwards        Yow! I'm having a
                                  at               quadrophonic sensation
                              gmail.com            of two winos alone in a
                                                   steel mill!

