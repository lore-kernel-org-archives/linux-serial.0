Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A843C7DE
	for <linux-serial@vger.kernel.org>; Sun,  4 Oct 2026 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116650; cv=none; b=okxOgdVC8mXWWOY5wGEgkx4RjA5JN5SFMEQ+25ao3iigLDONyqkCJwtlH8AWlTPt57dYx+A/ffo/ZT4BMXMo6L0OYtJo9B7T8IgcIaYKbqHwSuH/RKGnmkaAUVt3/f0GhMAUJvYuZuPJfcdy5UxsFJPBWbtUHdWWkvy69yClAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116650; c=relaxed/simple;
	bh=4mmMmFG2LLNqDPE/6d4nUFhU0HgKcQ0iSQFmSRlz/tc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bdzoCfyBxUiohdJlxOMjnqM8/AucbHVh09vQXJq+SiZizi8YI+5KREJfxsO1ojtOid4XjiSeNHrPi8VbI9zaN6g1Gck/tfcP+mu5Gso+PhT9n9Hwlr+gJlV8c3yElVPLEIbn5qvwG1Nygj7tpN5IRtZyGwWD/g0CNynWUgYWiJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBxlsM0Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBxlsM0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4111F000FF;
	Sun,  4 Oct 2026 12:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116647;
	bh=4mmMmFG2LLNqDPE/6d4nUFhU0HgKcQ0iSQFmSRlz/tc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fBxlsM0ZVbFHxXiN6iuok4WTBEZtiHZFA+ABWwdlfWxD8up0mwb3qnWIKtcUZJYOA
	 Oh931DMZTb6HdXZpEz6+Dbwwh1g/1Zo5CSm/4ah9JCFInxUw0IaXKF7j7cL70ASQ63
	 RrqP5PluNmjHc5lCyVJOxiGsOYp3r9rfOGU3UxSeDIV6LYN7OHfucwWmvMn4WfnjBh
	 r0jJwwKHOOIfvAubu164ifr2rsBh5VLqlU/pnoI9xnljflDZilpsU5fneDEn5wiohb
	 63Ab1S2hhBN5IqRv+BSonA9O5gQZ5u0QG2Wd+z2WsnjbgUaDFT5pDBfQY/95aPExGK
	 xsXzwvSwk32dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/9] serial: max310x: schedule tx_work directly from
 the IRQ handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-7-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
 <20261004-max310x-rs485-sw-delay-v6-7-3a0ef13ed9e3@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:24:07 +0000
Message-Id: <20261004122407.9B4111F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-max310x-rs=
485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com?part=3D7

