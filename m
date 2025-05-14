Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89E1CCEC8;
	Wed, 14 May 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235597; cv=none; b=qUzwdQkeDcPVqIPNFUaCQPBR058c6v3WmCuLFIcvZmbUev12b7DNkZSw7JPTaZEg9Q2Ngz8aShIejhSQt56BUod4ikhmtZLFtUzi9P3cvr0z4SHl5h33fedfyW9Qk73wNxF9B7OUzD6Xaa2SmON4anPYrBENq6lMA4XXtqzdhp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235597; c=relaxed/simple;
	bh=zl1v2/H8k3D/FXnW1CQclEtA4Ko7M2htdDPX310mlo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apYdY0YxvkTqNdzJvs47VkQb9s+iRV20uzas99vrfDk5N6Iys2KBbSufIHdlS1ie/8AIxK8fy+YEG/5dBRH9rOvom1EoX42cO6l8y84+BUMDspU6Pl/HkDWIhQpEtMDasKwZ+uh5Qiuu0y0YOB/Yce4oNRcInN60J4eMY+qIRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4FbyPXi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4FbyPXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE76C4CEF2;
	Wed, 14 May 2025 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747235594;
	bh=zl1v2/H8k3D/FXnW1CQclEtA4Ko7M2htdDPX310mlo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4FbyPXizKjf+NfhU7WzSzSeymdkxvC70N38Mad+D9ASehRtQCQoANcv7MkmVR/yD
	 Qurg6HthadcCUzvFBij2Ri8zd4uIO0O3yqU4ZxOAGb6XophzdFY/9rlBWP5eDWl0aW
	 uUZJnLCrkRXXQHFDzIgFHNf4o9yXLrs6f0D+dxX9d9gBDlkqE0uA2GMLXVbDVfjutC
	 92atqQwBJXlz5u4RKcvGCbXBGxapoTu53d2vB8LZXmV6Ea2mpjSiAsKRc6nV4Zm1DR
	 17kLsyEH/LWj73S4QLPjv29RpAPTr/FowKFGjOoj++dSv+gPv4ODHhHngDst2pIPAY
	 d8xaL3Ct55x2g==
Date: Wed, 14 May 2025 16:13:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: 8250_omap: Drop redundant properties
Message-ID: <20250514-another-throwback-108b3bf064c7@spud>
References: <20250514125127.56149-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9O0NV7Ef4FXQKc2E"
Content-Disposition: inline
In-Reply-To: <20250514125127.56149-2-krzysztof.kozlowski@linaro.org>


--9O0NV7Ef4FXQKc2E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 02:51:28PM +0200, Krzysztof Kozlowski wrote:
> The binding references in-kernel serial.yaml, so there is no need to
> explicitly list its properties.  Note that rts-gpio is also redundant
> because DTS should be simply converted to -gpios variants.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--9O0NV7Ef4FXQKc2E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCSzBQAKCRB4tDGHoIJi
0n7zAP9L3esjpVqmnG0odaxWLue9KHi/yVAJWyHPmZGEucUD7AD/aO14rH/2FryA
wCz6d5lQ7HQz/+5+23K0AjYjZ6n+MgM=
=gmfl
-----END PGP SIGNATURE-----

--9O0NV7Ef4FXQKc2E--
