From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: n_gsm issues
Date: Fri, 3 Aug 2012 14:42:19 +0100
Message-ID: <20120803144219.302c23b1@pyramind.ukuu.org.uk>
References: <440_1343835403_50194D0B_440_1588_1_OF108ABE84.7A08D19F-ONC1257A4D.00556998-C1257A4D.0055C11D@sagemcom.com>
	<20120801222322.345d0bc2@pyramind.ukuu.org.uk>
	<18908_1343911065_501A7498_18908_1370_1_OFCB0326AC.108F61B0-ONC1257A4E.002F0361-C1257A4E.00455DD9@sagemcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59011 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab2HCNhr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Aug 2012 09:37:47 -0400
In-Reply-To: <18908_1343911065_501A7498_18908_1370_1_OFCB0326AC.108F61B0-ONC1257A4E.002F0361-C1257A4E.00455DD9@sagemcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guillaume JUAN <guillaume.juan@sagemcom.com>
Cc: linux-serial@vger.kernel.org

> I'm using a 2.6.35 kernel, but I have upgraded specifically n_gsm.c to the
> latest version I found in
>       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> ('git describe' tells me it is v3.5-8833-g2d53492)
> I also checked that I had all the n_gsm changes from
>       git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> Is there anything newer ?

No - the Linux tty git and linux-next are the current tree. All
development that matters is done upstream.

> > > gsmtty_close does not wait for event DLCI_CLOSED after
> > > calling gsm_dlci_begin_close.
> >
> > That one is intentional.
> 
> Oh. I thought it was safer for close to be synchronous.
> Is it intentional in gsmtty_hangup too ?

Yes. The underlying serial events are modelled on the way actual physical
serial links operate

	hangup blocks all further access to that user app

	open waits until the port is back ready to use

	close does not normally block for long (this is actually
	configurable on some drivers and maybe n_gsm should support that
	too)

> I am not very familiar with the concept of tty hangup but I believed it
> imposed to cease I/O on the tty after the function returns.
> Moreover the call to tty_vhangup() from gsm_cleanup_mux() will lead to arm
> the T1 timer and if left asynchronous, to try to send stuff after
> gsmld_detach_gsm has set gsm->tty NULL.

Which would be a bug!

The basic idea of hangup goes back to modems. You want to prevent an end
user leaving an app hanging on a dial in port pretending to be the login
process and collecting authentication data.

(its basically using carrier a secure attention key)

> I was half-hoping you would identify other line discipline callbacks that
> could be useful for this purpose, or ways for the ld to tell the tty layer
> it needs to access the tty at closing time.

There is no facility for this in the tty layer currently.

> BTW what is the meaning of "flush" here ? Is it "push the last bytes to the
> tty" or "discard the bytes you have in store" ?

discard

> If the latter meaning, isn't there a lack for a callback that would give a
> last opportunity for the line discipline to send bytes ? Is n_gsm the only
> to have this need ?

It is - and trying to block there causes lots of difficult locking
problems. It's something that eventually wants addressing but we have a
lot of other locking to sort out first !

Alan
