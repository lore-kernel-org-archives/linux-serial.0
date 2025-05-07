Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2C286D64;
	Wed,  7 May 2025 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625912; cv=none; b=cYP0XSHlJ0hMaG3MKVqpd7cn1yvr4KIJVmXO3/WZve/s4Czf+8TCwDUedGg5/U6oqM6hXZDR6mhrcom68BdLwd+M45Mb5yIASfWSo987aPeUYz4RwzkwIs/O5sz9MkCBynHAgWJm+Ri8hdSkLIEhE3nugCO/73sCCHhDhDY0EY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625912; c=relaxed/simple;
	bh=h47AWz6e86VE/pORR0sq5lsusKYJBjxKblt7H5Ks3D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cw4SasGrbxwSAOVkSv8JHlndo6OD8B+1wHrXLogtB6CPowUj/lG1xuYUZEPQxCPc9QldpaunZHl7jQ/GM2EOoRNyTnIo2qaAhKr9IfSIIwd55c6Mh21LvcJLASW5y89eQ7fXKAp1UkPibDU7Rx7UX+d1WBLM8VPI4IshM1KlgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AM5uEYWB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM5uEYWB"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fb0f619dso80364465ad.1;
        Wed, 07 May 2025 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746625911; x=1747230711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0y9NC6vp0a8s9iJ8BhQvpZ0iFDf2yyS+rfp+xWO/1g=;
        b=AM5uEYWBT/V59UbE57gqFmLLdhPDOSJ4a7pgSe0NhbVsHKoeVn3YKhF6wFbhEweWin
         TEuOHtTyQBCCpu4qsFzStlvXAO/WZUgaGfb5dd4rHykczKu9kqboirett0fJv7HbkR/B
         lH12i7R0cl+75rc2/jRx6qMvsmwdM5o/WP0KwCZBoUckXV2D0T2XAx+h42Gx8hTDrJIF
         4pZLeuyODD8C4pPynLFVB8z+TrIKxK424Q2iSFEALxC6R5IA083YHt+s5F6q8/ceg++/
         jRVRKXUnKYagyuZUTyE1e9rTA2kEQZaXxEQhP37S4l1eA5N3GQhv3t+Qsv+wHCz6xE1k
         upFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746625911; x=1747230711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0y9NC6vp0a8s9iJ8BhQvpZ0iFDf2yyS+rfp+xWO/1g=;
        b=uaLnfsDsZHYswEIkg50bkedjakqDNIe1ZhXdE1McG+QMfceGmJYg1tQ6FcrsARiWVa
         wfF/HAmRqWxp5KarfTKP/sLW5g6yXoXJ8TU8XZ9fqbqVZ2LHzbo/8kggEHtX1FTv4GRf
         s7xSSCbvGwfs7UYaZW1nZ14XYah9aznjbQda0RwzFX8rRAOLLOEITvyCiObnYt1K1abR
         i9jQy69wgFOyEIj2oIv/9kLe1iEK/7kSCivXpH0fvzKkTwmWNb3YHBkAS+dLqlB32S2T
         nRucxrPB1pWYbTs6lTJkT4VZPC+bEVdcTsmvIPo465zCPKplnhZxQ4Xngp3dWQeC+Ite
         YrMg==
X-Forwarded-Encrypted: i=1; AJvYcCW+ZbaQqQVAQFPAdY4bUF0JGdiSSbINMM9KyrFlh2eKEQHwxuyouwMDIdE9wiBgqHwCgkHFuUsbAIXh9xLW@vger.kernel.org, AJvYcCX6uWs/hyWiFd8VgZ0EHtbP2RGTI4na89lpgXLruCxCQ++W05UEYI+gBxNJZk8eVwZYE1yfDCJEOj8zKz3I@vger.kernel.org, AJvYcCXjzZ9E6914kK+zR8mzPe4a0EefVuoQGj46RS78wTQTWL2wmnBuhgdggzlzU3muY3jYw9r6TL5MBuuX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2qK/kdnhu827RB4PtmBKm0uIKVYiLLYyf8BpE99Y79cQVhTxL
	Bpie+KwZby14WtCgo9zn4gliFT38gwvdQfuDmcOtjDo29gO6fSN1XpIElw==
X-Gm-Gg: ASbGncs0MtNI/Z4JtQglnaZSJhsrdpELsPtSPiPrICEFC7SsyVoMyRIrFVk3K9/rz2/
	60snzpe4f8Ys174Y3q7yMpea1IPrxBH3rrrGdcbo5EEIB1yRIICWj7uaEzRTPT/dugyy5e8bmLv
	kRiFvdQSnlFglpbVGian15vlHRuOI3KDS6uIMhr4gjSZQV3NZjIZXMq4AFw9GaS6NxBYE6teYh/
	tvbq0SkFDFk9zB7ek0jwdTa8PzofHw8hkGMyyoAr6yTHjMpNiKZfmQRTODwpxLxVSmtU5J7fKZk
	up/CoECPBs1ivXYrhANKR+Hyjtid2iHUJNRm8cW4BdhZh7KTZW/uJ9FAKNAeUCJA+GI69ngs/6R
	iU3qh/sXoUgw0fxJh6Lar0/Z0IqL9TvoZXidswQ==
X-Google-Smtp-Source: AGHT+IFZpdNpzgDNCCYdJwtqu9K9pEOb9S3Pi3mdEpAsRm6Rul1XB31z6qeBSlh9ylWDVCaBdCC4VQ==
X-Received: by 2002:a17:903:990:b0:223:517c:bfa1 with SMTP id d9443c01a7336-22e5ece3fe1mr50812985ad.38.1746625910654;
        Wed, 07 May 2025 06:51:50 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e97eesm94163495ad.71.2025.05.07.06.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:51:49 -0700 (PDT)
Date: Wed, 7 May 2025 15:51:38 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Convert arm,sbsa-uart to DT schema
Message-ID: <jnacngndarw4hsjy3r7r7gksxser65uwuznwgywf3woofa6xch@q7llf3x2egqy>
References: <20250506220016.2545637-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bvuag6cniewn6z7a"
Content-Disposition: inline
In-Reply-To: <20250506220016.2545637-1-robh@kernel.org>


--bvuag6cniewn6z7a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: serial: Convert arm,sbsa-uart to DT schema
MIME-Version: 1.0

On Tue, May 06, 2025 at 05:00:15PM -0500, Rob Herring (Arm) wrote:
> Convert the Arm SBSA UART binding to DT schema. It is a straight-forward
> conversion.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/serial/arm,sbsa-uart.yaml        | 38 +++++++++++++++++++
>  .../bindings/serial/arm_sbsa_uart.txt         | 10 -----
>  2 files changed, 38 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/arm,sbsa-uar=
t.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uar=
t.txt

Reviewed-by: Thierry Reding <treding@nvidia.com>

--bvuag6cniewn6z7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgbZWoACgkQ3SOs138+
s6G1/Q//Xf45F928Et50M8R8ozm9SUWkTSIoEGUsbVUOVT9o416eo+LyuZB6NOVF
Pg+a4gCY++YAyk2lXUQ7aPSbBX/sxsDOsDsNElfTlnDzX8cFXjz48DstgCgy8ec2
/8/0505Yf1OzYa9pbh1d/HhYeqQmb5b7K/LJwpgnU6Orp9XrB3u081OiYpATFWCd
X+lOsVcMPCNcbpqoEe4ruQB2ZAXrT1aXGzRAqCWOsVI090vSp/D5lWCfkNiDnZSf
mdPHAnSxjvkaTQ+2zdunKZanMrQy9jnxnAXZHJFVft0ttgdSOgFQ4++fDb9nSZHL
QzxN89y9u6E50FB83eFwuemy8ADb/ombS6D4/48dg6KK3nZIJlA4NfMEElYsyLVG
ECsdjBzBKGB9SLFvBzXfUAAbHbrdO64cYV1q4KP1tFDKGIvEXxCO3Wih/tnNerpY
SZlcPIwjW/iTXLZTXASuN2Iwpb35716Oj82EzGnYeQL23vJNXCtyyoMUUT6ZfIg5
ZvnVJTnw0YLiTWG/MV6hHU99yZnT/d7Nm/mqnajH7ifJHsBrJ+KWVGleUymZCwMd
7Ab5WkXA1iTe7/6gsaIpYVZHoYl/TVYVqLxELNLcBF5ZRwc4Xgg72ELzl7gf1p57
smMrg1caggeAnwyPoSmQdpYBMn/UEmNsOSLnu1/fyoUKaC5Cho0=
=IOpy
-----END PGP SIGNATURE-----

--bvuag6cniewn6z7a--
