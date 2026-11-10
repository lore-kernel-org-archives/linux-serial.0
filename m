Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334584;
	b=eoGdcdc/FNA7Sf94hqu7URz5Foy+YQ03p5HOTKIVNzx74SBi71h7BtNe4KfH1V+Oje5C
	 GUFELUQ8PV2NUuzEis5oHwNNib8aMdb3X5DJTA445WgrWBGErjUFtpyHVHjpO8YGAokkQ
	 kfszD2aFwEBQ3CIVBjcwxXb7q/RALOWndYXTI7IkRaJ8Jc4tqFMmDu5cuxpxp408lNVJQ
	 GdDb6epXNwTpWN+aKJg8OAluCcPasi8Uw6blfoJoDd4AgP23TfJRs5Usta08t1DGMah/T
	 6GG+YRTzapZspa9GfP9VgHFWYo9dbeeZooqpHZwXdk7dheGBEtaPV58+xRIQCLyQYLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334584;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WOswCe00ecth5aegw9K1yzGGEgL8XZ5Bn4726F7aM/M=;
	b=RF5lnT8Y+wALlV+DxuZmWLJLogUctBKOMk6H90m5osjYaMpD++wIWSEO/EEggTv27kwu
	 J/Y3Ye5NH1qVyzg56chHJ2m5blMKMKYRKkUliYHfWmed5vkYr+VEjEIVHidYc2r3IDH8r
	 tjbssbpInnvNJs8rMrIFxwx1ipyDpUJIftgrjCXXM4op2Nm46y0XKCWE8RVu6DxSEnpzU
	 +QHEHB+X/gseiXzgtoRO5hINMbNMGcasrgY2m+RT4wpVfz66CIQLlN47o9htoUpdv9Puq
	 5L4FSpbIKoTBkqMkoMH6WiVAhKsBF+fmCBPxXZib1pr9D9ao/1guWHNkzalUXpvErsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCkXlZHo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3319606A31C;
	Tue, 10 Nov 2026 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCkXlZHo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260641F008A1;
	Tue, 10 Nov 2026 18:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334583;
	bh=WOswCe00ecth5aegw9K1yzGGEgL8XZ5Bn4726F7aM/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCkXlZHovhXIEMkXyHaLIoiLZziXCf5ktPbVRuney59bKd3vZcA+KXDhc/H83FMEk
	 jFuIo4HTN7InXDDc+UGiTHBakPkz5vJSl/6Z7d4w+j3dpRQkAauRhMzZyDBLCYQlOL
	 8RZIq369C9kUf46m9S/dOkAhg/op4aFOwwloUzfldj/8KqIo+XOWRE7ZoNYZ3qwOkK
	 1p6wQ0TKq8Tbw0tlMQjY2nccZIKESS/KYDK85SYLEbUDr9au0yUabufFucp30J9Ctu
	 M4NjYNx5kldzJ8oagpAimob0D9oasNsRZVjbe+wPc/5omaGFhIDL9e3ZPlQD5Z6GD7
	 6R8RjjrsZyliQ==
Date: Tue, 10 Nov 2026 18:16:19 +0000
From: Conor Dooley <conor@kernel.org>
To: kohei@spacemachines.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, conor.dooley@microchip.com
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: 8250: add Microchip Core16550
Message-ID: <20261110-appease-euphemism-0bd52845b396@spud>
References: <20261110-core16550-rs485-v3-0-4294334243fa@spacemachines.com>
 <20261110-core16550-rs485-v3-1-4294334243fa@spacemachines.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5peolnbzRFGeN4F6"
Content-Disposition: inline
In-Reply-To: <20261110-core16550-rs485-v3-1-4294334243fa@spacemachines.com>

--5peolnbzRFGeN4F6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 09:06:48AM +1100, Kohei Otsuka via B4 Relay wrote:
> From: Kohei Otsuka <kohei@spacemachines.com>
>=20
> Core16550 is a 16550-compatible UART soft IP core for Microchip FPGAs,
> including the fabric of PolarFire SoC. Its registers follow the 16550A,
> but it raises no interrupt on TEMT. A driver that knows only ns16550a
> waits for one in software RS-485 mode (em485), so RTS stays asserted
> after the first frame and the port stops receiving. ns16550a is
> therefore not a valid fallback.
>=20
> Add microchip,core16550-rtl-v3 as a compatible of its own. As for
> Microchip's other FPGA fabric cores, the -rtl-v3 suffix is the major
> RTL version of the IP, Core16550 3.x.
>=20
> Link: https://github.com/linux4microchip/meta-mchp/issues/5
> Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>

With both dt-binding maintainer and microchip fpga hats on:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index 50d5c977afa3..d9ee14f7b694 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -111,6 +111,7 @@ properties:
>            - aspeed,ast2400-vuart
>            - aspeed,ast2500-vuart
>            - intel,xscale-uart
> +          - microchip,core16550-rtl-v3
>            - mrvl,pxa-uart
>            - nuvoton,npcm750-uart
>            - nuvoton,wpcm450-uart
>=20
> --=20
> 2.53.0
>=20
>=20
>=20

--5peolnbzRFGeN4F6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavNfcwAKCRB4tDGHoIJi
0oevAP9+B2mKIfIt9MlyTQPo2uuhkDjROEjGArmWBz+UubfWDQD+MAPDc1uACvh4
EuiIKGiMg36T/N1hXY55h64GA4xRMAM=
=YANR
-----END PGP SIGNATURE-----

--5peolnbzRFGeN4F6--
