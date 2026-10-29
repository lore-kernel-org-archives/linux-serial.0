Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793303164;
	b=DuQwZViyI1fsWPZBStYvVv3EItsGMihwWk0krLQJC/q/rovDT2wfFI3vKUzQmoGf8/+H
	 x64VHODODiWleJjcj5WE5shFjfDxQfDiejXmoEsBWDvn97ZURJNo+w1ZgQ9hLCR22Oi+K
	 /vhS5UWxD1/QJqhgqICqJVWRK3Fu7MSNCf/O8bjwN9VYbne9uUIQS9p57xVARnIZEc0sP
	 CFkwiqsARF5rdlggxNZAI7t95Zr0SLmkfHcxxGn1SHR1RaHhBE6Pp6tswAOFotKNfM3cm
	 dCiSkpdL9WPVsCFELNMhyfxyReBAqeBFWiyMLfPqs1JBfQQlkO5fd1cy1VWJp2qiiqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303164;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=T//p5dzd+nUs6RGkT9FOPq6XfHPBSykpDW6FOc0lNR4=;
	b=r00pEz/gUfYNWhm7yXw/8rFxhfLccIteoGjI4+8KBK0XuvVQTYUfo2yviOrWEtJg9Mlc
	 pc+m7jFkFxr5Ndmzj2yTd9f/C7TqAdqtS/oXyGmW957bUHdMUnsRTrfQqBoAqw2ie6s02
	 oC69hfzAiF2kGGqwz9TBQnbHuM2QP8tOMESAQ7odkHhPLsdQifReDMg862SAMvrzgV5wf
	 6d9VA7Myfat4KBjjsfBKK4QZJ5n1iFK76C68OMVi6Mx5HsOc5vwmurFny2VsjovwHbgBT
	 TbuuDemjOl2q2RqkYbUUnAIm2p65QSBcKlKa4tsn3VuSsZCHmvxDf9UvIQxBW/beZLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GulK2+NY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565E1606A31A;
	Thu, 29 Oct 2026 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GulK2+NY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0821F01816;
	Thu, 29 Oct 2026 19:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793303163;
	bh=T//p5dzd+nUs6RGkT9FOPq6XfHPBSykpDW6FOc0lNR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GulK2+NYu6OXLKnYDvVei/xi4VxfmAbmwxCtDEiTHb/8vs+0OVId/fFcGBEFATnow
	 yZA/8vcNf3pTFb+2lLOJgTW4husYkV8NNGxrDLFYQGZTIHXRYHSoJDYVHWBfYyGAnj
	 yHWsqZz2XQH0dzK+2GEaeLyQ/NdaEWgjXPSvd+zjoL2axQbey7kZ7wf++0Ol0AxRLG
	 lqgzq4bJMekgaEw03n7nUU7HO8awdq6P7W3olyFZW12dk4Rm0we+anS7RWK3absPDR
	 zR5l4M8hdWhcGbFHKpc7hoOeAzFh/tjCpFrYk//Shd3e+DjTBjeSr0pTjkC9WSKhnu
	 H/ZA3qzeh1SPw==
Date: Thu, 29 Oct 2026 19:45:54 +0000
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
Subject: Re: [PATCH RFC 11/18] dt-bindings: firmware: add A210 SCMI clock and
 reset IDs
Message-ID: <20261029-lazy-salami-cabba2657632@spud>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-11-74d58ce85bd8@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="j1YaT5ntQHv0iC48"
Content-Disposition: inline
In-Reply-To: <20261027-a210-scmi-v1-11-74d58ce85bd8@iscas.ac.cn>

--j1YaT5ntQHv0iC48
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:37:02PM +0800, Han Gao via B4 Relay wrote:
> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Define the SCMI clock and reset IDs for the A210 UARTs, pad controllers
> and AON I2C1. Each UART has separate serial and APB reset lines, so
> they get separate reset IDs, numbered like the matching clocks.

Drivers will never use these, it's all just passthrough - is it actually
a binding at all or should it be in the dts directory as a header there?

Given this can change with firmware versions, and isn't fixed, I don't
think it is actually a binding.

>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  include/dt-bindings/clock/zhihe,a210-scmi.h | 15 +++++++++++++++
>  include/dt-bindings/reset/zhihe,a210-scmi.h | 13 +++++++++++++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/include/dt-bindings/clock/zhihe,a210-scmi.h b/include/dt-bin=
dings/clock/zhihe,a210-scmi.h
> new file mode 100644
> index 000000000000..b8f6441ac650
> --- /dev/null
> +++ b/include/dt-bindings/clock/zhihe,a210-scmi.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +#ifndef _DT_BINDINGS_CLOCK_ZHIHE_A210_SCMI_H_
> +#define _DT_BINDINGS_CLOCK_ZHIHE_A210_SCMI_H_
> +
> +/* SCMI clock IDs; existing entries must not be renumbered. */
> +#define A210_CLK_UART_SCLK(n) (n)
> +#define A210_CLK_UART_PCLK(n) (10 + (n))
> +#define A210_CLK_PERI1_PAD 20
> +#define A210_CLK_PERI2_PAD 21
> +#define A210_CLK_PERI3_PAD 22
> +#define A210_CLK_AON_SYS 23
> +#define A210_CLK_AON_I2C1_IC 24
> +#define A210_CLK_AON_I2C1_PCLK 25
> +
> +#endif
> diff --git a/include/dt-bindings/reset/zhihe,a210-scmi.h b/include/dt-bin=
dings/reset/zhihe,a210-scmi.h
> new file mode 100644
> index 000000000000..53e108c15407
> --- /dev/null
> +++ b/include/dt-bindings/reset/zhihe,a210-scmi.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +#ifndef _DT_BINDINGS_RESET_ZHIHE_A210_SCMI_H_
> +#define _DT_BINDINGS_RESET_ZHIHE_A210_SCMI_H_
> +
> +/* SCMI reset IDs; existing entries must not be renumbered. */
> +#define A210_RESET_UART_SRST(n) (n)
> +#define A210_RESET_UART_PRST(n) (10 + (n))
> +#define A210_RESET_PERI1_PAD 20
> +#define A210_RESET_PERI2_PAD 21
> +#define A210_RESET_PERI3_PAD 22
> +#define A210_RESET_AON_I2C1 23
> +
> +#endif
>=20
> --=20
> 2.55.0
>=20
>=20

--j1YaT5ntQHv0iC48
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOicgAKCRB4tDGHoIJi
0nRKAQCSAL2ueiPMHjMObm/56vK9Z9iz6fiHz92RtC5Jf8QRIwD/YIsAtrtE4TAM
quUITnSpm7b/sphBMJW2Zw6RLTkZmAQ=
=RNBV
-----END PGP SIGNATURE-----

--j1YaT5ntQHv0iC48--
