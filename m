Return-Path: <SRS0=mx0D=6J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FE3C55186
	for <linux-serial@archiver.kernel.org>; Sat, 25 Apr 2020 07:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD1920857
	for <linux-serial@archiver.kernel.org>; Sat, 25 Apr 2020 07:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgDYHHR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Apr 2020 03:07:17 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60286 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgDYHHR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Apr 2020 03:07:17 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 61F541C0229; Sat, 25 Apr 2020 09:07:15 +0200 (CEST)
Date:   Sat, 25 Apr 2020 09:07:14 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v6 1/4] lib: new helper kstrtodev_t()
Message-ID: <20200425070714.GA21938@amd>
References: <20200213091600.554-1-uwe@kleine-koenig.org>
 <20200213091600.554-2-uwe@kleine-koenig.org>
 <CAHp75VcStj5sE3f0uK2deOWC=ojfx-z1fbrh6Lu6jAor9F9PgA@mail.gmail.com>
 <20200220074901.ohcrisjgd26555ya@pengutronix.de>
 <CAHp75VcxXWputX1y90t8f-c0a3dw2CHU6=ebQ+o6e8Z1GymiDw@mail.gmail.com>
 <20200220105718.eoevd3kb63zzrotu@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20200220105718.eoevd3kb63zzrotu@pengutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Why simple_strto*() can't be used?
> > >
> > > I didn't really consider it, but looking in more detail I don't like =
it
> > > much. Without having tried it I think simple_strtoull accepts
> > > "1000000000000000000000000000000000000000000" returning some arbitrary
> > > value without an error indication.
> >=20
> > So what? User has a lot of possibilities to shoot into the foot.
> > Since you interpret this as device major:minor, not founding a device
> > will be first level of error, next one when your code will try to do
> > something out of it. It shouldn't be a problem of kstrtox generic
> > helpers.
>=20
> I fail to follow your argument here. In my eyes if the user writes a
> valid major:minor it should work, and if they write an invalid one this
> should result in an error and not a usage of a device that just happens
> to have the major:minor that simple_strtoull happens to return for the
> two components.

Yes please. We don't allow feet shooting where it is easy to prevent,
and that is the case here.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6j4aIACgkQMOfwapXb+vLLpQCeLh/gVFRj+yr45muUNQpcw4Z9
6YcAoIQg2AjbAFlgvSuiqmW5HGqLrwmR
=9/gs
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
