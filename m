Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76C4BE453;
	Mon, 12 Oct 2026 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826780; cv=none; b=W3yuvXfT+1Ykt+clziNFso7ctdWJhqzKu8tG4kgEF+Bjrb1EOVPbIM/GIbqPbhE/uSqxbcju5m6ajtk33t/xhYrnHMVziZiPbaP2pgony+wZn0k/1P22C7Z3UOlBu5tir7bBlh6TtrIMlWoFa5PKIvNFOnvIeS39R1XTLoCx9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826780; c=relaxed/simple;
	bh=5EwlMNpn7oWnnxKo+WN5L7wLe9jC312a8nhoS0ZVSAY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gKSAUqfpcm7a8fdSg/X1aXfTR6kjBDkAgZVcsZCpCe1yAuy0QRPVcLcyOaDhs4fxOCeNKC3uGUHTribCWSVeTJwNidN/bnQKzIduXTFCc2C85vUIRKeD9o8PiGcooQgUkH+ubl0+DGbzMT6fM5mEH4lK6LhbaXXX/2qF+cC7N6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKIObDea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKIObDea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478D41F0089B;
	Mon, 12 Oct 2026 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826778;
	bh=5EwlMNpn7oWnnxKo+WN5L7wLe9jC312a8nhoS0ZVSAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKIObDeao1gR2/ktYh246Si2d8EDSos9Id2s72qm/ZTpJbYrcEtulbjXA7gcMZi//
	 xEjEcUbXYkBhVzy3vxIi/KTvlpZa4Egz2CDH/u7T33gs6O9VVGMDHpnjVv7920NYz9
	 L9ZiWCnVIIavhxFGzaQEy8WflYesDSGhwkFN/uioXs3yTcCn6gssjGJW8Uny3TG4u1
	 Md47wOCKWCJNE5CYo4GJGo7ovgvqIocXmYdXCZRDk9/xHW+dbh7gUAKdLCBReiA3Xq
	 tG4PRpNq/b6dvnCDUVv+ei7lxMlcMuEmcV0Gi2bm3fA3pxhq14Neq5RC7g5LQEDH7a
	 dC56GKSdgN33A==
Message-ID: <sashiko-outbox-168475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/10] ARM: goldengate: Add support for the CS75xx
 SoC family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-v4-4-df250d903682@gmail.com>
References: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
 <20261012-b4-cs75xx-v4-4-df250d903682@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:39:37 +0000
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
> to that revision and can be enabled on a multiplatform kernel. The PL310
> is r3p2 and needs none of the PL310 workarounds.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v4-0-df250d903682@gmail.com?part=3D4

