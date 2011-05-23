From: Greg KH <gregkh@suse.de>
Subject: Re: [GIT PATCH] TTY/serial driver patches for .40
Date: Mon, 23 May 2011 12:43:06 -0700
Message-ID: <20110523194306.GA20850@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <BANLkTi=jGtVjJEY9aE2SPJCHhbpXfgsFTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43486 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756190Ab1EWTmF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:42:05 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=jGtVjJEY9aE2SPJCHhbpXfgsFTg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, May 23, 2011 at 12:27:35PM -0700, Linus Torvalds wrote:
> On Mon, May 23, 2011 at 12:05 PM, Greg KH <gregkh@suse.de> wrote:
> >
> > Some api cleanups, and driver updates, nothing really major. =A0You=
 will
> > get two conflicts when you merge this to your tree (one in the tty
> > Makefile and one in the bluetooth driver), but they should be "obvi=
ous"
> > as to what to do.
>=20
> I went a bit beyond "obvious", and actually fixed in the merge what
> looked to be some missed things:
>=20
>  - the hci_uart_tty_receive "Return value" comment was stale
>=20
>  - it really looked to me like the 'stat.byte_rx' increment should us=
e
> the new 'received' count that we return.
>=20
> So anybody who cares should probably check the end result.

It looks correct to me, thanks for catching this and doing the merge.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
