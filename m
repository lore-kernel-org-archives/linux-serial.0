Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D833A7F48
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675915; cv=none; b=b8e+5ytN+4uEDAWXJ7cwHK8fBYCQHOCVGDEcjtTycqVq4L+6TFE+v1WLyGDEXnj5CuqWMN08Zp7J3s/JM2z8gTcjW6sTVEC2M6Rd8GsNFBQAPq8mECy28Jfcb4NIevN3Gk0rqG/joJyxvE1kHWfySWdBuu1ZjGilvtTHk9r5Vwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675915; c=relaxed/simple;
	bh=oUvFd4K0VJrIjEI7G91a9N/4xUJjnUEBRo9AsHpyDE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oGo+7AuU/2RqvzxpTggqOmCdu8c5Xhr8VhAxTD6E829ZyK2PclDCnkj7pGlECYWq/mnrHkWbzwgcGJyIJjkPZkMhi3B1mdu6e7YTdYzeeZoUwhhp8bHVHts5FeJlgv3YkwbUP+SRdRVQw7+3hyAxF4YGfIHvkhCusL8sIDR6veg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZpqHiLA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZpqHiLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AB61F000FF;
	Tue, 29 Sep 2026 09:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790675914;
	bh=oUvFd4K0VJrIjEI7G91a9N/4xUJjnUEBRo9AsHpyDE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XZpqHiLAQ4sMbKGkTjChzLaGFlFOiQoYgGC2UJUkZZuAbbw1W/5Kfd6J5nmmh33nh
	 vYav4kr4IabfCn/D2haIutsdA40kSgvkPTh41z8YKmoqKCWlN25k1XPq6o8d/KDcc8
	 vnPmEMGgY1vt5wzeeviPqPGpTqMTwOuNKJNCZuGtvjykhYXJVUJiErCm2Xj2a+M554
	 XQJd93PNvrEuZpQBABKl+Jceqn3NJilNInpDWnid8tPK8AYR91ajhiqlCMMx9HAP6f
	 OtVk36TLLroh2QSWad9gHUfhBRdNuaQ0MH1U9hxfcaeX5OXpCjTVvD8BycoA+IJllB
	 sBQlm7vgRYzuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] serial: max310x: schedule tx_work directly from
 the IRQ handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-6-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <20260929-max310x-rs485-sw-delay-v5-6-ae46afa583f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 09:58:33 +0000
Message-Id: <20260929095834.31AB61F000FF@smtp.kernel.org>
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
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-max310x-rs=
485-sw-delay-v5-0-ae46afa583f2@vaisala.com?part=3D6

