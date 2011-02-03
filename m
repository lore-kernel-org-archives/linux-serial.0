From: Greg KH <greg@kroah.com>
Subject: Re: [uclinux-dist-devel] [PATCH] serial: bfin_5xx: split uart RX
 lock from uart port lock to avoid deadlock
Date: Thu, 3 Feb 2011 10:32:42 -0800
Message-ID: <20110203183242.GA20886@kroah.com>
References: <1294723003-8496-1-git-send-email-vapier@gentoo.org>
 <AANLkTi=Kp6ix8j5dG6RTySZcScTnRBKsVReTp7v0Y8XP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:53285 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932312Ab1BCScp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Feb 2011 13:32:45 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=Kp6ix8j5dG6RTySZcScTnRBKsVReTp7v0Y8XP@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, uclinux-dist-devel@blackfin.uclinux.org

On Thu, Feb 03, 2011 at 01:29:08AM -0500, Mike Frysinger wrote:
> On Tue, Jan 11, 2011 at 00:16, Mike Frysinger wrote:
> > From: Sonic Zhang <sonic.zhang@analog.com>
> >
> > The RX lock is used to protect the RX buffer from concurrent access=
 in DMA
> > mode between the timer and RX interrupt routines. =A0It is independ=
ent from
> > the uart lock which is used to protect the TX buffer. =A0It is poss=
ible for
> > a uart TX transfer to be started up from the RX interrupt handler i=
f low
> > latency is enabled. =A0So we need to split the locks to avoid deadl=
ocking in
> > this situation.
> >
> > In PIO mode, the RX lock is not necessary because the handle_simple=
_irq
> > and handle_level_irq functions ensure driver interrupt handlers are=
 called
> > once on one core.
> >
> > And now that the RX path has its own lock, the TX interrupt has not=
hing to
> > do with the RX path, so disabling it at the same time.
>=20
> ping ...

Is this needed for .38?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
