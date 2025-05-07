Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C2E28A1E9;
	Wed,  7 May 2025 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626238; cv=none; b=Pg633T5UPhp2Eqz76QgAAhnxrNeVDG5NgSZeMJnc1N3oWu5hLhslwCYjDRUdHr3y6Eo6NnX07wijZd8vSbM8CnRWzUZ9bhpcZnYZEJgnc3FMR8hgvtJpUI0OymctqEaf2sZIQ1uRL+V93Rad/oE48dE8fxZ6EPy8r2Es5TTwn08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626238; c=relaxed/simple;
	bh=OKJfHPXBmdW8+xUfhGMLn1XI4KC9uUIa2ymmWXJpQi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKGoT6DyMvV0uodccvjeaExwgCsZoSjTMuCSS1l9PFv6e7XfOgZlj+tdhKjs9vgxVdUy0+orbbWsdvxoyxh3c9mU8oEREQBzFSiAgUaZc7vletdJqSpuaGs1XsmySWOyWDTsdNJCVyi6a8S/ZIbvkv6rdcIpH5AVgrYfqvkFzeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PydtdIcB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PydtdIcB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so59197185e9.1;
        Wed, 07 May 2025 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746626235; x=1747231035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVLLqnf2bJPOOCWqNSUchGPn67McCCi/UhhuQQXMf88=;
        b=PydtdIcBX1NhiHCZpZKNATbA3WdI9euZYGB7djX4KoIWJj9Rls6Nw9hsESp6TB52Ch
         q/O2jnzXCf1jLNlNiUIpRFyuyyIEOeZnvvWI5CbhR80V96EgC4Mj7aeJUrNyo4Lu1ZaJ
         0sQp39loKyWGSV0vcHcrEtR/N9VQrpHiEDQM1LyKsb9/8yzbA2VSFuNjutRwqLUl1aVz
         3b9oicsRdvgECDI+Gz+frd7ydJbgirLiK5NXKeLqLAXio4ngiRkdhmUBcGOaIsspYGSz
         82QMsQDFkunU2M7qu8NqCFnKQt7GWuQNV40pE2WrIuRs3fzrS0l3df+kq75DitHo0XO6
         lFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626235; x=1747231035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVLLqnf2bJPOOCWqNSUchGPn67McCCi/UhhuQQXMf88=;
        b=H9MPSQiVGct8c8aNsoZLwxh+pHopZ7yI3j2ayMhgplRLTpeCbBlnGsjFZcvMs2FgWj
         QVsFY/63YxwDqeqN3qIizb5RkINauPk9yyEypPa5uGY2wepajZ6iKAU4p/DzxsN6WHN+
         Diou17LrOnOStQel5EFWefFVnx8Cl0lJmYlmQA42PGcTxz0+F9KYLyYipPc3mp/op1G4
         +/F5KCT8gBrvP6MC4s8FUupQSXtMQZHrTQ0AUwmBdEM62arqlV6OB5iLxDS0GNRhGqqY
         IwlDT9nRGxTxkkQJtcHwSdsAWpzf/8xn71wP+YUoxi73iixyIKL+B8oXFdin+npwnwVd
         Ny6g==
X-Forwarded-Encrypted: i=1; AJvYcCU6GlZrNkhwkgoY+uc4aZ+hAF8oHcGw0CJ6VEToiRXW39RJEHGVhG8Vn+Kv+hcTZGfX68R0kQmnL5PSxQ2j@vger.kernel.org, AJvYcCXEqOgN68pMPT/+9ZoSZYu3J+mUJMlUZ21diko7kjYDgd0DtRa8mpMeXClVpk8NHZBcIsEoTW2CASN+@vger.kernel.org, AJvYcCXrHNqeXG+MKWjVxWOMObKq26r430aGoXm25HjvQ6OJnYwcOGoGNY1/XO5xTuj19VKkc/UryHQVaGxNSPiD@vger.kernel.org
X-Gm-Message-State: AOJu0YwinwDnXSJe9ocKW6zmAeO0j0aZY4S5lQRXKkFkXFH19i6akW9j
	0jaht83S/Qc7o2/t0H0NZUnZXFWuWyDrQM75WZ39yKjeUFnJYbQv
X-Gm-Gg: ASbGnctaktwva2k+X1rDddvGOKKHQ8TtYPuWfxvaG6C/6iPtrkZDxXiPPbRf46Vzocx
	stzgrBeJXnL7lGH5q65LRznWOwu+mx4Zs87L271NHruCcARu+ZJvxqdVfVlhWPI6PcVNvjcGguG
	ZKuPR/c8jRalh+nKnrOUkPCJ/aNRQpGb+7ZIydr4Cn52zPwQrQjCfdN2Ay3O7mAzhx4yVUbof22
	xD5pS3aDGE9W+qcOYQfROEpeyft4hhbY/eXzPplUYnvPZF0qnNcwecV7n6luraje9XQnMBGico1
	XGPZCLr3VijF1IIgezT+9VNkwE1+MMZLYLxlOlzJDL0xfLGbcrdAbsYlb01CVaErPcnlzoYXrqq
	UcRJmInV++1fSCudKNNaeshl2xXqsx3w/U7gbYQ==
X-Google-Smtp-Source: AGHT+IHO2frrcwS6w6CujoFa6sxVQ42LctJfbOrXd/uhQzNbEyXTh8MMSZGiJa06dRRr/eDgsHU7+g==
X-Received: by 2002:a05:600c:528c:b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-441d44e32cfmr32926485e9.31.1746626235177;
        Wed, 07 May 2025 06:57:15 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd34bd90sm1884605e9.21.2025.05.07.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:57:14 -0700 (PDT)
Date: Wed, 7 May 2025 15:57:12 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vineet Gupta <vgupta@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Convert snps,arc-uart to DT schema
Message-ID: <zmoa3kgn7p43d3knajjuhxchbfkiwqvogtwftjbvycwpwzaf33@m2ucrzrkiizu>
References: <20250506220008.2545296-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ombmyfmzkb4wzekx"
Content-Disposition: inline
In-Reply-To: <20250506220008.2545296-1-robh@kernel.org>


--ombmyfmzkb4wzekx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: serial: Convert snps,arc-uart to DT schema
MIME-Version: 1.0

On Tue, May 06, 2025 at 05:00:07PM -0500, Rob Herring (Arm) wrote:
> Convert the Synopsys ARC UART binding to DT schema. Drop the "aliases"
> portion which is not relevant to this schema.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/serial/arc-uart.txt   | 25 ---------
>  .../bindings/serial/snps,arc-uart.yaml        | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/arc-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/snps,arc-uar=
t.yaml

Reviewed-by: Thierry Reding <treding@nvidia.com>

--ombmyfmzkb4wzekx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgbZrgACgkQ3SOs138+
s6E5Hg//Qor9w0C8Esqv+qcvEEPqkmU5dkdX5OQefcsjCHVLLC7G7tiV/2GXo86d
DiE+KJWeEx738nFf5wdtY6rw5DHFhsdbPu0k+qW6PVB1c/MP4eg4x7ZroyZCX3/M
+bI8iSQ8rtoD39aKEqeTGFGjagZly/74qfjuLXKQPFAHSpzGQF8XBHYm3BhkYQqI
klPqIcDgvIB8lJbjYayDWH7GBgf9u19e5kJ1eGAaZ5LLyIgUaCFShTvap5ovz33K
mYNATBxx+v1JIiAXPyMopgnwCxt34IjL4FkoGhnesaekmOMhMw48uBmSgetzQ0Yc
c5TiSR0/ahQN0D3YnNVVHe2P1KOl2rzWSw3twVWMTxJF8T/BiKLqNscW3/bOVRXt
6QRjOEU2pjpE0B9GcQk56v8FLt7rPJWXGvMPzdgCiG8w0U82HpU51HmQk5/f8eW4
SmtI9fBoW9y7/A0rI3YNv9JyWPvpgzL5zId4Gd5fUtrV65M022uHlTfomAoPWit7
HPx2PHXSldt6hcb5nAQ3dSKvz0V1WpqovRk7jJR+W7f/gejbVOq4fZIV+J1z7umj
WusPhX1Pn0/o0ee3U5vOCwmHYpbDzvSUUsIWhGKfL4Cf2E3hr2LQ+Zfr4SKWF9IC
hmCeyxgeWmEkYci2tENgwsbNFLTupvtXBvki0y+ThOilzABWc+Y=
=hDGC
-----END PGP SIGNATURE-----

--ombmyfmzkb4wzekx--
