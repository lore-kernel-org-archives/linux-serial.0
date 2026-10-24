Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792880028;
	b=1JQwyEbDQpFf/zjMcZELlbNnVPMAAv7lr12pelhpoAYXYRzdvPf/Q0Ci/g0HgeckzCul
	 7mXkZPQEcLATpO/P4sKfNJJofNBHWEeMCqnBmW8hLKJdGskm2wgZAiz/HwkXpeY6+80gZ
	 pzH9uqzy8Ohti/XX2BI+N1RZhUyj1b588fZxs/cUjI3fp9shHqP3M534zhaRIsi6oJ1F6
	 aBfoHkwcFPy3ywSsW0B2muiHG54gyMMmUkiSHELbIeRXKBeUedy22t7ROw6+KnXjVYkc9
	 SDFcW1W38SX56qhBQcax2gjfYJZ4pi5dKonJDaw9ZoQ23EX15gf8URMHbCDw/Djf0YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792880028;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+4MBVaVzNt0GZVO6eQK469IjMSEa21LCxzv3kU74efY=;
	b=jJ/5PTDAWsLIZvhyK4ibrwK/NgULzrCE645Ex+N2cdLUVLTotIfuUil8oM7FW/+FFfSN
	 gNjvTTH5vj8h/Nlhu2SzDJr76gle3HfdVbJDHBC2d8AONU032pHHnpwDA8Eqsdm84NL4j
	 lXgnWEzuClxchcrK5zHe++KhLKFhiv6uAU+vc9GaB9LnI4GFa7x+OUOpQZVV6fBRU06GK
	 PJHLf5vKJO0GDlAxT2ulpL9mP+oWGmNCGjJEfCcKpk6HrtOmq8KQEihjOLiXgtAR/u/sr
	 w9OOEcMUj4Ys8QlPwUhmpyukqDeO6QadI0s2IR10LU91ua4QmTHHBDPysn+8Oa1yREQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hokd/BfW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC91606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hokd/BfW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CC31F01825;
	Sat, 24 Oct 2026 22:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792880027;
	bh=+4MBVaVzNt0GZVO6eQK469IjMSEa21LCxzv3kU74efY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hokd/BfWVEx6O816NPqqUCV1xfWTsU02wjhSrvgsQjW8DDeWvbwp1NotSEDdtsqL/
	 cNiswR+zJvmXEtpmET/VANAyFEe4dNA0i9bayqDr5wGTLZZwJQQYeXcmItMECi6xNA
	 j4Dd4bf8xA2BqgWIXnVpM/v58ko4x6xtjUqRzokSEoC8yM8hFgbpfhBu4s1nlhHgEb
	 B51+JEHpMcmzv/GLX9mckyk3se+EyGFGShZZUpl3CZxkeykdFhhHBF4DWjKVF+LMEi
	 Ga1w6qtYEuDWRMaSo+TRqbZ4H53Czec9oWZDduPrO2t62ZTruWRx2CPdOe9ZxKQXR+
	 T0+7IAd+W7vrw==
Message-ID: <sashiko-outbox-183921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_ingenic: Set UMR and UACR at probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Olivier Louvignes" <olivier@mgcrea.io>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024220712.23250-3-olivier@mgcrea.io>
References: <20261024220712.23250-1-olivier@mgcrea.io>
 <20261024220712.23250-3-olivier@mgcrea.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 22:13:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Ingenic UARTs have two registers beyond the 16550's: UMR, the number of
> clocks a bit takes, and UACR, which adds one clock to chosen bits of a
> frame, for fractional baud rates. The JZ4725, JZ4740, JZ4755, JZ4760,
> X1000, X1830, X2000 and X1600 programming manuals all have them at 0x24
> and 0x28. The divisor the 8250 core computes assumes 16 clocks a bit and
> none added.
>=20
> The driver never writes them, so a UART keeps whatever was there before.
> On a HiBy R1 (X1600) the vendor boot loader sets UMR to 8 on its console
> UART, and the vendor kernel had left 8 on UART0, which carries the
> Bluetooth chip: every rate came out doubled, and the chip never answered
> ("command 0xfc18 tx timeout" from hci_bcm). Their reset value, 0, which
> the X1000 and X1600 manuals call normal mode, does not work on the X1600
> either: with UMR at 0 the same command times out.
>=20
> Set UMR to 16 and UACR to 0 at probe.
>=20
> Tested on a HiBy R1: with UMR at 0 or 8 the BCM43430A1 on UART0 fails to
> set up; with this patch it comes up at 1.5 Mbaud and streams A2DP audio.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024220712.2325=
0-1-olivier@mgcrea.io?part=3D2

