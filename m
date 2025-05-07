Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD328A406;
	Wed,  7 May 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626003; cv=none; b=TTEE57VIMyJEbi+wEKLgEncPmt9tyVRIf4fZerUaPr1+PW7W9Y//dTFF48HE9mb5DFUXEIdN9lWwonrlRxx5Fz+4GWY3k+B1XQNUe7QHCrcbodCDCGS+u39hjqWgzz0ncP4tScDiXBMqgUAng7HiQYmEkya38b1gU2ilcCXetco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626003; c=relaxed/simple;
	bh=lXxeYkSg9kC8tNdgmHD7yfjtQhf4M4m2tBHE3tRQMzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3xIoVNAB7BJCCrmGhF9yL4slL8TFYD8Fezo/MNuxkZWa6fPSqBgfpnhScoScglbcjLyc6sXIRxKJD1pqdEg0Ypl1gtv7qfBSLdBDRxEdy3KdECLt4AGCnwXA4/iduGbPn7SwFOUqAU4Oi/mnFmYpvHcj1zfFYxCkI0pRqKcu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoJ1/iy/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoJ1/iy/"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso670057f8f.1;
        Wed, 07 May 2025 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746626000; x=1747230800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8CKX5RtKDBhVUfuV7o6TJDYp+hkhEN8uz8LA3KQM/U=;
        b=JoJ1/iy/86vNMSXFtEWkJsJ1+EeT2n/PPa2rxZztm92mPzj9jvqVboZQAKWk5iSIPA
         lTNvMrJCZmGFfVrj9Aj1du+JaHAowQqV5mUtTaKQkSanabTS9tGhPNyhEkgQ6Vs3ldAu
         eorjSDx7CmvEXksr6CMJoQmV26yqMbPLqQ6HtuaHhCRcU9gx6QDbACk0dfYmNCu59j1c
         V0LuVWhwFt5PlRKQrTsxMtdlfKUNtvZp2ciXWEm6tsk9orInUB+4LwzD6spuWcsGJyh2
         vyLfo8LogqGjRw50b9q4cE08x2B/X2EBz02pNc7q3Ykg7R0/Xa6F3LRcejN12sTUukB0
         tEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626000; x=1747230800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8CKX5RtKDBhVUfuV7o6TJDYp+hkhEN8uz8LA3KQM/U=;
        b=glRgIjRqYmjF6tEZJwyk7IClsLd/yDK+igbRqnhIXDFXbLfCnTvPhCeV+R5d3Ex4bc
         IZ2gCSYYyRT+Hws9VQiFybNZfw2ebhdRQ3v2JhD5BXg5DzVSraWmDLt7P8JWXRAIqqXv
         dEoj5iiPKpdhXySi325vuca5xe4tSCn8bqKNmG9gCe6Dc3TkZYzb5gxcx+AJtYLLOtg2
         1ZNKx8a+B0EI3B0YYiVSbZTqxlNixdoy3Gncj4rLpVngP7poF30UscBZmE2MFp0zhwoh
         o9pZl8CKTwijgpADDub9V93QPEztmpQ1JIjxvaMuAx6S+0HGoNaQe3UlBIW4IGC8dGj7
         DeYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7uWfotVFsAftTPNh1rySDyac9OmOr7cWLa66JjOn85GzN+8IWWlydZPMAixH8/UbLbGUGVIAVTa8djCZu@vger.kernel.org, AJvYcCW61+vB0UszOX7eM5er9/lmzIpp+fK3D/iXMgeLbub7pIt3c9d3mjtSo8D56///TFBA+WvRDNnZ/w7d@vger.kernel.org, AJvYcCWwf8o03cZ6pK9y3Hd9HKpmaI5R/mko3jn/DCjV69+o9XLxtQ2Tj+292ai/3y25sc74eqUiVE8EVnEWVQ65@vger.kernel.org
X-Gm-Message-State: AOJu0YwyCcFVPo9G0l5YJ79mkAz9SZ8x+/A8Tms61doRjtLnSjQb8s+d
	n6Tbp775YlU11OYxfp1irsCL1urJG8lN/obwzTT1DYlhLOSZfE2v
X-Gm-Gg: ASbGncuDE0LQGgUctrV3f1WvCY6o+avX7rpvngD6pb/nco2OmFOWMWogHuz0a0rQrPA
	FerWKF4EBho+cfMybb3ocy1mnzRvtSKvk42cX16Qx2DcLaXv320BwJ6FKtyZSSGYPduZiFIQ/iN
	K1MVLA7a4/1y+3UiYvXawdpAInSXqj9MD6hwu1uAGDvaMbdM/Fcr/EzdDgXeUAIU8ndxyYn7S0H
	RZATMdpZ5R+L4alo55yYSN2qAw48d4paHstt75FlG5/kbF2sd+WR/iue3ru7/HfC9aydoSdvEKr
	wi86Y8VzAAPx2dBcIJPj0d1x41/S509hkjvSjplVMOQm+LXfvm6v40ds1MKk5Hsk8XOtNO1mPdC
	HFWpDRkuQMXe0xwW8RRXbVGN+f+s=
X-Google-Smtp-Source: AGHT+IGiZQCYB6NVFg9TXxSzOwjtnYqTmre5AXBjPdkm5XFgXjGxTjxB4v1QFfUbJ3UrvGM9ejoxSA==
X-Received: by 2002:a05:6000:2510:b0:3a0:b207:90c with SMTP id ffacd0b85a97d-3a0b53e9eb1mr2470130f8f.19.1746625999708;
        Wed, 07 May 2025 06:53:19 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3c49sm17293968f8f.39.2025.05.07.06.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:53:18 -0700 (PDT)
Date: Wed, 7 May 2025 15:53:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Taichi Sugaya <sugaya.taichi@socionext.com>, 
	Takao Orito <orito.takao@socionext.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: serial: Convert
 socionext,milbeaut-usio-uart to DT schema
Message-ID: <fdstwr7r6mbk23eumztvyt2br6kuec4mz52cezvbsseh6fq44f@bd37mbcznfv7>
References: <20250506220038.2546557-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jrzy6va6ji6o3orv"
Content-Disposition: inline
In-Reply-To: <20250506220038.2546557-1-robh@kernel.org>


--jrzy6va6ji6o3orv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: serial: Convert
 socionext,milbeaut-usio-uart to DT schema
MIME-Version: 1.0

On Tue, May 06, 2025 at 05:00:37PM -0500, Rob Herring (Arm) wrote:
> Convert the Socionext Milbeaut UART binding to DT schema. It is a
> straight-forward conversion.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/serial/milbeaut-uart.txt         | 21 -------
>  .../serial/socionext,milbeaut-usio-uart.yaml  | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uar=
t.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/socionext,mi=
lbeaut-usio-uart.yaml

Reviewed-by: Thierry Reding <treding@nvidia.com>

--jrzy6va6ji6o3orv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgbZcwACgkQ3SOs138+
s6HMCRAAmaBQl8RNi3nV8RVeUWOB2s6tsCICUsITP7eKVArNNB18n99307gQPh40
+f02OMvUsF486Mm+C/PoAfpi7v/ATcENRqoPRFiFqiZR7ZUC8IUVFNpehD02PD8Z
+0x6ZbwTKYmYvttqJpLFQe1f0OmVQx6laSCg796FpTla1dBQjCAsQtNgN3HF6ZU1
/+R8W+2lskoS1GOFHvjQcnVWyHCd+n8r4a5Hrq6dKoG3BVkBidnq0viKEdvJ+asl
+EvlOJpdzZbE2IvYAeZQj57eFZQUlaaL0JmLqp12a4A2qMPztsG0IcBSK7i3Ir1L
NXs22PgsKyQKjBdqB2G04mUZKH/A4hZ1ki3cjJ+BQ7c+JOtCzvyMbmLyIAAsICxa
bi1GWh1DdeYSbdFI0OMwWGQI2pbwrRWGlddm0cYoyp0L2qKp2CvXEkHqQWBJ6/O/
Ib/B39Zbu+VP2cZppAjMaohuVYak3nrYQ11A7vkhlVXWfhRwZj3YiJfWzK8Ys6tA
NpNpI83ZEUvMKzvea3Np+s3iIMmtIllOcIuocuSalV6psrR50vcD2w9YdBmr8KIq
FdW4a7OkbQXV0k/AU2JaWTo2/wFsJ2t2UO2CVJci+AYTRUYCclizJBBe9oispzbk
zmr1qhO0aRDfEi0i3MwOjicMrpyUs2DIpCh/iwU5CtNzSZRMA3o=
=S4E+
-----END PGP SIGNATURE-----

--jrzy6va6ji6o3orv--
