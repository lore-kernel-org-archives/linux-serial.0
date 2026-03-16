Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF9B2494FF;
	Mon, 16 Mar 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660027; cv=none; b=f3ZNQBcr4UQ0RcvCK++whFkRKI8RaY/KOEgrYVdwAFqims8FQMUypEL9Ce8MifBp4KYfLyx5j/Ucub2Vzr0VsM7N3vKT6xn/1NMkxeH6ATciHh2AtbTAatiTmgy63lwUN1hcETTGQkU2oWpctri+tCHSpJCAFYSCjNmpq6GNoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660027; c=relaxed/simple;
	bh=dVJUwMYfXrWl+hL9SCPmas+DDb5aN/lmBHb0o8Zc6jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WicbomUOyzDIAqZ1ZWQOhW/lsgJ6iu6OBaQAzhDNOuqx92+jQkHEcWBiHRjvp2sFqhWkLdehO2NyHFJVcybNVuxFbf/DjyumxavLiRh0Xg4p4dPTNtFn90KD13kAwpH5J7b1gv75Cj7ksnx4fL8xxHiojmYPRzFZdLlSHK6k8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkqMEwZl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkqMEwZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A34C19425;
	Mon, 16 Mar 2026 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773660027;
	bh=dVJUwMYfXrWl+hL9SCPmas+DDb5aN/lmBHb0o8Zc6jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkqMEwZlCJcDEb1xxK7FugSdj93w6hg2H0ZN+yuW4vy/upw9kOs4g7WL7aIWNMg04
	 q/3UXV63GjQbZab1BpB+cIaVvqFj2FE4acIZ6YQEDkHPV8lps52oPUvU3PsXTNBbl9
	 6G6NPsWkhe5lrsJPxDVWOZdWLLEpRmRuLQbozaQbDYuYj9coPI7tfk66d6yx1EnOrN
	 AlnCSCqd+ewdIN1v00xmBCYzTCXuRudXHcYG3nb6pskoh5FXVdUlbydUan4xXPdf1S
	 HUsEu9ktebdjF6I/0xa9XSHk4Btpv3O0t/4T9PvJ6Iwt4N2yp4d5++4lB5Jg8XqAIf
	 Yg9BDgDZ/mYHw==
Date: Mon, 16 Mar 2026 11:20:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: serial: update bindings of ultrarisc
 dp1000 uart
Message-ID: <20260316-emit-garter-292687076ee3@spud>
References: <20260316-ultrarisc-serial-v1-0-c464f3e933a5@ultrarisc.com>
 <20260316-ultrarisc-serial-v1-2-c464f3e933a5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wdBWOCsNzigriQdV"
Content-Disposition: inline
In-Reply-To: <20260316-ultrarisc-serial-v1-2-c464f3e933a5@ultrarisc.com>


--wdBWOCsNzigriQdV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 09:36:19AM +0800, Jia Wang wrote:
> Add UltraRISC vendor-prefix information
> Add DP1000 UART compatible information

$subject: update bindings of ultrarisc dp1000 uart

You're not updating, you're adding it.

>=20
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 6efe43089a74..0040ed28e35b 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -78,6 +78,8 @@ properties:
>                - starfive,jh7100-uart
>                - starfive,jh7110-uart
>            - const: snps,dw-apb-uart
> +      - items:
> +          - const: ultrarisc,dp1000-uart
>        - const: snps,dw-apb-uart


This doesn't look right to me. An items list with one const is just the
same as having "const", like the snps,dw-apb-uart entry below it.

--wdBWOCsNzigriQdV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabfndgAKCRB4tDGHoIJi
0qccAQD6zlH0epUiaLIDo8zyA3e+UoE4noDoNHVS35rkUmynkgD+IicJiFQ3eOUm
4bBJEucTGH6R8VgSxm3CAkkSqP7SNwA=
=dVh4
-----END PGP SIGNATURE-----

--wdBWOCsNzigriQdV--
