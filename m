Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94E7E9;
	Mon, 12 May 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065656; cv=none; b=ewA/G54JZRy6j4fVkhELI7cQUYkYMD9ChTRhN4XHb9EN7cIq/+saoh3OY/oI5Tg2ddEGw78TuvCtypWjRfuOjYgfO54oh6hq4giT5RWNxnCp7Ys1L29OgCG967/sJ4aRBr4bTKFI3ef51E20Vl98e60N3eSgqYUZioeTfnObI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065656; c=relaxed/simple;
	bh=5ULX35j9SB3R6eiMUzUDP5ujKYpZ2GypHAV7cJiBd7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB5B6Plp0krcLMw7no1I58yDLuZeJNsHaprdYJxmf5X/CAdKvPNZQXGqRHYfvc2j6aYAwyxEbiBxu4RohbS7jP7oF4DeqM6gLXd84uOU+u2OIMr/Fhjv+mYjEwl7Ejg/cHQjPy9fkb8yPNnqeFJ407gglSjVO/SxJH2nyPMhTnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5DMF1CC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5DMF1CC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30853C4CEE7;
	Mon, 12 May 2025 16:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747065656;
	bh=5ULX35j9SB3R6eiMUzUDP5ujKYpZ2GypHAV7cJiBd7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5DMF1CCQwsfnuCZaPECRkzPsK/Ylv2qXn7ckN/KWEtDtYIrlbcOMYTq8jpsWcCVQ
	 tTfYxCeg0COyKSK1Wk/ihRFGbww2B4gp5WRNa4aaAxduRShX6TyZqZdh4mQPO4l6Gk
	 UTf/wOh/sVwG66z9zT+nlVfg7Y2PBtI2yLeVJl/SWjbvjWejrtfcpC/4fuz7fiK8F7
	 xR5MXrl4muuymo/c0jQeRjoUeVgWK8Q+uWXs2CgvbsQIFr4yHWEYKOH048D+e8twQS
	 Vm+oHutQCDbw5BPW/keHAd0aQPcyYL1/mJj8nFkI5/DzRpjzmDzKqwMT4M1DXfdmvq
	 LJTBcngtPWtbA==
Date: Mon, 12 May 2025 17:00:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Sirius Wang <sirius.wang@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wenst@chromium.org,
	xavier.chang@mediatek.com
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: Add compatible for MediaTek
 MT8189
Message-ID: <20250512-ferret-willed-348cdc19fe4e@spud>
References: <20250512115355.923342-1-sirius.wang@mediatek.com>
 <20250512115355.923342-2-sirius.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BrIJKWHwbpK/JFHA"
Content-Disposition: inline
In-Reply-To: <20250512115355.923342-2-sirius.wang@mediatek.com>


--BrIJKWHwbpK/JFHA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 07:53:48PM +0800, Sirius Wang wrote:
> This commit adds dt-binding documentation for the MediaTek MT8189
> reference board.
>=20
> Signed-off-by: Sirius Wang <sirius.wang@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index fa1646bc0bac..05e827076a7f 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -372,6 +372,10 @@ properties:
>            - enum:
>                - mediatek,mt8188-evb
>            - const: mediatek,mt8188
> +      - items:
> +          - enum:
> +              - mediatek,mt8189-evb
> +          - const: mediatek,mt8189
>        - description: Google Hayato
>          items:
>            - const: google,hayato-rev1
> --=20
> 2.45.2
>=20

--BrIJKWHwbpK/JFHA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCIbMgAKCRB4tDGHoIJi
0kTOAQDIrab/1dzT8IHi2s3bi/oJO11J04QcoOlpQG0eV2hgJwD/Xw8+792O52zo
lP7EobzCjq5NJW4XO0avY+MeprkoxA0=
=6Pyl
-----END PGP SIGNATURE-----

--BrIJKWHwbpK/JFHA--
