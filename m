From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New serial card development
Date: Wed, 17 Oct 2012 22:53:15 +0100
Message-ID: <20121017225315.13645d95@pyramind.ukuu.org.uk>
References: <5074703E.408@commtech-fastcom.com>
	<20121014093704.GA6207@thunk.org>
	<CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
	<20121016002608.64b33de5@pyramind.ukuu.org.uk>
	<CAJp1Oe6k7NWqdbYkJnd787JiT55-wSbG+tX1tP7Cy-oPShdVaA@mail.gmail.com>
	<CAJp1Oe7zyDh9w7Nc-xtbPQrbg7FEBr73QmYh_er3UX53KcGL8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43500 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab2JQVsM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Oct 2012 17:48:12 -0400
In-Reply-To: <CAJp1Oe7zyDh9w7Nc-xtbPQrbg7FEBr73QmYh_er3UX53KcGL8A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: linux-serial@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>

> > That probably needs a bit of tweaking to getthe best results
> 
> Does this make you lean one way or the other in how I would best
> implement this driver?

I would always start from what we have.

I wonder actually if there is a bit of a disconnect here from the line
of questions. I know in a lot of environments the model is

	concept design
	internal approval/verification
	consult with other stakeholders
	commit to model	
	build
	release

but in the Linux space the model is

	don't break anyone elses stuff
	get it working
	figure out as you go what is needed
	if it doesn't work out adjust
	polish as it becomes clear what can be done better
	repeat

So even if you submit initial patches to make it work with 8250.c and it
turns out that actually this was the wrong thing everyone will be happy
with the patches that then relocate it.

In addition what tends to occur is that the rules change anyway. You get
half way through submitting support for 256 byte fifos and someone comes
along with another different device that has the feature and so on.

So I would start from 8250.c and get trivial stuff like the fifo changes,
the PCI identifiers and so forth in as a small set of patches and then
work long the rest of it.

Even 'don't break other people's stuff' isn't a hard rule. The real rule
is 'if you break other people's stuff fix it back up' - because it
happens, and it's unavoidable.

Alan
