Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B986883F;
	Tue,  6 Oct 2026 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791311015; cv=none; b=q29onyRhN2OXhrp2S0Y5FJ4pSvTT1KlVab6Rq2IR/IF/2u60k63DiSGBK50+3oe+iLqKgMtxee61vAtCtHvMzYZuXofgnCR8Pn0+nAWkZD2vxiaXgVFzPiXwuyhExhxl+WCC6SFMG18lAsw3ofPCRPGfB96Ob/Yi4d7ZBDY1J34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791311015; c=relaxed/simple;
	bh=636E1otDySw7WLEp51vh7Q8cOz2DxHgyj8u45zofOeQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nPKgWWo9l9Jw6RjB2zK2R3IFnm76oyP35ofbPZGisDiwHSURm2Xf+F46GaXBmZsQSDKtaTWzF6gH18dm4C+L3QJPgpamXyPYUJSdDDpTsC0dDJeNrlVerwaTE6HyNeoncgFN75O35MWg7uvmwTizxYcLbk5EUEKruMFs0bKnlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ7wQ6iR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ7wQ6iR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE921F0089B;
	Tue,  6 Oct 2026 18:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791311014;
	bh=636E1otDySw7WLEp51vh7Q8cOz2DxHgyj8u45zofOeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JQ7wQ6iRQXqCMHdZQZy1VW3ZRxY5q6OPKIYeHvjPZCMDOPKAif9NGvoqV9xad/K30
	 x4BVJWi4rnY03RSO59VtzMguCl8PkndyFzX2g3gU07+YOBTQ1Cstlp1mZtXoS0iz1b
	 tC7s0ovDNDZFuubIAC2l9EojHYC453HDYrH4wNKjv2g9kR3Yid7WbdHsegfEotUig/
	 pqDk2bTsx2dT3MAfs5MxSMvLTd77jPwdEsC0rdk+k06VMhSgVk0C95HkvDpGJ5mYaT
	 cY/AG3AA1azUfU3hMRGshX3kwkiYGpHW9kPQkbpgWWHVSrh90CvlyNO3l0k5zYqaFK
	 kENtCCH9DYBjA==
Message-ID: <sashiko-outbox-162338@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 08/10] ARM: dts: cortina: Add CS7542 SoC and
 Securifi Almond+ board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261006-b4-cs75xx-v2-8-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
 <20261006-b4-cs75xx-v2-8-b7d6e1e24d44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 18:23:33 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add a minimal description of the Cortina Systems CS7542 SoC: the two
> Cortex-A9 cores, SCU, GIC, global timer, private timer and watchdog,
> PL310 L2 cache controller and the four on-chip UARTs.
>=20
> The peripheral clock (APB) runs at 100, 150 or 170 MHz depending on the
> boot strap pins. Until there is a driver for the global control block
> that reads the straps, model it as a fixed clock whose rate is provided
> by the board.
>=20
> The Securifi Almond+ is a touchscreen Wi-Fi router with 512 MiB of DDR3,
> 512 MiB of NAND flash, a QCA8337 switch, QCA9880 and AR9580 Wi-Fi and an
> ASM1042 USB 3.0 controller behind the SoC PCIe root ports. For now,
> describe the memory, the console UART and a ramoops region, and reserve
> the top 64 MiB of RAM which the vendor firmware hands to the packet
> engine queue manager.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-cs75xx-=
v2-0-b7d6e1e24d44@gmail.com?part=3D8

