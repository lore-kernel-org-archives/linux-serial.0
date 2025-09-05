Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAF17F4F6;
	Fri,  5 Sep 2025 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097487; cv=none; b=KahHWuyCwVwp4VgFaPcMR2mlIoqxXeHSAAGP7E3DKDtCMBJ10bBDUE7R7oBbtjFRoXBd8AnxolFEWqAL4Cc1GMUm56CcfMlQV2CMXX9+kBaT8uosngYyvBndVED8hh0fUiHBYr7O2g4hUqFco+7kQmyYdLgg9vTNUtPypEhOwfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097487; c=relaxed/simple;
	bh=zBznowgcA9KRpPYdFjqyySbRdKkl9xdj5USfqCcnRzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbtbhkImDdIC2Yfe9YR5IfDm6G8M+19cdzYKRoD3vO7AGbdKEVWeCR3hsCxP0ESXH1quat/z9ynE75Eg0yTv5HpY593dza+PKSupJLJBeRcBZx2Zn3W8iu2HdBfm7QQ+ld0r/jX/C6JKH4BrkeaTnOEivN1aAsDeMALzQlZpbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKX9Ju1m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKX9Ju1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18486C4CEF1;
	Fri,  5 Sep 2025 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757097487;
	bh=zBznowgcA9KRpPYdFjqyySbRdKkl9xdj5USfqCcnRzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKX9Ju1mWOXI6N75KfrsrKrwLfvt94Xo7Jbvycrs9IXgcAFnJc1MoWmjzHNi1e8bV
	 b7oIiDbtVqIwoFAbp7CuQUaSqsm05FRccpW8RQGc7uBYl1iQ6/ORuE37l+zFqol7tv
	 N3109/8CwbsVFqDjUOjdmOL+7kqMTH4eLzEgZDLlnaEosbQSwQ3zj4grFA1h9/Egd+
	 vwKy64+AOVyk8yoWTurZAmQ8WJMj1wHeoRhO1r4v+0x4TxtPsgXpTCf2CA3cGcc9MV
	 D/TSUGfak+q+Gn1FXUVoAlQ+Mw5uT2M4bk8z2YLK7HCfSQSvZbJA/TR8VyqSbxXxSo
	 JU8ShV4YUxkMw==
Date: Fri, 5 Sep 2025 19:38:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vigneshr@ti.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, d-gole@ti.com, vishalm@ti.com,
	sebin.francis@ti.com, msp@baylibre.com, khilman@baylibre.com,
	a-kaur@ti.com, john.ogness@linutronix.de,
	andriy.shevchenko@linux.intel.com, yujiaoliang@vivo.com,
	b-liu@ti.com, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH 1/3] dt-bindings: serial: 8250_omap: Update wakeup-source
 type property
Message-ID: <20250905-saloon-siesta-77da98d7ae02@spud>
References: <20250904212455.3729029-1-k-willis@ti.com>
 <20250904212455.3729029-2-k-willis@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YBHU1HQe3eAUtz/k"
Content-Disposition: inline
In-Reply-To: <20250904212455.3729029-2-k-willis@ti.com>


--YBHU1HQe3eAUtz/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2025 at 04:24:53PM -0500, Kendall Willis wrote:
> Allow the wakeup-source property to be either of type boolean or of a
> phandle array. The phandle array points to the system idle states that the
> UART can wakeup the system from.
>=20
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  Documentation/devicetree/bindings/serial/8250_omap.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Do=
cumentation/devicetree/bindings/serial/8250_omap.yaml
> index 1859f71297ff2..851a5291b4be4 100644
> --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> @@ -69,7 +69,13 @@ properties:
>    clock-frequency: true
>    current-speed: true
>    overrun-throttle-ms: true
> -  wakeup-source: true
> +
> +  wakeup-source:
> +    oneOf:
> +      - type: boolean
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +        description:
> +          List of phandles to system idle states in which UARTs can wake=
up the system.

Is there a single other instance of the wakeup-source property being
used like this?

> =20
>  required:
>    - compatible
> --=20
> 2.34.1
>=20

--YBHU1HQe3eAUtz/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLsuCAAKCRB4tDGHoIJi
0sCOAP0YKRfgNPuWmw0VBD7mFYv3TWGmnWOS9WQUj1ptbhD6ygEA2tj71JTgNmGh
//hKbMoedfGWmP9EJpLiTCdPihC7agU=
=B5j5
-----END PGP SIGNATURE-----

--YBHU1HQe3eAUtz/k--
