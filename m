Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C4A361977;
	Fri, 24 Jul 2026 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892109; cv=none; b=WfrARnZLARRT0Muwu/DTNwPmyJeCUfn/5qFk0xGp3joB/T61Raf+1JgFfKL2j1h0/KkGrzhFrG6qi2KeGWv1QdA2RSLYEWF/iV/xvcg8O6LF81nrwpHeoKiG36Vlk5Iu1Pd1JHO9dR5xlMrsX4x+Ym5q7qpLVSPvYOdJlD4yAiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892109; c=relaxed/simple;
	bh=K82UgFb1rKgwcnvk+CHJqjUqxhQyvR/VjzcpGGebxj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spe3BfCICjtfYXfZZW3yXHch7Gh2dgmD8LgkvKH6j6kznhGHBBq2isdi/CTe2dgzwn78gLJC9FMKW4I21+gDII2VhdbnmihoOgkxZqtWYr2wVCwpamNWXqPC/B7+j9YDdc6eJZGQWJ23bB5zElaKiaVkYCtpR6/18pswdL8L53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1SX7FZj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1SX7FZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E331F00A3E;
	Fri, 24 Jul 2026 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784892108;
	bh=KaZedixFDmiSnf8rg7AkajdENjUKYbvhFLeADZl1ozU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U1SX7FZj0Z+t4PlAnWPBWFu036ahvf9RwwTPFkIr5y1fMKR5v/IjWF00HJi3gcMER
	 tdVb/+Ngx/IqFnPHwwxLz9BB0dlk4WhtZKzQ69tG3E4eAHKVDbkfkdVUYmoObfgZPa
	 rxFrJlgFsYy2chVlEC+hK5FrclPsrG8TH4hgaJF0l/bTQS820dyypi+LraF+1Kn/OZ
	 O5bzxGQ0krNZjpP6r20y3b6uGdPHB3PZyedLgmDi69jkd+1bUbknhCWMKAMEtZ4wMs
	 YI5r1eG1yTcxtsugSHqpJiG2/O3pjgIc9luSsKdaesyP1xP8AYLfQaSkcYGcNMA1yi
	 BFgjf942Zepsg==
Date: Fri, 24 Jul 2026 12:21:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Fushuai Wang <fushuai.wang@linux.dev>, jirislaby@kernel.org,
	john.ogness@linutronix.de, osama.abdelkader@gmail.com,
	jackzxcui1989@163.com, asrinivasan@oss.tenstorrent.com,
	andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Fushuai Wang <wangfushuai@baidu.com>
Subject: Re: [PATCH] Revert "serial: 8250: Clear CON_PRINTBUFFER on port
 re-registration"
Message-ID: <649ea8ae-8df8-42f5-a078-ae0985fd00d9@sirena.org.uk>
References: <20260724072452.40455-1-fushuai.wang@linux.dev>
 <2026072454-eccentric-flatfoot-a6b4@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7xmxfHf9TQe9x6y"
Content-Disposition: inline
In-Reply-To: <2026072454-eccentric-flatfoot-a6b4@gregkh>
X-Cookie: Do not stamp.


--f7xmxfHf9TQe9x6y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2026 at 10:36:26AM +0200, Greg KH wrote:
> On Fri, Jul 24, 2026 at 03:24:52PM +0800, Fushuai Wang wrote:

> > This may cause some boot logs to be lost on some platforms.

> Can we get some more information than that here?

I think that's:

  https://lore.kernel.org/r/120da946-505c-4423-a39a-f64f1532a4a7@sirena.org.uk

(causes boot regressions on a range of platforms)

--f7xmxfHf9TQe9x6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpjSsQACgkQJNaLcl1U
h9DI8Af/UkmfnqsoIyWFLMhjIcUjXOxhbrrFmEtRYN4AYOeBT/445S4e4eeJvSoq
ydtATiJeN+wKJWCT6XDlzlYPAcFBH95jgLF8Lt9eruNed3CYN/xQXKiP39e7vOxB
rnQNyQSuias21ViifrZ3V8pf296KYcBkH5NnyoimAGNwmH1pj56UTeLZC+lQbGcb
A3hhFcdinNaXm7XL8fw9xgOFiKmZWo4KLELJb5YA5PGj9EuQIlz1fmGnCxIfrg6X
bSlo0r8F8nxN9bJW5vlsUFC+HHM6soWIS34BL8hWq4vWjpKQvwyLnZXr78YKW8+u
yJsDS0xYltExTtWs1QrelCuVLdfvFA==
=iqbQ
-----END PGP SIGNATURE-----

--f7xmxfHf9TQe9x6y--
