Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58992C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 12 May 2022 16:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344868AbiELQNh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 May 2022 12:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiELQNg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 May 2022 12:13:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6C7644DD
        for <linux-serial@vger.kernel.org>; Thu, 12 May 2022 09:13:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1npBRS-0001Py-3k; Thu, 12 May 2022 18:13:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1npBRN-001ur6-2h; Thu, 12 May 2022 18:13:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1npBRK-009HMw-Ub; Thu, 12 May 2022 18:13:22 +0200
Date:   Thu, 12 May 2022 18:13:16 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-imx@nxp.com, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice
Message-ID: <20220512161316.5pknsjgl6lb75vva@pengutronix.de>
References: <20220511093247.91788-1-u.kleine-koenig@pengutronix.de>
 <20220512012910.GB37988@windriver.com>
 <20220512061724.4guiyqa6vcdru4iw@pengutronix.de>
 <20220512154621.GC37988@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lhk22cjenmk5dlwn"
Content-Disposition: inline
In-Reply-To: <20220512154621.GC37988@windriver.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--lhk22cjenmk5dlwn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Paul,

On Thu, May 12, 2022 at 11:46:21AM -0400, Paul Gortmaker wrote:
> [Re: [PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice] On 12/05=
/2022 (Thu 08:17) Uwe Kleine-K=F6nig wrote:
> > On Wed, May 11, 2022 at 09:29:10PM -0400, Paul Gortmaker wrote:
> > > [[PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice] On 11/05=
/2022 (Wed 11:32) Uwe Kleine-K=F6nig wrote:
> > >=20
> > > > Some Freescale 8250 implementations have the problem that a single =
long
> > > > break results in one irq per character frame time. The code in
> > > > fsl8250_handle_irq() that is supposed to handle that uses the BI bi=
t in
> > > > lsr_saved_flags to detect such a situation and then skip the second
> > > > received character. However it also stores other error bits and so =
after
> > > > a single frame error the character received in the next irq handlin=
g is
> > > > passed to the upper layer with a frame error, too.
> > > >=20
> > > > To weaken this problem restrict saving LSR to only the BI bit.
> > >=20
> > > But what is missing is just what "this problem" is - what applications
> > > are broken and how?  What are the symptoms?  This is a 15+ year old
> > > platform and so one has to ask why this is just being seen now.
> >=20
> > The problem is "However it also stores other error bits and so after a
> > single frame error the character received in the next irq handling is
> > passed to the upper layer with a frame error, too." which is just the
> > sentence before. I hoped this would be understandable :-\
>=20
> I was trying to get you to describe symptoms at a higher level - as I
> said above, at the application level - what were you using that wasn't
> working that led you down the path to investigate this?   Transfering
> data wasn't reaching the expected max for baud rate, or serial console
> was showing lags and dropped characters, or ...?

The situation where the problem was noticed is: The 8313 is supposed to
periodically receive a burst of a small (and fixed) number of
characters. In the field it sometimes happend that there was a peak on
the data line between two such telegrams which the UART interpreted as a
character with a parity error. After that the first character of the
next telegram wasn't received in userspace, because the driver claimed
it was received with another parity error. So effectively a dropped
character.

> The false positive error bits description is fine, but it isn't
> something that a person in the future could read and then say "Oh I'm
> having the same problem - I should backport that!"
>=20
> > > > Note however that the handling is still broken:
> > > >=20
> > > >  - lsr_saved_flags is updated using orig_lsr which is the LSR conte=
nt
> > > >    for the first received char, but there might be more in the FIFO=
, so
> > > >    a character is thrown away that is received later and not necess=
arily
> > > >    the one following the break.
> > > >  - The doubled break might be the 2nd and 3rd char in the FIFO, so =
the
> > > >    workaround doesn't catch these, because serial8250_rx_chars() do=
esn't
> > > >    handle the workaround.
> > > >  - lsr_saved_flags might have set UART_LSR_BI at the entry of
> > > >    fsl8250_handle_irq() which doesn't originate from
> > > >    fsl8250_handle_irq()'s "up->lsr_saved_flags |=3D orig_lsr &
> > > >    UART_LSR_BI;" but from e.g. from serial8250_tx_empty().
> > > >  - For a long or a short break this isn't about two characters, but=
 more
> > > >    or only a single one.
> > >=20
> > > I've long since flushed the context required to parse the above, sorr=
y.
> > > But the part where it says "is still broken" stands out to me.
> >=20
> > The current state is (assuming the errata is accurate and I understood
> > it correctly):=20
> >  - You get a problem for sure if there is a frame error (because the
> >    next good char is thrown away).
> >  - You get a problem for sure if there is a parity error (because the
> >    next good char is thrown away).
> >  - You get a problem for sure if there was an overflow (because the
> >    first good char after the overflow is thrown away).
> >  - The code is racy for break handling. In some unlikely cases the break
> >    workaround is applied wrongly.
> >=20
> > (Where "thrown away" is really: passed to the tty layer with an error
> > indication, which depending on tty settings results in dropping the
> > character or passing it on to userspace.)
> >=20
> > My patch only fixes the first three issues. A part of the reason for the
> > uncomplete fix is that I don't have a platform that requires the workar=
ound.
> > (I thought I had, but it doesn't show the described behaviour and
> > instead behaves nicely, i.e. one irq per break and no stray bits are
> > set.)
>=20
> I was hoping that with the full description of the issue from 12+ years
> ago that you'd be able to reproduce it on your platform with the WAR disa=
bled.
> I take it that you tried and SysRQ still worked fine?

I think I did. I have to plan a bit of continous time to reverify.

> I also found a copy of an earlier proposed fix from 2010 on patchworks:
> http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20100301212324.GA1=
738@windriver.com/
>=20
> Maybe there are some additional details in there of interest?
>=20
> I wonder if some other intervening change in that wide time span happens
> to mask the issue?  Who knows.  I'm not sure if you are that interested;
> enough to go try an old kernel to find out...
>=20
> > That the patch I did is correct is quite obvious for me. Currently the
> > fsl8250_handle_irq() function sets the bits BI, OE, FE and PE in
>=20
> If I recall correctly, it just clears BI - are you sure it sets bits?

Not explicitly, but it does

	orig_lsr =3D up->port.serial_in(&up->port, UART_LSR);
	...
	up->lsr_saved_flags =3D orig_lsr;

So whatever error bit is read on function entry is reused for the first
char in the next irq run.

> > lsr_saved_flags, but only evaluates BI for the workaround. The commit
> > that introduced that only talks about BI, the mentioned erratum also
> > only mentions BI.
> >=20
> > I can try to make the commit log more convincing. Or if the ability to
> > test this code on an affected platform is declared a requirement, I will
>=20
> I'm not in any position to declare any requirements - just that when you
> are bit-bashing to work around some "black box" silicon errata, any
> changes might impact whether the WAR is still working or not.
>=20
> Your change alters lsr_saved_flags for *every* event, even when no breaks
> or workarounds have been in play.  I'm not sure what that might trigger.
>=20
> > drop the topic, just stop using fsl8250_handle_irq() without feeling sa=
d.
>=20
> That might be the best option in the end but I did notice something else
> you might want to consider.  I believe the fsl8250_handle_irq() was just
> a copy of the generic serial8250_handle_irq() as it was in 2011, with
> the single block of code inserted for the WAR:
>=20
> +       /* This is the WAR; if last event was BRK, then read and return */
> +       if (unlikely(up->lsr_saved_flags & UART_LSR_BI)) {
> +               up->lsr_saved_flags &=3D ~UART_LSR_BI;
> +               port->serial_in(port, UART_RX);
> +               spin_unlock_irqrestore(&up->port.lock, flags);
> +               return 1;
> +       }
>=20
> Of course as we all know - when you copy something, you risk being left
> behind when the original gets updated.  I just took a look at today's
> generic 8250 one -- "git blame drivers/tty/serial/8250/8250_port.c" and
> there are changes that probably have left fsl8250_handle_irq() being
> left behind.  A bit more detective work would be required to see
> changes prior to the refactoring in the 2015 commit of b6830f6df891.
>=20
> It probably would be worthwhile to return fsl8250_handle_irq() to be the
> "equivalent" of serial8250_handle_irq() + WAR as it was originally.  It
> would be hard to argue against mainlining such changes - they are table
> stakes.  And who knows, with a bit of luck it might solve your issue too?
>=20

Yeah, I already looked into these and part of my plan to fix the
workaround was to bring fsl8250_handle_irq() on par with the generic irq
handler routine. Effectively there isn't missing much.

> Of couse that is more effort than to just stop using the workaround, so I
> wouldn't blame you at all if you decided to go that route.

Will discuss that with my customer how much effort to put into this.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lhk22cjenmk5dlwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ9MhkACgkQwfwUeK3K
7Anv+wf+NCuGIAOfPewUUXQMVNIFIwEh+hmI0rIHJySFsYQL+XupH2+rSZGhfoxg
9heCqLrvIDvxiTeZGdi4YCfSkXRAKsp7r+6TCOtZEG/K5jrHiENkHgMtFD7CrIRy
rx748Q+QjWBpIDszbGcFIeTXmB3jgbaAjbnxzn9eMXTDvLKHhUMLiBixXw8nfRn2
VL0daCgvITtEqVqdacsRTaEd8sfNgTwx8AL/1MB2hiIr4bnhil8BUJfBfY6QWLJW
f4TTBDX6l9m4QF1y6vkDybSWi1QctRHLONF7hPlXIQ7q+xCKbghoooZEWWnJeTyg
fFOxIJ+25awf5NwEmcHpCBKwcy122Q==
=D/U5
-----END PGP SIGNATURE-----

--lhk22cjenmk5dlwn--
