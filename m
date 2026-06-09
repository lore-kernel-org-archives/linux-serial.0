Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554A3C98AE
	for <linux-serial@vger.kernel.org>; Tue,  9 Jun 2026 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987575; cv=none; b=HM5PgjHYYZoOb1whpNVkk+xXXokRrGH1WCv+9rDRZ0JyA1ccKUUqoAA9EiRMvqvM+yrL/93b8ukwuzOiv9Jbq4/DK2U6UBXzkMZHhlq7jmaxvHzF5GZgNoXSx4ONI2mEUZYqHSReonepRs3/zBO807p3q3IA/EI59jhwP3dEt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987575; c=relaxed/simple;
	bh=nV65ddx67cpoFK1oHkFvicC6qsuIHqhlnB6kJD6yPkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8Flcm1WCLAye13YwYnfIskok8BQcd/McxQl93Wxh9q2fl09KyizNkzEkhLCpBV6U0OtT9eQFd0IHMSrZyMNh6wR9ofTUR9vCEUfHYTasO8/Vj2DSL/NRw5i0LD1cuNsqHW7oF7kMqRbQLhugiNAqzk1W76Pv/OhdaA7rwNaD2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZzW/kuF6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZzW/kuF6"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso3635057f8f.0
        for <linux-serial@vger.kernel.org>; Mon, 08 Jun 2026 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780987572; x=1781592372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9aLRuDp7Xih/Aj1X7aLFN0+aYm8OKoa5N8gsfDwGCs4=;
        b=ZzW/kuF6NEtfecYWHGi+xvvp86gtfpy0s45gre0+FES5IfFBaM9fCeSfseGsxWzZFs
         3pT7iaUdCGDD39zOPtI0aqE4BzOFL+FGLaphoRHbZqCTjTBlkAxgxn9lA0LItEzouDSk
         Tc/KYykfWALRue6RUSVSB5J7D49P0VPhMCy+Kn5wz30coJrQGOAENe8WyhbdCfrdA+NX
         2s9i23NQzDm7koD6xEm3MxIEgvZlg6r+2DQH8JL29WOIlEH2aEunF2Fu0duEfLwWnO++
         tHbLzj7HOCN0KFmd9WXpKgkmm4XzYQRFb1ROvJfT/ICBCtCObaodseBhm1Z/krUWRIh8
         ZjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780987572; x=1781592372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aLRuDp7Xih/Aj1X7aLFN0+aYm8OKoa5N8gsfDwGCs4=;
        b=WAR3OKczODQAUBz4xL9JVdOVB+2A5vWmqJNLzGaIinhw/D7pxiw5Qf4X9gexJDm3fb
         vb0+A1VWPqaFQWyD0EAlQcqmPq9fGBT5mVZlh5WE6Ypq5BEqY6WGbRPst1HrtVjLhDXg
         kPoGfTFEgpwA1/6KA5VKvQUTopxLTOFUh4xh4diWRuIOjoUy3oZYZfIMOHc5xoWdSy+0
         EuDxNJWLT+1lcMuVU8X6oPU13ew+kp9ufhyyW1rm/4PW3CdPQNXM+q9IsGLJrPUyFHMU
         Rz2T+iJTNcOnffemA9v2943scYTLt/rkqARD4BnooflGB1KAklVg7C0Ti792ulpoay2G
         zZyA==
X-Forwarded-Encrypted: i=1; AFNElJ9ifR4fr9FZ0j/LO0dHCEwmb4s6oARm7rmblnfv7C1Wk4VbW1ZrQ9rqqr6eyC5vKoJ7SGac8jZxrH83Bec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37X1jeF5f/AJMabTScEZvIjnENLKP5IxjoXqVtlBW3xAbA8ap
	kQ7DsjNjYDYe66PkZA5vQeJgD1P53OvvE/oNWifK4mV8XZKDOhyBf7PrSkPJYukulAAZdboPmlM
	2b+ks
X-Gm-Gg: Acq92OEjuAz7ePdPn2W1jMK5kpHHyt7fo+ntKsTvezoj0oC3WqaCzywQ7uZ8xnfKYrd
	UNsPTjTz6musYl6ERyxtgUxkX7efRCtRPKdpzK6Rxaazo19ywl9JQTrZTPdcyOGZHagSybpJVhb
	R5LdEuHIIyjvitMHBJ5d2tdLpTglZB783uaV5+76neniD3qLmgpstGBd0uAJDVWjnWs8qjDn8eJ
	quSgH4PGD0mPNC8sS+N/QLbVXGcLJAetr9jK5HLEbTSJzYgD1mLiwLZF7Do0+nDM3gzCnw2fwqr
	UrsIp7fFWqBXxHzOqXSm3vvhUlnQm1f7VE2uUBIG1yhAaE9gWbVz2sHdJ/4ppdgvsAmwUXWOnst
	WgH5gTr8dI2zh118NTbcira9E5AnuqoCCbST2C9E4Sc+D7cPsoWYzf3vKXrOZD281OSgBrO4owT
	o2DubU7EkeJhiV8sfxmyjI4B3HyetNNJ4aP00NIAg=
X-Received: by 2002:a05:600c:524a:b0:490:b11f:2560 with SMTP id 5b1f17b1804b1-490c256f131mr331757165e9.9.1780987571715;
        Mon, 08 Jun 2026 23:46:11 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490bc3918fcsm519876865e9.3.2026.06.08.23.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 23:46:10 -0700 (PDT)
Date: Tue, 9 Jun 2026 08:46:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pnp: Drop unused assignments from
 pnp_device_id arrays
Message-ID: <aiezs4ocgTd7dWDz@monoceros>
References: <dfc218a0e9265e9459df1c5bf621db12be5c551e.1780937987.git.ukleinek@kernel.org>
 <fd9576ec-0dbc-4ecf-bc5d-2630c7df637e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fps3hdcvjg6qomz6"
Content-Disposition: inline
In-Reply-To: <fd9576ec-0dbc-4ecf-bc5d-2630c7df637e@kernel.org>


--fps3hdcvjg6qomz6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: 8250_pnp: Drop unused assignments from
 pnp_device_id arrays
MIME-Version: 1.0

Hello Jiri,

On Tue, Jun 09, 2026 at 06:33:28AM +0200, Jiri Slaby wrote:
> On 08. 06. 26, 19:00, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
> > Explicitly assigning .driver_data in drivers that don't use this member
> > is silly and a bit irritating. Drop these.
>=20
> You do not do that in the patch though.

Oh, I used the wrong commit message template. I wouldn't drop the
explicit zeros here because .driver_data is used as a bitmap and some
entries actually use a non-zero value here. So IMHO having the explicit
assignments is fine.

I'll send a v2 with the following commit log end of the week or so to
allow further feedback:

    serial: 8250_pnp: Use named initializers for pnp_device_id array

    While being less compact, using named initializers allows to more easily
    see which members of the structs are assigned which value without having
    to lookup the declaration of the struct. And it's also more robust
    against changes to the struct definition.

    The mentioned robustness is relevant for a planned change to struct
    pnp_device_id that replaces .driver_data by an anonymous union.

    This patch doesn't modify the compiled array, only their representation
    in source form benefits. The former was confirmed with x86 and arm64
    builds.

    Also simplify the list terminator and use a consistent and more common
    indention.

Thanks for paying attention, best regards
Uwe

--fps3hdcvjg6qomz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmontq8ACgkQj4D7WH0S
/k79KQf8C75qwc2FO1G3L1h0VdxS5/8RkDCeVVlbWtRNC1Ah6ap1S4c+iorEnDce
fljsBbYzFB8Ff232VUDM2itNn+acD0WPy/W7J3aH0bTge5xmijrWJ+SSqKT97nX+
r1ufJ5+Hw//1UEM8CTomW7b3n7Iui0y2nZgJbROLhPiwCW/neeeMUbEN7RWtR5Od
voQdr5XYzAleOZWFxes1PoCgiAmqkGlLTlR/lrqrZ5Vyqk0usW/oGsbCPyXVTFKE
AcHeqwDEBxVp8sFdw1A/IZQdh8pWCPu3GOnxZk4x9vPwxiKYTsBcE2s3JqSFkroV
H+gbjFLXSaHBcruMflftHJBEYAxHdA==
=0ECu
-----END PGP SIGNATURE-----

--fps3hdcvjg6qomz6--
