From: David Lawyer <dave@lafn.org>
Subject: Re: n_tty.c driver patch (semantic and performance correction) (a ll recent versions)
Date: Tue, 30 Jul 2002 22:31:39 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20020730223139.A928@lafn.org>
References: <11E89240C407D311958800A0C9ACF7D13A7915@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from davespc (mail@66-81-79-99-modem.o1.com [66.81.79.99])
	by zoon.lafn.org (8.11.3/8.11.3) with ESMTP id g6V5bNk48187
	for <linux-serial@vger.kernel.org>; Tue, 30 Jul 2002 22:37:23 -0700 (PDT)
	(envelope-from dave@lafn.org)
Received: from dave by davespc with local (Exim 3.35 #1 (Debian))
	id 17Zm5E-0000FW-00
	for <linux-serial@vger.kernel.org>; Tue, 30 Jul 2002 22:31:40 -0700
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A7915@EXCHANGE>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Tue, Jul 30, 2002 at 10:07:51AM -0700, Ed Vance wrote:
> On Sat, July 27, 2002 at 8:02 PM, stevie@qrpff.net wrote:
> > 
> > But... but... the standard says...
> > 
> >    A pending read shall not be satisfied until MIN bytes are 
> >    received (that is, the pending read shall block until MIN 
> >    bytes are received), or a signal is received.
> > 
> > And because I'm too dead-set on doing it that way solely because 
> > that's how it's always been done, I won't ever consider changing it.  
> > I'll blindly ignore how much xmodem transfers suck, and the fact 
> > that I can come up with no practical purpose at all for this feature, 
> > and just repeat what the standard says.  Why should we obey what 
> > Linux man pages say? What do the Linux man pages have to do with 
> > Linux?
> > 
> > Remember: Computers and their programs aren't here to make our lives 
> > easier, or to make tasks simpler. They are here to follow standards.
> 
> Hi Rob, 
> 
> Stevie O gets to the central issue here. Why _not_ change long-existing,
> widely used interfaces in subtle ways because the old way makes no sense to
> us and the new way does? Is standards-based programming a lemming behavior? 
> 
> My answer is that but-I-think-it-would-be-better, alone, is not a sufficient
> reason to risk exposure of old application bugs (if you don't actually have
> to) and to bring down apps that ran just fine with the bugs for years. In
> this case, the proposed new functionality is triggered by use of interface
> space that already had a specified behavior. 
> 
> When new functionality is added, at a minimum, its interface should be
> outside of the previous valid use set. If one simply must attach the
> tendrils of cleverness to the vines of an existing interface, the new
> functionality should only appear upon app behaviors that would previously
> have been invalid enough to reject the request and burp up an error code. 
> 
> As I said before, innovation is fine. Just don't pollute the existing
> interfaces. If even one real customer running real work has bad day because
> of exposure of an old app bug or an unanticipated consequence of the change,
> then it wasn't worth ignoring safer implementation practices. One can't
> attain 100% safety, but one _can_ minimize the risk. 

I think it's very important for Linux to be efficient so that it will
work well on old hardware, etc.  What's being proposed seems to help.
So I think that if there is a low probability that it will break any
existing application where non-trivial harm will be caused, then I would
favor innovation (actually common sense in this case).  Also someone
should try to get the standards modified to clearly allow what's
proposed.

			David Lawyer (Maintainer of Serial-HOWTO, but I
			           try to avoid Serial-Programming :-)
