Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663845;
	b=U8NsMWzegIv8iFZOfJvB6Spk5M1AAGq2WPQ364e+7SXwg/Ad9lPfKJmVyGYOaozyAW1X
	 3qjNpFCZKL7A/e+Awu4Rpz5wnv4ri4aIt5AsWCQd0Xec4pXfKCQG0xHZ6QcNAjpMEcYwg
	 YMsXgHUCKWhSkRaw/bop3qb7nTbmY6aY2aiXbPcH9HHSs3+5//aTXLmmgY2l4YeuSRHT0
	 r0g8XMzKkyYBZhwht2nT5kQnSaUrQfs/jxRaY9/wEqI1dnnBN7f7d0tKnHxNEk+xRGok7
	 /8pzlZLW26XvfGwjvBeaGncyVZZK+87hYJ+QofcBWVCXVSSyWu+VeBDbPZp5LanwhIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663845;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HWu0KslN2JnC5WOx5b4gJPlo/nxhj1EC7x6emNObcI8=;
	b=vXhz0G4XYGwMwnKvK68HWzw+WFH6YiqqKgiAJJwt5RYD7MbQYKqjf+hd3v4PeYI6HfvY
	 MTkeYaLJxD4kcmA8y6vbDKM2+AFxk3ILi/0Bnsxx9XhtHEdI3sln8cyQcCnqI5Kas5aQ/
	 qoOIY9osVmiKJdXZugPSoOjwka2PrWLIW4pvVe5cSfk/rDgbvgaWIDNckag4C0j7uLEae
	 DUXXQZdHH7EXU5dybQhsbMkts+wi33ni7uwn69Q+K7iN/0UsjNRO0YBkvvFebOhSuQI6L
	 FxcFjhZ1xsz2Y+mEOazS+3/gtCaw0cDaWKZF2uSwwTQu4DSydh54bIewp+Hplktx95w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=np7qQHA9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D8606A32D
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=np7qQHA9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BA21F000C4;
	Sat, 14 Nov 2026 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663844;
	bh=HWu0KslN2JnC5WOx5b4gJPlo/nxhj1EC7x6emNObcI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=np7qQHA90BsjvVj0ualVi1UOtkZ3HBFSfzV+ypWlE72QeRKj9cTd15zHr9HyHUVAE
	 rTAOEhINbNlfbkoaKJ4qZpv0BBAm6yHO3LMI5pLfKipV7mTszBe8zYSN4mwrI89mVj
	 GBv/dd6a8Ke2gqIiORXrnEw0DYeD20GRts2X0iQ+vyHtWUBYpYehouilstJoy/3cqT
	 zGKCSKjXTJDhOmfGrn+d3GfGdSvXPHMKOp8WQ6bzw0Ouo3e5rZixw4gCY6dLAkiKJp
	 5jVTXm5KVQQ5q3r8JR1uoeyVOypIbsH6qMcLgEuuFIT7CygcmSHneV3567dTJocU2t
	 ASvW2rEKsBUjg==
Message-ID: <sashiko-outbox-214586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114-b4-cs75xx-v7-3-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
 <20261114-b4-cs75xx-v7-3-8f17f38821b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:44:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> On the CS7542 the bootloader parks the secondary Cortex-A9 core in a WFI
> loop that polls a global software register and jumps to the address
> found there. Add the "cortina,cs7542-smp" enable method for it and,
> as with the other release-address based methods, require cpu-release-addr
> to point at that register.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-cs75xx-=
v7-0-8f17f38821b4@gmail.com?part=3D3

