Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099534;
	b=GaO/Fqp1X3bjtrV3RiA66UBRe5ctxWXifkGWimjcbVahmJK+gQQ/Uv6tlO7XxanHB17m
	 4VzA75pwX3uA5Dgf5Nv4f/wWtFg3M5ZLa9UY3r1+6aaZ4vpINKLHfxi6gqTqp4tOf0tKm
	 Pa177HKtf9Cp8Z0vzlHG0JcYRzER/NY0y85GKG2sl6hvBGznQS00vt542VVvBYd4GaoYA
	 0YvLp0UxAQ7csFFpob9iAorkOpDsiK7+fsBv20B/pTcmX7sPbbOmWayOEUDefvV1Bg8cd
	 0CBiF8vyGEHvQ4JH4e+JNEEtK0DaBjyi2GqHowOZdQafF18wvC4bqf34Q3SnfRqWogw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099534;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dsBnn+wtvt9Mw7+Sxw/AlEucg77MfZZGXKibEYI0YCk=;
	b=sEu+06ufeuuDZgCwjELf7VRo65TyQllZc1lmzzytG2w6S1lalxBTFU5cdB18Lk1VwcIQ
	 CSFDohPYhUgggonalBJlnxNgaubPNrUxPAHG+1MsrmzCXZx/2GmiRYO9YBK6kqJVpyDot
	 6JcKl2NbPhXCesMDltXp2QpQoSYoyIu94w1gTuPDbbc1CVKzma9lRVyQFZ5uoIW0UzaAm
	 xCGEBySGFg5bRwcTrra863/zwQB7LSU6n4chUkspNQjm/RBxX1yl1RVtegyEGJZ27fkd1
	 erzolUGDWeEY6VsDeEY1zMXpFC0gMvziX+FBLlms1MicaFz0rpKlDrA7hOw+cbFq8gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEzRMvqy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961A606A31F
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEzRMvqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0958F1F01825;
	Tue, 27 Oct 2026 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099534;
	bh=dsBnn+wtvt9Mw7+Sxw/AlEucg77MfZZGXKibEYI0YCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IEzRMvqyjqu/Pu2uG5g3mvePnuOumdRR0D7FyV5zr5VOr0oaGzwLlstDg0Uj4nEiY
	 QNG0uL0YGBtG47dxh+xJo5JV8kAQqdAtyYNz6LCvYCm2rbCEBmbjRKO+U3A7kb5DSp
	 Noz+hsL6tzZ2f/IAu0kS8R5hyfFgtu8jm27bwd9bcP2wD9S13zQdEfHYZLEDeBjhkO
	 dTiSHfCasfl7tkivxJO9d7A94+OU0sKrpyfGxkgw1oKb6SrIlLGBe3qw6izMpHjGnj
	 Y8GVMuXU7wamTT2Lxw00ght1z/J5sPN2mK7TwOGV1fmZ6i4TU/LmFET7SECfK4NEYH
	 P6UT+nhqT3ucg==
Message-ID: <sashiko-outbox-186417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/24] serial: 8250: add bounds check for line array in
 setup_serial()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-6-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-6-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:12:13 +0000
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
- [Low] serial: 8250: build failure in setup_serial() due to non-existent i=
nfo->line
--

commit a2e0e82dd3bc2dcce54251c9832007f4a9e30584
Author: Joshua Rogers <linux@joshua.hu>

serial: 8250: add bounds check for line array in setup_serial()

This commit adds a bounds check in setup_serial() to prevent out-of-bounds
writes when registering serial ports for a PCMCIA card.

> diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/825=
0/serial_cs.c
> index 5dcd1544e478d..8bd88f3d6d865 100644
> --- a/drivers/tty/serial/8250/serial_cs.c
> +++ b/drivers/tty/serial/8250/serial_cs.c
> @@ -349,6 +349,11 @@ static int setup_serial(struct pcmcia_device *handle=
, struct serial_info *info,
>  {
>  	struct uart_8250_port uart;
> =20
> +	if (info->ndev >=3D ARRAY_SIZE(info->line)) {
> +		dev_err(&handle->dev, "no room for more serial ports\n");
> +		return -EINVAL;
> +	}

[Severity: Low]
Does this break the build when CONFIG_SERIAL_8250_CS is enabled?

Commit d6a0791098be ("serial: 8250: make port operations work on struct
uart_8250_port") replaced line[4] with uport[4] in struct serial_info in
drivers/tty/serial/8250/serial_cs.c:

struct serial_info {
	...
	struct uart_8250_port	*uport[4];
	const struct serial_quirk *quirk;
};

and updated setup_serial() to store the registered port in info->uport:

	info->uport[info->ndev] =3D serial8250_register_8250_port(&uart);

Because struct serial_info no longer has a member named line, referencing
info->line in ARRAY_SIZE() fails to compile. Should this check
ARRAY_SIZE(info->uport) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D6
