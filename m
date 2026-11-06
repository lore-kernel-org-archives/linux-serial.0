Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987716;
	b=hHkN4UUgI4Ntt7u8pWYR3mTRXEG86zhHhjkZNNj6b8Ypgvcx0+grckRs3TPRSUXQ3QTT
	 m/lzjrUKvqgLOM38VBrBLWVdkuy/6JMYs5i/yqxGnglf0vTuvhgR2tY9QmXY/+/M63xNP
	 T3PAvUgAKBjpFMwiEx7vjBOMSMdfuW0kKqZzdRtPemEbFmdFRpMd1bgQ94Ju0jvSSf3Rz
	 t/qwgMKNgEe93A8dT8suGYCbGZZf6wHatUi1kB8VXAooHJQfIofW0lcwrmC0sgO8PdZlF
	 dCsfvKamOw9c0VPUyDesk1DO31hxcy/FulcUCTmLHrpkkB1uyeXIrUH9GfGuC3d9PDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987716;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Slw7IzCaqPRYPs5qP8w8RJF2WXLJYullyRST6UZQnck=;
	b=fmDszjLN7kjwgGyGd3aAo1u/KUDEQwf6bt3mAFLCqKfaKkrujdpTfEmn8vvLids3ev5G
	 7wjOwmlWu3xZcsatrBLvbRGDUs3uRnFRSWLItFZEBVB0M/kKPuNXrcIUUmTRM7hnSiYy3
	 jX1pJx+RMUppqQYze/pOn2TxBPHs7KrD18uOADtP0sZQpYI9kSs2dums83RNl5/qNjO/W
	 8jQ99DvG76KlXKM9ucNQexaXCylYGSLpbXOOGLVr7OxpR731Psx7/ILoI5tD5kGiQGmJB
	 4OjqDXJ7BF/xMByI6+zEeZYDuJ/JxOB6oA2d9DKM8myAsSzYDtceO/poyvgzdNnEl7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2haV1jf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0659606A326;
	Fri,  6 Nov 2026 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2haV1jf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27191F0089F;
	Fri,  6 Nov 2026 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987715;
	bh=Slw7IzCaqPRYPs5qP8w8RJF2WXLJYullyRST6UZQnck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d2haV1jfgqlnTB4aD+TrBInUFDaA6U7aLIycswQOy7Lb+8zKDUvBJoACRr2teqFoT
	 q0WSvqwcD7aNLSd7Hr4T7k1ZCA+liji7NGYjfFCsu3bmh67LnpXiIe/++epPs9Eok7
	 VPgvJn/Zri3XwYgI0quDILWRiyCkSaIgZH2HJ+qKmgoJHvFxiHRmCP9S6EVlgEETbD
	 Z1bEFtMMXxeHJGezK6yNwIPvpPHbn7FmCvYu3uvZ9txCDCkKI0XhxHoh171kYtrFnk
	 ZWgly+CyYxfVEiUNABjpm5DW6YrcU813UvNROm6VVH4Uily+CxJA4WG6/qGc0u9Ywi
	 x72KsIaWH7+pQ==
Date: Fri, 6 Nov 2026 17:55:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: gaohan@iscas.ac.cn, Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
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
	linux-serial@vger.kernel.org, Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH RFC v3 06/17] dt-bindings: pinctrl: add Zhihe A210 pin
 controller
Message-ID: <20261106-either-smudge-c1b21b4a81cb@spud>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-6-ee6b31580808@iscas.ac.cn>
 <CAD++jL=5SypKyjwb71hT2pzTZ3s9qi62JG_EevyjTjGgTZiE8w@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="3tpStlpzQjO9g692"
Content-Disposition: inline
In-Reply-To: <CAD++jL=5SypKyjwb71hT2pzTZ3s9qi62JG_EevyjTjGgTZiE8w@mail.gmail.com>

--3tpStlpzQjO9g692
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 02:14:27PM +0100, Linus Walleij wrote:
> On Mon, Nov 2, 2026 at 8:45=E2=80=AFPM Han Gao via B4 Relay
> <devnull+gaohan.iscas.ac.cn@kernel.org> wrote:
>=20
> > From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> >
> > Add a binding for the AON, PERI1 and PERI2 pad controllers of the Zhihe
> > A210. Every pad is muxed and configured on its own. Functions of the sa=
me
> > kind share one name unless a pad can select more than one instance of
> > them, as with the UARTs.
> >
> > Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> > Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
>=20
> This LGTM, just waiting for a non-RFC version and DT bindings review.

This version seems okay, but I am also waiting for a non-RFC version to
ack.
I think stuff like pinctrl, that has no dependency on whether or not
SCMI is used, should be split off into standalone series.

Cheers,
Conor.

--3tpStlpzQjO9g692
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4UeQAKCRB4tDGHoIJi
0nGqAQD4uPonsKu1Nn5d2AXZzXklvHVCALSr5hp97wCKf60/IwD9FQ/JcPhJXo+G
8lVmOiMQ/Gmo0P47KaBRYh3sfdQOqgY=
=9UUN
-----END PGP SIGNATURE-----

--3tpStlpzQjO9g692--
