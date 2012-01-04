From: Keith Packard <keithp@keithp.com>
Subject: Re: USB disconnect -> kernel panic
Date: Wed, 04 Jan 2012 09:26:24 -0800
Message-ID: <864nwbmla7.fsf@sumi.keithp.com>
References: <87mxahk3d1.fsf@gag.com> <20120102182255.GC8562@xanatos> <20120103235847.GF21311@kroah.com> <201201041001.57080.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from home.keithp.com ([63.227.221.253]:45338 "EHLO keithp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756435Ab2ADR0d (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jan 2012 12:26:33 -0500
In-Reply-To: <201201041001.57080.oneukum@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>, Greg KH <greg@kroah.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Oliver Neukum <oliver@neukum.name>, Bdale Garbee <bdale@gag.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Jan 2012 10:01:57 +0100, Oliver Neukum <oneukum@suse.de> wrote:

> Do you have a pointer? I assumed this to be this issue:
> http://www.spinics.net/lists/linux-usb/msg55779.html
> And I am waiting for the announced patch.

The patch was posted to the list about half an hour after the Thilo's
first message:

From:	Thilo-Alexander Ginkel <thilo@ginkel.com>
Subject: [PATCH 1/1] usb: cdc-acm: Fix acm_tty_hangup() vs. acm_tty_close()=
 race
Date:	Sat, 17 Dec 2011 10:55:10 +0100
Message-Id: <1324115710-14756-1-git-send-email-thilo@ginkel.com>

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTwSLwDYtFsjWk68qAQh1Cw/+KYLQn/ZHA8MLeHS8pHEXjBZWpMpNFlkH
NpBxtFS+8HwOTjkhm7i6u2Vag0d9TXLOU6xTX03uMRNjp72Q7yHyQazWLKt48Osy
SANhpSGUY0HZk7lWy+iCIhauo6j0R3HGHMXpdF4KzKqs2IwvQAw7TIDU2QTGtPoe
ws0AR5bEaJgMXGTKzTfsh8ndCgibEt5WAB09thH+RuwTj7MDhuFOV7nwV3k4TE82
qq0YLhj7HhKMetuOJl7uXB+PUlukxYr3ES1HBj8ld8hDOG3bDRRtLFNnv/Lc+vei
MXFJwVyvFHpit5laDrIUIQuGn8st2ZeaLqhEFXsZQY63sdfrYRsb6cK3ncHp0o1n
QutB6pGDqMS4bIlO+958uyaih/D4DzgCaEv8jROKriHTKAQKhAkOojqc+QvAeVKR
eZcaX/fhhY93HJNphkH4QGgnKLgLj8Jh2p9F8eDWb+GbZhIoARjaZ7yyDK+EgQTO
uJHgoapuGVxXKgpBUPIuwd835nEaJ5RBfxqwZTGHsAoeB+mmnhvPC1BZk7G/u8Ph
kwRU+fOGUzsm/1q8JlZ1trOH3rVI00qSWAdbT+17bvslIjcgZMalOR9iwNVVkswq
M0o0B0GlRkh+BlaWjLabp3YFjTBFkOO24wKsNfPkpePh+PsYWGzEFL3PupMbmpda
XuU10I3h3ys=
=MRTV
-----END PGP SIGNATURE-----
--=-=-=--
