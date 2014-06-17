From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH tty-next 14/22] tty: Remove tty_wait_until_sent_from_close()
Date: Tue, 17 Jun 2014 13:31:38 +0200
Message-ID: <8191805.dfI4LbYmWz@wuerfel>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com> <53A01F02.7000202@hurleysoftware.com> <063D6719AE5E284EB5DD2968C1650D6D1725DAF6@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:49942 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870AbaFQLbw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jun 2014 07:31:52 -0400
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1725DAF6@AcuExch.aculab.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Laight <David.Laight@aculab.com>
Cc: 'Peter Hurley' <peter@hurleysoftware.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Karsten Keil <isdn@linux-pingi.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

On Tuesday 17 June 2014 11:03:50 David Laight wrote:
> From: Peter Hurley
> ...
> > > I don't understand the second half of the changelog, it doesn't seem
> > > to fit here: there deadlock that we are trying to avoid here happens
> > > when the *same* tty needs the lock to complete the function that
> > > sends the pending data. I don't think we do still do that any more,
> > > but it doesn't seem related to the tty lock being system-wide or not.
> > 
> > The tty lock is not used in the i/o path; it's purpose is to
> > mutually exclude state changes in open(), close() and hangup().
> > 
> > The commit that added this [1] comments that _other_ ttys may wait
> > for this tty to complete, and comments in the code note that this
> > function should be removed when the system-wide tty mutex was removed
> > (which happened with the commit noted in the changelog).
> 
> What happens if another process tries to do a non-blocking open
> while you are sleeping in close waiting for output to drain?
> 
> Hopefully this returns before that data has drained.

Before the patch, I believe tty_reopen() would return -EIO because
the TTY_CLOSING flag is set. After the patch, tty_open() blocks
on tty_lock() before calling tty_reopen(). AFAICT, this is independent
of O_NONBLOCK.

	Arnd
