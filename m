Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1B48EC9D
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207012; cv=none; b=bOM9bbBcmEPJghR0hPYntlG0FZq09IPxGz+1BPVxeORTBbobUH3Pemd4BmafqiBq/179aA0wIB0qAOfoXVjTQr7Uy1AGokkW37dWbkyX4eMLhvtYc0uiR+4b9ceft1j/s0TEl/mwAw+UtFNHFad51bJ1Gp2nJ2H2mrqywcWEVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207012; c=relaxed/simple;
	bh=ZcS1ts/BLcgmd/NRQvXgC/06o1XAtl/GAisSTiI+Xmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SwkT7+D3siAQueeRQDnUGGh9tYCqyDI5ZmXWKuovl7ZvNTHreOsgElgwCtsym2A4ulwhKEQSzdrSLSfYbL1GDHnXEn9BDX8ZnKzR6n5oNWlNxinScaDSIGFFeKtDfIyhFYKTQEI53ia5hbTn1+FREJ3Htx31GsJI33w02umZbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYawpFk/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYawpFk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C6C1F000FF;
	Mon,  5 Oct 2026 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207005;
	bh=ZcS1ts/BLcgmd/NRQvXgC/06o1XAtl/GAisSTiI+Xmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BYawpFk/2GilZvN0uzrDgr2hq1S11lhwEnFacTRUikcKlZEZDXa8cNWgcPfa3ePBY
	 dGfoFjSufNsur6s4/8qKbZUAiuGo51mmzqCm2rIZKXS/bhQwKQNHcWnrcGgUvp/0C9
	 d1Ov345ighUbPAGM5HwU9SjNC9Fuj4EyM/A/5SEvobeMTvgVz7TbMtLEnntfecu8Gk
	 9hcAdcq/1wSZyZ/aFfEgLS7UUFHYUzKJgWzY3OsTPAWihJ8HqADhg6E/bSOwq08KRY
	 5hiUc2u6cDoSBdr6eBCstK+KR6Y/zQEbgXKOlZNucvPjJA68Ngk+iWxIw0GjaX0UDX
	 iuGv3ygYXojsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/9] serial: max310x: schedule tx_work directly from
 the IRQ handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-7-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
 <20261005-max310x-rs485-sw-delay-v7-7-6ae392eca08c@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:30:04 +0000
Message-Id: <20261005133005.12C6C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The TXEMPTY interrupt asks for a FIFO refill, and start_tx() does
> nothing beyond scheduling tx_work, so going through it makes no
> functional difference. It does conflate two distinct events, though:
> start_tx() is the serial core starting a new transmission, while
> TXEMPTY can only fire for a transmission that is already running -
> the bit latches on the FIFO's non-empty to empty transition, and the
> IRQ handler's read of IRQSTS consumes the latch, so a stale TXEMPTY
> cannot exist on an idle port (if the bit were level-triggered, the
> handler's read-until-clear loop would never terminate).
>=20
> Schedule tx_work directly, keeping the interrupt path a pure FIFO
> refill. This is preparation for a following patch that adds
> software-timed RS485 RTS control, where start_tx() also starts the
> RTS envelope and a refill must not restart it.
>=20
> No functional change.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-max310x-rs=
485-sw-delay-v7-0-6ae392eca08c@vaisala.com?part=3D7

