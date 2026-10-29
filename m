Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302910;
	b=qdJI9JaJ3yeC7S9f2TqUWuvIYhPV/BMeaNQTIE/tno/yJ6k6Rpb7oRWYPjJ1UBMjE/jN
	 +mUEA6HsAhpurWa3hyClbDROgT5InHZNSTtk8ckWS4ZxSok4wRqMdTWbKgENPnzl5Usu5
	 jKAF+LB0b1EWfvDb9LjDVHKUb3KmyofezChqaTAeegqRiLYAvWuxGhHRIc4POoR0kkgRn
	 1O59IKkO3ox5TSxyEaU2cl1TJO7SF3imnVbINkIkKCXNV4H7VqrHpPRHijVSn/9Lix6gA
	 RcZseGGaTCoe4sDk0NoogmJVWb2XxE6sA7yZQgDbeHfeS/wJkntGEgjUM277mU7F5wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302910;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=B17oc8WpndzlQmt4uZst9Vo/pqlNk6e5++M2mkaal6Q=;
	b=GagXR4eZQsUn1wVirz4eghqxQEGUfSFWTsbq1iAvK/BSnEgndVVfD1BvkKQq8Z6lrHRW
	 hBQGLIzCNqKKTfy8+GAZ84ADscDpco/z2XxWokvIFxUkVMXEo/4EBA3bB4YAEWWoCdj1z
	 syxEX/XuxSAtggxQL6owfv/IRmWoINnnLTUgVNoNXkj+WmZ9Va+9f2bJtQHrBvdxnNmUV
	 +dGw7TZhiJtY7Y6G6GT7IN6zrffwSISeRWTVBXOOC7tvUsjxu59moJ0XXmIEXwvC9gTYN
	 yKl1F614o64E0yBuUEv2AYXpYEq1gwAbyH1F7ad/cjcxmf8W8U2LX0cRfhCbhYkK39w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=brOEXCv7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D5606A31D;
	Thu, 29 Oct 2026 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=brOEXCv7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6161F01816;
	Thu, 29 Oct 2026 19:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793302909;
	bh=B17oc8WpndzlQmt4uZst9Vo/pqlNk6e5++M2mkaal6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=brOEXCv7ghTKpvSCrtN65OvP1JadGCZnR0AVm2KJBlxV0jnfcvm7n07hHq4Mch4PW
	 jeJTwdgTw83R/cVx2PB12wW7LD3/R2YQhRNIT0HCmely3WIOwYC6dk4tx9iQNVyHbg
	 qgRTxXF9mAHV48jYAQbxR3qgNwaieg8rz+bceWBFC4pjbvIH88oRy7QjmWMgyfVf4z
	 nssGbpdnDpBaA5bEaHABoRakiIFsG1msCoONk67sNi0kwAdX+8/Oq8Rr01h/hz++ST
	 LVooCNqdQZfm058k1ywEaJRDI3bLgvMnSi3vDRpbZOKDaljUABd0W0D/57Jb3FpHbw
	 USl/lW2gvgPug==
Date: Thu, 29 Oct 2026 19:41:40 +0000
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
Subject: Re: [PATCH RFC 09/18] dt-bindings: riscv: add Melon Pi V1 and V2
Message-ID: <20261029-repacking-pastor-380e92e1ce94@spud>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-9-74d58ce85bd8@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="dsKkk7RTBz7aJOQa"
Content-Disposition: inline
In-Reply-To: <20261027-a210-scmi-v1-9-74d58ce85bd8@iscas.ac.cn>

--dsKkk7RTBz7aJOQa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--dsKkk7RTBz7aJOQa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOhdAAKCRB4tDGHoIJi
0uF7AQClUV/fqro5Tr5TDnC2Mpw74PScgpYqEc454b6R/ZRx7gEA+KLcCpIvyNI6
XIZZZW4Uf2sDbwWWSY6vEUwZk24bcQI=
=fYYP
-----END PGP SIGNATURE-----

--dsKkk7RTBz7aJOQa--
