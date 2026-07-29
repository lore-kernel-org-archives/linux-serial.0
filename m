Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83043AFD18;
	Wed, 29 Jul 2026 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320485; cv=none; b=rlhJ5MxE4zuzOmwLG0Hvs2JDNzD8gSt12ph5mCTGuP3wJWr8cizZLly5EjQKwVj2zohVakWuUnygfn0Q+LZ+FGybrj5EecuyfNLylYxdvau1YrJ9TlkXvaaeMW5Hbyn23Z9MR/RcGjmO+cEqSufTUvzSrUaBo4pG4l2FsRK5TYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320485; c=relaxed/simple;
	bh=KpK7zHISOVraNy1i6aP5eWFOkEBvxpEHL/7MMwbQBFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5udzUflMmb7Q4WYva8WF+bimvz9c5fdqFL711r3g3+O7Tw8zLAWTw8ejvk1iyPhEZOQ/XxbqH94CBbrIhLR9YzUm7kFZ6ho3waCkpeB79ilq/vzQw9d3XsafUpZ0aOEzGwTcXvywCb948Er2dkxSdFE0vE2RzRy+g2B2NbQsfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd3OJSve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd3OJSve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACC41F000E9;
	Wed, 29 Jul 2026 10:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785320484;
	bh=KpK7zHISOVraNy1i6aP5eWFOkEBvxpEHL/7MMwbQBFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dd3OJSve2pSm3XNrcgQ5UKgM3mUzeVgwfJFK4PWcuPAexS8v+E/riV4w0WLBMczkR
	 saUF2a4LXKVNU7vHtE+PVg+76j+f0XOU4/bqFDMumJxKcVBxpuqdeqz+n02uGaoABV
	 2Tc2KA5tANR8gkgYRLSr+2H3tLUeTLBo3xeFp6hIi//copIL6/at+BGk6qFUMjslov
	 hMreK6yY2mEPdTLgH8CCczKdRuKXF0XBJKhaFsaYytkeA83CRsFH2lPY0wdvTvwZR7
	 1L6GdxGxTo/S9jCHZU7F7fMNfgOMoTGCeI6drFmgHW4CB+oX1tZhaXZmnZv11TnkHn
	 ok56nUD2c3lrg==
Date: Wed, 29 Jul 2026 11:21:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	john.ogness@linutronix.de, osama.abdelkader@gmail.com,
	jackzxcui1989@163.com, asrinivasan@oss.tenstorrent.com,
	andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Fushuai Wang <wangfushuai@baidu.com>
Subject: Re: [PATCH v2] Revert "serial: 8250: Clear CON_PRINTBUFFER on port
 re-registration"
Message-ID: <e086c2da-e08b-4d53-abb1-e7a5cfd0d6f6@sirena.org.uk>
References: <20260724093151.53216-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="icPnZ6cwnYoemwbV"
Content-Disposition: inline
In-Reply-To: <20260724093151.53216-1-fushuai.wang@linux.dev>
X-Cookie: A well-known friend is a treasure.


--icPnZ6cwnYoemwbV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 05:31:51PM +0800, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
>=20
> This reverts commit d338ab1d90603f875c4f7ed223406535378173a5.
>=20
> uart_console() only indicates that the port is selected as the console.
> It does not mean that the console has already been registered or has
> printed the buffered messages.

The multi-system boot regression this fixes is still present in -next.

--icPnZ6cwnYoemwbV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpp1B4ACgkQJNaLcl1U
h9Bv2Qf/Qd1WFNPmgNHaS9HnpOw0cqAS7HEwSkXRJ1asJfbvlQ/0i6BV8tBB9uyx
j1fNDFMeaFFEv+PXhnew75pdTv52BGr0N67VdBmnTLUla9oL5V614F8ORgZoEOAt
jq3vS786WoOVdpM+CTnUvWb//bIKX47OtlAJ3kpwbklEMazd/b5mYLuTpGiARAyR
dz5db5HI6p9UTdGffVc8FUi9VebDzOuDHwb1fi47gto1HDEQ5UVaTfkTzT8JaQ+D
vFBAgQ7cYArGKh9enklqZ3RJCKn4v70QJKrvtgXgj+Wrt+S13tYXGTcr+07fL7Cv
HYuMbKbsauV/JZciHdEllvP3z7yX1A==
=1HhY
-----END PGP SIGNATURE-----

--icPnZ6cwnYoemwbV--
