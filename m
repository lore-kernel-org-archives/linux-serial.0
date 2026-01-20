Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6A37A49D;
	Tue, 20 Jan 2026 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938571; cv=none; b=UlhmKkcUiT50XKjy61oE/iVzqnOKvLk2f8bBzScLHErnNnux1PaEri6KnN/GnHJ/Y6SDat1SWMuRan3hiag18nEKaBNrk+jEXpTi7idH64w+0CdW+3PgR/kFexOfBYIka3sRubUs6AgBcMR2z9d6aPFFNh7WtfsZy10uqb0UlS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938571; c=relaxed/simple;
	bh=mTot7Q38/x/8CwocVTc+5EvDGHnAEp5pvFVT9iyOkas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhptHp0lE45E0Qt45krvDcHs7hM6wgDntlf2sOVSIyzT6qKRv+Pov0+uuWsjS+/s+U5637S1ovXpUB45tx8L7X0pQTH8SPudjJplyfy9QBHTw87Sz0Ot5OEbNa0CjAPKYPOR4gvF3oR7jpYt/p0oswpqQJ4Z4jQJTy9dGvHIRH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osFQ5eCK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osFQ5eCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0022C16AAE;
	Tue, 20 Jan 2026 19:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768938570;
	bh=mTot7Q38/x/8CwocVTc+5EvDGHnAEp5pvFVT9iyOkas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=osFQ5eCK3StoflUWwK3eO/L6o5peJ/87hxkmpPq1Taj0yuvRw9CEZvqAFEzz2mmnF
	 x1v7YBw6xZFOTpGc+T3CwO5lYqsnMmEEJJd5Tw3WhpD134omJlccbuO5VxMhnJB2v9
	 BP37Kfw4uDRpjnOFiwQdghdXopeqjg5H4V+SaEgl58xfLMUbreDMK6Q+NCNBj3uFif
	 +F6ZedZmbVlgTNhUX1Mm66KPADirUsOIfqX3uI0sbCw2ws+kwDLVA44FUmLWJmxgQb
	 B4xYJ1FrJX+OxY8D2CYl8b8k6Xqw+Vn9ttdXipXABaJoxsojvEbCfakxOtp7GR5ClF
	 Nv/E50WF+u1vA==
Date: Tue, 20 Jan 2026 19:49:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 01/12] dt-bindings: serial: renesas,scif: Document RZ/G3L
 SoC
Message-ID: <20260120-unafraid-body-2c646dc099e1@spud>
References: <20260120125232.349708-1-biju.das.jz@bp.renesas.com>
 <20260120125232.349708-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cSz45uwo3ug8U7NN"
Content-Disposition: inline
In-Reply-To: <20260120125232.349708-2-biju.das.jz@bp.renesas.com>


--cSz45uwo3ug8U7NN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--cSz45uwo3ug8U7NN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaW/cRQAKCRB4tDGHoIJi
0h2wAPoDlwir2cqqcy5JC6EzOqPxRebGI8P5TO2bFnJOH3oABgEAivzSVJZsRTLw
snvtZewjdbAEhF5sF64LHT/dt1wawwQ=
=51aL
-----END PGP SIGNATURE-----

--cSz45uwo3ug8U7NN--
