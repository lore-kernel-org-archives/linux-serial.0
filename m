From: Greg KH <greg@kroah.com>
Subject: Re: New serial card development
Date: Tue, 23 Oct 2012 12:16:04 -0700
Message-ID: <20121023191604.GA1942@kroah.com>
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
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54587 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932144Ab2JWTQE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 15:16:04 -0400
Content-Disposition: inline
In-Reply-To: <k66okv$811$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On Tue, Oct 23, 2012 at 06:45:51PM +0000, Grant Edwards wrote:
> On 2012-10-23, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >> Can it be guaranteed that it's going to be fast enough at high
> >> baud-rates to prevent any gap between the first byte and subsequent
> >> bytes?
> >
> > Possibly not for some protocols (or worse yet 'almost always' for
> > some protocols).
> >
> > It's something to look at once the basic bits are in.
> >
> >> I now work for a company that has manufactured PC serial boards for
> >> 25+ years, and we still get regular requests for that feature (and our
> >> boards do support it -- though our Linux driver does not).
> >
> > In which case when we get to addressing this it will be good to make
> > sure we cover your needs as well.
> 
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

What do you mean "lack of long-term stability"?  The userspace tty api
hasn't ever changed or broken.  Don't focus on in-kernel api, that's
always going to change, no matter what interface you choose to use in
the kernel.

Just get your drivers merged into the tree and you will not have to
worry about it.

thanks,

greg k-h
