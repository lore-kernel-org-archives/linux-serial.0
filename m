Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E110D288C31;
	Wed,  7 May 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626280; cv=none; b=t5fvOtkAlj87NVcaRewgb2L3938CPx9kTnN57zJeN75mWT9jiRfFp6vc7HEMId+2t2UHVAb5NBwOiyYqDTWu00ZmeZ9No6hM7XY5bdDpGRZ3rUE6JTxMLaSDJaxP8MqDFGVcVypIiNLyXpdCCpLDnkf4goSdrjinE92O4sR8CPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626280; c=relaxed/simple;
	bh=v2YZAnQ6mzyd3RhSYvFfSGNiKE5ntzczrHy/2pnalWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD5u3JTsoxOhbjr8yGs38g0oLdGuZ0I636mGRZ6wKblpVfZpH7hKmiujmx20lVUdy5dZpgZRcShQxkbrb7G1ZFHxyNUqwsl54SmHwS3objYVguuwvlOsV5257cDDzKGLUImECmahnqIu4Zr9OAroJLrnSz1wUr7Ggyn2CkOpgKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQrpxu3i; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQrpxu3i"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a07a7b517dso4622371f8f.3;
        Wed, 07 May 2025 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746626277; x=1747231077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8PvDKbve9DY0ro7NE6c3wM/VQ78tPxIbjWRBtYI55dY=;
        b=KQrpxu3iX+qcwptEa5VNV/h8buonTapwWVxGp650tJ8vEP5vD5PpH7wm9avF3jW/9D
         1J/45Q17Y/6VtdqsTcikn6mm6N5d/MMQao0mSEw+RRf5jHyP4MtaOPJnWJkI4oOEKfFq
         IdDXY4Jn9K3aoIVptQSFyoGc0PQLdeem0xNDIwxfOnQOICARQZOd+JJER03RFvaXuVkI
         9MjMTynYhIbY5Dtpl+5/5HhqfsZSNM66yjUPCNEOq2fYetj0/7UQNr4tCdcIcjIWArUI
         A6FcZ6xbWNg75b1qRaH271jSduLZe4tAABlMfR2oqvhU+k6WvsIMHunD/rsIrFY9eR9y
         HJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626277; x=1747231077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PvDKbve9DY0ro7NE6c3wM/VQ78tPxIbjWRBtYI55dY=;
        b=goPuZp+3r/vg/8yJrdgkLXwGmz/Pn07+n2xDlORKVn0e7kVIWHtb37hTzLJ9uHL6+0
         aOTxoTQ1oMstmkFOvKV6GDqPhe9PybMNHLwYAPfNd4zA1px/W4de3ddSHfoO9IvNGJyy
         xT8tsXfWRYAmWRZfamHIO1P8VOnL9opo+6KqrhhXlO4XnbYWU/anrpY2+lWhwVLhC36L
         fDAyndoz2u2QT3dax8fsO7+uzGSogpZwNwI5kP8K9ZxBpuKh2VIwZpRQ3eDX/vzDUSwo
         MPJAyh7MOtc1OXRpDSruPAOVT2ySUiEPZH1JtAj3RB2Xnvr5IoZ50WcnBbfPmtzaR5p/
         r8fg==
X-Forwarded-Encrypted: i=1; AJvYcCURAAH5YhpaZIr4pPMn5xC9lG4P2/ffAKcEdE8XDOrPoEmGA3M5rH/sbe2kA+mXfs0RVOt+59tin6fp@vger.kernel.org, AJvYcCVfttl3N4qYBUn7IINgXwp+JVtcYwCkyKLdcakROC3xBmBsuLdQejUTwBonniPMyaD7PFUd/dvdAubDALpU@vger.kernel.org, AJvYcCXSJa3F3EtcAlmYuidJdRSlhyPknMfkeqie4lclb5KlO/ff6Lngq1q4lLb2RHdtsrh7ppF22cl2BRyaRx8v@vger.kernel.org
X-Gm-Message-State: AOJu0YwP1CCjIICp+VNLQKLDtd7VOM0Qu4LhnXmzLjgOB8xHlrhR/apH
	OIDo0//BAIdUDrY2BFfQvCR2jmQ49rweTztwAc9BNOU38gJtFhqa
X-Gm-Gg: ASbGncv9HYRFkC63SfRTDCWUH95Z4OJD3Taq/9sDwgRUTGtEfKROb1vvduCrdbdP39O
	SKSJKiyeR9wGSEh/GSb2UAKbml/SA6VfM1rRXM0p4yYX+dEfAjVK2DrNU0zWx0mafQRSTx0rxkF
	3WB4PYYEEWJdvAEmNGuolNV48QBUUlnGBwY6T0XMO15mS68blmTcJRBG51gYCQ7LFZ4a6lUccAb
	+cx3CWW0yL4EwbSat0B50GrRJbzeRTpj71KZQRLDkpc0gX11c6scyuQ0c1HwaTG4a+oFxcAl8Xd
	2CToXmadZO1Gli+Y+yiVLPsR0Zaw6pR1vU7ALyc9/1KwUpUZCuuBYc9q9C0MzKmCu6FxxL9yZpp
	MY3bdnFUl2VtDmIUcKie+wyzZ50c=
X-Google-Smtp-Source: AGHT+IEyR9v5/hav6idDtHtRxHVUg4eeq6IwCtJsmBhUB6XloihntpJoDqY+J63B4HKXklPt2EqdiA==
X-Received: by 2002:a5d:5988:0:b0:390:e62e:f31f with SMTP id ffacd0b85a97d-3a0b49ac670mr2825211f8f.3.1746626276902;
        Wed, 07 May 2025 06:57:56 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd2b3be5sm2382145e9.0.2025.05.07.06.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:57:55 -0700 (PDT)
Date: Wed, 7 May 2025 15:57:54 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Convert altr,uart-1.0 to DT schema
Message-ID: <iho2rdfchvjiklvlmk3pkutlsfkqzq6gbhp74vp6qc4tpjmsov@zm25az63lrlc>
References: <20250506220004.2545130-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xugp545vgutldllo"
Content-Disposition: inline
In-Reply-To: <20250506220004.2545130-1-robh@kernel.org>


--xugp545vgutldllo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: serial: Convert altr,uart-1.0 to DT schema
MIME-Version: 1.0

On Tue, May 06, 2025 at 05:00:03PM -0500, Rob Herring (Arm) wrote:
> Convert the Altera JTAG UART binding to DT schema. The "ALTR,uart-1.0"
> compatible has long been deprecated, so drop it.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/serial/altera_uart.txt           |  8 ------
>  .../bindings/serial/altr,uart-1.0.yaml        | 25 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 8 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/altera_uart.=
txt
>  create mode 100644 Documentation/devicetree/bindings/serial/altr,uart-1.=
0.yaml

Reviewed-by: Thierry Reding <treding@nvidia.com>

--xugp545vgutldllo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgbZuEACgkQ3SOs138+
s6Gs+BAAgBhcamvoo3Ua6l8FY6ad+AeNc0sSlgRsdw65m92OKWzDOH1tGeSzVTvK
qesY/2arRQi8vDA2vE426BPwjILuP8j04eocQeNykxv38bKyo/f0WwsRXqLTMXzJ
xtkg+gqIK3QwTpbB+OBgW12LONLlRUnf5CALIsyuUDwrv1+MzudnzaFAk9PJuRTe
h49hFze7BgUJj5I+QhxbkapxFtCBnWGuQYpB8aU1Jd/cKto6wfCjySK/2rs9oiWE
+SQkcNP0Lqjkk4S34UMUElDdjwjkeTh16aQMzFGat3GEXxyDpw+xZxqK/qJXC0jj
HWZTvtjERmrkfW+w6hqpVi/3WIcLGv1FcYEryai7rvdTU936JPv4uwLR5rTPzzk1
feRem6cmVwa5cI6/kw+OjuLR1v5NW6E6z1YLOlacZpcxA1tsFpL0vpaOAiF0UFT+
zfdho1qh7qpyczM4MSYwRB8iSNf/jZgtzZcfb4cvyU2KX8ZwHj9KzgGCTVSbVkgg
InovMxJRWcQT2RIARWOWfDvb4G4tKf3Dxw0lQTeaCvj1zepfxSzwXZ4rUCOnlv4e
IvaaEEyhPHZXFrqkgxJqg7As2E8/5pvNPenIelm89kYtB+HxHt16hCwrmSwOH16g
b9t2G97T3kd+VXVLxjmB0GR7vtiq9eQYUlZo6nlsv5H6P5MyRk0=
=nrE3
-----END PGP SIGNATURE-----

--xugp545vgutldllo--
