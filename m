Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF92728C004;
	Wed,  7 May 2025 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632599; cv=none; b=P4+d6+A5WVWAMFyILwH02UEvfQ+XIBPq+a99IVx0o1yf7VBom9opOdQ7vuuveoapdDNkL8vJPgqsrEwRp8U5QmIeeGR9nTkKKQT0nnPVYX/H5MuOwXAZqHfvmu6dKP7YJyuJg4rqx70DnuI7ybYvojMvBkFIkxiM7brBjLy8AMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632599; c=relaxed/simple;
	bh=6E20BuLxmf7Ou6q+WhERGS6qz0/P5Z1+f0iLMyDY14k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKnYy1s5LVtX9dUpc2u8mdYXMdeKvd/9CLgawkTWT+z82Xva9/SGV6jT1gi5RmbeWXkfiq3I7QOWp1P+C5i/wk1s2Zwea0uINBH7PQOKis8vGrgwoL4jQdY5abgnnWiMLfeHqxDQCXxZg/GfbQDtCE0cVJ7LYNgneGuR3ZJEsCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ikg17e7s; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ikg17e7s"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso9969f8f.2;
        Wed, 07 May 2025 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746632596; x=1747237396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wBr3zUbq54VZyL+/LHjVYV2mIQ3PF+kL4DJjDshhJ3M=;
        b=Ikg17e7sZQlIxeixWVOtbviCuvMO0XEftnz32rxDS7f33wl4Blk2gdbVcrGjf8SOpv
         QC7ArOpnWMvYgikrzSzParSiGY8TUtGSlC7KZprwJflEPeQZ0Zla5uPOeETWlREi2wQh
         olp2EPhp6VU1YtW5LiZSPdoUZWAa+Yf8TPVq9e9Ax142q9fZRw8QfLBQL7ix0o6ShQvI
         R+15oOErHQapDvs7XPcwerKfmeOwacPp7I38CEGX+wjX/ymDErBI1EkE2H7AqH9LzpxI
         SyJYZxCYLFz0p6i30nCIhu64FKnb8y3l3frwoeBu3/xjlN/vuIWcn3qRmrWSdUpK+HFs
         IuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746632596; x=1747237396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBr3zUbq54VZyL+/LHjVYV2mIQ3PF+kL4DJjDshhJ3M=;
        b=BP9vSOOlhOdQ0QOWY4emSRAKyoleOf47Ze7EECVodl7crjt5IRKmGp3fiytK2UJqtz
         MZhxTVaiF6VERLnllBDJJySW2z+t1NDh5fiv1WCDP1ykyzeHm+IiR4sLmjE9ZBVnRJ2/
         IXjES6VgjRetKfqf3KRJXs5wDRM1+47eIB01PlRNYvAGDwni1nonmSFzHxf6OMsJprV1
         sCt1QvjFLDcTXOEqkfVYIlVGvdyJkgfZ2lPj79S/6KD84SfZ46ko3W4mrNBJe0JLY+5Q
         nmSEySB/xs5NHuGxRXO/ozYCgVumi9Jc/pGLbJZ/6ugfxqUxzQcq+GC7wRj7b+/Y1Gr3
         VYuA==
X-Forwarded-Encrypted: i=1; AJvYcCUz3nC8uWmzawnt2wYrp581HQbKjbInAHi08vsYIpfBcd2lp08rarFEAYNo3TGQp7DCKqy67Gj2ZDWDKkjf@vger.kernel.org, AJvYcCVLEJQe0HIftlwzk8xgixSFFZxt013AlGuWhEAMO0V0h9S0QbBKNvW4siFwtE5buGR4y+bUEdCdemdvzUY=@vger.kernel.org, AJvYcCX1cx4uoakBCSDRY1KzsxAuOiho3zGwsBLy8TKnApG7mx9AON9ytXSlj0enbJsrz8qYKJMiTM3ewYn0DUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfC74jMq0dY4bjTQs02KlEn1kbQrj+qgleSKF3s84aSxa+GqCd
	B9WIWjqwDWSq5kZRiUTB9PTbBQ01T6oJTbr7xqyEzeAbAvc3myZN
X-Gm-Gg: ASbGncvtNb9WFn7PZ2FCS2IJmYeOEXGmjzV32/Cf4xmgSAEDFX6yiFqiZs8TWoxCHJU
	OcsPsD1POGnF/2edy2MNG5zUfIJrKjRHjWzt0B+TRz8t2XeeDKiXct9++Symu55azeSwNdweTI+
	2AOJm7SlLfseWBaLNnE8QjHVKm5sELJ9lVzla1IxcCT8xgXHkTVw2eg70PulRVqLhKrQ6UlZOdV
	oqSNtBy5WH8mVv0tx46XcDz4BKcIFROAz31gV1PYZ+2MI5J/5RyGgIpUCClxMjy4yg01/MRih2B
	81eu2bxZAushgFE6yY3li6Gt3dvoM89ZSkO2H6BCAVOLjYfeNuroDjy6McRr1fY0tgvzSW+NqmA
	CdvNl7OisIeBBeeAzz6ldSAi3hNk=
X-Google-Smtp-Source: AGHT+IFewhDO4Iidnrkn2dQZNyPk+OKIQ0nIKow81Cn4DupL8wePD8W7+Ka5SzlZLEBFKF8krlLPEA==
X-Received: by 2002:a05:6000:2c7:b0:3a0:8ac0:bbbb with SMTP id ffacd0b85a97d-3a0b4a0509cmr3678532f8f.46.1746632596044;
        Wed, 07 May 2025 08:43:16 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae834bsm17419773f8f.60.2025.05.07.08.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 08:43:14 -0700 (PDT)
Date: Wed, 7 May 2025 17:43:13 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jonathanh@nvidia.com, 
	kkartik@nvidia.com, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] serial: tegra-utc: Remove unneeded semicolon
Message-ID: <ny7qenz2vnbvjaam6glkx73cu3u27iyxv6lmgur7m3rjzmcccp@4hwy3badcids>
References: <20250407040712.2577607-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qzz6islky2ua2azc"
Content-Disposition: inline
In-Reply-To: <20250407040712.2577607-1-nichen@iscas.ac.cn>


--qzz6islky2ua2azc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: tegra-utc: Remove unneeded semicolon
MIME-Version: 1.0

On Mon, Apr 07, 2025 at 12:07:12PM +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
>=20
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/tty/serial/tegra-utc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This probably went under the radar, so in case it helps:

Acked-by: Thierry Reding <treding@nvidia.com>

--qzz6islky2ua2azc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgbf5AACgkQ3SOs138+
s6GFtw//UYXBUThKIJCTGtfwciWm3yMQ5GMO5bV69EScq6S4G+9iWtYiXj4hpKjL
CMELPelbXz0vsb7Te0/B4Ca42b6ZU4QX3qnWMQDSkIUax1xPiHYfWV7vrtGVSbDF
i+jZiVQJDdIWqOtoNh983kCX01HknVhi8Pa+ExLN3VBOV+HavZZOEPrpCrQSG58v
d/AldDq391TapQQZ5nzYE+UhAfusEWemOP7FARdRE+4Qn3YxJNN8zD1KpinC73dK
YIvZ5Hw4Wy4uytvaz3Q2sZ/MR3L3RqPzmiuEX23gAI+nz9uQrZdTl0eUAZ/8A5S/
o7rcToG/HMRrjlIk6gOrzlBznPatO8w8M6dsWQUKQT0IE9nKizIkq9vOb8cqJV5s
Co0YgcdgE6mvY96J+sO3M+DEY4gK5MTKTZXIxe7Lm00Xd8o+qsd0NKhhEClviJxM
M2K7JbCOb2prizv88EKdUo7RJ5I6kKLSrtehbdmKq2HVQlE/2Vuk69MuTT36nL/2
zW3wb01qfuwi6HvRh4CSVQr8xKkKM8tTW4eCXfbfdEMxOsZu5TDIWns08jOUWGJ7
jUG+fviwXkncK+UsnIuP/AZ472Q+As0Wwz/zHz1oTSfskBedr9P2hET1lk9VlawB
gaKhneVwJU4dOgymAwIN6flYTBWwhC8au8YPj+2U/rUeNKwDL88=
=8GSg
-----END PGP SIGNATURE-----

--qzz6islky2ua2azc--
