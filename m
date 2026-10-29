Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793303606;
	b=wSD+ECNwrGcJXJRuKEfQzQRC/rkSJCxzwQ9oBVaAA9RRtzN5CsK/cryOM3FZiPHlPNPA
	 J1lFsBdNdk79olknosPgO1afM0Kp77xIUnp4xmjI2BCmbCZJbvMUwx2Gq1/ZKz6/3AxN9
	 qPkvvB4Bah6ZYkHKaI2dxugFBl6sNV7/EkToN8G5qDjhyB43PL+sRWG3ltDDhjhaqtemi
	 N3/SapwoeIWUztE8Q8Mq1KJu7pvZroSsUcvIKUNoalWQGcNJzzj48sZXBJN3lcYMONvMw
	 K4/u7vEVdQmzOnxeVTVbV1I12mPRmxJgaFKRi2waVBqz9hOUf7UWHlo1P/DBTaya46Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303606;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sxufEbmJccbPCMBIVWCkzuEvgvSqJww+j7Cv/utg30c=;
	b=nGABrRlKuRdHbNNeL+hDPldoBsjpF/wKPlH9Xr7Qmd7IvYEnj8YcRPRhwIZ88nZPpG80
	 9bDIpeRGhsny4G+OUQUpdrS//JmLKgDSJA6PE6Dum7S1d2Jg24dPcgXejb2SZ7PiG25H1
	 omWFKeYRzKMaASj50uoKzvY95SB6i6ttqdHAEmhvomML5AeYF+7BeRyyhvwJHmXtmieYq
	 kAYWje/f3uzCdgPml05T1XBlv8JrGRIU/RkDvnjQi1VmKb8X5oPAzAdUTfFQpdQAdkQzu
	 1Qdtli0mufBbV1h8HKu9JXobmrnDljC6t26GneV5M4H+Rov7vXcdY2TA6FQWVjRAbyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuzKxIaK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DCA606A31A;
	Thu, 29 Oct 2026 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuzKxIaK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6E11F01816;
	Thu, 29 Oct 2026 19:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793303606;
	bh=sxufEbmJccbPCMBIVWCkzuEvgvSqJww+j7Cv/utg30c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VuzKxIaK1tOS0QvcCfnoS3lX532BUYdgQ2HPsgUhMZ57Uaj2IxhzN4UsDX4okAdIV
	 4opVn1/ygbhMc3z3Z2yppkD7zhFyP37vkwDSlDx2iEf9G7+wdVk6sfHh8+Un6xEr5x
	 0fB1tbaKdt/TyEQFA95vSPN8K9e2ffoUIk+N71AeIkY1emvKO+t+Wfv/M8mdo9cSyp
	 ab3W9pWHEO/+P0R7Rhthj0dtNhUigysikpMynCiEKBkBzqkpxUtUkQpCSxS/hsU5dD
	 5tXjrkzTznS4xWo7lvxqskebO5FC52ObdsIa1JFXqSnNtfc6b9ihbEGbJokZRlQcVg
	 3HBIIifVij5zQ==
Date: Thu, 29 Oct 2026 19:53:17 +0000
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
Subject: Re: [PATCH RFC 12/18] dt-bindings: serial: snps-dw-apb-uart: add
 Zhihe A210 UART
Message-ID: <20261029-imagines-suggest-46436f99114a@spud>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-12-74d58ce85bd8@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="NHW4k1IZxtJrQ5WH"
Content-Disposition: inline
In-Reply-To: <20261027-a210-scmi-v1-12-74d58ce85bd8@iscas.ac.cn>

--NHW4k1IZxtJrQ5WH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--NHW4k1IZxtJrQ5WH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOkLAAKCRB4tDGHoIJi
0uS0AP9yvaqaeXIgZ6Q8UiuXm3rCSxIas74cfCcrHRrYUjPouAD+I1PZv3LKS1gm
ahygoYVVdGzKpaSEjzWcHGQkXEqtnQc=
=IozQ
-----END PGP SIGNATURE-----

--NHW4k1IZxtJrQ5WH--
