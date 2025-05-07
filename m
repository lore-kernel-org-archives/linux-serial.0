Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14291289E0F;
	Wed,  7 May 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626111; cv=none; b=k1B9FP41jfIdtX25yytiMBeq4gmf2C3KXLdxRJiWsw0FO/NS3zMAp1fds1478Ecug5qp+yu6658b0Yv29qOzcTHOESDLqSk6vPdr8oXTFuWklR5iJ2b2PfBh7OktMGK7QutQjgnz0lqlZdFEXYla3QKiTJNj3zoHvhr6AjO+MrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626111; c=relaxed/simple;
	bh=O3lK9O8MOlFJ22S3bVWYOt57Oo1oTISBPFrYqr8v6Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlLirb8R4MFyj+OVv6toidmSmMKYU3bVKGYscrBOMCs064xe8xVOq2eObMTqqe9KUPzh05DdvaupS4TMgTMLqLyGxgCxjrv6uH8CanYQI6vzobUpFF4EGclzHmMzUI5YG5cwo6jox5PclODXL737/chhdEbuN4tN3x58q09MsPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp3WBv+n; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp3WBv+n"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0618746bso50499465e9.2;
        Wed, 07 May 2025 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746626108; x=1747230908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WnTHQiWLUMQGeqv2NTcj6QDK3soHu+sTbr9U/eBZ7WI=;
        b=Fp3WBv+nRbIqIL44f+NIzZXi2hs9xo/bMqIhJzZWb04jp5Z5ME5YYtNOy5n3WM/D/u
         lqI3CDC8wz0tuzQ3Mm/T7bdObvQrsMk75yBgqJKCIbJQh3dq5Ao4AkmbvKeqn7URXOXD
         8klOlv6TXnyD06tXMjcEB+Tup9C4uK6UVFjyVVL3ri015V2zEkrOnlhAWy5Kpvplk8AE
         Gy/QQ5eQ3lcHHWgGSLYA5BdGxEWzTxURcH/eVbqglhwxjBS/E8Mdx4RpgBd68+QpL8Uo
         drmKgaUhvrbiYkeDnMR5m7/ADKnoH2ezl2YhaAY6K90u38VA4cPmVs+WgphVLSESQS5H
         Df0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626108; x=1747230908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnTHQiWLUMQGeqv2NTcj6QDK3soHu+sTbr9U/eBZ7WI=;
        b=bao5Z5hAKW2oKeRWH3luJ3ijpYNe8IqkGrz2OwnZHMRVed+ZmTRHDnQ87bE7c1lM1b
         fDv7oPTNyom88E55/Hu/zcYvnOBUNbkPCLgEKcq2vcHGnsm++YzIaZVDiJ8a1MwKhXTx
         BKNFh01Fu9UQjOUWdX5IIIiNPYqTfmRhXuhAyGgNDjNRBkE2szfS+hERuo7O2qg48nIw
         RbPae9WkSIiYx5k6JS1qEJP+MPVPfQsuocYznjRGpYLeENIsN7dZW6umG7dR6f/F0g+w
         tpqEc8vT9ZvtcPLkrZ7dXXDH1vcam7tU0+AIX0kRGMXNf9X4SpGv8Xn+ZaXME5yYeVfk
         +oGw==
X-Forwarded-Encrypted: i=1; AJvYcCUR/ID0Z02pSc+i8nC+rh9CeCprzU/Q8BCDsP0+9yvXdjsRCblm483vMVk3qPWxR+zUoqCDiW7lwJS5DUiU@vger.kernel.org, AJvYcCURvIVDwUeOvk+hv9lk/L73e98DaunHPt11Y6TJRnDwhbBW23vDbtxCU5UXlvYVQvqSrs7YQpxQ5MNS@vger.kernel.org, AJvYcCVzwB+ihvXeydkolXPfT9hReBIfgArS/eIn30FQc+1Bi+y3CrCRiSEUiWT46aYIMXSIgK+yZwBy8kP42J3z@vger.kernel.org
X-Gm-Message-State: AOJu0YzaMx5Xf9purJgHDfOaGRvXIhVcGb9YrsRMDZipgg8M18A/C3wG
	Px+TBnJUYkPlXm/btJrYME7RweJAJ4L/fvLBzG1uIcRzLRHozq2I
X-Gm-Gg: ASbGncvF2jAwdfmLx6flDSw4t0ViFRECZmniUAWS5ojrccx1RM8FPYqL+Vy1QehG5bA
	/+2GcEgW7GdcgQZmWsWhTqej+sBYMUv1NVC8rwlOLZvMHHnV/o1RUO4kKGrv73vQc6ABWex7B/N
	JXT+YT2yhVKXy/RaPopvLdJpJ0khTYQZmJXyx9CDufglsXEqKXbuPUABVhtUuGrnMds22lY7wAG
	EnFxU+UEvddRBo5DOXk0eAw2thbnStTTPEYtF6hBJkvimLNsfCrJP08dpwrhMjAhi0qWRgIqf2w
	RCbGs6Ttra7lSpTDvdWwyxBfSe9hb3Nlnve0pQEk2c7XYn0REczYkP4ARvfrUrMsWtZ6ntAVSOQ
	n/06Evq7uTrJr+BAq+B+Ds7JfkG0=
X-Google-Smtp-Source: AGHT+IEb3s5r0tzt4J13SHuTnyrUEEoizYd/G0Q4fUW6CsFjqN+mxH2wI6fI3XlsrrrqYAMtkKGuOw==
X-Received: by 2002:a05:600d:1b:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-442459df273mr20612315e9.11.1746626108099;
        Wed, 07 May 2025 06:55:08 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd35fb49sm1820095e9.28.2025.05.07.06.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:55:07 -0700 (PDT)
Date: Wed, 7 May 2025 15:55:05 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, John Crispin <john@phrozen.org>, 
	Songjun Wu <songjun.wu@linux.intel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Convert lantiq,asc to DT schema
Message-ID: <tr4jy53i53iiyzdznhtczy62vcqdrqhz5ncyw2rozwvdh4gs2h@yls6ovvkpqf2>
References: <20250506220029.2546179-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dlvhedjs2xvby25t"
Content-Disposition: inline
In-Reply-To: <20250506220029.2546179-1-robh@kernel.org>


--dlvhedjs2xvby25t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: serial: Convert lantiq,asc to DT schema
MIME-Version: 1.0

On Tue, May 06, 2025 at 05:00:28PM -0500, Rob Herring (Arm) wrote:
> Convert the Lantiq SoC ASC UART binding to DT schema. There are no such
> clock identifier defines nor a user with clocks, so drop the example
> with clocks.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/serial/lantiq,asc.yaml           | 56 +++++++++++++++++++
>  .../devicetree/bindings/serial/lantiq_asc.txt | 31 ----------
>  2 files changed, 56 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/lantiq,asc.y=
aml
>  delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.t=
xt

Reviewed-by: Thierry Reding <treding@nvidia.com>

--dlvhedjs2xvby25t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgbZjkACgkQ3SOs138+
s6FdGw//V8g7aZGNkt/SaLaEDGkgANm+T6HBw7ktIC/ewVKIe8aeZsPtMTUf8nwb
o5oZXCbcqiGdGw06UnNyVOBOd+2PIkJTs5rOMz5ZhLZ7rcqQi1OmK45FegKj64Im
RphFC816ZznMZaW0u7NsFpRdFJnse20Y/nPGywZ8BlotVpC19HqG7zZz+iG5eMaE
hozF54uidBXDzB8BvUdu1ug80vcmk8MfgQiI/S5/Ec2Ih1C4GFNO79j0PcuxAm99
eTQ0REUSmdKuEFnp1GAkq6rIIva6KdSNF4S1gL3sveD6UAhCGEoN+QvBfrLreJt9
hsjOqOyu2ia9eML0KSn2zMy7+SoU5OcNylqAeYC30PZsL8uOeN8Jw2RYeN9dHJQN
SMZikkWSOszba4pUjk+5b9t6G6vTChd5Gwk6Lf3lBHJ1lPUAW5hbVaHs7iGM84RN
PVU7u1nXjhpdppj4+cdnMatF+td/jHDcd1VGFgcph9N6aAwgGTt9gC/FRnHLBzKF
jsG2ZdyJaAVM3Mm6cMa9XF6q5EMdm7ns+OBfMVyf3SlYw/zFFZO1lSHDrGIr7KaT
PokYEQMAo9Mg56xAUlbH6ZSSvGOUJYPkXBlmcpyuLecW1hfD6voaEQJ5z0KplPD3
mgrnfLuClahfcMWrGthhZCFLZmQfh8IVwalujrczCLIVfdJEEGs=
=7lG2
-----END PGP SIGNATURE-----

--dlvhedjs2xvby25t--
