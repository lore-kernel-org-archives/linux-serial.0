From: Greg KH <greg@kroah.com>
Subject: Re: New serial card development
Date: Tue, 23 Oct 2012 13:10:16 -0700
Message-ID: <20121023201016.GA3408@kroah.com>
References: <20121016002608.64b33de5@pyramind.ukuu.org.uk>
 <20121016023226.GA17446@thunk.org>
 <CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
 <20121019212158.GB4721@thunk.org>
 <CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
 <k66mc1$cml$1@ger.gmane.org>
 <20121023192633.18849645@pyramind.ukuu.org.uk>
 <k66okv$811$1@ger.gmane.org>
 <20121023191604.GA1942@kroah.com>
 <k66rv4$4ir$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36678 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933418Ab2JWUKS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 16:10:18 -0400
Content-Disposition: inline
In-Reply-To: <k66rv4$4ir$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On Tue, Oct 23, 2012 at 07:42:28PM +0000, Grant Edwards wrote:
> On 2012-10-23, Greg KH <greg@kroah.com> wrote:
> > On Tue, Oct 23, 2012 at 06:45:51PM +0000, Grant Edwards wrote:
> >
> >> FWIW, in some products we're planning that will require support for
> >> various industrial serial protocols, I'm leaning towards abandoning
> >> the tty driver approach and writing a stand-alone character device
> >> driver.  The byte-stream oriented tty/line-discipline layer just
> >> doesn't fit well when dealing with frame-oriented industrial protocols
> >> that depend on things like 9th bit addressing and detecting
> >> sub-millisecond inter-byte timeouts.  When I add in the lack of
> >> long-term stability in the tty API it seems like it might not be such
> >> a bad idea to give up trying to make the tty abstraction fit a use
> >> case that's just nothing like a teletype.
> >
> > What do you mean "lack of long-term stability"?  The userspace tty api
> > hasn't ever changed or broken.
> 
> I meant the in-kernel api.
> 
> > Don't focus on in-kernel api,
> 
> It's my job to focus on the in-kernel api.

It's my job to ensure that you don't have to.  Why are you caring?  Are
you trying to keep drivers outside of the kernel tree?  If so, there's
nothing we can do, except point out what a bad idea that really is to
try to do.

> > that's always going to change, no matter what interface you choose to
> > use in the kernel.
> 
> Maybe it's just my perception, but the the tty API seems to change a
> more than the plain character-device API.

Recently, yes.  But, once that churn is over, it should settle down.

Oh, and watch out, the "plain" character-device api is going to change
in the next year or so, I've been working on lots of fixups in that
area, and hope to publish something in a month or so if I get it cleaned
up.

My point is, all of the kernel changes, all the time, so don't use the
lack of change, or the rate of change, for a specific api, as any
indication that it will not change again in the future, possibly in very
drastic ways.

thanks,

greg k-h
