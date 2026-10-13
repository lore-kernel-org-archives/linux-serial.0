Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1E4B0E57
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872718; cv=none; b=G/2CXRl2+UdquXcsrwkdgodfDljStOobuuWbROduk1AHRCpLW5/RrnIzLsT8Som6fFldTYkd7TwZe539aUJov7x7XIN7z3cp8YGxNEk23rYOc+innYbxlCwMaA3xrCSRr4CtP6iuee7c3ofIx7/1i5LGxq59WjBbSstmo6GFoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872718; c=relaxed/simple;
	bh=ZBwDZf5/0nwKwheDogXvTURy6pHf7DA9eU+N1qGf7Cg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dPATmfm+8joZ+tTT2owKBNeL0dygzQGgP1JChetOkhhVwxMsv2aWa1sVVDgjVaaS5hlfJU8xvSkzkc12Kh1oPBpNdCUXtfpia+vwny8rTp7c8NIV96I+jkl5/IfFbhSVaKMQMPZzxieEkNwnkiXFC8Lc9zli68MoUh/Y1WpcxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfIh4WQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfIh4WQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788171F000FF;
	Tue, 13 Oct 2026 06:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791872715;
	bh=ZBwDZf5/0nwKwheDogXvTURy6pHf7DA9eU+N1qGf7Cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bfIh4WQiaG45KACLMqOLWs2Xp7jF9AXWIkGwPl2mY1IINyrhmNOoLhT90Ga+Ta2IT
	 Zv39++K4DLNW7zgXapW67MZTBJCCqVtFtd5mBOm2hoETvhDYVJhEqEnJj2pR33ODSB
	 mv36a0IuaIfTS/M/8MyoAU+5IR6PqBmnS6RD81EAeAjBmIw147t3PObSG2BCVTaCjO
	 +jPK0ZXV0wt4h64zqlaNEne/8MhMSHbzpUnW8U9zrgyD19UdnfEjn8TjlpxcYcHwcs
	 9RyXj7XZpo9DFcNAw3nA0/nKcWqbV9cW5/kyVbbVRwVxtxLY0CLss+kULu0B8ldoSF
	 mk3pXA2360nGw==
Message-ID: <sashiko-outbox-169081@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/10] ARM: goldengate: Add support for the CS75xx
 SoC family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v6-4-37e8f3969b7c@gmail.com>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <20261013-b4-cs75xx-v6-4-37e8f3969b7c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:25:14 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> The Cortina Systems CS75xx ("Goldengate G2") are network processors
> with two Cortex-A9 cores, an SCU, GIC, the Cortex-A9 global and private
> timers and a PL310 L2 cache controller. The family includes at least
> the CS7522 and the CS7542; the CS7542 is used, among others, in the
> Securifi Almond+ router.
>=20
> Apart from the vendor this has little in common with the Cortina
> Systems Gemini (SL3516/CS3516) supported by mach-gemini: Gemini is a
> single ARMv4 FA526 with Faraday peripherals (FTINTC010, FTTMR010,
> FTGPIO010, a 16550 UART) built for ARCH_MULTI_V4, while the CS75xx is
> an ARMv7 MPCore whose UART, GPIO, interrupt controller and NAND
> controller are different blocks. It therefore gets its own directory,
> named after the Goldengate codename like in the vendor kernel. The
> [ ... ]
> is r3p1-50rel0 (CACHE_ID 0x410000c7), select the workaround for its
> erratum 769419 as well.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v6-0-37e8f3969b7c@gmail.com?part=3D4

