Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12AA26462C;
	Mon, 10 Feb 2025 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222399; cv=none; b=Euh5iSn6G+qU6cwBIir1CK34+vee91fPm8AXx1Sf+D0uOb2IIAl+cTL5bFL+gH0WfqERgaosfc4V5Q9sXvkmjFIpmyLsecMJIRlF7ZT1lMAoacGw86CNuIPRPq64EnVS5tGz+GC0V4uwZmMaj4uR9VeXHMgaLdu3GA94AlWcZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222399; c=relaxed/simple;
	bh=ehNFSX8mn6MN/slaTYKEJU4tV0v3zFtf6nQm4BF3jYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYV8qK+jK3cB7NjTve2aewbg0+i3G1ai5wMsfUt2EaqUU7v4LTCgbiCzXv9rVlGNU6X2DScD3WlejmYzrf7VqUrESoTxc77kF9WbkP6Bih+5XqaOHa52kQYho0GmC/mlaKpHq8WTwUn3RKqLfuuVfOSwX+NeKBCNOXU+530FaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRtewqEL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRtewqEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B12C4CED1;
	Mon, 10 Feb 2025 21:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739222399;
	bh=ehNFSX8mn6MN/slaTYKEJU4tV0v3zFtf6nQm4BF3jYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRtewqELhLtyiF4+WLJhc16NbS/9H6LxWosQxVN4yDaXw/Qapsk1mKTc3V8950af8
	 MzlOzTyQ/qzYS76nE6rMbIiAEsyuzssEogO5cHtbrgG5wMwbQRvZtWzlgz2dZdb8uX
	 OI3g+gdPmDupG45Y7il/SnOtetGMjy8av3HUl/9w4hzs7uxm9EuXrlLFM+sW21X6hf
	 +mpQAjkwCJWMbKmWhE9TBApgHW0a16MliU8csuwbvRhnuxCGYfDgBvVAT9hrLNkGCi
	 +H4XOHujm3SSGskS/49yPIuqQVV6qLSollmSX8YweCyS3RCKxOyygwBDXmrb4riXt8
	 TKFGq8NqlueLA==
Date: Mon, 10 Feb 2025 21:19:54 +0000
From: Conor Dooley <conor@kernel.org>
To: j.ne@posteo.net
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Allow fsl,ns16550 with broken FIFOs
Message-ID: <20250210-impish-payable-857c6337fc98@spud>
References: <20250209-uartfifo-v1-1-501a510a5f07@posteo.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TXn/W+h467QUJd1p"
Content-Disposition: inline
In-Reply-To: <20250209-uartfifo-v1-1-501a510a5f07@posteo.net>


--TXn/W+h467QUJd1p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 11:13:40PM +0100, J. Neusch=E4fer via B4 Relay wrot=
e:
> From: "J. Neusch=E4fer" <j.ne@posteo.net>
>=20
> While testing on a Freescale MPC8314E board, I noticed that changing
> the UART compatible string from ns16550 to ns16550a breaks the output,
> suggesting that the FIFOs don't work correctly. To accommodate this
> fact, move the definition of fsl,ns16550 to the section of 8250.yaml
> that allows broken FIFOs.
>=20
> Signed-off-by: J. Neusch=E4fer <j.ne@posteo.net>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--TXn/W+h467QUJd1p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6ptegAKCRB4tDGHoIJi
0lZ/AP9PZ+WvqClKs0XIgnC8O9bm7dV1DQ4xEYVLsnqVwZhDAgD/SFZ1+hMnkBKX
N7MUBOcomYb3LaB6MmiUulTOijWWkQU=
=FgM+
-----END PGP SIGNATURE-----

--TXn/W+h467QUJd1p--
