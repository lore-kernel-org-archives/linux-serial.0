From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: New serial card development
Date: Tue, 23 Oct 2012 16:31:02 -0400
Message-ID: <20121023203102.GA28626@thunk.org>
References: <20121014093704.GA6207@thunk.org>
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
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from li9-11.members.linode.com ([67.18.176.11]:57056 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933945Ab2JWUbF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 16:31:05 -0400
Content-Disposition: inline
In-Reply-To: <k66okv$811$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On Tue, Oct 23, 2012 at 06:45:51PM +0000, Grant Edwards wrote:
> FWIW, in some products we're planning that will require support for
> various industrial serial protocols, I'm leaning towards abandoning
> the tty driver approach and writing a stand-alone character device
> driver.  The byte-stream oriented tty/line-discipline layer just
> doesn't fit well when dealing with frame-oriented industrial protocols
> that depend on things like 9th bit addressing and detecting
> sub-millisecond inter-byte timeouts.  

You might want to take a look at how the ppp line discipline (which is
obviously highly packet oriented) works.  One advantage of doing
things that way is if you have a multiport serial card, where some
ports want to play this packet-oriented approach, and other cards
might be connected to a traditional modem or terminal sort of device,
you won't have to figure out how to share a PCI board between two
different drivers, allocating one port to the traditional tty/serial
driver, and another one to your new driver, etc.

Regards,

						- Ted
