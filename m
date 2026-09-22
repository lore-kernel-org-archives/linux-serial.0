Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564124CDDCD
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066589; cv=none; b=Tck1/O+xX+sxExO9K5W8soZ1TZCZlTs5rbYvQiiRtycRDNnus1nx5Khf3/A7ZzDs36t+5Srg9vMgcDEKXuLY6wvunzuZqacMunLBjtT4qtla4gLzg9kt4OgNPnjO4xx+4s3XCN4M0GWtwbuniYJcpOoe9u4zUNolqFe2TqT+WRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066589; c=relaxed/simple;
	bh=t4EmK1sUallqBe0L3hZsyxBae7X6tiPeZAuDbPZYyfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ws8q6hEHUq6PeCCrn6OcoFTVoFVSkupsZO2pG69ehKxKQ1yAswakC2y+zSS/Okvu4HOBobpFk7PB3HNIAGuHqz7kHfMigNvQZ0n6B33jm8ilyaSYWmH4yYEatG2cdvBNGkVGBH/rr9r03B6ZV1Ns/PqRCq0BWCexGqEupS2qVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCu09aXx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCu09aXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91E41F000FF;
	Tue, 22 Sep 2026 08:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066588;
	bh=VplTMM2s8gNFKDqTjAXsU2EUJellkVe491TU3dZWecg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nCu09aXxY+gJzSyPxlPj+EosYVyKX5JixCEb5Gz2NbmuJlEpImPmx4cIZGIewmWui
	 AraPK9KTd1Ph4SSmpK2LqOpJs24D+B4J84rtF/c2woTQorWCZvudwWYdhNWeSYHqbD
	 ZDXviWntrXVOvh8RFLjyoyk1+/1jOaurpNCtOkPZ2pcVjCjZDFGrWmcWAiSzQdCn8B
	 bXnxtchECKcX04AHGN8ASrxQ539H9Fdr7mk2NDpD2zlORFN9MiwR4YHGTEvjTC0Epu
	 +wAuGLCybcipEg68wJljMWayuQUmu02loixtOofKb4NaoghI2jvFRXS7UZiGVXFGOa
	 e17eTqyvVwuYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: reject baud_base values that
 overflow port->uartclk in uart_set_info()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260922083152.4055969-4-benquike@gmail.com>
References: <20260922083152.4055969-1-benquike@gmail.com>
 <20260922083152.4055969-4-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:43:07 +0000
Message-Id: <20260922084307.D91E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> In uart_set_info(), new_info->baud_base is multiplied by 16 and stored in
> uport->uartclk (an unsigned int):
>=20
>   uport->uartclk =3D new_info->baud_base * 16;
>=20
> While uart_set_info() checks if (uartclk =3D=3D 0) and
> if (new_info->baud_base < 9600), when new_info->baud_base exceeds
> UINT_MAX / 16 with low bits set (for example, 0x10000001), multiplying
> by 16 wraps around in 32-bit unsigned arithmetic to a small non-zero value
> (16), bypassing both uartclk =3D=3D 0 and new_info->baud_base < 9600 and
> setting uport->uartclk =3D 16 (baud_base =3D 1, well below the required
> minimum of 9600 * 16).
>=20
> Reject new_info->baud_base > UINT_MAX / 16 alongside the uartclk =3D=3D 0
> check in uart_set_info().
>=20
> Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
> &ss) with ss.baud_base =3D 0x10000001 on /dev/ttyS1: on the unfixed kernel
> TIOCSSERIAL succeeds (ret =3D 0) and wraps uport->uartclk to 16
> (TIOCGSERIAL reports baud_base =3D 1), whereas with the fix applied
> TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 6eabce6608d6 ("serial: core: check uartclk for zero to avoid divid=
e by zero")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083152.4055=
969-1-benquike@gmail.com?part=3D3

