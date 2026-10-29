Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300719;
	b=ffUh9eUqJZDyYTx4VmWqfUNqK/FtJUQoCnfaSWu/4xrS1n5Svr/ekhv6lQhOLD4fL4jI
	 LzjBjRw4bliKXTtGwINhgAybXNNYByMNWoAIoyrKwS2j7TTCdDrWku3wBmYPijArTUFSa
	 I34/JkOIJ/XYq1JwK4m68UOoTS/Yind40VH3MtAlWKF1v9jwVEzY5yINgtQSqo1mDs7pH
	 HFudRQZIa5ZhgTyw9wFhKzO9ZsFUHxSNM3OIAGDkLpC0CtY7ao1ZuXjZmveENDh477FFu
	 LzcY2ki+AMeelSchl/32aqvOgcWAi409MiPONHa2cBPMLKWHx+kwca0X2l9MHt3AkJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300719;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZIrKddf6pvxQavxN4Amy5fMjCUZq8twVYnoaojmCO50=;
	b=w1QJfx7mhwQUqahjspTe0TwNjGlEqzcs8JG8epC0eGDkE36/Bx1NyiJ4Xp/kaRD2D66n
	 +PI2eERyR85hPSDxbSEu2b7a0fdVubcRXSY70TfMX6ybJ7G8ZBxI44ZvZP46/QuuXZnC9
	 XI4AsyLsL99bZi1AD3x3cit4pDjiKGJ9j2q/yc1M5jx4WBwerNbvLsAGV1UFOZC4LdHuB
	 bn5gjmH+uPFe+8aSN22OSUtnq8JICAhRddMO6eAxKgcqtVOOuQd1LKyQeB0zpyuwRKoRo
	 ehvbUOG41jhRtL9qH1zJqaxJIkxAGnvpZPlrSspw2L/YkGPTIPNZuJLBqKyIPwOOKLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pui3m9Aj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC3606A31E;
	Thu, 29 Oct 2026 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pui3m9Aj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747CA1F01816;
	Thu, 29 Oct 2026 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793300718;
	bh=ZIrKddf6pvxQavxN4Amy5fMjCUZq8twVYnoaojmCO50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pui3m9AjSPH1MZlpcaehf1JH5eg/ZnS7g/erGiLGLK4BqVVBUQtlnOkYVhg5IENyl
	 TJqWo6nwpnO27pqSFlm4w+r4s/rg3NBrFhOJReBK9LK+wzY0RvRduLQaMqRgDc6d1S
	 zm0uDg3CaFEOQjDcJrgihZwxjE8a8GML5q/e1susNgAdpcFvbPPmc3YJvbf2sx1iDM
	 n+Hkt1rSjyDElXicwNDqQ0JGnCtVzVEEq7ERoTZZFeo2MAkvudTi8lAznndem5DQ/A
	 4Fh62FFYdq8oh4cXpBPjFaHUH2PTJR27Cz5SDtgnQHgLobCmyPcU+1IoO2GjIzPAPN
	 zifHWKznRsZ3g==
Date: Thu, 29 Oct 2026 19:05:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Kwanghoon Son <asdfkwang@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 09/12] riscv: dts: bouffalolab: Add BL808 SoC
Message-ID: <20261029-rimless-could-7b96455c785b@spud>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-9-b736ee920078@gmail.com>
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
	protocol="application/pgp-signature"; boundary="9JO81ZQA/u1VUulC"
Content-Disposition: inline
In-Reply-To: <20261029-rust-bl808-console-v1-9-b736ee920078@gmail.com>

--9JO81ZQA/u1VUulC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 01:05:50AM -0400, Kwanghoon Son wrote:
> Add the BL808 D0 CPU, PLIC, CLINT and UART3. Leave UART3 disabled for
> boards to enable. UART3 connects directly to PLIC source 20; firmware
> sets up UART clocks and pins.
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
> ---
>  arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 70 ++++++++++++++++++++++++=
++++++
>  1 file changed, 70 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/bouffalolab/bl808.dtsi b/arch/riscv/boot=
/dts/bouffalolab/bl808.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..c739c77960c4578b87fcf2bc0=
96ef7c8cda089bd
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible =3D "bflb,bl808";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible =3D "thead,c906", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			mmu-type =3D "riscv,sv39";

> +			riscv,isa =3D "rv64imafdc";

Please drop this property, there shouldn't be any part of the stack that
needs it anymore.

Cheers,
Conor.

> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> +					       "zicsr", "zifencei", "zicntr", "zihpm";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +	};
> +
> +	xtal: clock-xtal {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +	};
> +
> +	soc {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +		interrupt-parent =3D <&plic>;
> +		dma-noncoherent;
> +
> +		uart3: serial@30002000 {
> +			compatible =3D "bflb,uart";
> +			reg =3D <0x30002000 0x1000>;
> +			interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&xtal>;
> +			clock-names =3D "baud";
> +			status =3D "disabled";
> +		};
> +
> +		plic: interrupt-controller@e0000000 {
> +			compatible =3D "bflb,bl808-plic", "thead,c900-plic";
> +			reg =3D <0xe0000000 0x04000000>;
> +			interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_intc 9>;
> +			interrupt-controller;
> +			#address-cells =3D <0>;
> +			#interrupt-cells =3D <2>;
> +			riscv,ndev =3D <82>;
> +		};
> +
> +		timer@e4000000 {
> +			compatible =3D "bflb,bl808-clint", "thead,c900-clint";
> +			reg =3D <0xe4000000 0xc000>;
> +			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>;
> +		};
> +	};
> +};
>=20
> --=20
> 2.47.3
>=20

--9JO81ZQA/u1VUulC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOY5gAKCRB4tDGHoIJi
0msBAP4795/OI4/Z/fe0Yr9RRuYypthWWhBXNyzAEDKFE8sLdQEAtwkfNDEfXRMn
ii8vn56yY4seLAp/qcClM7GtoSAN2Ak=
=DS5v
-----END PGP SIGNATURE-----

--9JO81ZQA/u1VUulC--
