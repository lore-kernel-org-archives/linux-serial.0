Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C4727BF79;
	Tue, 27 May 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359456; cv=none; b=Vof+k4hLkpHfYtW8foMM3cAH1wqo6daxZtV37wrGRZIUMKj/sFAY7JmnR+OjEfSS/yX39SOKlqBANmqOT60nbl2b4v+YWJz3TkUALwJ8e2fKFlHDabKx+h0MH+g97ANEkQnIJvTfhmqrTgeCZGNXb3T6hOqvQyBhzmd+Lko8/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359456; c=relaxed/simple;
	bh=Jq9ajyv9ughoXp0jWZNfxwybF1kcZBgKEBJR1MQvOSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpO7opj2tw52Oq5IT01SeZdTPbNuvJu7Ixs+Sjcum1fu6GF/apSYPN9nMkeNhEd2tIChTj4XjSgnXy7MuefhANj1/Zcfdqg3oR78FnuQH3GAPLiDqdf1+piWBQsFSUpl7T0EgMivSssBbwggaY92wqtsq8xZJg+vT+ycMdGevLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GORHm5np; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GORHm5np"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9070C4CEE9;
	Tue, 27 May 2025 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748359455;
	bh=Jq9ajyv9ughoXp0jWZNfxwybF1kcZBgKEBJR1MQvOSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GORHm5npqCRaGqtqDNSngOgxQQvcRBtnb6udvxkCumQvY8YXWsfXUmoSnt6RDUn+q
	 ZYEYMGoUmmVer3LeEav2HLfPQ8RsEmUPcZhAg3aogkB28iN19nncvVK2r2wSOFp6Ya
	 VsEBBenQZW1/KI/0YygpTEPgG0GPjSV4puXKSg8NrM5rWJXaXLlbDGVc9NVU8Ld0AC
	 WTvyODCpa/ijFFg9gxu74a8sdw16p1MKhGoBVrvxgPDIecxREtnQh1LcrHCJQTqhgw
	 e92SeCStxlfOMU2rcyjH29oltojdTKXCi2LUcdLSk8gTbrmInSVpxNCILNe2ZVpR0K
	 WDRhoP43UJkJw==
Date: Tue, 27 May 2025 16:24:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: 8250: Make clocks and
 clock-frequency exclusive
Message-ID: <20250527-polio-snooze-c05aafc1e270@spud>
References: <20250524105602.53949-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cg5oiNTrmqNAveHb"
Content-Disposition: inline
In-Reply-To: <20250524105602.53949-1-ziyao@disroot.org>


--cg5oiNTrmqNAveHb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 10:56:02AM +0000, Yao Zi wrote:
> The 8250 binding before converting to json-schema states,
>=20
>   - clock-frequency : the input clock frequency for the UART
>   	or
>   - clocks phandle to refer to the clk used as per Documentation/devicetr=
ee
>=20
> for clock-related properties, where "or" indicates these properties
> shouldn't exist at the same time.
>=20
> Additionally, the behavior of Linux's driver is strange when both clocks
> and clock-frequency are specified: it ignores clocks and obtains the
> frequency from clock-frequency, left the specified clocks unclaimed. It
> may even be disabled, which is undesired most of the time.

That sounds like an issue in the driver itself, no? If the clock phandle
is present it sounds like the driver should be claiming the clock
whether a frequency is specified or not. If so, that should be fixed
whether this patch gets applied or not.

>=20
> But "anyOf" doesn't prevent these two properties from coexisting, as it
> considers the object valid as long as there's at LEAST one match.
>=20
> Let's switch to "oneOf" and disallows the other property if one exists,
> exclusively matching the original binding and avoid future confusion on
> the driver's behavior.

Have you checked whether or not there are devices that have both
in-tree? If there are, can you fix them up as part of the change, rather
than adding new warnings.

>=20
> Fixes: e69f5dc623f9 ("dt-bindings: serial: Convert 8250 to json-schema")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index dc0d52920575..4322394f5b8f 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -45,9 +45,13 @@ allOf:
>                    - ns16550
>                    - ns16550a
>      then:
> -      anyOf:
> -        - required: [ clock-frequency ]
> -        - required: [ clocks ]
> +      oneOf:
> +        - allOf:

Why is the allOf needed here? Does
oneOf:
  - required: foo
  - required: bar
not work? There's a bunch of bindings doing that, so not sure why it
doesn't work in your case.

Cheers,
Conor.

> +            - required: [ clock-frequency ]
> +            - properties: { clocks: false }
> +        - allOf:
> +            - required: [ clocks ]
> +            - properties: { clock-frequency: false }
> =20
>  properties:
>    compatible:
> --=20
> 2.49.0
>=20

--cg5oiNTrmqNAveHb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDXZGwAKCRB4tDGHoIJi
0stbAQCqgioKTt6CEkQJpcEMEcKE5cMu34rXAzJrmjDZYgMo8wD+OSU/P8Qh0hd3
abV9cio96MzAXJYlM3DoCEYBIALlyA8=
=iN1y
-----END PGP SIGNATURE-----

--cg5oiNTrmqNAveHb--
