Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C04F5E0F
	for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662458; cv=none; b=nUwufQedwFIPaxw5yDvKZEAMhwi+EZQOsN1KLydV+I3y/obAlrPki6lbghd3zui7WgsrK+UTur+V/c17+3cFS9x6g37tKX+Ilm+6+/PqxPQKWIMUFTimazXFjrzg136JXarH+o3jSKX/f0jwVDaBokZIPhBiHv7H5duvfO5D+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662458; c=relaxed/simple;
	bh=YuW/qSaiI70IBXqZyJaLO/EVx1RK7sFF+wUOGjbrEzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGfwRH3tnUCQSG0FYloxYxn1el3B4yynyGMONHoSAQk00vU1dRK/WbYMtvfrZXB22nKRhIeCTOvL47I8BbQZUUia7g1aTFXZiyeIuYM4AEjfgv8LVWi3XE9GIj9FSQTHwAqFqjpj0jAhJXLmdrSrn1SIp/FmT9H4gZTmgfTcE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=e2JHUKY6; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="e2JHUKY6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=YuW/
	qSaiI70IBXqZyJaLO/EVx1RK7sFF+wUOGjbrEzs=; b=e2JHUKY6DqJpsgzMdTpY
	bd0S09/vWVuT/iNWqfiWST23XsBGELgvdFvTOhQJY8w8wlQuPXqHczqIjvN/5EmW
	s+U1i7AaNZTRuYVq5TsGgnsFZ6HF4/FTs1v1iH3G7c2VhXJc50fv/5ac0wz8jyZR
	0NtdHq3Zhk0PTFPkXawUBtpcVRS/O5g4GqJ+vUMa8bTC8ZEKkz5Sx0LUZMbB9iAb
	rxdalJDma4YGgPxwF/nwBKyahaJaLCje/eLBEf4WIqV5KEYQPl/FRTWFIdhs+VbL
	/HQ6yj2JL19v2VSln5AotqylXqfYwo+ZCZvI/KG748WT1sAL1F+BQvJg7oWhvNmJ
	mg==
Received: (qmail 2109676 invoked from network); 17 Sep 2026 18:27:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Sep 2026 18:27:33 +0200
X-UD-Smtp-Session: l3s3148p1@jTvLQrBbkKoujnsL
Date: Thu, 17 Sep 2026 18:27:33 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Increase number of
 DMA channels to 6
Message-ID: <aqwU9Wux1nvnp_Gi@shikoro>
References: <4d6e5ac045af387dde8ef3810ce08c7cb079fc29.1789653872.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E/ewsyVISeEEMbNv"
Content-Disposition: inline
In-Reply-To: <4d6e5ac045af387dde8ef3810ce08c7cb079fc29.1789653872.git.geert@linux-m68k.org>

--E/ewsyVISeEEMbNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 04:06:50PM +0200, Geert Uytterhoeven wrote:
> On R-Car X5H, SCIF serial interfaces are wired to three DMACs, hence
> referring to up to six DMA channels.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--E/ewsyVISeEEMbNv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqsFPUACgkQFA3kzBSg
KbbhOhAAnixzdi3pqYX9P8oYLP/f7CmIdtjkNs/JAJ+1hFM6LVexIsdevW0MgWT/
FKRfm5dpgQIqXLxiDqhT6FFHovBP1MCB0QJOzBlXrdItviiZ1J7SFEJERzhBRREQ
tEkEkahHGD+D9/Q6lAVupPtnFpY0E2kt/QkLelv1dNIqTPRRPujuH0LyKDA3JSz8
LFxdJu8jwICHdyw+bMWfOVyBDW3U0cnoNEUl+DIRTa50rs/VG5ZJD832A+qgYfi2
UgwV8AqtyoohR7neAUodUvKZ2tORG0hpZS0W0dlhbdeELM2dls++qFJZyTKU2k3o
AJqgU5cwmNfjUX4SrLgUr1RbeU7eT2ovGbtSZc3MvckkErbz6cHrzvblarksCZgk
zYT3RUasEbjEJg0HegtX8jJSTK+hdjN+e5oy1ZPcEqPDVi1GvUGenWLlOAkSuFCd
LlhqVDcUrwtFwo46yWQWBzMzuxGBS4xyyBgENrf3w/gRHzh9RCryUpXCCOhXrbrx
3qzTRfsBRGz5FL8Ko4a/XIPl4mXAElp/LGAdXV7qxnxq+5SFwjl5QEt3oJOsmwxm
sRTa7lo1dLw6ICz2z8uvEHEDNl1e3FknV0wJVH4NwAoazpPp1Q3vzt+dWlYQZmqB
whTnCoQeOskqjBS1cK/+/NoAFmi+YlMa56L9LxGog70bm/syngM=
=uT63
-----END PGP SIGNATURE-----

--E/ewsyVISeEEMbNv--
