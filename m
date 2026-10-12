Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092164BF955;
	Mon, 12 Oct 2026 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826658; cv=none; b=bsHylInNKaUH2L9jzzVjKeK2RYRh+AVjBAJ3CClE+ldFllK29E5rFHArDdpB+3Lk7Q3vOW7WclEau9b6ucFmwIt4XeUDj+lJYq3wFekGE28DC0lRyg6KpDkzpEW5OenPhgAbiZceNDnC3oDtXKKjGXPiIpTYCwz8bXNP2AO9K3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826658; c=relaxed/simple;
	bh=3vND8Q3Mv8wwzYEtP1nvmphGddAGOXzTbZVmENfY5cU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ixVRs9emWSbT8mGCMjHZ+onEeSplcwfGuVvFmIs3nrP7FxdKdbqXjkwBlnzOyVN37WTOnfuqRaso8KQat2U6EDmzmk4Ycm4IvDVv89Gd1lP4fzwWdqSwurhXVHvMjmuQopG7ygnPWD13pcH/esj6xk3qHwlprAd+Vkmv8Iowpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0DJkfge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0DJkfge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4B91F0089F;
	Mon, 12 Oct 2026 17:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826656;
	bh=3vND8Q3Mv8wwzYEtP1nvmphGddAGOXzTbZVmENfY5cU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K0DJkfgeE0Djcos6rMf2d/7Y5XfdmNWxpUEzmHRg6/lrvW7+fziOJu8KVadjKULMs
	 DJ5BdF1wMIehvP3f/KCacw9Qrfvg0V4szoAaxV/4gODnabyvUxNikdKjXD2HliyYkH
	 RBqJjNd0/1sSNQQuw9TjvfEwwfj0+Ui2ZvCKVwpZf8tAI4A6zBHaf00seyfhU6KfxB
	 VnFJJGghinD9L/IYHTHNdPEAKOUODxDtUGiN0fQNpBe0WtN6ch4eZjE7vibemtApab
	 0UP3/QxVyvDl0AyLXuvSq8+b+p+wbGUltrpjannJS/soJPl1jZjYoE3CN3Gk0QvNrr
	 KAz3G5fndsJIw==
Message-ID: <sashiko-outbox-168471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/10] ARM: dts: cortina: Add CS7542 SoC and Securifi
 Almond+ board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-v4-8-df250d903682@gmail.com>
References: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
 <20261012-b4-cs75xx-v4-8-df250d903682@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:37:36 +0000
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
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v4-0-df250d903682@gmail.com?part=3D8

