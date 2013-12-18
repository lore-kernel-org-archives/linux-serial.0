From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] tty: xuartps: Fix build when SYSRQ is disabled
Date: Wed, 18 Dec 2013 00:02:09 +0000
Message-ID: <20131218000209.GA28455@sirena.org.uk>
References: <1387322858-5111-1-git-send-email-broonie@kernel.org>
 <20131217234744.GB21329@kroah.com>
 <3cc3bceb-93a4-4053-bbde-0aa3c2eebe1c@VA3EHSMHS043.ehs.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJKqlw44nclc26Ih"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:48381 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab3LRACO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Dec 2013 19:02:14 -0500
Content-Disposition: inline
In-Reply-To: <3cc3bceb-93a4-4053-bbde-0aa3c2eebe1c@VA3EHSMHS043.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linaro-kernel@lists.linaro.org


--IJKqlw44nclc26Ih
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 03:53:14PM -0800, S=F6ren Brinkmann wrote:
> On Tue, Dec 17, 2013 at 03:47:44PM -0800, Greg Kroah-Hartman wrote:
> > On Tue, Dec 17, 2013 at 11:27:38PM +0000, Mark Brown wrote:

> > > The sysrq field in struct uart_port is only defined when
> > > SERIAL_CORE_CONSOLE or SUPPORT_SYSRQ are selected but the driver uses
> > > the field unconditionally, causing build failures if they aren't (as
> > > happens when doing an arm64 allmodconfig).  Make the usage conditional
> > > as well.

> > Is this a 3.13-final fix, or can it wait for 3.14?

> I sent out pretty much the same fix a week ago:
> https://lkml.org/lkml/2013/12/2/694

> It seems to fix a broken build for certain configurations. Hence, I'd
> say it's a fix for 3.13.

Yeah, it's a definite build fail with an obvious fix.  You do have to go
looking for the issue and there's a simple workaround so it's not super
critical but it's definitely -final material until very late in the
cycle.

--IJKqlw44nclc26Ih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsOX+AAoJELSic+t+oim9z4kQAITl6cxHTp0ooVX3+eFhidLA
ZaR2WRRdGfo/rjgSl4gtJCSUbIPa6U9dRO08yOKlIq6lVxSpDZR0bqFzTymBm5tG
TBSTBQzm280lfyUVcllMKj1aR5HiTZ2+jkjH1WMyDIwXSLUwsA5Sx+IMYoFAaeTQ
Xnmalm6G2sllC0HJTBIth/jiK99xAamYCsAhe04uHjo3/jbpiwRAHROTD72Yzaxk
MG7+fR4zOfmO5yO+cUJTTzgu3RBiNoZtKu8UaRQm9e0A3ANlIFjBJ/Dro9uFvgT8
WZ9v/amkZD9AngZIxBJ5J0Vh9PyPCQUkgy1shGV6xvswplnD5PxUjkCO3OSYTzPu
7iHfwlaqBRwFhcgmrLugiFotPxkHgzKY/HLc0u3AmJJ/FlH8tuj7PDx5K7yCqb3L
3M0JaFBiD2xMMXdc3b2cwgualp5j67CJRECwEcVTF/c5KWPjUT0Xc19xrgmBKiSb
uPFWle2slCscmYMtAC8AS5b3//b16ZOD8Z3OweqY3f5MyUcVZwn5CIuqfluXHKKy
j1LPmXOrj4MZlW2j684swTZAgmeGSS7jQIwL0XCLXIKIuH4i4S4orijhAD+JQgBz
xd1jfCMxu6su6T1DXA5nFfCo8pTj79uDQcQZNjKEflBJ78KWe/Zui5sWUhuJvgFO
WOaUcjNYm0+eHJoCR0LQ
=nW/K
-----END PGP SIGNATURE-----

--IJKqlw44nclc26Ih--
