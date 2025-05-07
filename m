Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B1289E2F;
	Wed,  7 May 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626186; cv=none; b=ccWe6kraTW/k0Tfuqkh7lEi5eJ4Q7kx8Lsjdi+B0rX7h+xTaCsHXcAdNxsNg1lI6in9N2tk1vRgF6mvM0VNK9160umgnITzpkDOcD6W0OuU/sAipyVTjtrsn5tWBIFDHPZn+4Gg4gPYMjfD1dRXV3IGrFjDi8ccMIqUjz+mL+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626186; c=relaxed/simple;
	bh=Ez23oXIIQDSBf9jO7DkYJ/sHT7NKIqHsm8N2Kxp9l40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8iIoHBzsPWerPDBK7fsJSgM911olcTClIbpvOyUE0dMuSrhfcCBlPf6y98v1qBS87SSHq8Jvr422Y4fVeIYjsn9xXKjk1VuUzar9ba79E1x/FyiY60BDP3vsrUHOwndb8vk8xcHICrVGKYGzzS/aemN4FQgx3/umIbJhWEXUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBBE2gPR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBBE2gPR"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so4626380f8f.3;
        Wed, 07 May 2025 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746626182; x=1747230982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKOS9l2lmbL8Axvzo8aLp5W97gUUtTm15QkqxA7mKCQ=;
        b=bBBE2gPRTKH9EmLI+0HKfCkSLP9iUfLfhIcDywNtZlLCR/Koj64DbYI0LioRJ4mAC2
         wfeVSNolVcMCm5cDmIhIeunZc8pxmLV11G9pls2YFTH8da+Rz+8tmNdNVSIglF9AGclr
         Z/C3NJXGvqEj9nBW2YBjk9106IZFjJOKeZTOgMZuXuhqsbQ02rV3TagITL/lgHOVcs6g
         /VfdA/MBnS696vod7s8TdInFnwdY1HjuLV7L0o0TVFJ0DUAi7xK04nGmi93lojTniE97
         vXbm1T+/Q98GNuY2mK3JzMoSCB0/WHK4C+KfvHA6AP7wN6MUZ6+uK7uqaoba3ag8BfeD
         9s3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626182; x=1747230982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKOS9l2lmbL8Axvzo8aLp5W97gUUtTm15QkqxA7mKCQ=;
        b=JzirzDbT36T2X8NS8ZscqkpQ1EtGkGJb7kpCaTfUdenMBbDP74YSM+r2lcxpXVYKPr
         S/vGZPZwGPJNJjx+4hlg2xTNm+D1gpoOGx5Ci1LNlbxuI8Pk8/+7TBNshkEvJ/Rub27h
         hEDMueJL/AZJY5Bj4RYW6T70ukd/01sPsF/HrK+O/fIoAi/ffm2DG4D7/Rnm4Yu8/buD
         zm4Lx+4GKKrv3LcjfupBLlbuB4uCl9xbVCVH0ePicDHVQ3KFcQqBLugT7KIBKYMw4gdI
         78CknLK/CO17ctRBn8ntzonTlBNFK5j5shMWTvIXsDJ8/j8lE7h9SqTv9qpfBRpI3/D0
         58AA==
X-Forwarded-Encrypted: i=1; AJvYcCVAm27QVKYyLtbP7deX/8gLGV3CrX90WNFtCG+0CIHQ5Ngr6seoWPM8Wqb2L9wXJ+SmBmbwwtulsU7c@vger.kernel.org, AJvYcCWiWJntL7r0N4cPEoehhOhJqmrRlu+iAEigw5WNAUpS3MzmaQsVWexAFke437RgniTqz8fUZGT6SA4LQM/j@vger.kernel.org, AJvYcCX85vFAMiQ/D/C1KFL4T313K47+nKFKKk8SKcaqVTL4R0h1OOdyKxezYTa5+AoVQ0/IbbC1AaNmTNCma2Sl@vger.kernel.org
X-Gm-Message-State: AOJu0YwtxmyIMwdtrv4JelXVHgNBYopxjlHpmR+cghlXUlmJG5B+yZJi
	DZXPvKklJat8iQcadzcTqMgRiDKjZ43CiIWFvzwlzf9JkS5+8EkfJIO/sA==
X-Gm-Gg: ASbGnctt7TzMwgAP4jNKcQEbQCXPxPWk/iU5beeLivFDE+6O6hUw0kO9j0Q5Bi8KWRy
	kj8IMuF/B4XxaeLUHEyeWvx/M2Vcg4/EdY6zD8JCuEyeEXvJtp/338G+gu5wGZ/5MRUfeiQ+5To
	1AZUgPL0EM4QHjPq0Pjf/OmYa+nw0Azl0cjh+MobWmhQXUjSyzxSsjV0H6OrGPHbUMMTxgDSomd
	RI0woJOpfmL3V/gpSHzB3TfUblBd3zBNti2/GZ0YRiyM84TgcP7wv1S6OMxbtWVo6dxcvqwCgHE
	xz7r+Yctmc/ekno/HyvMywEC07tFQhKmzNfUaAmQD/m+Gr1vrwBROb8fW890eWq+37SYnUEHOw/
	UXqhEt5w+hgRN9U2yC8mRydppAbA=
X-Google-Smtp-Source: AGHT+IEsuwOKCYKoTeoEByX7th+p3h1XhK4MpyYuObxMfQ7BHcewy/49G1NXPqbx7VQK1mFfV300MA==
X-Received: by 2002:a05:6000:1849:b0:3a0:ad55:ca0c with SMTP id ffacd0b85a97d-3a0b499c8a6mr3036888f8f.1.1746626182362;
        Wed, 07 May 2025 06:56:22 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd34bbf6sm1849245e9.17.2025.05.07.06.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:56:21 -0700 (PDT)
Date: Wed, 7 May 2025 15:56:19 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Convert cirrus,ep7209-uart to DT
 schema
Message-ID: <bzdgof2kenxvdsqgedmi4jn57vkwiot4x2cihj6wuf742qurm6@yppjjudtga7s>
References: <20250506220021.2545820-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5wvm27otmdi7qpoc"
Content-Disposition: inline
In-Reply-To: <20250506220021.2545820-1-robh@kernel.org>


--5wvm27otmdi7qpoc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: serial: Convert cirrus,ep7209-uart to DT
 schema
MIME-Version: 1.0

On Tue, May 06, 2025 at 05:00:19PM -0500, Rob Herring (Arm) wrote:
> Convert the Cirrus EP7209 UART binding to DT schema. There is no user of
> "cirrus,ep7312-uart" other than the example, so drop it. Drop the
> "aliases" node part as it is not relevant to the schema. The modem
> control GPIOs are covered by the serial.yaml schema and don't have to be
> listed in the schema.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/serial/cirrus,clps711x-uart.txt  | 31 ----------
>  .../bindings/serial/cirrus,ep7209-uart.yaml   | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/cirrus,clps7=
11x-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/cirrus,ep720=
9-uart.yaml

Reviewed-by: Thierry Reding <treding@nvidia.com>

--5wvm27otmdi7qpoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgbZoMACgkQ3SOs138+
s6HKFhAAjJlBPDW35RsL8PiT7CWYEuYDFn4Qwlacl2vG9aX3+GKWOWVFeXU+jxC6
aXMvOlsc3H9cJ0BG15YGdE7pqMLBhbYbbSveSR5EyR//af6Vb3EsmS59uTQzq6BU
JphXxvEHA6InOj8mubDQg5t7xNCrKf5lnjPB6GKfvToBfg1Yggx2K3nHDpxcnNdl
Oz3YjMp1eD3YxQWWTkbr1df+dpXLMC1TiGk9vUS+mB0ojfrNDo7Sm1AsqcqJnP6K
bc5blLJ5JzpA2q3m9o31ZfeMipd2Eq5c69B1HwB82X3y/FHMRIcFuE52ps1yNFxE
9RQ6QJ4GUPwmS3SOAHyZ44RWo+70Ir1fEDZXayDrVMy8H7paAK+iuMYTBTEGsXq0
KuQvULtMFYVMYUBzyVx5Xx2Bq7MDAPHtV4cDuAoozOSgTzBv6v+JPZsQePFI98oQ
11iBhMcSMezOw1WK7FT+uPg6s+lJ8GCc7rr+XSmqC0tMAZhIC4aGS5bhloiCI+rp
uTGCptFgex7Uzd71Xktzk2Sg2EStX+7assN8TwZxVMFcfflcZNCU1bVAwezqalKB
pI+sxIa1OZrx+vpu8klAhkk1pvAP0B35vQXcK039U6oBFTz/zPLw8u77LEvNv+xr
rTFxlKzkmjmkFKq8FINzrrQAsQhbsi+fZL/aiZ2S3Yws9PdG8CQ=
=JOc+
-----END PGP SIGNATURE-----

--5wvm27otmdi7qpoc--
