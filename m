From: Ed Vance <EdV@macrolink.com>
Subject: RE: n_tty.c driver patch (semantic and performance correction) (a
	 ll recent versions)
Date: Wed, 31 Jul 2002 09:58:13 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <18069.546603556$1028134826@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: 'David Lawyer' <dave@lafn.org>
Cc: linux-serial@vger.kernel.org, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>

Hi David,

On Tue, July 30, 2002 at 10:32 PM, David Lawyer wrote:
> On Tue, Jul 30, 2002 at 10:07:51AM -0700, Ed Vance wrote:
> > On Sat, July 27, 2002 at 8:02 PM, stevie@qrpff.net wrote:
> > > 
> > > But... but... the standard says...
> > > 
> > >    A pending read shall not be satisfied until MIN bytes are 
> > >    received (that is, the pending read shall block until MIN 
> > >    bytes are received), or a signal is received.
> > > 
> > > And because I'm too dead-set on doing it that way solely because 
> > > that's how it's always been done, I won't ever consider changing it. 

 [ snip ] 

> > Stevie O gets to the central issue here. Why _not_ change long-existing,
> > widely used interfaces in subtle ways because the old way makes no 
> > sense to us and the new way does? Is standards-based programming a 
> > lemming behavior? 

 [ snip ]

> > As I said before, innovation is fine. Just don't pollute the existing
> > interfaces. If even one real customer running real work has bad day 
> > because of exposure of an old app bug or an unanticipated consequence 
> > of the change, then it wasn't worth ignoring safer implementation 
> > practices. One can't attain 100% safety, but one _can_ minimize the 
> > risk. 
> 
> I think it's very important for Linux to be efficient so that it will
> work well on old hardware, etc.  

I agree 100% so far.

>                                 What's being proposed seems to help.
> So I think that if there is a low probability that it will break any
> existing application where non-trivial harm will be caused, then I would
> favor innovation (actually common sense in this case).  

I don't agree that we have a trade off, here. (big surprise? :) We are
simply asking the wrong question in the quest to achieve the desired
benefit. We are asking how to deviate from the standard to get better
performance. We should be asking how to change the kernel to get better
performance without changing the standard app interface. Of course, making
the standard (but rather uninspired) app interface work efficiently is a
_lot_ more technically challenging. 

>                                                        Also someone
> should try to get the standards modified to clearly allow what's
> proposed.

Good luck with that. ;)

BTW, I am hypersensitive to this issue because I got bit by Mot V/88 that
had a buggy MIN and TIME implementation. My phone ran flames for about a
month because of my initial decision to match their quirky interface
behavior in my serial card's driver. 

Best regards,
Ed

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
