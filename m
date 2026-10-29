Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301526;
	b=Nuw4pjkHvk0ZlAS6K+x5REBDEZW6lQm98BuGTIb0ZBi9vxTxFOmj3yzr+PBg2QDZh+JV
	 q5PF3aBFtqgUaQy8b/S/Mr+14aOPh4fk5hBB08+Uo15lxAwWalhrSZR5s+bn8A02pIcUU
	 fZKSiF0KqePm+ALyHs5+arQy7JuoMPoLShfVN5UGlu7d4e5AoLwhMKur/B+eMQpwyoRzf
	 4MwfoUCmeEuUiZ9XU+4/ORbtfKvUgDjUB6BBuGkOkhiuUgP6gCdnHtyy2X12c25XUNXqL
	 tPMKnq3mNebirIfBtMR220yZkfnIhU8aUDYIcxkMAVFg7dP5MVQ+8RPtXqwpLKGtpog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301526;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ph8C1jmnpdrdeev4LCocOpai7bmb4a/dXqzWxHzIVz0=;
	b=YQidcfAhBYhT7Clwm6yE4pB5E8IaCBOAIK3V6/zdanVGv0/KH/izqsUTF1jREwXWLo1/
	 9fMeJk8fqxTM7e3WDXTZTBUsAIXpMmQuku8fs3/Jy2ogjPczAeelBPUiiYJXnfDosv9je
	 qsf7qTJHSMTGcJICU64sTos+ElCwXKE/ujjm7jLLCBAnpYiGvH5DQbpmXesGOHfm5Suai
	 w1xfDfiIkbdstZT7/qUWJnNOJuhtSwAnn4P8p/3G88yU1iucF9hLESW6GcBlFLewjR7bP
	 oxtY2XvrG3mWGo2nN1aol6utQy43DuY1SRzlL936EVAXWu26FxhLDYqNUBiB7ICtqPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gf3rGWJU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69140606A31A;
	Thu, 29 Oct 2026 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gf3rGWJU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A11C1F01824;
	Thu, 29 Oct 2026 19:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301526;
	bh=ph8C1jmnpdrdeev4LCocOpai7bmb4a/dXqzWxHzIVz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gf3rGWJU5hbTZOexRbTZOJDmxHULJI5KXdcRKAlnfLmHqVHp9ZGY+dEmN25dhzEAl
	 3DEuSOE0mIwV8CyctydR6aiUqxOr9XHMH7VyF2VXTSZmFsNkHwUiEGyo/Vk8brWuD7
	 2HH1Utj+X9rzkIQtOPZBqQWXqugxM1exuPJRbHt8SycgJ74axOP/RiOmdoJGeWe+zF
	 hBIh2PFr8Jf+U/lG0ANzGDoHDUwPpZlQwjc22JnLMWY+Q1O4rTuJQaKOUWodAKpVeo
	 UUQI8rgTznnArkRPRZgSdHJT0tshbP3lJkbuHTHgwK4CqTVhjsO0omZdPWqpGjFea1
	 IsrJQJpFIHaeQ==
Date: Thu, 29 Oct 2026 19:18:38 +0000
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
Subject: Re: [PATCH RFC 05/12] dt-bindings: serial: Add BL808 UART
Message-ID: <20261029-sequester-countable-6a7b597c2551@spud>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-5-b736ee920078@gmail.com>
 <20261029-pouch-enunciate-e74cf84e42a7@spud>
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
	protocol="application/pgp-signature"; boundary="Oo1FlmzmZPb07xbS"
Content-Disposition: inline
In-Reply-To: <20261029-pouch-enunciate-e74cf84e42a7@spud>

--Oo1FlmzmZPb07xbS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 06:54:49PM +0000, Conor Dooley wrote:
> On Thu, Oct 29, 2026 at 01:05:46AM -0400, Kwanghoon Son wrote:
> > Describe the UART register range, interrupt and baud clock input.
> > Initial Linux support targets the BL808 32-byte FIFO and reuses
> > Zephyr's bflb,uart compatible. UART3 is D0 PLIC source 20.
> >=20
> > Link: https://docs.zephyrproject.org/latest/build/dts/api/bindings/seri=
al/bflb,uart.html
> >=20
> > Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
> > ---
> >  .../devicetree/bindings/serial/bflb,uart.yaml      | 57 ++++++++++++++=
++++++++
> >  1 file changed, 57 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/serial/bflb,uart.yaml b/=
Documentation/devicetree/bindings/serial/bflb,uart.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..df29d258f0a1c6d7bb283cf=
19c4157436991b64b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/bflb,uart.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/bflb,uart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Bouffalo Lab UART Controller
> > +
> > +description: |
> > +  UART IP used by Bouffalo Lab SoCs. Initial Linux support covers the
> > +  BL808 controller with a 32-byte FIFO. The compatible follows Zephyr.
> > +
> > +maintainers:
> > +  - Kwanghoon Son <asdfkwang@gmail.com>
> > +
> > +allOf:
> > +  - $ref: serial.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: bflb,uart
>=20
> This needs to be a device-specific compatible - please just use the
> binding already reviewed and agreed upon in Jisheng's 2023 series.
>=20
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Baud rate generator clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: baud
>=20
> Drop this clock name, with only one clock there's no more need for it
> than the interrupt-names or reg-names that you do not use either.

And additionally, I see no value in picking something to suit zephyr,
when zephyr uses things like "bflb,clock-controller" or "bflb,pwm-1" and
"bflb,pwm2" and so on. Make a clean break and do things correctly rather
than try (and fail) to be compatible with the zephyr dts.

>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    uart3: serial@30002000 {
> > +        compatible =3D "bflb,uart";
> > +        reg =3D <0x30002000 0x1000>;
> > +        interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&uart_baud>;
> > +        clock-names =3D "baud";
> > +    };
> > +...
> >=20
> > --=20
> > 2.47.3
> >=20



--Oo1FlmzmZPb07xbS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOcDQAKCRB4tDGHoIJi
0vgpAP0Ykz6jLYW3pZLrj+OXAuKEfEQ7s4+gO6k+C0dlr9qAfwD/Rk+Q3480s7KS
h4SKrbAvl0+aogP6ibLD6PeZLk0/vAc=
=kFab
-----END PGP SIGNATURE-----

--Oo1FlmzmZPb07xbS--
