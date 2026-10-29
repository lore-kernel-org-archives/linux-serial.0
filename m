Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793303477;
	b=d+rQN16V2ZpSs43SDeql3JQp8CQKS1vonwbrG3FhXM3HDk1Fnp7njjczmlbE5cnBeW5/
	 B7s1v1WA4IJjiyk94DjdxB7JW2aLt1IxrKZqxa0y0mnxyaROnrLuSjaAhIQSXuoyTBisp
	 cZ3/9WJxqkaOrrVLuI1irVzLvOXpHQbG9wm8RnqKEMl2i7m72TzWZBFpGvLrEIJbpHFos
	 GT2XP7YVK8oZ9YJQvsdITG6Oss7dtr63obfX7L5yVNx19Uc8Bd41vSWa+x+c6n9+5j8na
	 7Ku0yyhPRQRiqK2CGp1PGFVeIzU6pWKGMnPGd8pJD68Kx+s33eLZB6f6csa1vo5xFJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303477;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KtHmkWpVa9EDMKk9zLknJHt+iL+tMZYjl7Y0pmLSU+c=;
	b=csnyHxMmAVoKt3bn3hDAHgKmvbnjdwTc8SygyJAqKlgWucYpQVEcjx8iv91RDV8UoP16
	 DVBFsZRwN2ygshqgdd7KlYQ9LQbvmHvNMOkgAKZ3M6K4gm0DtK/NsR9K9eBd/bXxNyN0i
	 hommciLghuguubtMIimJan4CDJJgXEjpyywnCTf6SOedKwOvLvfYMTxlGsX5+yfEV0Vb/
	 kQFWE3LaEUOOrU3yzNQlIm4f1q5P4WLQioHsw/46d8dfMuz7mdDwYbrthY35kw9ggtyPG
	 JXVhG7exq3tODy27wzKdXbs/Mts6UahmGwyPXxID+J/FSiY6rRDdIxUTrb4vbIB0bOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKCgzPgE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CE606A31D;
	Thu, 29 Oct 2026 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKCgzPgE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3331F01816;
	Thu, 29 Oct 2026 19:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793303476;
	bh=KtHmkWpVa9EDMKk9zLknJHt+iL+tMZYjl7Y0pmLSU+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CKCgzPgENPrfcm5i3vjXyQg0c+ZufGV7+m+uwxUpTjSEbPbjc8qJiilkNvFQYE5et
	 VgMOOhqhbTSSjUeYp/6lt2PnmK/aR9b6LTMldxDANq6V3Y2nz+9EAMay6+0vOt9vDA
	 LM5nw/aQriOfcORoVIhPtOdOJ4qVM7UvejYvHOztoQzzmeSEua6PrqOAQhT+7nORsL
	 zWY5bLanEqPNrKgTUTcPerKK6LM5+zOEmlrbHrzKSZq6zRSNj+HqkO0oqE/lGdzio+
	 z8aNz1Js71e+L+ltR1Bu/wjtFfv9Y9LSBo7UY98hGDqeQfeNn8skonOU4+bQ8cLadM
	 nTuFlXU0rrQ1A==
Date: Thu, 29 Oct 2026 19:51:07 +0000
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
Subject: Re: [PATCH RFC 02/18] dt-bindings: vendor-prefixes: add Zhihe
Message-ID: <20261029-battered-wistful-2bded2acb9a0@spud>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-2-74d58ce85bd8@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="LnnD6s57K7/oxCyC"
Content-Disposition: inline
In-Reply-To: <20261027-a210-scmi-v1-2-74d58ce85bd8@iscas.ac.cn>

--LnnD6s57K7/oxCyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--LnnD6s57K7/oxCyC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOjqwAKCRB4tDGHoIJi
0m4zAP9hOWNcLGo/D9ValB0XwlKB6J17J6HXMj0W9RIVM1WKDAD/RnMCJ3/9mjw7
f5eVmKa348OJDviBDEXzpcZx8aR8xAY=
=M8+G
-----END PGP SIGNATURE-----

--LnnD6s57K7/oxCyC--
