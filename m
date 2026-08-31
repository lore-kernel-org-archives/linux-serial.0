Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E841BA75
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185991; cv=none; b=dz+dTv5yajpKX4wx9dVd2phjOeca5nSASDJT8Xo5LB0LLewz2TYDNcepNIArd1TmrnvLFKai37VII2t26KJgHCJM1Tap/ofkxPsKomH2cZA9fGTWgy/td1rqM2db0gm99jRPzE763jgalvWirn9HHDB5jElkaUU0q9ebr5yM0ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185991; c=relaxed/simple;
	bh=gPx3cMwdaJKw8OV4EZwEYvs9OBsKo50R7/2fNZ/mYoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UfDP102WckZ7YxP1NNqs6tlp0pD6/tivYE5tipwkd7zAp0pA3F6q75RzBqZ/FkiY3YN2yWtpdr5f0DgXHSN1tNIOOViEYOLsC86fJb9tETLTmeUDMNR1rajMH/lzrXpkq+8N3uOzpPvv3XL8Icxw3EJP6y/br69jfO0J1DpEytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRVqH8ww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRVqH8ww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FE81F000E9;
	Mon, 31 Aug 2026 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788185990;
	bh=gPx3cMwdaJKw8OV4EZwEYvs9OBsKo50R7/2fNZ/mYoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gRVqH8wwR+D+fQvWhmuTNKEcv2niYqpDzn9CpEC+yxei21ZmqhZHASHYg/Bb7irtw
	 wnbE1sVvts//pUE8+bG8Uvgq89XuFuOUk7o48g6T0xPmOG/Ew6ywdpc8dWVWt5F5HJ
	 56KAtf4GRU5JmPGODh+S/oknJmYJjMCr9tWDp0Nh1wwzzryNRDmeRLs2haeoyswBUm
	 Cre6AbHwcxXlSIAwbwgS4n+S4gsiIKomvgS5WtPXTbqU4p03QeirjXO+XVTTP0nuOH
	 RzpKz81tN5wGYyYs/NEhar0sAFAOPMy9Flyh9+8QWb7x7sY3RbuaKAsE550yCwVpUM
	 Z7tFz0LYjHDJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] serial: 8250_port: recognize UPIO_AU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260831133314.4125787-85-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-85-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:19:49 +0000
Message-Id: <20260831141950.12FE81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Manuel Lauss <manuel.lauss@gmail.com>
>=20
> [ Upstream commit 49fa670efdfdd27e29145cbd2beef065c08717ef ]
>=20
> My MIPS Alchemy systems generate the following warning during
> probe of the 8250 driver:
>=20
> WARNING: drivers/tty/serial/8250/8250_port.c:462 at set_io_from_upio+0xfc=
/0x124, CPU#0: swapper/0/1
> Unsupported UART type 4
> [...]
> [<80521d40>] set_io_from_upio+0xfc/0x124
> [<80521dfc>] serial8250_set_defaults+0x94/0xe0
> [<80520fb4>] serial8250_register_8250_port+0x288/0x51c
> [<805214ec>] serial8250_probe+0x160/0x1e8
> [<8053b5f0>] platform_probe+0x64/0x90
>=20
> The least invasive fix is to recognize UPIO_AU (type 4) in set_io_from_up=
io()
> and do nothing, since all parameters have already been set up in
> 8250_rt288x.c::au_platform_setup().
>=20
> Run-tested on Alchemy Au1300 platform.
>=20
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> Link: https://patch.msgid.link/20260430135822.905035-1-manuel.lauss@gmail=
.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-85-sashal@kernel.org?part=3D1

