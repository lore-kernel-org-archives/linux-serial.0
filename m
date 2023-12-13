Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD285354;
	Wed, 13 Dec 2023 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDrTRQ4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5D6C433C7;
	Wed, 13 Dec 2023 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702483341;
	bh=iU0MYjjyzlZMDWQFfoANj4Ve4q83Cm1o4XgWEYy9/o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDrTRQ4TbJ1MLpgiWBdfCkeJFD62W0AFnk66stElmOQfrYXU1FuFZy1hgVFjxkCO3
	 r3WGKhdoNBo7Y3hdfKmn6WVcXbUsfeJhkoRq5MetVc+yt/XdGIBQVV5PJ1cRE6k/LF
	 5KxKfKJrD1EL/jTqlvoLIB1WOUtpbzWyGNrEIEySxEu4OgdkLOWzPkAiUBsJBz7CWu
	 SfO6cf7ncX/LqvQXfJs3PPl/f2rIcK9rNxjqq2ZNW8xyEG1sRRdDiS0GoZHs8e2vPe
	 2UmSn/60q1WTjoPRPOCEimVXyZpERLMbqQ8T4ZwpaYxSN5ScfZjYrsIUGtudFEvrkC
	 xrPdF7cC9QbgA==
Date: Wed, 13 Dec 2023 16:02:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, gregkh@linuxfoundation.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jirislaby@kernel.org, linux-arm-kernel@lists.infradead.org,
	radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
	shubhrajyoti.datta@amd.com, manion05gk@gmail.com
Subject: Re: [PATCH V5 1/3] dt-bindings: Add reference to rs485.yaml
Message-ID: <20231213-chief-heroics-fd8ba9dbb653@spud>
References: <20231213130023.606486-1-manikanta.guntupalli@amd.com>
 <20231213130023.606486-2-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PON0JI5JFuC6UHYc"
Content-Disposition: inline
In-Reply-To: <20231213130023.606486-2-manikanta.guntupalli@amd.com>


--PON0JI5JFuC6UHYc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 06:30:21PM +0530, Manikanta Guntupalli wrote:
> Add reference to rs485.yaml

I can see this both from the diff and from $subject. What is missing
here is why.

> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Modify optional gpio name to xlnx,phy-ctrl-gpios.
> Update commit description.
>=20
> Changes for V3:
> Modify optional gpio name to rts-gpios.
> Update commit description.
>=20
> Changes for V4:
> Update rts-gpios description.
>=20
> Changes for V5:
> Remove rts-gpios description.
> Update commit message and description.
> ---
>  Documentation/devicetree/bindings/serial/cdns,uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Do=
cumentation/devicetree/bindings/serial/cdns,uart.yaml
> index e35ad1109efc..2129247d7c81 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> @@ -55,6 +55,7 @@ required:
> =20
>  allOf:
>    - $ref: serial.yaml#
> +  - $ref: rs485.yaml#
>    - if:
>        properties:
>          compatible:
> --=20
> 2.25.1
>=20

--PON0JI5JFuC6UHYc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnViAAKCRB4tDGHoIJi
0kWPAQCxViZ7KfO02cW9B+6e9MKb9cXp8W/9ckLEheKy7g8N9gEA8ja8T/s7+kVF
ErNJOVODs7LBh5h9z7mnTeF7dLHdlw4=
=GUr0
-----END PGP SIGNATURE-----

--PON0JI5JFuC6UHYc--
