From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: New serial card development
Date: Tue, 23 Oct 2012 19:48:01 +0000 (UTC)
Message-ID: <k66s9h$4ir$2@ger.gmane.org>
References: <5074703E.408@commtech-fastcom.com>
 <20121014093704.GA6207@thunk.org>
 <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
 <20121016002608.64b33de5@pyramind.ukuu.org.uk>
 <20121016023226.GA17446@thunk.org>
 <CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
 <20121019212158.GB4721@thunk.org>
 <CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
 <k66mc1$cml$1@ger.gmane.org> <20121023192633.18849645@pyramind.ukuu.org.uk>
 <k66okv$811$1@ger.gmane.org> <20121023202404.7e916cca@pyramind.ukuu.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52869 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932223Ab2JWTsT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 15:48:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1TQkSc-00084k-MG
	for linux-serial@vger.kernel.org; Tue, 23 Oct 2012 21:48:22 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 23 Oct 2012 21:48:22 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 23 Oct 2012 21:48:22 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2012-10-23, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> FWIW, in some products we're planning that will require support for
>> various industrial serial protocols, I'm leaning towards abandoning
>> the tty driver approach and writing a stand-alone character device
>> driver.  The byte-stream oriented tty/line-discipline layer just
>> doesn't fit well when dealing with frame-oriented industrial protocols
>> that depend on things like 9th bit addressing and detecting
>> sub-millisecond inter-byte timeouts.  When I add in the lack of
>> long-term stability in the tty API it seems like it might not be such
>> a bad idea to give up trying to make the tty abstraction fit a use
>> case that's just nothing like a teletype.
>
> Not unreasonable but we do need to cover it to some extent because there
> are a lot of 'multi-use' port types where you need to share the hardware
> or switch modes.

Agreed. Providing support for things like 9 bit mode, inter-byte
timeouts, arbitrary baud rates, half-duplex mode, and user-selectable
electrical interfaces (232/422/485/etc.) in the standard tty API would
be a good thing. Half-duplex mode (sometimes called RS485 mode) and
arbitrary baud rate are great recent additions.

> Although we don't use it that way its not entirely accidental that the
> tty buffer code supports chains of buffers with lengths 8)

Thanks, that's good to know.

-- 
Grant Edwards               grant.b.edwards        Yow! I can't decide which
                                  at               WRONG TURN to make first!!
                              gmail.com            I wonder if BOB GUCCIONE
                                                   has these problems!

