From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
Date: Mon, 25 Jan 2016 12:23:47 +0000
Message-ID: <20160125122347.GM6588@sirena.org.uk>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-4-git-send-email-mans@mansr.com>
 <20160124223629.GI6588@sirena.org.uk>
 <yw1xk2myli0u.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e9BJxh3jTFf/APYk"
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <yw1xk2myli0u.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--e9BJxh3jTFf/APYk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 24, 2016 at 10:38:57PM +0000, M=E5ns Rullg=E5rd wrote:
> Mark Brown <broonie@kernel.org> writes:

> > This is patch 3 of a series but I don't have anything else in the
> > series.  What is going on with the rest of the series - what are the
> > dependencies and so on?

> I give up.  Seriously, this is impossible.  If I don't include everybody
> in the slightest way related to any patch in the series, I get
> complaints that patches are missing.  If I do, the lists reject it all
> due to too many recipients.  What the hell am I supposed to do?

You should normally include at least the subsystem maintainers in at
least the cover letter and cover the dependencies there.  Think about
how this is going to work: if you don't give us any information on
what's going on with dependencies then we can't tell how to handle the
patches - do we need to apply them, only review them or what?

--e9BJxh3jTFf/APYk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWphPTAAoJECTWi3JdVIfQvIsH/18K67Vz/iG1dCd7ZJk1hjqq
xKXkc56SvttMqO9uo72pUp+PN6u+mCP11g1FVm85HDe23wmJO8XAwfB8bzkwsDLv
kxGWqrd+PLiiu9CE5YASx1I84mzjimE29A4nR6A0/tIgGa09RKQioXB9eUeen39B
HZIa8IjeK7I7+CZNfWeqiwTQAdeGsfk/dCzSdBit2Yx+6tvHhOItwP+dlgKcIKIH
ongI/E2X15SipfHED7PQ7nEcs2M+sGaVMmLMveKGV3lC2t3ajcqSZIt1vo1MrNvO
TVnil39laB9fKmftvh0AeN1vwsF6ybEPmT14V2kX15rsVNpsumiiBC6cUGU5raw=
=kyi6
-----END PGP SIGNATURE-----

--e9BJxh3jTFf/APYk--
