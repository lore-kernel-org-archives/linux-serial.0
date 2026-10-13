Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E833D5657;
	Tue, 13 Oct 2026 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888729; cv=none; b=HxWZXdYweGCjoMrL9IfbZflJwbU3qouT+19ff3lYqrQgEWwL58siOjab5555tKj2r9r0BDKTYCJrwdY/h2mtAfLvGnjJF55ijkeoSkE9Ws5fCaZmZKBFWBt+tGQSuY6/EjIcrlEeTGXzRJ3HaQVBCuEFnSIXZbTSEeGfvAC9sa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888729; c=relaxed/simple;
	bh=dj1+LJ3thWtN/nue2VmcT3gfEYusoFmc6/vBbAf9a1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdSwS88GQskUh9DUsduCg3En/g0zVgVh3erY860pLhoLsEY4RtsDwNUuoEpUnXdtiJjo+418mWPAsxYQtlg1g0YAcNSuIg/15NUnCPWO03UsnYVFTf6PVH+4JXDFI10MFt8rX/K2bSZSnx8JeNoSiFG1N6pEHH//VeVa7EfTrag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlgl82H/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlgl82H/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D251F000FF;
	Tue, 13 Oct 2026 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791888725;
	bh=NmoaT3+F+QCTM5d3Nx2zwWv/bCDXlxs9igceUs3R3l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mlgl82H/76jyp3QVFGTfmvDhqe4IEDwaDJUnrcU/u/3wDDV81a1YHtW7dL19WqH0B
	 Cc2qSvqyo0IQ8CFsdNqgnz6PQ0tw0RnNGTtY79A/PmFoK2G4XKqJ7IMtg4LIJN5POb
	 WmEuYc/AINieJMo1EB0Hz/llOApLXqZCcr27FrQVTRKbT7vFl4yoZgxH70W8jUYA11
	 TRdiN+re3Zt25rttpmGe7sAtV6CxYo9f58MZ3pLh2olty4oSH0LIySjF9Stgmqnbwm
	 2k0qH4ecd9irYArmfv9uy/C3KtDCsdBMT/NVV+91yfGbN/oxp0ZOPswZZUzTHS0A//
	 mbeeCV09WzG5g==
Date: Tue, 13 Oct 2026 12:51:48 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
	Paul Cercueil <paul@crapouillou.net>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-parisc@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on struct
 uart_8250_port
Message-ID: <as4JDXOIGvCbAnE_@debian>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
 <as3etnbZatn4sbfx@ashevche-desk.local>
 <c6b08f53-b5ee-44c8-93d1-54fdf5994ed2@kernel.org>
 <as31PsESOgLUhMB6@ashevche-desk.local>
 <b404f3d7-1b2d-418a-8634-72c61ce33f8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s7yswkjhiyfpvc3p"
Content-Disposition: inline
In-Reply-To: <b404f3d7-1b2d-418a-8634-72c61ce33f8b@kernel.org>


--s7yswkjhiyfpvc3p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
	Paul Cercueil <paul@crapouillou.net>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-parisc@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on struct
 uart_8250_port
Message-ID: <as4JDXOIGvCbAnE_@debian>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
 <as3etnbZatn4sbfx@ashevche-desk.local>
 <c6b08f53-b5ee-44c8-93d1-54fdf5994ed2@kernel.org>
 <as31PsESOgLUhMB6@ashevche-desk.local>
 <b404f3d7-1b2d-418a-8634-72c61ce33f8b@kernel.org>
MIME-Version: 1.0
In-Reply-To: <b404f3d7-1b2d-418a-8634-72c61ce33f8b@kernel.org>

Hi Jiri,

> Date: 2026-10-13 11:39:00+0200
> From: Jiri Slaby <jirislaby@kernel.org>
>
> On 13. 10. 26, 11:09, Andy Shevchenko wrote:
> > On Tue, Oct 13, 2026 at 09:53:26AM +0200, Jiri Slaby wrote:
> > > On 13. 10. 26, 9:33, Andy Shevchenko wrote:
> > > > On Tue, Oct 13, 2026 at 08:48:51AM +0200, Jiri Slaby (SUSE) wrote:
> >=20
> > ...
> >=20
> > > > > -	rc =3D serial8250_register_8250_port(&port);
> > > > > -	if (rc < 0)
> > > > > +	struct uart_8250_port *uport =3D serial8250_register_8250_port(=
&port);
> > > > > +	if (IS_ERR(uport)) {
> > > > > +		rc =3D PTR_ERR(uport);
> > > > >    		goto err_sysfs_remove;
> > > > > +	}
> > >=20
> > > > Also do not define
> > > > variables in the middle of the code (it's only allowed for auto cle=
anup
> > > > variables and for-loop iterators).
> > >=20
> > > Why, actually?
> >=20
> > Because it's the style.
>=20
> There is no hard style though. It varies across subsystems.
>=20
> > Linus also told it many times
>=20
> Which is neither an argument. Linus is wrong at times ("Link:" use as an
> example).
>=20
> All in all, I do not insist on this at all. It's easier to read and follow
> the code for me. Not necessarily the case for others...
>=20
> > > First, it is used in the kernel quite a few times already
> > > [1]. Second, while it is sort of c++ism (and I like to use modern c++=
), it
> > > makes the life of the variable a lot more obvious.
> > >=20
> > > [1] eg. see output of: rg -U -C 5 '}\n+\s+struct .*\*.*=3D' drivers/
> >=20
> > (you made me to install something I haven't heard about, it's better to=
 use
> >   `git grep` though)
>=20
> rg is order of magnitude faster (searches in parallel). More importantly =
in
> this case, supports multiline matches. (And respects .git ignores.)

Is that really true?

	alx@debian:~/src/linux/linux/master$ time \
			find * -type f \
			| grep '\.[ch]' \
			| sort \
			| xargs grep -n ARRAY_SIZE /dev/null \
			| wc -l;
	58852

	real	0m1.022s
	user	0m0.726s
	sys	0m0.358s
	alx@debian:~/src/linux/linux/master$ time \
			git ls-files \
			| grep '\.[ch]' \
			| xargs grep -n ARRAY_SIZE /dev/null \
			| wc -l;
	58854

	real	0m0.923s
	user	0m0.650s
	sys	0m0.333s

There seems to be a difference of two occurences, which is due to
symlinks:

	alx@debian:~/src/linux/linux/master$ diff -u \
			<(find * -type f \
				| grep '\.[ch]' \
				| sort \
				| xargs grep -n ARRAY_SIZE /dev/null) \
			<(git ls-files \
				| grep '\.[ch]' \
				| xargs grep -n ARRAY_SIZE /dev/null);
	--- /dev/fd/63	2026-10-13 12:40:11.675302047 +0200
	+++ /dev/fd/62	2026-10-13 12:40:11.675302047 +0200
	@@ -57769,6 +57769,7 @@
	 tools/testing/selftests/bpf/benchs/bench_sockmap.c:128:	for (i =3D 0; i <=
 ARRAY_SIZE(ctx.fds); i++) {
	 tools/testing/selftests/bpf/bpf_util.h:69:#ifndef ARRAY_SIZE
	 tools/testing/selftests/bpf/bpf_util.h:70:# define ARRAY_SIZE(x) (sizeof(=
x) / sizeof((x)[0]))
	+tools/testing/selftests/bpf/disasm.c:23:	BUILD_BUG_ON(ARRAY_SIZE(func_id_=
str) !=3D __BPF_FUNC_MAX_ID);
	 tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c:1006:	cons=
t char *sorted_keys[ARRAY_SIZE(keys)];
	 tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c:1012:	fd =
=3D lpm_trie_create(sizeof(key), sizeof(value), ARRAY_SIZE(keys));
	 tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c:1014:	for =
(i =3D 0; i < ARRAY_SIZE(keys); i++) {
	@@ -58786,6 +58787,7 @@
	 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c:215:	dsa->max_copies_p=
er_batch =3D min(dsa->max_copies_per_batch, ARRAY_SIZE(dsa->copy));
	 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c:340:	for (i =3D 0; i <=
 ARRAY_SIZE(dsa->copy); i++) {
	 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c:349:	for (i =3D 0; i <=
 ARRAY_SIZE(dsa->batch) && count; i++) {
	+tools/testing/selftests/vfio/lib/drivers/igb/e1000_82575.h:240:#define E1=
000_VLVF_ARRAY_SIZE     32
	 tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h:249:#define VERIF=
IED_GPU_MAP_SIZE ARRAY_SIZE(verified_gpu_map)
	 tools/testing/selftests/vfio/lib/iommu.c:59:	for (i =3D 0; i < ARRAY_SIZE=
(iommu_modes); i++) {
	 tools/testing/selftests/vfio/lib/sysfs.c:48:	VFIO_ASSERT_GT(read(fd, buf,=
 ARRAY_SIZE(buf)), 0);

And here goes rg(1):

	alx@debian:~/src/linux/linux/master$ time rg -n ARRAY_SIZE | wc -l
	58957

	real	0m0.512s
	user	0m0.490s
	sys	0m0.974s

It's around 50% faster, which I wouldn't call orders of magnitude.
rg(1) inherits the bogus design of find(1) in trying to filter the file
names with multiple subtly different options.  grep(1) can do that much
better, and by using a pipe, you have a dedicated process (often in a
dedicated CPU) for that task, which is likely more efficient.

And here's plain grep(1):

	alx@debian:~/src/linux/linux/master$ time grep -r -n ARRAY_SIZE \
			| wc -l
	58957

	real	0m1.140s
	user	0m0.663s
	sys	0m0.489s

Multiline matches are also supported by pcre2grep(1), BTW, which uses
PCRE2, which are way more useful than that.

pcre2grep(1) is itself a bit slower than grep(1) --especially if you try
very complex regexes--:

	alx@debian:~/src/linux/linux/master$ time \
			find * -type f \
			| grep '\.[ch]' \
			| sort \
			| xargs pcre2grep -n ARRAY_SIZE /dev/null \
			| wc -l;
	58852

	real	0m1.857s
	user	0m1.408s
	sys	0m0.516s

But if you pre-filter the files with a simpler regex, then it comes back
to usual time:

	alx@debian:~/src/linux/linux/master$ time \
			find * -type f \
			| grep '\.[ch]' \
			| sort \
			| xargs grep -l ARRAY_SIZE \
			| xargs pcre2grep -n ARRAY_SIZE /dev/null \
			| wc -l;
	58852

	real	0m0.919s
	user	0m0.830s
	sys	0m0.462s


Have a lovely day!
Alex

> > Note excluded __free() if I get regexp correctly
> >=20
> > $ rg -U -l '}\n+\s+struct .*\*[^)]*=3D' drivers/ | less
> > drivers/ufs/host/ufs-qcom.c
> ...
> > drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >=20
> > So, less than dozen of drivers doing wrong is not an argument, try some=
thing
> > better. But thanks, I will check and address this in some of the above.
>=20
> Well, it's only an example of a declaration after a previous opening brace
> "{" -- this one turned out to be easy to search for. There is a lot of mo=
re,
> of course. kernel/ included.
>=20
> thanks,
> --=20
> js
> suse labs
>=20

--=20
<https://www.alejandro-colomar.es>

--s7yswkjhiyfpvc3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrODT0ACgkQ64mZXMKQ
wqmSbg/+Kju6cdcJwKw+4RB5Y9NYD3/4h30SzLAQqWN9I3eKY84fT/BFFDoaJ7hi
43SSIJlOBL5aHdVoLJnH8NHMhjDni9S7v/ICfAwWVczFVPuTnwPT7I0qvy58w2Pr
PvNuZmAO06suQoxLddO85y/EBEm7AgNOSzdcU2zJsoCbLAiuH0n3OpYF9sb5Ew5z
zINiYzCOqYUeExVNGJXjIHOIN9pwj/cb/SfrDgRdXW9Y0QEcbqLTEz5Z5xBiCiJl
eJulybBXYjKgDTAATmxOFCysshiNeA592E4LgD4Te2Xn4euC3Mcu6IMlALtNU/m2
/LABEfV2L5Qa7Q0d3sMxaDNrXrZlUJld+97MFJZbWDFUvhBFE2olcmOghQDebQBP
F9XjCs6ItuyPuhyO7G2XJJNfPYOZMR8Rqhmsa5FBgoCOCUhTzfkhQoo22gJmsTcN
hgTManJTpSlBejON9o46dnV4f6G7xO2vOA69VC3xMcEI5NA6Apik/0eVJYht9O2g
AcnuL6Jk29oiuS9l1Z7T+hEvqEFF3PDYfqujobxTS3ta0/UlVUZ6Q42/+DyrGwAh
FjogH/PnfuEaMHW2byuxaZqGh7rpp/+80Ep92FhZOgemaUkDgLlKK7TIHwBf+kqV
OHqTtEU61AdsLz8ghooeiJCWPAK3nwOJ46EOnBLL7wWcAEn7T2s=
=poO+
-----END PGP SIGNATURE-----

--s7yswkjhiyfpvc3p--
