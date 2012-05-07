From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] tty_lock: Localise the lock
Date: Mon, 7 May 2012 17:42:40 +0100
Message-ID: <20120507174240.4209c5cb@pyramind.ukuu.org.uk>
References: <20120503212151.568.91854.stgit@bob.linux.org.uk>
	<20120503212219.568.15653.stgit@bob.linux.org.uk>
	<CA+1xoqezLCQh_fqJ1iNAs25X7Fm24W=-0J8zTZuVVJQnWTtSLg@mail.gmail.com>
	<20120507171126.5beddc27@pyramind.ukuu.org.uk>
	<1336408208.3638.15.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33612 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659Ab2EGQjt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 May 2012 12:39:49 -0400
In-Reply-To: <1336408208.3638.15.camel@lappy>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, 07 May 2012 18:30:08 +0200
Sasha Levin <levinsasha928@gmail.com> wrote:

> On Mon, 2012-05-07 at 17:11 +0100, Alan Cox wrote:
> > > I don't believe that this change is correct.
> > > 
> > > Consider the following scenario:
> > > 
> > > tty_release -> tty_lock -> pty_close -> tty_vhangup -> tty_lock
> > 
> > We hang up tty->link not tty.
> > 
> > It's now a per tty lock. So I think we are ok.
> 
> Unless we can cause tty->link == tty, in which case:


We should not be able to cause tty->link == tty. So that's a different
problem altogether.

tty->link is set to point to the other half of the pty in pty_install and
in pty98_unix_install. It's never assigned to the same tty and ptys
simply wouldn't work if this wasn't the case.

So whatever your trace is showing, that's not the bug. Something more
complicated would appear to be afoot.

Alan


