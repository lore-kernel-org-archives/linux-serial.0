Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142622;
	b=f8LUo85QlPcKkcDGxweBqv0onBRxmj4QAVT+1PZJYwDGtYBBQYIF7QItjXZfF/ycIUBD
	 Rw+wZjuN/TVW4IwJVB+jZannN2TGgztdIGJou8dN/u9Bz2b3fZ23YJHpgAv9s3eViWaHr
	 bYZH0k1uCYwXSp6XOQzokPhM3hO9p+V2kY523X3qra8E7Ou89OVQsiZkGXTqPXjQ28wJA
	 VRoBk/oKIW9YpNGD5/26ZW+BT34R/qX0DkkjmNZMw5DWE1rbwXa07UUEEPzrHoI33Mr4J
	 2WXVf2xBW2gspTj0pHEk5BmIFkWahX7O23WhUk8+sPggbpy8jNiSfGCuPM92DgTMqKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142622;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TMDAwFeqjTdAuiM5min1nxajAqMRcATdr28GFNYX+sc=;
	b=kZ4IEajYJ3+ozx4nSeRXbvGQDYQVKi/KhVjiBkUJEMUdVF4p957HelYODcS4c2234IQ3
	 hsCMAKlznjNgNcxN21q6avQqxPTRUkhPc1bhIYdI8jNcTfJQsiSa2lAUX9azCHabUu0z6
	 krkvWMTgw5p54o6tZyiywxZMdLtNHYjBuKUoF7kaJvhuOYQOz5tiHl2t1mJmVHI2IXCIX
	 X/4PEZC+WIOgQYkY+Z7fd2xKO8ehsDpGojKfr/SBWqdhIxFw30x0D10F5ka/XOSeMaIWi
	 MvsNqrUH3W3DGCu5Cyh8WDSqDJaJOeFcCG7oWJdPFIQDpmjinQMoeICUVwUMkT2UdCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKYl3O4W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB68606A31C
	for <linux-serial@vger.kernel.org>; Sun,  8 Nov 2026 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKYl3O4W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357171F0089F;
	Sun,  8 Nov 2026 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794142621;
	bh=TMDAwFeqjTdAuiM5min1nxajAqMRcATdr28GFNYX+sc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cKYl3O4WZZ5OwvRo+GXDdLTt89l28Io9qAT6YZPYUtcCWlM8yKwtF0laP/Ts5csaw
	 GigKLL8fv/oZvhQMOhmthte8o4npqVQdFcq0SkYj4+lU+J+dkzdMyNyaj1VVJ09W3z
	 uz0CqmiIt+IvkMPcSVFEeljZAr9uB8z1CdsD02tn8779k8klpjWq8x8NxLymmbQ6Tv
	 gY9ZA4liniQ+pPH8hRLL76iV/RvuuiN0GdyZ3ssGdjNJbFBFYImqd0VuHKuuDWtL0M
	 iXahi3jxkatzDyWnpaTPhARQO94aAke23nar3ya8ETsG485pLQVVjhq1QVVw+Ei33D
	 +sgIUYOvsUR5w==
Message-ID: <sashiko-outbox-203754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: n_null: remove legacy BUG_ON() from module
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bramwel Barack" <bramwelbarack89@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261108125031.33753-1-bramwelbarack89@gmail.com>
References: <20261108125031.33753-1-bramwelbarack89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 12:57:00 +0000
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
- [Low] tty: n_null: unreachable error path and inaccurate changelog in
  n_null_init()
--

commit 2e48b6bbf8be04b1c87e0588bfba668806cfe4f9
Author: Bramwel Barack <bramwelbarack89@gmail.com>

tty: n_null: remove legacy BUG_ON() from module initialization

This commit replaces the BUG_ON() call in n_null_init() with an error check
and pr_err() log when registering null_ldisc.

> diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
> index 5a429d923eb31..886f6789f872c 100644
> --- a/drivers/tty/n_null.c
> +++ b/drivers/tty/n_null.c
> @@ -32,7 +32,14 @@ static struct tty_ldisc_ops null_ldisc =3D {
> =20
>  static int __init n_null_init(void)
>  {
> -	BUG_ON(tty_register_ldisc(&null_ldisc));
> +	int ret;
> +
> +	ret =3D tty_register_ldisc(&null_ldisc);
> +	if (ret) {
> +		pr_err("n_null: failed to register line discipline (%d)\n", ret);
> +		return ret;
> +	}
> +
>  	return 0;
>  }

[Severity: Low]
Can tty_register_ldisc(&null_ldisc) ever return a non-zero value here?

The commit message says tty_register_ldisc() can fail if the slot is
already occupied, and that n_null_init() propagates the error to the module
loader.  However, tty_register_ldisc() never checks whether a slot is
occupied; it only returns -EINVAL when new_ldisc->num is outside [N_TTY,
NR_LDISCS) and otherwise overwrites tty_ldiscs[new_ldisc->num]:

drivers/tty/tty_ldisc.c:tty_register_ldisc() {
	if (new_ldisc->num < N_TTY || new_ldisc->num >=3D NR_LDISCS)
		return -EINVAL;

	raw_spin_lock_irqsave(&tty_ldiscs_lock, flags);
	tty_ldiscs[new_ldisc->num] =3D new_ldisc;
	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);

	return 0;
}

Since null_ldisc.num is statically initialized to N_NULL (27), the if (ret)
branch and pr_err() are unreachable, and n_null.o is always built-in under
CONFIG_TTY rather than a loadable module.  If BUG_ON() is dropped,
n_null_init() can simply return tty_register_ldisc(&null_ldisc).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108125031.3375=
3-1-bramwelbarack89@gmail.com?part=3D1
