From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: restart callback not supposed to sleep?
Date: Mon, 20 Aug 2012 11:21:45 +0200
Message-ID: <20120820092145.GM2232@pengutronix.de>
References: <20120820082423.GJ2232@pengutronix.de>
 <20529.64510.403690.325993@ipc1.ka-ro>
 <20120820090546.GR18957@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34482 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab2HTJVt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Aug 2012 05:21:49 -0400
Content-Disposition: inline
In-Reply-To: <20120820090546.GR18957@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Aug 20, 2012 at 10:05:46AM +0100, Russell King - ARM Linux wrot=
e:
> On Mon, Aug 20, 2012 at 10:57:34AM +0200, Lothar Wa=DFmann wrote:
> > Hi,
> >=20
> > Uwe Kleine-K=F6nig writes:
> > > Hello,
> > >=20
> > > while triggering a reboot via sysrq on an ARM machine I saw a "BU=
G:
> > > sleeping function called from invalid context" message (details b=
elow).
> > > The reason is that the sysrq handler is calling the restart hook =
in irq
> > > context. So what should be done about that? The obvious possiblit=
ies
> > > are:
> > >=20
> > >  a) ignore the problem as it won't result in problems (and maybe =
somehow
> > >     silence the warnign); or
> > >  b) make the restart hook atomic; or
> > >  c) assert sysrq not calling the hook in atomic mode
> > >=20
> > > What do you think?
> > >=20
> > This has been discussed earlier (with your participation) with 'a)'
> > being the conclusion.
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December=
/033877.html
>=20
> Except if you look at the backtrace, it seems that it fails to restar=
t.
> There are two attempts there at making it restart so the first could
> not have succeeded.
Just for the log: The restart works ok.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
