Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5233A9856
	for <linux-serial@vger.kernel.org>; Fri, 22 May 2026 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456549; cv=none; b=dF1kPqiqeyFK5yGpQoJ3OxiH+mBQqT1YkFETpcNjVm2Q2um2ajr945YD55KjrcMZ8Hf0MLZ0lA7+cgba5GpaAhc6lw1HhPlr10/i/7hl02AR2vNxeL3tfNeEUXXMnyHuxB0dXKFSlUZJXLfgWPxiwU2k6BhN6R8dIl2rJIIZ/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456549; c=relaxed/simple;
	bh=uA5XK7hUcVBDK1TQ5IhMdTQ3KKamgRn7wWw7Lc9tdmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7KpOPHS0TUuxlt7/WJH4u/bus0x5MP9649js2PL3A5oiaOSXAI080R91vKXRkUHmilHgEbmFMRs2uZz/njoEQ+tDJNLk+UPJvBxuwmwLLW/xcPvBeCK36vyH4owkgNSCP20MFpfMVkbbZD812vi93a1ltqglqLNSC+pc4NUboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nINf4MVk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nINf4MVk"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45d96d21e82so4209857f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 22 May 2026 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779456543; x=1780061343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htNYCJqAv5Kn4qWeRy9oacU9mjKWIUf7MYgoPGtubds=;
        b=nINf4MVkr+odyz0TaKW+pKlpATO8A7tAf0HFm2ZtS5vcAKc5O/WH4ZyxNcpHQPBDKm
         MGpAYgQZ1TEgnEzKye9hTdjhQ4qyE3JuKWj9+ew+SVJd0nKaEowGTsbIIr/OK6iLJRn+
         tYsblPkRlgaA1aZcVZ/lWciJsMzQ9SxUebnJhkmDc74R1TTHxCblKnYPIydEs0SiMes8
         NOlvzg6t2q+pLLOBd0kP3DTd+7025pVdEOoeMGPqbUcWWlZm9O6fJO6a2CU9zDVg7tuY
         nbAo+K0PngL7zh3jxiYS8vHe5cmiLjB+Br9DmZbmnYKRN75Sg2mK6cJWFjfQU6A6VkcP
         qJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779456543; x=1780061343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htNYCJqAv5Kn4qWeRy9oacU9mjKWIUf7MYgoPGtubds=;
        b=gnlhS3/XVp0b1wYBY/Gi7pyxOsZLxLpurFKvINPZyg1qQfnXiZDD5Fw6Yr1NazLwon
         ni+Lh0gW2tDqJsBedcbt2vnrQqIgEhSDWCUB1EXySIJW/p77srCj93DJXDYR9B0V2XMN
         hli/fATkv1WG9QDry9V7QMj0Ofsa1IhruGaVQYd4H9Mu4F4GIFWlyFYrgG9q09WZ2h49
         rkFblV56RsjyA8Ea0laMz2k3cz8Dfx9l9nb/Lvnh0W1lWVMAvcdCXCTzzZkWybJK8LjT
         8sG9bwLgP7vnHwXwQuYfHbPYHBaqhaHDADwlxxMSOatyG6E0s48rx7btFwY7bB8joCRz
         NrfQ==
X-Forwarded-Encrypted: i=1; AFNElJ97v2k2E5lCMTJiu3JkoGV/j7NIQgi4/AtYMMubblELzTHQKzC568PViT9DF5Mi8JpWPdmxxjKSr+R9pUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxynSs83LU2R1t6infbvmIo2IjKlvrWebRbgsgE/vSNPio05eNZ
	j7Pw24HXt+nvDECFqLttT1t0+vDAHBfOtcEbDxgWCJYn8GAclzZnbQnQlAinuSAvqXM=
X-Gm-Gg: Acq92OEj3EfyV2P1X90xPmK5lhtsEn+U5FQurJpuK5u2flZjRbwkbAmKnYvhcpHdS1w
	sBil+6mt1NdYcEsgeXmqcOPtEAWlw6OMOdYu8U94Wq95bRMbfhVyj3iDUGaIsN2HZr6AmenGr4D
	pIHjbUUK9ZrUm45Wfa/HpBD1wAosMSH8jPb4/IUtw1vj3VWGenvCUnPkLh+Z646r6kNfiIjZ73o
	/NpoX5Jwp6cwt0b5mMWFpcHLGYEBUAkGLaLFEPkwWJ2qF/yhX/NeVtO374FBDwmwpJl+bcVtEQB
	Mt8F+xbiPdFajGZjGE70JaTxjjLDxCHLji8bCRZBR/cYymIiOKMKv3MuhhNoEWrbxwO7H4wUim4
	BCnMAY/cn+snyYdQldAczW8rKWhls5BDAcOOjj7cqbuPzVLKnu24qjquqyQgwbZocALaBBA+9K5
	QzpXXE6itE8fIoMb82w2jMp9UNeU5E
X-Received: by 2002:a05:6000:388:b0:43e:a9ba:b194 with SMTP id ffacd0b85a97d-45eb38acbc6mr4543931f8f.34.1779456543197;
        Fri, 22 May 2026 06:29:03 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45eb6c9f598sm4400739f8f.6.2026.05.22.06.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:29:02 -0700 (PDT)
Date: Fri, 22 May 2026 15:29:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, 
	Tapio Reijonen <tapio.reijonen@vaisala.com>, Dan Carpenter <error27@gmail.com>, 
	Xichao Zhao <zhao.xichao@vivo.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
Message-ID: <ahBZ2Nz4WsLteszV@monoceros>
References: <20260518101456.632410-2-u.kleine-koenig@baylibre.com>
 <agrybgEu5PT7orKA@monoceros>
 <2026052243-phrasing-oblivious-cb15@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3cssjjmdjo6efmsu"
Content-Disposition: inline
In-Reply-To: <2026052243-phrasing-oblivious-cb15@gregkh>


--3cssjjmdjo6efmsu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
MIME-Version: 1.0

On Fri, May 22, 2026 at 11:41:48AM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 18, 2026 at 01:07:00PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > Hello,
> >=20
> > I messed up the Subject, of course this should have been:
> >=20
> > 	[PATCH] tty: serial: Use named initializers for arrays of i2c_device_d=
ata
> >=20
> > please fix up accordingly iff you apply this version. If I should resend
> > for this reason, please tell me.
>=20
> I'll fix it up.

I see the fixup made it into the automatic notification that you picked
up the patch, so that worked fine. Thanks!

Uwe

--3cssjjmdjo6efmsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoQWhMACgkQj4D7WH0S
/k6rgwgAtPeTYUENGpnCQ+9Nu55uuaWO+Caa5aeVMhK+q13Z8P/rJJ14Oaw1d+ur
AFj2tSJ4igokizK1dSOdoSUiSvT0/GdA1F3ipbY7kAQo67kH+w+rQ+7HqtVh8u8r
yV2+se+2wm0p1LTCxzUFAbZagMTNrpbe7bMw7PAKQ3rXNcaMEg1jbgqbapNFYYSd
uG89+cjferyqFroTeNBeC1pb4FeZSRcbZ56awo5CCLtke8UqpLoU6k88nxoSZSTs
gSur7uTdwTXQf3/cUyEu/CmUfGRV73NnvtYiScnxleOztMWY8AznHA7s/FNIXQ1Q
Ex/O+ZxndmTvhx9tGDfsDrFIjFtIdA==
=2n0R
-----END PGP SIGNATURE-----

--3cssjjmdjo6efmsu--
