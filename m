Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD559457E4D;
	Wed, 30 Sep 2026 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752103; cv=none; b=sUu4yIn8ND6VK0ldkZuf6UmayDiJQLHjP1C5w2oM/nUNp2ZLSHnE8G6K4d4PPX5gR3hawDJpfrfa15yn+y03QY4UrtIOnhOuE2FXp7MxmItia5sqldUBuvjRWf88Ctct8ELPsN/HB+Cw+sMj9uhWkMWabLQYIi5PwJa/Jrn04tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752103; c=relaxed/simple;
	bh=VKlJRp1e3Zq+JS9fzszOOphb5GhuPRDAAJfmBAJwNjs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AIZ6q9dTP4BSOIJXmQi7Cf9zH+Byx58p7105aytcUUPTFyaGa94avMaLsvFdHrxSKatEIZnn70LQedfHchuX9sf4OTmxjavJB4mqa1Ft4esBLWltNX9t4NOYkz9KRn9yZxdpeBejZGOPGeBslUdmkQPhyGiCNlvI11K4MWVrT+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeP6RChA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeP6RChA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D211F000FF;
	Wed, 30 Sep 2026 07:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790752102;
	bh=VKlJRp1e3Zq+JS9fzszOOphb5GhuPRDAAJfmBAJwNjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GeP6RChA94e1zs8Kyl/fMMeXWIsK/hHFzhZOTmJ13V5od2nPY+pwehLZgH9XMqK9d
	 D9mWdp0M9Jbrybehty5ICFNvo/fiO694wFZLsSaKIssNbtUyzf+N10WxRP5vMs+FM7
	 F8YthGRExd2sI4/wAukqaeOoIQBFnVIC7+9lu7+vUqFjbaFQX+2oKwkhmdZ60VsUDy
	 59qIAG6bjAIqUjgiR+UF55O4gqrFyraadDCiT28dWV32oqBD8lhX/upRfGUIv2E83i
	 w3z108QyXT7o6J4ORLpIh2PPz7aWKYS/+il+jBtKWlb2hw64fM+vAs/RKgehrrNu7h
	 cHb1ZpavD87Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/10] ARM: cortina: Add support for the CS75xx SoC
 family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260930-b4-cs75xx-v1-4-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-4-4617c4463529@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:08:21 +0000
Message-Id: <20260930070822.16D211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> The Cortina Systems CS75xx ("Goldengate G2") are network processors
> with two Cortex-A9 cores, an SCU, GIC, the Cortex-A9 global and private
> timers and a PL310 L2 cache controller. The CS7542 is used, among others,
> in the Securifi Almond+ router.
>=20
> The generic DT machine is sufficient for the platform, so only the SMP
> bring-up needs code: the bootloader parks the secondary core in a WFE
> loop that polls a global software register, so boot it by writing the
> physical address of secondary_startup to the register named by the
> cpu-release-addr property and issuing SEV.
>=20
> The CPU is a Cortex-A9 r2p1, so select the errata workarounds that apply
> to that revision and can be enabled on a multiplatform kernel. The PL310
> is r3p2 and needs none of the PL310 workarounds.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-b4-cs75xx-=
v1-0-4617c4463529@gmail.com?part=3D4

