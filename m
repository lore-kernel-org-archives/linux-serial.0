Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115615CD46;
	Wed,  7 Aug 2024 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723007639; cv=none; b=JiJ2ZrM65cDj2ExIseF5fgjQTK76lbRZSYFpeAu+XEXKJ2P8eSJEZbW8uiWPG+a/tgxky3HpwXiE6ba3cu1RjF+q7iPCFwluM6iC/t0CCksK/Y28nXW5XTfokPsMWwIfs36N4viDgs/DxOabc2cB1JJLX1+uTnvrxY+vwxzP80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723007639; c=relaxed/simple;
	bh=myfg24QZeMBpr6RDET5k7wik6pAyBkHUktrUl6sTguA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6XFjIiyMEwCqjswCk2IQKgic/ls27UCEZ0+8AHvqvxdsB+9nR7+/gt4OPo7pZZ7QzlL09UtDg+aUXEm3F/2nmS60Qyi7aVpPxgvNk5w2iP7+CKnGIAOhj3IJmK1h0bqv//X+rCtYXe3kOEootGlU8w/+TEaxS1NCV0aZClvSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=QxCWqUAM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QxCWqUAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1723007634;
	bh=H+XgIFrGX20mY+ynGg23RFuP/1uIR3ib6OltHGdAmlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QxCWqUAMTNvAb2wI+8f6AXkWEARiu6THFAB0YF0mlzROplM7oOxgvsDg4TmuoaQJA
	 PIftH72jhb7jKlel2H8FohhIQqGCBmx9CzEIFe+5xRBkBvGwZeQroaXxgPlk6L7YHh
	 jn1ds5ItaZLYHhEjEKfEhBAAtuBJ4vKL7vKtLS8WS/Kbm6L5UGAkCrHU1oOY9Jaxz2
	 ZsROVWcZ6+RxAfJQ4r1/SN2X+1nXkUYroneXXJHETsSwyzOcJ6/RB4hLBHN4lNkkRB
	 HFY6RTfD1YwQxrxj31SFGgNYdC+qS5Ih3VaD81iz9m+b0pfLW5iIv509mm54NOWxah
	 SaIKivGTqpoqw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wdyy95ytrz4wbp;
	Wed,  7 Aug 2024 15:13:53 +1000 (AEST)
Date: Wed, 7 Aug 2024 15:13:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] serial: 8250_platform: Fix structure initialization
 warning
Message-ID: <20240807151352.3d66afe8@canb.auug.org.au>
In-Reply-To: <20240807042210.1608026-1-sunilvl@ventanamicro.com>
References: <20240807042210.1608026-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UvhuLjtR8tORIn7VjrcEiSE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/UvhuLjtR8tORIn7VjrcEiSE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

On Wed,  7 Aug 2024 09:52:10 +0530 Sunil V L <sunilvl@ventanamicro.com> wro=
te:
>

> diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial=
/8250/8250_platform.c
> index bdfb16bed4f2..d8c3c169a620 100644
> --- a/drivers/tty/serial/8250/8250_platform.c
> +++ b/drivers/tty/serial/8250/8250_platform.c
> @@ -108,11 +108,12 @@ void __init serial8250_isa_init_ports(void)
>  static int serial8250_platform_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> -	struct uart_8250_port uart =3D { 0 };
> +	struct uart_8250_port uart;

Does just using "{ }" as an initialiser work without warning?

--=20
Cheers,
Stephen Rothwell

--Sig_/UvhuLjtR8tORIn7VjrcEiSE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmazApEACgkQAVBC80lX
0GwYxAf/RWqpE0k4kD8EmJDXJkZ2tZAUbG/OelChMjt7727S89ZspmBw3Oi8y37t
B7d4Yu1RBA/+M37dIMDXmVkJ8Me05r2Uxl/AwO/iM3JYeMYeE6aO+GvjCafB1FaD
7szayVIdCZOrQyyJyyI/PqaxDe1gl9QYh0c4E16F9y4eNsDNHDxluksiRtJ6leJ8
qlx8dsGV0R+g90RoDNKlRPw52E6VMQmWKmx7ti42ZAhPMQK92l4H7/LVTyM5bC76
yBgsUPwDXEDhKZK6Q8NCfbn1ypSB7am0M3a1R0lUxZtLVH/EB1I2GiVwZ8z6v2mN
6Ux6wmlLGxCI3xx1uFfsCRosAJH+6g==
=H5g/
-----END PGP SIGNATURE-----

--Sig_/UvhuLjtR8tORIn7VjrcEiSE--
