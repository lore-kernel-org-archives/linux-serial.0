Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B417559;
	Wed,  5 Jun 2024 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606905; cv=none; b=seZEAW8a6LUueNBJvo6EIrrm7ut3MJd7tXX7bsvo2uB2E6I2lHZ3dOABEzMjYwGj4ixXzsJ6fNEb3jX1so+fLbojX6xdPlPqUzP9IXBPpy1nnePGpbc08SWsaxOyncshSrodBaz6olpzY8FeXr1CLZL+Xthbd0IRGQMlM/UXBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606905; c=relaxed/simple;
	bh=zCAN5fvV7sG+TBo7QjvDHZ1N+Q5/foWftqmae93zAu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO8cvrgb0vqMIfXtx2wCpTyTRi6/VT08YQA3nTY75T3Zjr5DAx1MqP0UbV/U8lamBwtOZKq6b2a4U7mKWMuIa298d6HsMPTWdfjSN8pGwt9m7kt/ktWcxbX1g8c0EOh0HU4b+Jln4tsubINTHSuLXNnwOSlb3GLzZnro8sbOyj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMVXVjue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMVXVjue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BE5C2BD11;
	Wed,  5 Jun 2024 17:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717606905;
	bh=zCAN5fvV7sG+TBo7QjvDHZ1N+Q5/foWftqmae93zAu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMVXVjuexfcZSyHxqtr1cu1NbAxWpdd5f2pgLM3J901K7EBR/QIUNRvX3EYy5zAP/
	 V6szEVh85JczRPq6EZS1PcEECSQvxB+J3lpOrOyQfc77moyXedzKsOzMMk9OmbmIYw
	 obkmtDM/8kPVjYCWTkzm5EJdggxPFsHGXI+uvheIS93y+AKXtpzbs7O5f2UO6JoH/F
	 xGS7Gwzz+FAHjoI2lgr7jGibGup1FAokBMAE/gvvlWkKVFjCYRpLgnz7t4J7qA2zzJ
	 hoHZu0I5QkYFzK8SFvfRsTXUrCvli7LPhSDIkifyXbLT1MgdlhyIhJRH/TybTcgSrD
	 vd71AsMjFK+sQ==
Date: Wed, 5 Jun 2024 18:01:40 +0100
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: serial: mediatek,uart: add MT7988
Message-ID: <20240605-luridness-spinach-361baff3266f@spud>
References: <20240605085433.26513-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qvD3WpJf0cT24KfH"
Content-Disposition: inline
In-Reply-To: <20240605085433.26513-1-zajec5@gmail.com>


--qvD3WpJf0cT24KfH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 10:54:32AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> Add compatible string for serial on MT7988 SoC.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Acked-by: Conor Dooley <conor.dooley@microchip.com>



--qvD3WpJf0cT24KfH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCZ9AAKCRB4tDGHoIJi
0q0iAPoDuLBzRzyjKeEDkDAevQJGAoIppk4kVDr53+/aFXCfDwD/alSAM+OD8lbR
hxxmPOADF69E/+HRKcGGDPwKRJyDWQk=
=taoy
-----END PGP SIGNATURE-----

--qvD3WpJf0cT24KfH--
