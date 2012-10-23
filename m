From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New serial card development
Date: Tue, 23 Oct 2012 20:24:04 +0100
Message-ID: <20121023202404.7e916cca@pyramind.ukuu.org.uk>
References: <5074703E.408@commtech-fastcom.com>
	<20121014093704.GA6207@thunk.org>
	<CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
	<20121016002608.64b33de5@pyramind.ukuu.org.uk>
	<20121016023226.GA17446@thunk.org>
	<CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
	<20121019212158.GB4721@thunk.org>
	<CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
	<k66mc1$cml$1@ger.gmane.org>
	<20121023192633.18849645@pyramind.ukuu.org.uk>
	<k66okv$811$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50671 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab2JWTS5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 15:18:57 -0400
In-Reply-To: <k66okv$811$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

> FWIW, in some products we're planning that will require support for
> various industrial serial protocols, I'm leaning towards abandoning
> the tty driver approach and writing a stand-alone character device
> driver.  The byte-stream oriented tty/line-discipline layer just
> doesn't fit well when dealing with frame-oriented industrial protocols
> that depend on things like 9th bit addressing and detecting
> sub-millisecond inter-byte timeouts.  When I add in the lack of
> long-term stability in the tty API it seems like it might not be such
> a bad idea to give up trying to make the tty abstraction fit a use
> case that's just nothing like a teletype.

Not unreasonable but we do need to cover it to some extent because there
are a lot of 'multi-use' port types where you need to share the hardware
or switch modes.

Although we don't use it that way its not entirely accidental that the
tty buffer code supports chains of buffers with lengths 8)

Alan
