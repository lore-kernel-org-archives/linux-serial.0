Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B7AC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 24 May 2022 19:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiEXTXf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 May 2022 15:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240862AbiEXTXb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 May 2022 15:23:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFD86AA63
        for <linux-serial@vger.kernel.org>; Tue, 24 May 2022 12:23:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nta7o-0007Fs-Qh; Tue, 24 May 2022 21:23:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nta7h-004KGw-M4; Tue, 24 May 2022 21:23:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nta7f-00BsRk-96; Tue, 24 May 2022 21:23:15 +0200
Date:   Tue, 24 May 2022 21:23:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-imx@nxp.com, linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice
Message-ID: <20220524192315.cs7ry4bops45yyli@pengutronix.de>
References: <20220511093247.91788-1-u.kleine-koenig@pengutronix.de>
 <20220512012910.GB37988@windriver.com>
 <20220512061724.4guiyqa6vcdru4iw@pengutronix.de>
 <20220512154621.GC37988@windriver.com>
 <20220512161316.5pknsjgl6lb75vva@pengutronix.de>
 <4d72e94d-f527-976d-c1b7-2258bf14437@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="km4ria6l6zp3mhod"
Content-Disposition: inline
In-Reply-To: <4d72e94d-f527-976d-c1b7-2258bf14437@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--km4ria6l6zp3mhod
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 24, 2022 at 07:01:18PM +0300, Ilpo J=E4rvinen wrote:
> On Thu, 12 May 2022, Uwe Kleine-K=F6nig wrote:
>=20
> > Hello Paul,
> >=20
> > On Thu, May 12, 2022 at 11:46:21AM -0400, Paul Gortmaker wrote:
> > > [Re: [PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice] On 1=
2/05/2022 (Thu 08:17) Uwe Kleine-K=F6nig wrote:
> > > > On Wed, May 11, 2022 at 09:29:10PM -0400, Paul Gortmaker wrote:
> > > > > [[PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice] On 1=
1/05/2022 (Wed 11:32) Uwe Kleine-K=F6nig wrote:
> > > > >=20
> > > > > > Some Freescale 8250 implementations have the problem that a sin=
gle long
> > > > > > break results in one irq per character frame time. The code in
> > > > > > fsl8250_handle_irq() that is supposed to handle that uses the B=
I bit in
> > > > > > lsr_saved_flags to detect such a situation and then skip the se=
cond
> > > > > > received character. However it also stores other error bits and=
 so after
> > > > > > a single frame error the character received in the next irq han=
dling is
> > > > > > passed to the upper layer with a frame error, too.
> > > > > >=20
> > > > > > To weaken this problem restrict saving LSR to only the BI bit.
> > > > >=20
> > > > > But what is missing is just what "this problem" is - what applica=
tions
> > > > > are broken and how?  What are the symptoms?  This is a 15+ year o=
ld
> > > > > platform and so one has to ask why this is just being seen now.
> > > >=20
> > > > The problem is "However it also stores other error bits and so afte=
r a
> > > > single frame error the character received in the next irq handling =
is
> > > > passed to the upper layer with a frame error, too." which is just t=
he
> > > > sentence before. I hoped this would be understandable :-\
> > >=20
> > > I was trying to get you to describe symptoms at a higher level - as I
> > > said above, at the application level - what were you using that wasn't
> > > working that led you down the path to investigate this?   Transfering
> > > data wasn't reaching the expected max for baud rate, or serial console
> > > was showing lags and dropped characters, or ...?
> >=20
> > The situation where the problem was noticed is: The 8313 is supposed to
> > periodically receive a burst of a small (and fixed) number of
> > characters. In the field it sometimes happend that there was a peak on
> > the data line between two such telegrams which the UART interpreted as a
> > character with a parity error. After that the first character of the
> > next telegram wasn't received in userspace, because the driver claimed
> > it was received with another parity error. So effectively a dropped
> > character.
> >=20
> > > The false positive error bits description is fine, but it isn't
> > > something that a person in the future could read and then say "Oh I'm
> > > having the same problem - I should backport that!"
> > >=20
> > > > > > Note however that the handling is still broken:
> > > > > >=20
> > > > > >  - lsr_saved_flags is updated using orig_lsr which is the LSR c=
ontent
> > > > > >    for the first received char, but there might be more in the =
FIFO, so
> > > > > >    a character is thrown away that is received later and not ne=
cessarily
> > > > > >    the one following the break.
> > > > > >  - The doubled break might be the 2nd and 3rd char in the FIFO,=
 so the
> > > > > >    workaround doesn't catch these, because serial8250_rx_chars(=
) doesn't
> > > > > >    handle the workaround.
> > > > > >  - lsr_saved_flags might have set UART_LSR_BI at the entry of
> > > > > >    fsl8250_handle_irq() which doesn't originate from
> > > > > >    fsl8250_handle_irq()'s "up->lsr_saved_flags |=3D orig_lsr &
> > > > > >    UART_LSR_BI;" but from e.g. from serial8250_tx_empty().
> > > > > >  - For a long or a short break this isn't about two characters,=
 but more
> > > > > >    or only a single one.
> > > > >=20
> > > > > I've long since flushed the context required to parse the above, =
sorry.
> > > > > But the part where it says "is still broken" stands out to me.
> > > >=20
> > > > The current state is (assuming the errata is accurate and I underst=
ood
> > > > it correctly):=20
> > > >  - You get a problem for sure if there is a frame error (because the
> > > >    next good char is thrown away).
> > > >  - You get a problem for sure if there is a parity error (because t=
he
> > > >    next good char is thrown away).
> > > >  - You get a problem for sure if there was an overflow (because the
> > > >    first good char after the overflow is thrown away).
> > > >  - The code is racy for break handling. In some unlikely cases the =
break
> > > >    workaround is applied wrongly.
> > > >=20
> > > > (Where "thrown away" is really: passed to the tty layer with an err=
or
> > > > indication, which depending on tty settings results in dropping the
> > > > character or passing it on to userspace.)
> > > >=20
> > > > My patch only fixes the first three issues. A part of the reason fo=
r the
> > > > uncomplete fix is that I don't have a platform that requires the wo=
rkaround.
> > > > (I thought I had, but it doesn't show the described behaviour and
> > > > instead behaves nicely, i.e. one irq per break and no stray bits are
> > > > set.)
> > >=20
> > > I was hoping that with the full description of the issue from 12+ yea=
rs
> > > ago that you'd be able to reproduce it on your platform with the WAR =
disabled.
> > > I take it that you tried and SysRQ still worked fine?
> >=20
> > I think I did. I have to plan a bit of continous time to reverify.
> >=20
> > > I also found a copy of an earlier proposed fix from 2010 on patchwork=
s:
> > > http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20100301212324=
=2EGA1738@windriver.com/
> > >=20
> > > Maybe there are some additional details in there of interest?
> > >=20
> > > I wonder if some other intervening change in that wide time span happ=
ens
> > > to mask the issue?  Who knows.  I'm not sure if you are that interest=
ed;
> > > enough to go try an old kernel to find out...
> > >=20
> > > > That the patch I did is correct is quite obvious for me. Currently =
the
> > > > fsl8250_handle_irq() function sets the bits BI, OE, FE and PE in
> > >=20
> > > If I recall correctly, it just clears BI - are you sure it sets bits?
> >=20
> > Not explicitly, but it does
> >=20
> > 	orig_lsr =3D up->port.serial_in(&up->port, UART_LSR);
> > 	...
> > 	up->lsr_saved_flags =3D orig_lsr;
> >=20
> > So whatever error bit is read on function entry is reused for the first
> > char in the next irq run.
>=20
> Yes, it is clearly leaking extra flags (if those are set) both in the cas=
e=20
> of break workaround and without it.
>=20
> > > > lsr_saved_flags, but only evaluates BI for the workaround. The comm=
it
> > > > that introduced that only talks about BI, the mentioned erratum also
> > > > only mentions BI.
> > > >=20
> > > > I can try to make the commit log more convincing. Or if the ability=
 to
> > > > test this code on an affected platform is declared a requirement, I=
 will
> > >=20
> > > I'm not in any position to declare any requirements - just that when =
you
> > > are bit-bashing to work around some "black box" silicon errata, any
> > > changes might impact whether the WAR is still working or not.
>=20
> C code is not "some black box". On the next irq, only BI in=20
> lsr_saved_flags is looked at by the driver, that can be seen from the C=
=20
> code, no need to look at the errata.
>=20
> And then the C code also tells on the next next irq, the other bits (if=
=20
> any were set) are taken into use for a real character, which is=20
> undesirable (=3D BUG!).
>=20
> > > Your change alters lsr_saved_flags for *every* event, even when no br=
eaks
> > > or workarounds have been in play.  I'm not sure what that might trigg=
er.
>=20
> Indeed, fixing a bug alters behavior such that the bug no longer occurs :=
-).
>=20
> Or are you saying that leaking old FE, PE and OE into the next char=20
> using lsr_saved_flags when no break nor workaround isn't in the play
> is an event that should _not_ be altered???
>=20
> If no extra flags are set, the proposed change is no-op.
>=20
> Maybe Uwe's fix could be scoped down to clear only FE, PE and OE if one=
=20
> really wants to make a minimal fix? That would leave (mainly) DR out of i=
t=20
> which could impact the behavior a little (the difference seems a bit=20
> theoretic to me but it is there)?

Is this an Ack for my patch?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--km4ria6l6zp3mhod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKNMKAACgkQwfwUeK3K
7AnC9wf/cduC3f/k4iHSoJ60WzxzzFCj57+Odv0DJaQ3SynBKm0NiYuuREzV4V9K
hRQi5XNOw3N6yl0DujS9fTeRUlIU/aOxRqczJJIn+VN8P1fIZC37bzJkvr20A2i4
wi5kXyhVw4N5WX0vrG6wERatlcSpEG1jiQ7SmT7a9gEqFD7IbegQn9jkYbI5AIww
eNonhEU8Lx8VE34R9+yiwlkmSfwrWdDHfNIdfvJEBw78PezjaSa84fiPD9w/CZZ7
sxcowbZ2pHmpGugPrh0wUwsQ1qCFwOgtnhL8+XpXbtL2SYnOLRwo3bvA73KRHW62
DQtXzml6YDg0Ge39bJ5atcKfjWyElQ==
=fNdr
-----END PGP SIGNATURE-----

--km4ria6l6zp3mhod--
