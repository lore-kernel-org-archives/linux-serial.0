Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793303437;
	b=15pQ3xz8RwH3Lxz8SxnSwfXbzk/hQnNCJvMtJFT9j3gubnRaikTBwM3tvxhFdezr5JnW
	 Ar5L/GbO663PqoKVX1ooCeyKKi7it0rsioeEFvl74PD+0jlVTrgLgzYiQLPvRDfQhMDB4
	 NBN9CY8OG2SZXu+rIr9ukIYqmsI5wuWi8HtaqI7S4Rp9SWiG3yM6XrOhElEvQA2gD+fyO
	 yGrDKVU+bIBYuBqINlQxZpEFIHs+v5BgmwVNiIU0uLvo2BzGOANNtqINbic65mpMuIv9w
	 JBeGzvGRhGGuNcZrE8POqHJ51DKgWh9KexrzqN33GKh9pQGSP6H/ucQqRMD+hMPTibw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303437;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c0VuI2Veyo+JRtSrCAcVeS3CX/ZAsYeS6ljLG3SOqDk=;
	b=kElrAC/9DybVYc35YpmfJlbLc5GqKIXAJXW8tWfXkdcN4wd8OFqF6YVakadJ8+0isNvE
	 7EJmGTJ3wcU33H/zPgg9KABmPO3/wpaL2qqYuNvccuVqsfFd+T4gLZQ0/a8MxaTxB9ZYT
	 8RKzKl/z6UxnNCHzFt2KFw6YX6IRrNN+FsgBjUdiRi2mwwThZHDjk+tO+LetmW6hplPj7
	 uToAh66fHm+gry+TBT627S7IW5ocypvdl+1q73qV8JLk7sqXsnPw81cCL6wpAKRpT1PSz
	 Lfzi85y+ZRnA15C3T/YBeLDTOWsr0rLXkJVy4cTPcNa4SZ/8hWkCUM5dYBULH20314Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irgHetGI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5AF606A31A;
	Thu, 29 Oct 2026 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irgHetGI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806841F01816;
	Thu, 29 Oct 2026 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793303436;
	bh=c0VuI2Veyo+JRtSrCAcVeS3CX/ZAsYeS6ljLG3SOqDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=irgHetGIrvCd5kwq/QQ/Vq/nV/bg4ecvzr2mWJMzdMpDIyvLKpLi2himFIVdrt4kI
	 M5q2L+f0taP7diWMrMYR0ZBn3pcv37Or1ltiyMBJQNTpOXr937yPRKcwpp3R5M5CQg
	 GBbYY0orepwUDQfTumx2i0UVNVsDHuuzwtOun3Q321/l6If6Z9p6AZJTPnfTVpLD2B
	 5NcdQzJJZvNoNaQaPZVR+LMcvpqWkj7ThLpZ0OGNLO9GiFKCBixRrWKwkwASVDJ5O4
	 xo2Agdz5Kxi+/y5a2cEcDPiQRkyzQZoLHgW/bkgPc9Oa3q93hBnsnqCRcaERcl6wIf
	 iZaL1otjPAJjw==
Date: Thu, 29 Oct 2026 19:50:27 +0000
From: Conor Dooley <conor@kernel.org>
To: gaohan@iscas.ac.cn
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>, linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 04/18] dt-bindings: mailbox: add the A210 AP to E902
 doorbell
Message-ID: <20261029-mannish-levitate-d4a1d780f949@spud>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-4-74d58ce85bd8@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="7TyiCWuFggz3NMfa"
Content-Disposition: inline
In-Reply-To: <20261027-a210-scmi-v1-4-74d58ce85bd8@iscas.ac.cn>

--7TyiCWuFggz3NMfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:36:55PM +0800, Han Gao via B4 Relay wrote:
> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Describe the AP doorbell and optional endpoint clocks. Firmware may keep
> the clocks enabled before the SCMI transport is available. An optional
> E902 to AP data bank identifies a second, receive-only notification
> channel sharing the doorbell interrupt.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  .../bindings/mailbox/zhihe,a210-ap-mailbox.yaml    | 76 ++++++++++++++++=
++++++
>  1 file changed, 76 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mail=
box.yaml b/Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mailbox.=
yaml
> new file mode 100644
> index 000000000000..4541750223eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mailbox.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/zhihe,a210-ap-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Zhihe A210 application processor to E902 doorbell
> +
> +maintainers:
> +  - Han Gao <gaohan@iscas.ac.cn>
> +
> +description: |
> +  The A210 exposes a bidirectional notification channel between the
> +  application processors and E902 firmware. Payloads and transaction
> +  completion are managed by the client using shared memory. The firmware
> +  initializes the remote endpoint before the application processor binds.
> +  When firmware manages the endpoint clocks and keeps them running, omit
> +  clocks and clock-names to avoid a dependency on services using this ma=
ilbox.
> +
> +properties:
> +  compatible:
> +    const: zhihe,a210-ap-mailbox
> +  reg:
> +    minItems: 2
> +    items:
> +      - description: Application processor interrupt status and control
> +      - description: Remote E902 notification channel
> +      - description:
> +          E902 to application processor channel data, which identifies t=
he
> +          channel that raised the shared interrupt

Why is the number of elements ever variable?

> +  reg-names:
> +    minItems: 2
> +    items:
> +      - const: interrupt
> +      - const: tx
> +      - const: rx
> +  interrupts:
> +    maxItems: 1
> +  clocks:
> +    items:
> +      - description: Application processor mailbox clock
> +      - description: E902 mailbox clock
> +  clock-names:
> +    items:
> +      - const: local
> +      - const: remote
> +  '#mbox-cells':
> +    const: 1
> +    description: |
> +      Channel index. Channel 0 carries requests to E902 and their comple=
tion.
> +      Channel 1 receives E902 notifications and requires the rx region.

Whitespace is missing here generally, a blank line between properties
please.
pw-bot: changes-requested

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - '#mbox-cells'
> +
> +additionalProperties: false
> +
> +dependentRequired:
> +  clocks: [clock-names]
> +  clock-names: [clocks]
> +
> +examples:
> +  - |
> +    mailbox@321000 {
> +        compatible =3D "zhihe,a210-ap-mailbox";
> +        reg =3D <0x321000 0x1000>, <0x311000 0x1000>, <0x320000 0x1000>;
> +        reg-names =3D "interrupt", "tx", "rx";
> +        clocks =3D <&clk 0>, <&clk 1>;
> +        clock-names =3D "local", "remote";
> +        #mbox-cells =3D <1>;
> +        interrupts =3D <336 4>;
> +    };
>=20
> --=20
> 2.55.0
>=20
>=20

--7TyiCWuFggz3NMfa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOjgwAKCRB4tDGHoIJi
0ht8AQD7ArK5WVgUv3a70cq5xiO/p/W7d4mBqnyobSVpyyiljgEAmuu3o32sYzON
A24NeuZF+yZakkViR8FkYVgSqESWaAE=
=lqKL
-----END PGP SIGNATURE-----

--7TyiCWuFggz3NMfa--
