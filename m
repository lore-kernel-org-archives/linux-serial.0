Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286A3E317C;
	Thu, 23 Jul 2026 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843751; cv=none; b=fz7+nB7XJRbt9DnASJ8PxQ+dsNDDWbcnS1eGQ7aoTxh2jlGOiik0+NqnsA36hw6MnyYXcPifa6q+RcT72JsgWG5JvJfOEsBgXySI19KzqHHqpeOpdO8vb4XJkd17udktTbMIngTdhd8bo39LfeEZaYPWAavYGBuPK/yl19PTa5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843751; c=relaxed/simple;
	bh=r1APRD0VBjoN1kg0FaiFRiEEobt325NC0jDw7CNdBO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibzRSRCzegZUbxr6UippXKPZpBm3KMdDW/5lehaxIYDt0kkby7OhMaHzxkT5MAS8jSTHZ/HtbduEGf4m2LqMURa8X4NAhq2p2hIpXelMkxi7eD8W9Btm0vXwk2HnU4dmNvAaSWdNPL8swXEv1wby32lUlGJOHE53j9n81pJuusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkHgUgUZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkHgUgUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEA81F00A3A;
	Thu, 23 Jul 2026 21:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784843749;
	bh=3B2ZD5FxBGWaTYiGGIYbnPxJuqngym86jZ3Dp4NBXds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EkHgUgUZBCgfzjt5AT0SDCEqKWcF+hJq5Y9Uai+ZVxosnVzvXHgV9ZBReMl4CUlJn
	 UBOk/nzfAbovL9PuUHdRJeLnymeKyR9u5VxzNdgMDCE/gSDRL5qUX7zrudSQ+yisig
	 aRTQtRqki/WnPOB0SuH4M40ZxzS+f0ukTnEG+wb9f06+k236Gz+439Ki870ttewak4
	 O3v3Et0bvZJzZ2wb2GPpAB6MhTKxo8RC3kntacqeE+iiKjz3JwpA1Iaze7N3EzhFRD
	 9v9YiVY8JYjeZn4YSY5b8P4TMqUpQhxSCR1hnP7VoQII2FMiCJRNRXIEAtllkzzORg
	 HZB/h3vAI0IMQ==
Date: Thu, 23 Jul 2026 22:55:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com, osama.abdelkader@gmail.com,
	andy.shevchenko@gmail.com, jackzxcui1989@163.com, kees@kernel.org,
	sean@mess.org, alan@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, wangfushuai@baidu.com,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH v3] serial: 8250: Clear CON_PRINTBUFFER on port
 re-registration
Message-ID: <120da946-505c-4423-a39a-f64f1532a4a7@sirena.org.uk>
References: <20260522101042.21976-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GCWhvQQX64aySNJt"
Content-Disposition: inline
In-Reply-To: <20260522101042.21976-1-fushuai.wang@linux.dev>
X-Cookie: Do not try this at home.


--GCWhvQQX64aySNJt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 06:10:42PM +0800, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
>=20
> When two PnP devices map to the same physical port, the serial8250 driver
> removes and re-registers the console structure for the same port.
>=20
> During re-registration, the console structure still has CON_PRINTBUFFER s=
et
> from the initial registration, which causes console_init_seq() to set
> console->seq to syslog_seq. This results in re-printing the entire
> system log buffer, which may lead to RCU stall on slow serial consoles.
>=20
> Clear CON_PRINTBUFFER when re-registering a port to prevent duplicate
> log printing.

For the past week or more (I think since it was committed) I have been
seeing boot regressions in -next on a wide range of platforms which
bisect to it.  One sample is the VisionFive2 which gets to userspace but
grinds to a halt:

[   16.954602] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[   16.962739] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[   16.969371] pci 0001:00:00.0: PCI bridge to [bus 01]
[   16.974348] pci_bus 0001:00: resource 4 [mem 0x38000000-0x3fffffff]
[   16.980620] pci_bus 0001:00: resource 5 [mem 0x980000000-0x9bfffffff pre=
f]
[   16.987749] pcieport 0001:00:00.0: PME: Signaling with IRQ 66
/bin/sh: can't access tty; job control turned off

Full log:

   https://lava.sirena.org.uk/scheduler/job/3013935#L604

I'm also seeing this on for example pine64plus.  Some platforms have
some WARN_ON()s from DRM which slowed reporting but those don't seem
related.

bisect log, other platforms look similar and converge on the same commit:

git bisect start
# status: waiting for both good and bad commits
# bad: [9eebf259d5352b87080d67758f483583d9e763d7] Add linux-next specific f=
iles for 20260723
git bisect bad 9eebf259d5352b87080d67758f483583d9e763d7
# status: waiting for good commit(s), bad commit known
# good: [922cc3121ee3e099ec8d36c468f38cd3dff3308a] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect good 922cc3121ee3e099ec8d36c468f38cd3dff3308a
# good: [a442ff27677c2fdc0c046778a6c12b78cc9561ec] Merge branch 'libcrypto-=
next' of https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
git bisect good a442ff27677c2fdc0c046778a6c12b78cc9561ec
# good: [62dd23e06176ab94221cbe269c46483534cf6545] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
git bisect good 62dd23e06176ab94221cbe269c46483534cf6545
# good: [cbbe21042d5ae5b70f7bfd02fa345ccdea53b069] Merge branch 'usb-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git
git bisect good cbbe21042d5ae5b70f7bfd02fa345ccdea53b069
# bad: [ed9b79b61e9248ec87c34c0d2f7f2109e7f3a651] Merge branch 'staging-nex=
t' of https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect bad ed9b79b61e9248ec87c34c0d2f7f2109e7f3a651
# bad: [5e110656994217e9816366ae54b83511b55f4f77] Merge branch 'togreg' of =
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
git bisect bad 5e110656994217e9816366ae54b83511b55f4f77
# bad: [d6082d34d41e4bd21dbe39203e2e050016d092e3] Merge branch 'char-misc-n=
ext' of https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
git bisect bad d6082d34d41e4bd21dbe39203e2e050016d092e3
# good: [6994c8b4ef95114073a51d6143185bca39d6e5d5] drivers/misc/enclosure: =
Replace strcpy() + strcat() with snprintf()
git bisect good 6994c8b4ef95114073a51d6143185bca39d6e5d5
# bad: [6e5bd7cc3a2f304a66d294011647d82074421979] serial: qcom-geni: Add tr=
acepoints for Qualcomm GENI serial driver
git bisect bad 6e5bd7cc3a2f304a66d294011647d82074421979
# bad: [7a68b818d56e5c48b90232d59148ef8e716082ae] serdev: acpi: Free resour=
ce list at appropriate time
git bisect bad 7a68b818d56e5c48b90232d59148ef8e716082ae
# good: [25b51d1fd3268a219e43608b165098fff7cd9dcd] serial: max310x: registe=
r GPIO controller before adding UART ports
git bisect good 25b51d1fd3268a219e43608b165098fff7cd9dcd
# bad: [d338ab1d90603f875c4f7ed223406535378173a5] serial: 8250: Clear CON_P=
RINTBUFFER on port re-registration
git bisect bad d338ab1d90603f875c4f7ed223406535378173a5
# good: [7a52545d37eb805eb1f3c7e03ff336b12c12f5af] tty: tty_jobctrl: use gu=
ard()s in tiocspgrp()
git bisect good 7a52545d37eb805eb1f3c7e03ff336b12c12f5af
# good: [4d105880666ab7f7914a75716d3e95b0d8b879dc] tty: serial: mpc52xx_uar=
t: add bounds check for psc_num array index
git bisect good 4d105880666ab7f7914a75716d3e95b0d8b879dc
# first bad commit: [d338ab1d90603f875c4f7ed223406535378173a5] serial: 8250=
: Clear CON_PRINTBUFFER on port re-registration

--GCWhvQQX64aySNJt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpijd8ACgkQJNaLcl1U
h9DvvAf+K5pA4xEcGGNvGAYIZXr1Hv3h+cnUIOUoV7x4m/luwbf0lB4vvmyRXDiy
O2OwKBszydlh7+2KM0oee73Znqf3BUF2dVwL+NpaU+w0H61jEw+5Ph3uGyW60/Ob
WjKx74QYJj1ZVKx2Q1+m3C5gMEh4K5FrqacpWPc95k6FphKsL0P3FBw05yK6xaAw
1oymAMRIp8Q9JVC6rwnO2yxocfVEzLvhajTAl0A0KuwzMKShove6nF4g5J6HAWLu
WrWsa//zpbEpeSgM1yF207Bf/1gVMHZgZxRoI2y+yf2jbC42z1zN+EXsA6rsJfuG
RLyxs93I9Wbqb8Kel4baC/Z/W2czEg==
=xhBI
-----END PGP SIGNATURE-----

--GCWhvQQX64aySNJt--
