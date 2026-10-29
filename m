Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301686;
	b=MjVA49mb7c5oTy7RYqrQPCGpxPPf0aVQq/WqWqjo9gedkT4Jb7nsxdexGQlGULzGwRYx
	 iVonTDy6WUGZwVlLD9om8pQcfOPlde5UY5oRaMDZIl3utt3MoPKT9IXR59fj3xBXlJazs
	 p5/0tVtaKKWnebGCgQgGqC+ZaPRXXJEZwT7XPLDrDdKBGpwIE3aX6rK7o3MGedr8JJ2NG
	 Zq+j/W+qg4zSL1plpedD6s0SHKG3GhurCAaPLYLhjImoo2gdyUYWabIYSkrItXZKOE+UK
	 6p7Y9+VsR1Ix5jva8hndGVAgOs35Rn8Y3m1QY7uSgxC7pN43SUHs8SSxq3dm/nst31g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301686;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mB8QQ9/vuRBF76kR+CudZygjTkN8E4l9aL3S24NkFsU=;
	b=F+x1kn9Dam9+H5mJgzYo6N5jT5OIU1kmazsWHYGzitFedYNfiscEFHaKWe0Mr5BVMUG3
	 H7AMT2meFq7n/CCx2mGi5cxZao8cTYXRcAuEJLmVuPAr7Ok1OK1gRBU5KvuSgRUu8as6S
	 oKNcoMzfiPFEd7st1LeFS6+SOgEioQXTWQ+A03Dh9HK2g65ircIYNb9v8uAwHbBQ80lAE
	 OkCDXcIuPHM0otmTKOdxnuIwNdK3O2NvzpIZg7wP5QX3cAjrAbA1IcxOO/Rlk1AEt7+cW
	 QSc/EyHLnPt1rGr3jftDZ60JXBGmagdExhrygSDUOSegw5J6jB/LdrNECKLjRXclrLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAuzTLXi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6508606A31A;
	Thu, 29 Oct 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAuzTLXi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5314B1F01816;
	Thu, 29 Oct 2026 19:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301685;
	bh=mB8QQ9/vuRBF76kR+CudZygjTkN8E4l9aL3S24NkFsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XAuzTLXiGvC8VQP+nWevpaO+TsHjId4xLBvJWdQcv63R3x9XoN+Q/vGXj4CVBc57I
	 pC5q33SQ0UrPpJ1emPMBwAXIwrB8UexTYCEbNzxV37Ssahkr6ehEcyJU04FsmfLkYI
	 fe3vP4rgoJ4SnriSyUAoZ2v8mH8VIpTcj95TJalpCKYqaf9JiXglZfxreTyyjVku5v
	 UzebI4qJiXKPLFsg0hsAIlqFX7reNKWjEQuqgiHmG1dDsqeUY+cYAWmoINte08cOoH
	 r5U+rE8gAv4g2hVhVCGijCSqa7pUL4JR0vuQj1cEujEepOxfKU5rTzXL4CtaA+1ZtS
	 cKUispFNm1INw==
Date: Thu, 29 Oct 2026 19:21:16 +0000
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
Subject: Re: [PATCH RFC 08/18] dt-bindings: interrupt-controller: add Zhihe
 A210 PLIC
Message-ID: <20261029-untimely-zeppelin-b623272dac92@spud>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-8-74d58ce85bd8@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="xQea4YahfBZW6fDj"
Content-Disposition: inline
In-Reply-To: <20261027-a210-scmi-v1-8-74d58ce85bd8@iscas.ac.cn>

--xQea4YahfBZW6fDj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--xQea4YahfBZW6fDj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOcrAAKCRB4tDGHoIJi
0lkuAP4j1Syr4NaSYo5EgKM2vK/7/8yKlgaO3jdnsqLsLpiHOgD/UFmkhvm6cmzg
4hrX0XP8cpTtSUPiXYnApAVxiVf1CgM=
=4vU2
-----END PGP SIGNATURE-----

--xQea4YahfBZW6fDj--
