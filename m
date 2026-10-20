Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518457;
	b=zjWm7fuQeyRzhzxwvPXwyPyK7sZYGDnWa+i3XbhMJOuvHgYv6/Y17D2fYEdyH+FqxAMe
	 kRytRTh+3eLJKIwQsgKiadn2sGurjd7FEGBlyfC1DNZGqkdWl5+/vz5DjnIt0f/ELk8GP
	 6TIKAq1tAxRi3UqU9sKN5P7UrjmMY7EmVkE4GRF9SRx0KnDqt2EM+MVM8PuKOb5B2c2xM
	 luwnoIL3dJ3BBaoDX1Dl9FMqrZMKhHU2vY1FzciY+w1P2SQZFKir2hbKtWnCGyahXn3Ux
	 PtUEnRAkI+rKCvJ6YtBBaYCLXVTN9QYv+1S9iGh/0b/j/qsVngF8cR3zZ7RkCtPCn8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518457;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HAHTPseBysoQyjFWdWhxEUoIlAFSx4P0uFPxuTZC58E=;
	b=smb4Jc+a5a1XM2LYKVQf6zWxcFgrMlenHB9wkPpYAESb50liPqL6LRws3ZYYSQOTWKlU
	 c2zFYqTQx2zJZsoGmy1eLU2Wvayix28rKuDpwQkfaybD3Tvdr4ZycAHLeJVdSw1NibCkF
	 cZbnEt9Kcu813TMJtHhvuLE3+I/7SYvDPIZpHvj3a6zmkrcSM1rMuyXNSG8pCn/4RXT/R
	 jgwHuA1/5BJ7NT+4xsQxLn4wL+5Sqjrv/DkkkugT8HceCaN4/WDq4lu1ngy1gd9CPLt/Q
	 IqM3iYEKjutzoNBnnVE3G24intJoc9rQQKJlCJPisOqgHuVwO7y//obe6sL/e/MbbWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5klA8w8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14390606A319;
	Tue, 20 Oct 2026 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5klA8w8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C7C1F000C9;
	Tue, 20 Oct 2026 17:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792518456;
	bh=HAHTPseBysoQyjFWdWhxEUoIlAFSx4P0uFPxuTZC58E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T5klA8w8ldhaGXex5p2C1vk2XmCWEI5ePLrDsiyhXLVFchdZEn+v5/j//jHND7keT
	 Meqe1HYRaPtXccMkRp824RMlBY/ggOISFpPO91xfQXQlxRa2BEF/hHxRG/jK8L1CgQ
	 9muVPdNXFcV74oJ2Dgz4HaRViQo1tQbIdaPr+01vyY4wLmybDhkP+Vl1I+bioV+Ygq
	 uCkDYDCq983KX1BvcP2HAwIVds8N7k+Rqtsxjca0Ovu269GytYQIsu/QGvdh3m3Bcg
	 UwXzztQF8VoJ3nyz6bU2aIRxqOIpInSrUm2TtfG3URLEtNoUiddkCE0GL6sKdGKVFJ
	 c6nOo9rgiy+pg==
Date: Tue, 20 Oct 2026 18:47:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org, mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/20] dt-bindings: i3c: dw: support up to two reset lines
Message-ID: <20261020-endocrine-crown-c6d3c83cf436@spud>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-5-jszhang@kernel.org>
 <80b084d130b7dc7406ae23e54a77706a4f42b606.camel@pengutronix.de>
 <ata--JFFUzSoMock@xhacker>
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
	protocol="application/pgp-signature"; boundary="PF0S8SXN4APeQtUF"
Content-Disposition: inline
In-Reply-To: <ata--JFFUzSoMock@xhacker>

--PF0S8SXN4APeQtUF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 09:08:08AM +0800, Jisheng Zhang wrote:
> On Mon, Oct 19, 2026 at 02:55:14PM +0200, Philipp Zabel wrote:
> > On Di, 2026-09-29 at 14:14 +0800, Jisheng Zhang wrote:
> > > The Synopsys DesignWare I3C master controller can have multiple reset
> > > lines, such as core reset, apb reset, and dma reset.
> > >=20
> > > Update the DT binding documentation to increase maxItems for the rese=
ts
> > > property to 2.
> >=20
> > The last sentence just listed three reset lines. Why increase to 2?
>=20
> Per the doc, the last one is dma reset, currently dw I3C driver doesn't s=
upport dma.
> And increasing it to 3 is still dt compatible. Maybe I misunderstood
> something. what's more, I don't have platforms with all 3 resets to test =
and verify.
>=20
> If dt maintainers prefer 3 in one step, I will sent out a follow-up patch.

I think you can increase it to 3 globally, then restrict to 1 for the
altera device and 2 for your new one.

--PF0S8SXN4APeQtUF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatepLgAKCRB4tDGHoIJi
0nTbAP41tIofP+UpvSN0IwKJvT76VMbRwSrA7SIYBjKeyCaPgwEA7iCZGXK59MXH
F8eKb5c+ngwawXhmX7aqW4NflYqjyAY=
=Yxu4
-----END PGP SIGNATURE-----

--PF0S8SXN4APeQtUF--
