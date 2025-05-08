Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE28460;
	Thu,  8 May 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715735; cv=none; b=k+ePxRzaTpuv9T7G5ZsXcKGAiIWR91hAtJ0vn+HE8IL8ZuxVIlLSm3M8Ut/ACtWzelovGyYDhYQvTqcJUi41teAOTY1IKyPo2N/tJFmKUn9MJJe0Fxa8iDhJtzw7gwelR3KnfCt1Uc0v2QOjiI+I+u2o3drv0rHwDJak4DEOiGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715735; c=relaxed/simple;
	bh=0Drowwhz676AU4fo5WHa7IssF83cJ85LmVhU3lcAd78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEBRhdtvs1PwbBNuRhSliPSBJKQfdxrrx77w7+IWFu2Uep3e7qiFNr4UqHO2g/hdeKPIJSH5zKqCsanpW8yMWE5I6nX78qDBeau1w4f9/oxPfKgRvg7/vnrf/nq8O9AJLTG7M+VkSIdVxTNDo1CwB0mI5s2M7nbSSn5AT5Ni+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHKA3SDn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHKA3SDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA04BC4CEE7;
	Thu,  8 May 2025 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746715734;
	bh=0Drowwhz676AU4fo5WHa7IssF83cJ85LmVhU3lcAd78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHKA3SDnK2Nsa+9kO+2+ccSSrr83mCjYDv5m3fQw2npddWiC6YUJDZ1On1b79OGMo
	 nVZCWcwHNO88htlv7HDMlDuNudj/iQD9HZzSfFauEEc+ixQtE3jlKczr1+UfBDuAbi
	 ELzqbfkphJ73EfLc6AshZCJaEFee7JO9PItQGXeEuvhAi85+niAl0cGYUkYZni0AUH
	 AsplfopCzi+GkKhlf6JCrwrMTNZNseBTcDPwnKht6u5p6ivdOVJBm/aWGoFrIqPM6G
	 uBO8c0r3cNnpQ04G4adKFW+tzvd2VI8HF+uWL/JRaB/FMgUk9Vtmv7Aw0kjz2oGCVb
	 3ciLI0hsBjH8A==
Date: Thu, 8 May 2025 15:48:49 +0100
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
Subject: Re: [PATCH v2 2/3] dt-bindings: serial: mediatek,uart: Add
 compatible for MT8189
Message-ID: <20250508-kisser-kiln-647bbdeb7e29@spud>
References: <20250508063546.289115-1-sirius.wang@mediatek.com>
 <20250508063546.289115-3-sirius.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WfsJMtbABQGTO6qR"
Content-Disposition: inline
In-Reply-To: <20250508063546.289115-3-sirius.wang@mediatek.com>


--WfsJMtbABQGTO6qR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 02:35:41PM +0800, Sirius Wang wrote:
> Add compatible string for serial on MT8189 SoC.
>=20
> Signed-off-by: Sirius Wang <sirius.wang@mediatek.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--WfsJMtbABQGTO6qR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBzEUQAKCRB4tDGHoIJi
0nd7APkB6knx0CdiMImQ9VIt/mR5kLfe5LYFeudFrOjNwFttrgD9HNC9zC6M2rIX
AFFQ94oDHrxCJyRP5Yqjbq9t5zq6uwI=
=wdAJ
-----END PGP SIGNATURE-----

--WfsJMtbABQGTO6qR--
