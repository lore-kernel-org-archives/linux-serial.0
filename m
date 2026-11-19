Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108706;
	b=BCu8pCOPZONMNhMRb5+A6x7F8LTwzg7IOp34gIJTbbvvUs41U9gTKOaCdUUDq9HKIfSj
	 gk9gvE3sGJ/4+eLJTM5f8qAINkVIorY9mI91NWjNc9lS02q0ZY5Yc8mZf6Ls3IyLocItL
	 ZDTG97g72H8G0ll8303cGV4wgSf40n2HNh0yheLcZwYMKAu2G2FskCpVtZtvX4IdMqfKS
	 AU8po8c16XLz3EIlCqeChjRm5L73mu+pLBzrmvDy5AhWaMd0mrXkuZb6LG4q6ON2iOOUb
	 kOVmHVEmPS/mRQiG2N3motojFItl1HoCU6VqbGveyF2nxFZci0QGLtbPk9i+B+u6uaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108706;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jca+eER7ZVSpg0jQ3T0KP8gnjZPhkhRZaczjYaO/1WU=;
	b=pu5Zp6C+umwqLaUwso7JH4z4xksgaJMYczXXNgCK/CUetZgGmVBZ2WBy9HAuoN4nYNak
	 h89Wb4ALz2DSnB0yvj2Ghy4NdcXd7safK4PVvNQh6y2TJfOxjWVGTW6F3v1JJpD0MI/pp
	 IuzZh+u0I8s6tfKbJ0JfxOSZ77raJsN9xFp8tMwD/FVRKABYmYqwjse7ogfzsfeBAAH8f
	 LL9pDAyjm9mEjo+WS87EfN3tB7axW1cq3NGtBs7RfhnEGm6s1ITOKuKivY73shmcijHNy
	 aS5nG181lj+hrqJiV9rzruUA3AfhpQaKSL2GlXDAtPJuOUPpQVuKnGPJXT9k6Z+jyJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxPLKpL1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645AF606A320
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxPLKpL1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41411F000C6;
	Thu, 19 Nov 2026 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795108706;
	bh=jca+eER7ZVSpg0jQ3T0KP8gnjZPhkhRZaczjYaO/1WU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jxPLKpL1Z8BS1g0hbJzDQs5CB5qmqq31GbKsCNKkme1Uj85fVYQiLoJWcnGS7I7hm
	 YQLB+594um6zlM27CxtrfRVuViXeBMNaUUzyLfJrcyLviyz4o+ueIu/BC6h7LNeTlw
	 p1iQdvTiMjvoIgJMlLoF7VpPZ+JCXYQWXHTFYJgBDyXPGU4WYuTl7tRXZ8Cv2gz/+n
	 We1oQMNLk+eXZI4QJlrJaX4C7jez/FIzRtGFbGGHJifBIQ2TPM33I3axVBx4Pd9h11
	 unIEfiQp4tZZiAuIq61GANo+M2UCBcxD2ZLuw5fqwxVXE+MSI/G/2PIs1fsGtTMyKL
	 u5sd6dn/GK+bg==
Message-ID: <sashiko-outbox-223680@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: Use devm_clk_get_optional_enabled()
 in sc16is7xx_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Elfring" <Markus.Elfring@web.de>, linux-serial@vger.kernel.org
In-Reply-To: <1333a82f-d074-487b-b3ad-c1a3496b312b@web.de>
References: <1333a82f-d074-487b-b3ad-c1a3496b312b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 17:18:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] serial: sc16is7xx: double clk_disable_unprepare() in probe()
  and remove()
--

commit af406fb81a7e34a89742ecfa2081aa070c5abb01
Author: Markus Elfring <elfring@users.sourceforge.net>

serial: sc16is7xx: Use devm_clk_get_optional_enabled() in sc16is7xx_probe()

This commit replaces devm_clk_get_optional() and clk_prepare_enable() in
sc16is7xx_probe() with devm_clk_get_optional_enabled().

> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
> index dbf38825a78ce..3af8ea93b34a4 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1605,14 +1605,10 @@ int sc16is7xx_probe(struct device *dev, const str=
uct sc16is7xx_devtype *devtype,
>  		dev_dbg(dev,
>  			"No interrupt pin definition, falling back to polling mode\n");
> =20
> -	s->clk =3D devm_clk_get_optional(dev, NULL);
> +	s->clk =3D devm_clk_get_optional_enabled(dev, NULL);
>  	if (IS_ERR(s->clk))
>  		return PTR_ERR(s->clk);
> =20
> -	ret =3D clk_prepare_enable(s->clk);
> -	if (ret)
> -		return ret;
> -
>  	freq =3D clk_get_rate(s->clk);
>  	if (freq =3D=3D 0) {
>  		if (uartclk)

[Severity: High]
Does switching to devm_clk_get_optional_enabled() cause s->clk to be
disabled and unprepared twice on probe failure or device removal?

The out_clk error path in sc16is7xx_probe() and sc16is7xx_remove() still
call clk_disable_unprepare(s->clk) manually before devres runs its own
release action, underflowing the clock enable and prepare reference counts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1333a82f-d074-487b-=
b3ad-c1a3496b312b@web.de?part=3D1
