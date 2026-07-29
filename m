Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705513CF1FC;
	Wed, 29 Jul 2026 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320531; cv=none; b=n7plwnOfBBzon58cn6Sl6kTD5KwVKeRecgy7HPsfBp8ZoufmKp9sUc8i+w09otvuJrqgJZu6o2YeL09bc5sYau6noAsFnnl9Skgr4aIhVY6NdZDWUaum9QKVHbPi8kQPjs38rUm6zQhU6lINp3KVdnBslLOoqduiTnoL2TRIpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320531; c=relaxed/simple;
	bh=EiEiYdc47/G+5NwR7+cKeY7G6+OX0S7G9T79pascmtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjOcgvrc1ogt3bx2HTnAj++pIkHjlfKZLEqXIPc320Nkw7pOF/Nyxwya8cJxG858tFZlw7LaVCsrGfli663Zut1szATeGR1atKm3pyohTjIYiKqBtU78z1qjx1ZEorqtnQs/q66A6l8i0HUGxyWH3YiB2MjivRt51HAtdB07ZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cig+yABp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cig+yABp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4EE1F000E9;
	Wed, 29 Jul 2026 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785320530;
	bh=xO7hs8R/ve/G4tMLXgEx06HvBjt4sQwmTFtTm+se7/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cig+yABpaCGELEzHkHPEGC1CKyQvJoyVfU1DmrrswTvNO/TD7dNou2Rtesy/ik+r3
	 YRG9JZfChhemmo1WYrbVaCpmpbgcYL9cLbvNIGmXOSyRIHWjYdFOGqQpl9sBlx1u29
	 c3h43woUDJs/pWIeT6AUeqEqoRzrD5mlX2cv69wsn5mD+We7+L0vOQzC2bEm+5/T4x
	 iquGsqfZBRSL3HIIkEqAopq3Gn/AEr4TgA37Ber3Jx89AFTxpfzLu50j4C6GAGhzs5
	 o+QgNAHdd+OJX1AvK3NN0+Qa/VHV6Tapn2pVKNmmQqrU9GXEI4urnAtw4jDxhT5RlJ
	 xe98u+DMGTwIA==
Date: Wed, 29 Jul 2026 11:22:05 +0100
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
Message-ID: <83d7ef4b-9426-4439-abf4-2d61979afc20@sirena.org.uk>
References: <20260522101042.21976-1-fushuai.wang@linux.dev>
 <120da946-505c-4423-a39a-f64f1532a4a7@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gg2wJHSKmjveZud0"
Content-Disposition: inline
In-Reply-To: <120da946-505c-4423-a39a-f64f1532a4a7@sirena.org.uk>
X-Cookie: Close cover before striking.


--gg2wJHSKmjveZud0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 10:55:44PM +0100, Mark Brown wrote:
> On Fri, May 22, 2026 at 06:10:42PM +0800, Fushuai Wang wrote:

> > Clear CON_PRINTBUFFER when re-registering a port to prevent duplicate
> > log printing.
>=20
> For the past week or more (I think since it was committed) I have been
> seeing boot regressions in -next on a wide range of platforms which
> bisect to it.  One sample is the VisionFive2 which gets to userspace but
> grinds to a halt:

A fix for these boot regressions was pused by Fushuai:

  https://lore.kernel.org/r/20260724093151.53216-1-fushuai.wang@linux.dev

--gg2wJHSKmjveZud0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpp1EwACgkQJNaLcl1U
h9AL7gf/XWhw5DyKayeueE9hFEZVwC/yxPdw4npqZKQiMoDLKX9fEgIPEPNRdWYE
yCt5OSGtOvxg5NrB03sGv9SYNHTONHizRfmzV1yIm3RwP3FMarslUhj1lg7MxHi2
sTjCyGtiCpKB+vZhcV6T1q4X3yJZcPlGz2bbiw8ZudHxqencBqJD63YU3YROfzoo
77c90BD6IDyXiJLi9uOursBWGYjZMsp28IZjzG2ugIBB7GfwMLYL1f7w9MG8w2ZG
KwhLj1VCY18FmDd2ET+qftur5QcdD+PW/5n/lm7YZo2NnRHV9YhETtbtSOlYXbm7
sFyUa6ZaXpGjO/7ChdcsiHzCFjQ1Qg==
=boIu
-----END PGP SIGNATURE-----

--gg2wJHSKmjveZud0--
