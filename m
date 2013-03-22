From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Add hardware handshaking to pseudo-tty and USB serial gadget
Date: Thu, 21 Mar 2013 22:14:58 -0400
Message-ID: <1363918498.3395.26.camel@thor.lan>
References: <5D7CD300-386D-4AA1-B48A-0051D17C1F1F@beamcommunications.com>
	 <kifr4e$kc5$1@ger.gmane.org> <1363904564.4488.47.camel@thor.lan>
	 <DB8F1B3EEF94C3439BFFE674EB05E3CC23F2F537@SINPRD0211MB405.apcprd02.prod.outlook.com>
	 <1363910615.3395.9.camel@thor.lan>
	 <DB8F1B3EEF94C3439BFFE674EB05E3CC23F2F908@SINPRD0211MB405.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout01.c08.mtsvc.net ([205.186.168.189]:33965 "EHLO
	mailout01.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab3CVCPE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Mar 2013 22:15:04 -0400
In-Reply-To: <DB8F1B3EEF94C3439BFFE674EB05E3CC23F2F908@SINPRD0211MB405.apcprd02.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Craig McQueen <craig.mcqueen@beamcommunications.com>
Cc: Grant Edwards <grant.b.edwards@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>

On Fri, 2013-03-22 at 01:44 +0000, Craig McQueen wrote:
> > From: Peter Hurley
> > [ +Jiri Slaby who doesn't read linux-serial ;) ]
> > 
> > On Thu, 2013-03-21 at 23:32 +0000, Craig McQueen wrote:
> > >
> > > > From: Peter Hurley [mailto:peter@hurleysoftware.com] On Thu,
> > > > 2013-03-21 at 20:38 +0000, Grant Edwards wrote:
> > > > > On 2013-03-21, Craig McQueen
> > > > > <craig.mcqueen@beamcommunications.com>
> > > > wrote:
> > > > > > It sounds as though people have done pseudo-ttys with HW
> > > > handshaking
> > > > > > support--eg tty0tty project. However I'd rather implement this
> > > > > > function in the kernel pseudo-terminal driver itself. Is there
> > > > > > any reason not to do that?
> > > > >
> > > > > No reason other than you and I are the only two people who care
> > > > > about it. :)
> > > >
> > > > Assuming you're leaning toward an in-kernel solution, why not just
> > > > implement a new tty driver that behaves like a local serial port?
> > >
> > > The pseudo-tty already provides most of the functionality I want, so
> > I
> > > don't want to reinvent the wheel. I want to use it to simulate a
> > modem
> > > device. Various other programs could benefit from an enhanced
> > > pseudo-tty, so they also don't have to implement their own kernel
> > > drivers--e.g.:
> > 
> > I should have been more specific: I didn't mean necessarily start from
> > scratch. As a starting point you could just dup pty.c, rip out the BSD
> > legacy support, and rename the driver/tty device base names.
> > 
> > Whatever that was would behave just like ptm/pts.
> 
> I'm a little fuzzy about this...If I do this, how would userland
> programs create pty master/slave device pairs? Could it work with the
> API of the UNIX 98 style pseudo-tty in 'man 7 pty'? That is:
>
> posix_openpt()
> grantpt()
> unlockpt()
> ptsname()
>
> I see posix_openpt(flags) is essentially equivalent to
> open("/dev/ptmx", flags), so maybe if I made my own driver,
> posix_openpt(flags) would be replaced by open("/dev/my-driver-ptmx",
> flags), and the other function calls could stay the same. Is that
> right?

I was in the middle of dropping in some simple user-space code that
would do the trick when I remembered that what I suggested wouldn't be
that simple because of the devpts filesystem.

Sorry for the false start.

Regards,
Peter Hurley




