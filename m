Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D828936E;
	Wed,  7 May 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626307; cv=none; b=dFDMY3lKqMcuYOWvqtMaMd5IeWMWk3NT+zoLkIsYJuUl0HjBH7RHtyAdqxARMc81J9QYIWjGGb+sZ8vdQBpkQkpJjO7NGH2mQ5rbAQj5+aQ/YJUpOmSDvzxXYfcT5SykMGHTYKLupu90DVisJO/M5lRdMge5dSL5ixsi5rksGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626307; c=relaxed/simple;
	bh=WFer8e0bFikfukjmXwGyg1ZGpzNoXKUjdhtAJDp1nzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3xcH0rmGedYOdXoJ8b5RXQqkEuC7x+q//CxIGLJ5JPP67I/cQxwsppWGVl9tVZw11Dpn5tzr8+364+11nayvt6z4Jh1K9IcrrgUmGAqTQd3dpV9gOSG+UbOV/rd3R/IDTdPhrO9jQQJZ0IcnqVrrkCKKsQ2qaUx1D8ZXPDRpKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=magUTuRh; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="magUTuRh"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a0adcc3e54so1165534f8f.1;
        Wed, 07 May 2025 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746626304; x=1747231104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpBOaKV+yyjzqRs1dDOpKMagpR3gaIT9d9jJ3WjXu5k=;
        b=magUTuRhaKRZOIKmjnpB2+R4/r1vVZvmGwDb3/n6PBv40LLzvtpMJj/72Uy02m4lau
         qjGr8dixZq3b3+7u4lxIbrYoCk+Nk/soBYzFF2d68HGBpRnMUa21fedgz7fHBbS6fjjT
         Uc9TP5kXnznAPjZ1FM8DSkaZ8Kh5NHRInHFLfPtMozFpUQ8KCAJTdQi6tfimxbs9fqqL
         4I8XU74fL6UdvZ449XQzbKQzzTuKs6mU2z1jdf4nMRi1L6sTHNzOzFaHA1kDENqL3RFe
         FUvZI45yASEmuWfbS5f43H+2i7bwtxhjiVQag9hBz0L0zzY4r24IIk2CYeT94uL6PgST
         E35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626304; x=1747231104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpBOaKV+yyjzqRs1dDOpKMagpR3gaIT9d9jJ3WjXu5k=;
        b=mgFVn6VNglOpzW7Z/5PKQh2xh4ORYwiwDiYIsfn32NrcxUusyLxHGzyBtDwq3cqacV
         ra8alNzKgU4rL3KmZGqdkBn9zvmx8KD0NAixytakDPEwwX9CXZGoHNSo9zBVBNhi2JDy
         vODSwf5d5w4dbJmG56AL39dkbYASeh6g46ObhiEme1i5HS/QoOBjI9Hz72QzY+bBRBS7
         yMAAgNkMHyd8ESJ9y0PQf3uj5F5oWSCXBNJelzS5GxMMhwSLP8obiVci79RnkBQA/Fy9
         SrYC28k3J11JeqQlMJ1GE8nPNtudErmy1rqm2WnUQY5V//FNBDw3rOoqkRO/DPnFjRS4
         vMJA==
X-Forwarded-Encrypted: i=1; AJvYcCV8byfJ+pQw4L6L3DMpg0EeIR1vTU2cVI2duQSelZ1hUDG5EYhQrN8ZnKQl84+MEN93BgFuvzgxk46IDPm1@vger.kernel.org, AJvYcCX7nIyiBW5yyMtTrnejwJqz0I53Hd5HniT7Agp6FVbR3uQvHvo5NKqDVSjlIvvITYI5XuFejlTxoDEXxTZB@vger.kernel.org, AJvYcCXzzWCWzdRXNeajeznbbaXvXaX1d2lCVexC01QcRREiCLQBKJVIlU5yNlTdUQKZPRDoWmwFhDM/t/3x@vger.kernel.org
X-Gm-Message-State: AOJu0YyehlFYVwBvJO1kAPo5nXIvDl6nBxdILZd1JuAdhI9OCUDFCFBr
	tUj+nXdtAeV0HHNKraAYDjmGW7FQcdzKa7j0WhC4GPD20oR13juuaixDaw==
X-Gm-Gg: ASbGnctAX9d6tCOn197CeqI9Q4v8aBhIzD8NkMrZBgZBzoNv6bmxLU7y1C3C8xTDeFf
	Ywn/VYvRq58kTd8ZZtys4/EnD0MicyOz/YYg3ET2t1Epp+yyviCy548ExHGYSMp2Bv/cFp+Dv4Q
	ChnpJzmMxoyieY4xjLOZ8nqjD+TSfn8Mlz3ye51DePfDqm6a3Sl77j5LspSg0AKBgCqJhf4/PJS
	9WehrKjC2LeDuPuVbkd0Dji0DCViU8zQcrZrWM+mPf9T3mn7iZ1UVMveCcH7z2uRmvMS8Mn1DBR
	ciafl3UGicqkLr7ifdOCf7IJH0DUJjToi7LJ9AduvD9AV8ShwKJRNv8ig50b/5oMU0WSA+uLO/v
	o0Se7qcTGyr/flXJ6vv+ajZfYIDQ=
X-Google-Smtp-Source: AGHT+IEE73NhNkRPDgIrsa2zntE0urmbFH7L73hnMkdy1TBZb0kNJDjkn9LP+dpojQJT9A7UbLLGFw==
X-Received: by 2002:a05:6000:1367:b0:3a0:b4f0:c84d with SMTP id ffacd0b85a97d-3a0b4f0c867mr2423476f8f.0.1746626303703;
        Wed, 07 May 2025 06:58:23 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0bb5sm16722021f8f.7.2025.05.07.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:58:22 -0700 (PDT)
Date: Wed, 7 May 2025 15:58:20 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Convert altr,juart-1.0 to DT schema
Message-ID: <q7lacaplecj6kjbatxiwh6sjhby5mhxzoowwhr6feza7iownt7@sej7agtylc7o>
References: <20250506215959.2544931-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f4b6bbsdc4dsnfyf"
Content-Disposition: inline
In-Reply-To: <20250506215959.2544931-1-robh@kernel.org>


--f4b6bbsdc4dsnfyf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: serial: Convert altr,juart-1.0 to DT schema
MIME-Version: 1.0

On Tue, May 06, 2025 at 04:59:58PM -0500, Rob Herring (Arm) wrote:
> Convert the Altera JTAG UART binding to DT schema. The "ALTR,juart-1.0"
> compatible has long been deprecated, so drop it.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/serial/altera_jtaguart.txt       |  5 -----
>  .../bindings/serial/altr,juart-1.0.yaml       | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 5 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/altera_jtagu=
art.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/altr,juart-1=
=2E0.yaml

Reviewed-by: Thierry Reding <treding@nvidia.com>

--f4b6bbsdc4dsnfyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgbZvwACgkQ3SOs138+
s6EaUw/+PFpKm217yyGnEEtkwhARJq1ODAIXlAzA9oOlrGF4OtXsfMxD1nbJYeL7
HPjJZUwaymepSChyDvLUxw3gCx0hYnNFkoPrywBvkawvOtrmIf33DBNfDyD8lZZM
LnwQQCS6UmSDX+lzFbLOI12qw+bnApMTTDIcbvZwSOY//OPXpGg8oejxViHm59h0
KNP1Ry6FTA+tLVRwsUWwW6wxizXXhX+7+LbnF2u5w8zdsJCbgklB/QZe+cbr+02s
Q1UAQRDYQ5EmGwWHCjrlgX8XSxJhThpXS2qP1t8z0b4FvG6eXtU3jvOQim4NMKqf
REMFWd2JPNF2PjoETb4QFfANPxyZJttWkhAC1zwmKwecvAf73PnmF/kKs6WBHivk
OHus2lttXKLoEFebPPFsHcq+Bfk1nmfyPaiOVReSeAQ8adYdVBu3Y4s/dn4N8ASp
x5iYnb9zRI6h+vWpz/UGpiAywfrRNWe7rDLypMoFtwG+o6VH6oxLpMoZObMk3WZF
a3meBfJgSLNG0P2xT8DmF9xvIxVKs4bdRWZ/nAMsHE0Y794VfG61pE7TWQ6wwEq/
FoiBsoEFJq/ZLbYC/r5sqO4Mv0ZPnEJv3VOisAS4cNuoSiVPcGRFn9XjTJU5sEE4
JGaSYV5EwqQj9bcwD7MU0NfKbZ2zcQTDYHpldmF0wj4JvxaWe0A=
=lzjv
-----END PGP SIGNATURE-----

--f4b6bbsdc4dsnfyf--
