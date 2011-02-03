From: Greg KH <greg@kroah.com>
Subject: Re: [uclinux-dist-devel] [PATCH] serial: bfin_5xx: split uart RX
 lock from uart port lock to avoid deadlock
Date: Thu, 3 Feb 2011 14:05:48 -0800
Message-ID: <20110203220548.GA29114@kroah.com>
References: <1294723003-8496-1-git-send-email-vapier@gentoo.org>
 <AANLkTi=Kp6ix8j5dG6RTySZcScTnRBKsVReTp7v0Y8XP@mail.gmail.com>
 <20110203183242.GA20886@kroah.com>
 <AANLkTi=hXukoc6hd7+0zC-eO36wrheMr_xUCDPQBee4P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:52167 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684Ab1BCWJM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Feb 2011 17:09:12 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=hXukoc6hd7+0zC-eO36wrheMr_xUCDPQBee4P@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Thu, Feb 03, 2011 at 04:56:30PM -0500, Mike Frysinger wrote:
> On Thu, Feb 3, 2011 at 13:32, Greg KH wrote:
> > On Thu, Feb 03, 2011 at 01:29:08AM -0500, Mike Frysinger wrote:
> >> On Tue, Jan 11, 2011 at 00:16, Mike Frysinger wrote:
> >> > From: Sonic Zhang <sonic.zhang@analog.com>
> >> >
> >> > The RX lock is used to protect the RX buffer from concurrent acc=
ess in DMA
> >> > mode between the timer and RX interrupt routines. =A0It is indep=
endent from
> >> > the uart lock which is used to protect the TX buffer. =A0It is p=
ossible for
> >> > a uart TX transfer to be started up from the RX interrupt handle=
r if low
> >> > latency is enabled. =A0So we need to split the locks to avoid de=
adlocking in
> >> > this situation.
> >> >
> >> > In PIO mode, the RX lock is not necessary because the handle_sim=
ple_irq
> >> > and handle_level_irq functions ensure driver interrupt handlers =
are called
> >> > once on one core.
> >> >
> >> > And now that the RX path has its own lock, the TX interrupt has =
nothing to
> >> > do with the RX path, so disabling it at the same time.
> >>
> >> ping ...
> >
> > Is this needed for .38?
>=20
> it fixes a possible deadlock that exists in current .38 rc, but i
> wouldnt call it a "critical" fix as it only affects certain edge
> cases.  so if you want to merge for .38 or .39, either is OK for us i
> think.

I can do it for .38, just wanted to check.

I'll go queue it up now.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
