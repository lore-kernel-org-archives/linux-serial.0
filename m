Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BD1C43334
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 05:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiFGF6c (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 01:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiFGF6c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 01:58:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A9EFD3
        for <linux-serial@vger.kernel.org>; Mon,  6 Jun 2022 22:58:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nySEK-000077-Ja; Tue, 07 Jun 2022 07:58:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nySEK-006w0z-AQ; Tue, 07 Jun 2022 07:58:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nySEI-00Ehqw-BW; Tue, 07 Jun 2022 07:58:14 +0200
Date:   Tue, 7 Jun 2022 07:58:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] serial: 8250: Store to lsr_save_flags after lsr
 read
Message-ID: <20220607055810.szkjoitpr3vboymr@pengutronix.de>
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
 <20220606131124.53394-2-ilpo.jarvinen@linux.intel.com>
 <fb32bda5-ea44-da8d-493a-a043b8619022@linux.intel.com>
 <CAHp75Ve4t1aF4wDpXPOcOX3MXbn_DaaNWG4S9Ft1jpZ0dGSXzw@mail.gmail.com>
 <97e83f-8011-37fb-d958-2d881fcdbd3@linux.intel.com>
 <CAHp75Vek_O9MJHGXkgJQZT1w-QbdiU0Bpc_PqcA+P6yEBJcEpA@mail.gmail.com>
 <20220606194046.gbt4ghz2yvazsfo4@pengutronix.de>
 <CAHp75VdiJFtLnEJfW6KXwaVFsKWSSTSMgKQLvikSEQj7x3tgLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yoikwpz5xkunc5d2"
Content-Disposition: inline
In-Reply-To: <CAHp75VdiJFtLnEJfW6KXwaVFsKWSSTSMgKQLvikSEQj7x3tgLA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--yoikwpz5xkunc5d2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Mon, Jun 06, 2022 at 10:38:37PM +0200, Andy Shevchenko wrote:
> On Mon, Jun 6, 2022 at 9:40 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Mon, Jun 06, 2022 at 07:01:15PM +0200, Andy Shevchenko wrote:
> > > On Mon, Jun 6, 2022 at 6:54 PM Ilpo J=E4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > On Mon, 6 Jun 2022, Andy Shevchenko wrote:
> > > > > On Mon, Jun 6, 2022 at 3:55 PM Ilpo J=E4rvinen
> > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > ...
> > >
> > > > > But more importantly I do not see the reason for the Acked-by tag=
 when
> > > > > SoB of the same person is present.
> > > >
> > > > I just repeated what Uwe gave me. Maybe he didn't notice he was alr=
eady
> > > > there as SoB.
> > > >
> > > > This situation is anyway a bit more complex than usual. The line I =
took
> > > > was part of Uwe's much larger patch initially (which was fully reve=
rted)
> > > > so his SoB was carried over to preserve the authorship. As I made a
> > > > non-trivial modification to his original patch by removing almost a=
ll of
> > > > it, I added my SoB too. Given this situation, I kind of thought he =
Acked
> > > > (approved) the post-modification version of it.
> > >
> > > I believe you haven't preserved the authorship that way (since From
> > > line is different), but since you have done non-trivial changes and
> > > Uwe is okay with them, the straightforward tag chain would be (with
> > > your authorship implied):
> > > Co-developed-by: Uwe
> > > SoB: Uwe
> > > SoB: yours
> >
> > I don't care much, but IMHO the initial set of tags made sense to me.
>=20
> > It
> > has my S-o-b because the change is (somewhat) taken from me and it has
> > my ack because the modification looked good to me.
>=20
> According to
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#wh=
en-to-use-acked-by-cc-and-co-developed-by
> the SoB already implies that you developed that, but Ack if not. It
> also clarifies Co-developed-by for cases like this.

That's unintuitive (and wrong) in my opinion. For me, Acked-by is a
confirmation of the respective person, that the patch in question is ok.
If I take a hunk of a random reverted patch and add the S-o-b of the big
patch's author, can I really assume the original author "acks" the
result? I would expect that in most cases they don't. (And if they do,
there is no way to record it, because the usual way of adding an Ack is
blocked as there is already a S-o-b?)

*shrug*
Uwe
=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yoikwpz5xkunc5d2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKe6O8ACgkQwfwUeK3K
7AnxLQf9FaWIQXmb5QDARg811+5KuWh8stVYNDDX6DhKBZLPZ5KE3KM7xkNx0tSQ
dE8UcfFfKPkYjqxouy9DlsYB5N1iNk9hMVmhrh4f5Ya6XBQiUWkCvbPTrg+eFX0W
tSpv3IDhEgXIYXd/wBsZKEUvOitb2+ZJJ/U+d6six4hjLfSPuwjX4wzyC4ga7XYu
nTQCJCbpdsYLoXyawEiQmj1m6HI+0/YPydngicadew0KxP3sl2kafqBFwzbu/o6s
u2dHrPyceM5Gr+/98PSO42oMp1OfHBfvesQimBOL8iCi/Nq1xjGJVcW/w1RIyQ0G
Czw6qopsEdVz6smmyKlK73EA3CNXPw==
=xKNt
-----END PGP SIGNATURE-----

--yoikwpz5xkunc5d2--
