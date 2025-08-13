Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266A82820DA;
	Wed, 13 Aug 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755103843; cv=none; b=s4Iw+K/9AEXPEAkxSEFSCFRZboXcirRGTUj5j/SVL8ZU3bdOfcix9NGjyR/QRaLmM5kIiCe59a6sQcZCFVVEu0mNUB1P59PFEXkMgdZ85Jt2mxhHumf7+Jk17TZKtXIzlQfB98Gh7+PISz40Ba+FRh4Cl5CIdWBZWQR7B0HAccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755103843; c=relaxed/simple;
	bh=umOXwit7HPdgtpNai0nTQjZA862x6q+vZeNe21y//E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOp/H/vKOhPzlLnU/M7KcF3jSBnpRvDaj7Ha7diy/Ft1du3rRVYy2XcdDtqupDSs1id89EpWUtMdThVxl9ulp6kUFzSlHarX6SK34T11yJKwDT0RJn5Kyi7sIO9p9DsluVgI/qJ0bMT3sa7Jq1hoe2ygG9kTb2tahHbsy0iZOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAQQX0UR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAQQX0UR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCF5C4CEEB;
	Wed, 13 Aug 2025 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755103843;
	bh=umOXwit7HPdgtpNai0nTQjZA862x6q+vZeNe21y//E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAQQX0URqXwNQMry05zSHW6LAkUTTNSUlrvfCeJ98mGbcu4GZkzhYusG0v2etKCgc
	 AIrwuYRIZFqvNcvox0TtSHjLpLRmkDs2v3i93PvANAV/ogqTH1n4TSzRqCjS5AO5iD
	 HlWA0DNVAZOL7Ofa3zOo4oopTU2aiPjInv4g/GganJoAkEK7x8hHGRTPAPkBzmyE0O
	 j6WsmfWJdooLSJog5OHRiCMvS6VuCmiHCI9S9PTfRCmDbFd3tN1NncN8TvXfmegBeN
	 g04t+AN0mVzmrF13Motl0xh07Qaw73sWpvJAatt8qAqw8SkQZmDIlzsU4y/3L8yIjc
	 JyfGB1BChaJpA==
Date: Wed, 13 Aug 2025 17:50:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org, dlan@gentoo.org,
	lkundrak@v3.sk, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: 8250: move a constraint
Message-ID: <20250813-pelvis-undress-b2c4bbb1d814@spud>
References: <20250813032151.2330616-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4+YlI8SXROeMd4hi"
Content-Disposition: inline
In-Reply-To: <20250813032151.2330616-1-elder@riscstar.com>


--4+YlI8SXROeMd4hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:21:50PM -0500, Alex Elder wrote:
> A block that required a "spacemit,k1-uart" compatible node to
> specify two clocks was placed in the wrong spot in the binding.
> Conor Dooley pointed out it belongs earlier in the file, as part
> of the initial "allOf".
>=20
> Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional sec=
ond clock")
> Reported-by: Conor Dooley <conor@kernel.org>
> Closes: https://lore.kernel.org/lkml/20250729-reshuffle-contented-e6def76=
b540b@spud/
> Signed-off-by: Alex Elder <elder@riscstar.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--4+YlI8SXROeMd4hi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJzCXQAKCRB4tDGHoIJi
0gThAQCi1iV3SuPkecqRkGn5+WZqYG7Ill9PuYyIpNgLbYrr1AEAimZbtkYt4pa7
wWhXwjIqcs6KjT9DuXWGWB+Bk8dgJg4=
=5zk2
-----END PGP SIGNATURE-----

--4+YlI8SXROeMd4hi--
