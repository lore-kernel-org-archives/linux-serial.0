Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005887;
	b=nijEpWhK5V+qHyktyOFnCcJ5/f5h3wDYtZNdnhPq5qTn9FNV7JvQMD3bbM///3AQkKnD
	 DPSAIugfRNa0r4EopjZhjtjQcGWBtao+y54M6Msyq7lC1/HfdKCLai+2xSHDgtabVhYTO
	 N9vH5AufnUe3l7y9Hgb5uKDmLRvVVEsncFCtzfJdnb086QvOUp4cJ5VZ8kAMGJvrno/Aa
	 Y+ZEI/KWj191ATSH0ueBRh5FeZLaDU/0bD4YTGetmYDu5qGBdlGXzWx6yfUBR1W788Zch
	 60tKvis2Llp2XMno3U7UOuHOxnK7kjiQHYkwMy+iLT/O00YivIqWPs3N2PMJgu/A5Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005887;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cJ70pyZ+d8xbwHwlHx4iJB1qv2DxRkYcln10ZzA4EuA=;
	b=wFOhDy2fjHTl3MGoRRulVuuJV1N7G/WoLeRjeikK8R2NEdLpz9ftejWYWUUyJY1lxpCD
	 znrUk9iseoV1I8MYTqy2Pjb7CA1ETCvoK3M/egj44/NEvZq0TByopWdUyZBFkgj12RF3e
	 /emxINJKt53820fNGly7NGQP4zD0E0aiCT1236jO5pXzRz+21guW7StSivhqoNdT3G/7I
	 pzvALkf6MBTyGGk5zaceeQcWqEYscH/DBTwuqlgl2fYinp5wjA55PehsmRwtgjW3DPGWl
	 eQXfSg6A89AHKWvDn/UQXQsMC9+nWGLvy6qxvtHdXWKQrKSRpHjTrJdYi47YupTrhRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YJmtsYY/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA85606A31A
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJmtsYY/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48F31F01825;
	Mon, 26 Oct 2026 09:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793005886;
	bh=cJ70pyZ+d8xbwHwlHx4iJB1qv2DxRkYcln10ZzA4EuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJmtsYY/giF0vkcCBWnes6H0ZnViW5/VhTtsojB6MEis7kWL06ir/YwqWz2SMY/Cm
	 57nteUE2RcR29menXzArKMHWzcy4Tl8+Z8ENZlns68YuvFFE2aOTmIRHS5XCNuznEU
	 Rw4Nbocuz1k0VrK8Sj79I91xlnyjx1wA55ngUueHCtAthA6dCZOwD4bsSajT2TBki1
	 mpH4TvLJfiFw9VeNtFON8y7RCE2+exl2+RL+1t6g3WMS6oKwfeceWneootSQFQj/MN
	 7UZ4ss0A7nuJJTv2i0kWFtjSpyhl+LvPFbx9eRDkspQH8hWB6O9red9dtZwJ8kNKwP
	 aSVGDhr0box2A==
Message-ID: <sashiko-outbox-184743@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: mvebu-uart: use device_get_match_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bramwel Barack" <bramwelbarack89@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261026074644.17464-1-bramwelbarack89@gmail.com>
References: <20261026074644.17464-1-bramwelbarack89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:11:26 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tty: serial: mvebu-uart: unused mvebu_uart_of_match when !CONFIG_OF
--

commit 0c58839f587a9fd9238f4c8d5f0c179c6753ed36
Author: Bramwel Barack <bramwelbarack89@gmail.com>

tty: serial: mvebu-uart: use device_get_match_data()

This commit replaces the of_match_device() call in mvebu_uart_probe() with
device_get_match_data() and removes the <linux/of_device.h> and
<linux/of_platform.h> header includes.

> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-u=
art.c
> index 33ea496c93b29..adc2cf7ee65d1 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c

[ ... ]

> @@ -866,8 +864,6 @@ static int uart_num_counter;
> =20
>  static int mvebu_uart_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *match =3D of_match_device(mvebu_uart_of_matc=
h,
> -							   &pdev->dev);
>  	struct uart_port *port;
>  	struct mvebu_uart *mvuart;
>  	struct resource *reg;
> @@ -919,7 +915,7 @@ static int mvebu_uart_probe(struct platform_device *p=
dev)
>  		return -ENOMEM;
> =20
>  	/* Get controller data depending on the compatible string */
> -	mvuart->data =3D (struct mvebu_uart_driver_data *)match->data;
> +	mvuart->data =3D (struct mvebu_uart_driver_data *)device_get_match_data=
(&pdev->dev);

[Severity: Low]
Does removing of_match_device(mvebu_uart_of_match, &pdev->dev) in
mvebu_uart_probe() leave mvebu_uart_of_match unused when building with
compile test enabled and devicetree disabled?

Previously, passing mvebu_uart_of_match to the static inline stub
of_match_device() kept the table referenced when devicetree support was
disabled. Now the only remaining reference in mvebu_uart_platform_driver
is wrapped in of_match_ptr():

drivers/tty/serial/mvebu-uart.c:
    static const struct of_device_id mvebu_uart_of_match[] =3D {
        ...
    };

    static struct platform_driver mvebu_uart_platform_driver =3D {
        .probe	=3D mvebu_uart_probe,
        .driver	=3D {
            .name  =3D "mvebu-uart",
            .of_match_table =3D of_match_ptr(mvebu_uart_of_match),

When devicetree is disabled, of_match_ptr(mvebu_uart_of_match) expands to
null, causing an unused const variable warning on mvebu_uart_of_match. In
addition, the forward declaration above mvebu_uart_probe() is no longer
needed:

drivers/tty/serial/mvebu-uart.c:
    static const struct of_device_id mvebu_uart_of_match[];

Should the forward declaration of mvebu_uart_of_match be removed and
of_match_ptr() dropped from mvebu_uart_platform_driver (or __maybe_unused
added to mvebu_uart_of_match)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026074644.1746=
4-1-bramwelbarack89@gmail.com?part=3D1
