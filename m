Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1812F5A7;
	Fri, 17 May 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962611; cv=none; b=tMd/WJuEmLrruorLlKU8lxFjObz81CMNE1qAWB1OwtkiZt3UqaqJ9S211hrFsqAbucQIP36yNN+n0DCdBlgtY1YNlis6HH/zX9L8XJbQQjbp56stRXJj+8CCB1VE1pfe0zYI7xtpeCJonCHH2yuquNHWwYPXjQarAhNy/NtButg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962611; c=relaxed/simple;
	bh=sYIW6xiRFDKpO0E7qs68ZN7uyOIsz2AfW+6kxgmPMW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e67F7o6ue7QN4bAcn5kwxl+cS9tYDBTmBHKk9/8AU4d2R4nncjQCX8bjPvrytWH+f/pj0VDZpG+AG21Q12LKWSlv/4s3D9cNiRhMWyl1OnCd5w+zD/cG8BEzcQk4mNqCu4k4+sWv7SL5YI2HTo5CsQljizYKFrjmg19izZqNF+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO3rRbTs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO3rRbTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B40C2BD10;
	Fri, 17 May 2024 16:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715962610;
	bh=sYIW6xiRFDKpO0E7qs68ZN7uyOIsz2AfW+6kxgmPMW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aO3rRbTsGNqJTNoEOosC7U8ZPlbZsUJn4QsQ0FYLQ4lV+L6hIZ8E7tZGEmOgCp+3S
	 nx5sfSd6N3BjMVdy8MVnQPR0Xa1o1RwD8Msu53pdvMJOtYpiXn3JzCckwCricC3iy7
	 E0GSeOILvH+9HAhs/mkdsvTXPBNUv/4ZiO3XV818Pvtrtfu8jepDNVg/QNtYf7ufMy
	 3KZr6h6F9eozJmMX5qAJn0xS7maVdDSeAt7Uz1lSbEUS4Y5gcRfRDEGmqz/XiKKceL
	 MqKg/px5GKaE9M00BlqwYqo0RkDxgL0B7fobm1ncnMS1Wd/ztFdun0zeKujKjVgiyZ
	 pY8V39DEjDnMg==
Date: Fri, 17 May 2024 17:16:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: serial: snps-dw-apb-uart: Add one
 more reset signal for StarFive JH7110 SoC
Message-ID: <20240517-lion-supplier-f4d15b0edcff@spud>
References: <20240517061713.95803-1-hal.feng@starfivetech.com>
 <20240517061713.95803-2-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ET0G0aOiXXDFM+f4"
Content-Disposition: inline
In-Reply-To: <20240517061713.95803-2-hal.feng@starfivetech.com>


--ET0G0aOiXXDFM+f4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 02:17:11PM +0800, Hal Feng wrote:
> The UART of StarFive JH7110 has two reset signals.
> Both of them are necessary for JH7110 to initialize UART.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../bindings/serial/snps-dw-apb-uart.yaml          | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 1001d2a6ace8..a6396c5cbfb1 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -13,6 +13,16 @@ allOf:
>    - $ref: serial.yaml#
>    - $ref: rs485.yaml#
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: starfive,jh7110-uart
> +    then:
> +      properties:
> +        resets:
> +          minItems: 2

else:
  properties:
    resets:
      maxItems: 1

Thanks,
Conor.

> +
>  properties:
>    compatible:
>      oneOf:
> @@ -48,6 +58,7 @@ properties:
>            - enum:
>                - starfive,jh7100-hsuart
>                - starfive,jh7100-uart
> +              - starfive,jh7110-uart
>            - const: snps,dw-apb-uart
>        - const: snps,dw-apb-uart
> =20
> @@ -82,7 +93,8 @@ properties:
>      type: boolean
> =20
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> =20
>    reg-shift: true
> =20
> --=20
> 2.43.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--ET0G0aOiXXDFM+f4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkeC7QAKCRB4tDGHoIJi
0vZ0AP0SDG3gdkl/SROzsnRuQ3RQz0FByypwdFgIWR36PF1aywD/fUifiJN9EkJS
DWNaC36x9nDD0qUF9URCjGhdPH1TMws=
=KlsG
-----END PGP SIGNATURE-----

--ET0G0aOiXXDFM+f4--
