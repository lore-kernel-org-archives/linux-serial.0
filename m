Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793303308;
	b=JbvL6kq4QJj0/xb4X6jP8yrs95ZUAS7ix/nNHXo04SAvk7Nti4p9HgavF+uS89Ctz8WY
	 txcH2N0PfCJJAPit15bVlbfWJdqYwpAgn0woGd3J1FwPB4wmxAmXGt5LSIsk5h4CC17M7
	 mTvOP/r8l2kmS4B7DuV96q1Klcn8Aw2WTS0Ndvvs0jZIkVqUJVS/sMgd6b6m+o7EgT8WR
	 P/stEFLaXDzccdd1NqUoL/H3e/lttWJwhRCfALkrWYzDOt1R2XoINROQkwhcFJzJ+pyOp
	 BatX3GeF+gGfYStgIOoVp9hVaUpxxy662LVk6gorXlZyQ4ePrOQBWO9/TJW/XKfy2cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303308;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u252tjYKu8WES2GFHaIRhebsdub9EY80KrpQW0NOE88=;
	b=GWGN9sWdBBziVRZ0i4pfuYsYAm/3cOFXxxFxG2ZQfKKcJujp2JQdZKirqWoWmZrPyX8I
	 kIMCsSyvG/RgP4ijVpZLVzLtj5C/hNWMEHu6iOInqoj6FICZfDtTfpF5QVhI1GFhq4++g
	 d5KPoN9N7QTs+OW4nq+1zYHLJvYHT3rEYX8nylrAGzzHJPBWQO/yy9AKoH7FpD1GPjFeH
	 zdt2lESrLOeKbDtiF06vxaoPAr7U3c5ESTMLA2D7UfWnxwL9V8z3KcobqZGuHocPD7dTu
	 YVgCFTcTHfDY/L9Ct+t4IFl3LkLIurpnwn2rWV1hemcLeOcLfbiA0/1QWroaDTlfNJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGzL1GOL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78270606A31A;
	Thu, 29 Oct 2026 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGzL1GOL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111541F01816;
	Thu, 29 Oct 2026 19:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793303308;
	bh=u252tjYKu8WES2GFHaIRhebsdub9EY80KrpQW0NOE88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iGzL1GOLHsp9NYnOCGpNkmncl26bVqLnagbMlr0KRI9G3wEXzg6em6NxcPtL2GCNf
	 0ypl/tQU25ITnD0hK5MNjbbpCDg4AprAKGK9CuLTAncEaDD50HYKOS9Y1TB93kjXyq
	 OMrvAOXmMAS/A1lCvqHJwbkfs9FmscK/sfcUzUV9ib9G0Mt0iPll/bPRDnWxHORh5M
	 2IVZ28FQzvF0S1GyVa8Mq7KZ4xXW32RPJ6TzQkGiYlT9soynbXioyO6jZe+V09gpgm
	 /YabrN1IOs9SzcDy7/Cz1FBpJd4ly2M4GC7Cf0kwk5MTPo6kU4Hp9gUFIQ/DUjrSQU
	 ybzJKTrYFCTIg==
Date: Thu, 29 Oct 2026 19:48:18 +0000
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
Subject: Re: [PATCH RFC 10/18] dt-bindings: timer: add Zhihe A210 CLINT
Message-ID: <20261029-january-outplayed-7b3cc08ead9f@spud>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-10-74d58ce85bd8@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="W7hKehumc3z37k+1"
Content-Disposition: inline
In-Reply-To: <20261027-a210-scmi-v1-10-74d58ce85bd8@iscas.ac.cn>

--W7hKehumc3z37k+1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--W7hKehumc3z37k+1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOjAgAKCRB4tDGHoIJi
0ltpAQCa1wSwznBTy+fR83zbHqIQ7ceLE46Nv6Rh5+ETvcaylwEA9+glYYWU0dU+
Z+BQlJxBMAMKiT4bjKK4hdt/kOnCqQw=
=/QQ+
-----END PGP SIGNATURE-----

--W7hKehumc3z37k+1--
