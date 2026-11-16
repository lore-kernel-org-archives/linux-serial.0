Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827269;
	b=P1uZkk3Rw9YaWw69ZIT7MvsusR2Vj9DiY6zPXH23GMm+hmwj02Milx9xAvv/aPZvD5fY
	 lkS6hRbUwbeiHoGOVm9oj5cJtBcVtzCQv7Izhj36DRk1bf+AgJhSqcc9XFcBjb9bZK0wL
	 hw3leU92rUCG0ZIq19jqTf2y6D4Nvzx3godu/nkMm+Gp0glRtXoSDm7UtneTFrT+hL2OM
	 U8HmlV/yNLIClXVF01EAnXQ6BBFex2wafhrcXJ33XUr0vDR8nhOs7I03lWwBcsz3pbZLx
	 1xz8aOCnha8ymJ1cG7aUFkSHZLSiLhCHYEgOzPM0NfjHP8+1a7PYIDpTZn3QBZDRJGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827269;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yMzDy8tPORzWpYzGK5zbIWXni3eI84OVFQNEjmecPuI=;
	b=5c31cLJ5Ro92tlUpSaLCnq9tubNcY2Q7HAGfkdfUv4MvbzOuFhrmWXXlPrjKCeQZyB2L
	 gvVJPrfwwjlSdAwWhLGiulHvw6A40AlZdIkGB3NM+oCHuVlcoRDfdUZMivIdS7JmMgJVu
	 F2TvKQ+0bV5/kKlHQdRMSpFanWvczcQ6HzUXElm84pGmV3ql0oWzjrSjUPXoUOlkzxr6P
	 kDV8rqZfUyMyu8Nj0HbWSnrPKjsH61ueHG5UHLSTfSscy/4rzR+wuB7nndXpzCD1YPfs4
	 T4TRRB0SVPbF2UvWE9r+sSj3b61j8wCRZYuvme/u5lyUo1TDbBHzV8gIRVdBccou6ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXT9Hqcl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0E606B1B1
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXT9Hqcl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787781F000C5;
	Mon, 16 Nov 2026 11:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827269;
	bh=yMzDy8tPORzWpYzGK5zbIWXni3eI84OVFQNEjmecPuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXT9HqclqlDPwIaDgJzX976iSTban0C6BJBDeKsVgkii2/iDbKn0NmIj42Ly4h3bu
	 /AP8QmwD2pnKVeSIN34YolJQOe3Gvx1ER5c4HfKUY8y+nhfodsrsHFmvZ10LVswn4u
	 n+gkIue2AGqU2m49hgJn6zXni/9Ri+ZMqzi/OKny863hfZz1EFwgA4DRK5fJlPOW+Q
	 c03Ye+YZ3hcO2rulV6LMjTmXbd2OffENf2ryrDghieEO/uaR09mBwayhPJN9MTQiRW
	 OB/lmlfoWPWEWa4kaUeeNnZBgDfqDGYzOVlBZiIYligywc/cAvFXxpvJpaxsNyxAvm
	 ENbZPVufVfcMA==
Message-ID: <sashiko-outbox-216843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/6] dmaengine: dw: Fix XFER bit set, but channel not
 idle error
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261116-submit-dw-dma-synchronize-v1-v8-1-4a82d64fcd1a@gmail.com>
References: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
 <20261116-submit-dw-dma-synchronize-v1-v8-1-4a82d64fcd1a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:07:49 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> If a client driver gets to use the DW DMAC engine device tougher
> than usual, with occasional DMA-transfers termination and restart, then
> the next error can be randomly spotted in the system log:
>=20
> > dma dma0chan0: BUG: XFER bit set, but channel not idle!
>=20
> For instance that happens in case of the 8250 UART port driver handling
> the looped back high-speed traffic (in my case > 1.5Mbaud) by means of the
> DMA-engine interface.
>=20
> The error happens due to the two-staged nature of the DW DMAC IRQs
> handling procedure and due to the critical section break in the meantime.
> In particular in case if the DMA-transfer is terminated and restarted:
> [ ... ]
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: require a locked XFER event and handle an empty active list]
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-submit-dw-=
dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com?part=3D1

