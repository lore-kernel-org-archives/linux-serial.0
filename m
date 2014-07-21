From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] exynos: serial clear and set big endian fix
Date: Mon, 21 Jul 2014 17:10:29 +0100
Message-ID: <20140721161029.GC17528@sirena.org.uk>
References: <1405957832-6444-1-git-send-email-broonie@kernel.org>
 <5011135.PCJ33lEv6t@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q4O3w8UJ36hkf4ip"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48060 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932550AbaGUQKn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Jul 2014 12:10:43 -0400
Content-Disposition: inline
In-Reply-To: <5011135.PCJ33lEv6t@wuerfel>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Victor Kamensky <victor.kamensky@linaro.org>


--q4O3w8UJ36hkf4ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2014 at 06:01:51PM +0200, Arnd Bergmann wrote:

> The correct way to do it is to use the readl()/writel() functions, or
> readl_relaxed()/writel_relaxed() in case of drivers that don't need
> to synchronize with DMA transfers.

And don't need to build on minority platforms like x86 either!

> I think what you want is something like

> static inline void __hw_set_bit(int nr, unsigned long __iomem *addr)
> {
>        addr += BIT_WORD(nr);
>        writel_relaxed(readl_relaxed(addr) | BIT_MASK(nr), addr);
> }

> which is also endian-safe.

Indeed, good point.

--q4O3w8UJ36hkf4ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzTtxAAoJELSic+t+oim9YuQP/0KRr01vrd7KSt/wFVehsWh1
/7jy9sw6FwUQpXP2FefXnhO3gnss97Pg2Hs9bm5/ZxRiF8iaWtqTJROKL2yt9hq4
jnXyMGf58DL62/ti6Zv3dWe68EvePUYyADvp/C6EOcS/siDUURoQOhek5pmnKJ0S
F+9DV2/9capAl6rOVHEPdmzcDh8VTBBvM5+10u5MixIQ5bnYNlAycNIMiU9pbpon
WocziKtKB2xMKIsuZelRK1m/Q9n/AR7R1rgYnPBzKrPKWwuyhmfqylmWo4LxOX+P
6pE5YMqQUnpyqyJA5AZHt1JWEf0Qi+Ulz9lg8LoBz1/C5lVUneqrCAZfYC4ZTM3W
lZe/35nGXZxdZrvPSPwwsIuQ7PdLRpdby5EzsbOS3yl2ePjJl8UG7yJqMF8V7UIN
0osV9Ovjjt5DjmnuaG59NG1aAxic9m6OF8AJqlVzH+iogf/72QIIg9f5ooJ0wfAO
SS6aEsfVDEPyWhclRj/kQ5KU5jY9QF16wPPg6EanHDG6XurqRaMCoPHO6zqLfUse
n8r+7ohBHFc232Sth1CmdTpDe4XnjmIS5M3mGYHNeVGZVGSBO2AZfVRICYjO7YVd
6ImJnzkF5F9OVaJ9g3fvVvBXbap4bVlkEddqjQAweXgxV5Pz/q3uoT5qreh0x+Vn
kug5UcE8EZ8W+8zMNx5Y
=OpD8
-----END PGP SIGNATURE-----

--q4O3w8UJ36hkf4ip--
