Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082710;
	b=kwfMUKbws+PRHZmCoDcRTJ92WHi6f1ulbD9Vyl6Jw1tYSgepKirGa4uBOTlWvfoY1F1O
	 mILMStsAqCxgA0225FuJFYXtYVLRhSeQ5vZejsd+lgS6Z7jPMPkT4lSa/luJJsxwRNNNv
	 OMM4xxC0a6RzSB1cARz4JBJ3B/m4rnqA4k7Hp1yIoiz9Qju9lfE8Nm+LkY7vEy4HkoH6e
	 OHNkTnnuW0UF+tzx2kTHlwNjFncGWQ7homoEw7sCcOipZSrKpBaC2OwloBwK1QAAWXZN2
	 aBle650ZK3rufAeBEjoxhAmMH9mvhDi9a1h4eG6HYJYwzkpTEojXiFhBJ69tvbS1EsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=huAMzksB9Gg2uZ34hggncpbu2ScjgHmvvzVRKmDeAA8=;
	b=L6KzZwBRYB3OsAwlhPoc8YYdgDG2aPMU4gPdUxktc9b5PCbXoRvYvfsygdEp2d+6yTMl
	 /hwJ8romdZy0HtVrNhBLk1yE6Ttuc4tN/3ecSPfMxAp93LZBpm8yllKSiUjHp3tM4XK5S
	 fiJM4QRgm1kODh1NaObUskoG3+QWMMPvU8fo0uy3e6wOs7mBAoReyrh5uwgfNPNpg9mGf
	 4i5iO9qv9yTJuRJxMJyCV3E31JuaODxSRhrVnLqcOfwRP7e2UPW2WhB5C862Tb1/443AU
	 7j1cITWwJ7r/M6dn5lxG2MZx17S5gjBZtLuvmcg4oM8xC/aXtv1vdZGnhc8ulxZoBiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ib6YOyOI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39C606A320
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ib6YOyOI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4D91F000C4;
	Thu, 19 Nov 2026 10:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082710;
	bh=huAMzksB9Gg2uZ34hggncpbu2ScjgHmvvzVRKmDeAA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ib6YOyOI7xZcQORiJBK6LYpMcck/LpWflEanvMvAd/JBbd++tT1xbV5FbIxieaPXQ
	 UA7coZ65NYaXlOTJMfXgnvYd1eb6ZoRbFn9QlgmJDingQ4adM1uesREzuytTGNFG73
	 rKporJ5Kc8FUqzYuXQQeWYi46OH0nMD4Cz8JULUEMy3Lnjr8wy4O7J//19797m3SJ/
	 fgO/xwtziq0Lub8p496EcW14+q5W00zppatm3DkTcsZ4WU2aD4FPF42l6hxhJ415gQ
	 S5zQI2mKL5mucHradGVJhxwpAbUmrI5dh48W7GjvJVj2fqbVRubERZhFwSX1BATo/+
	 IxhJ3MUfUjCUA==
Message-ID: <sashiko-outbox-222907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/7] dmaengine: dw: extract hardware-LLP residue
 calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-5-3a737597a0d1@gmail.com>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
 <20261119-submit-dw-dma-synchronize-v1-v10-5-3a737597a0d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:05:09 +0000
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
> Move the hardware-LLP residue calculation into
> dwc_get_hard_llp_desc_residue() so it can be reused independently of
> completion handling.
>=20
> Keep the scanner's LLP snapshot, descriptor updates and early returns
> unchanged. Only one transaction is active, so the helper updates its
> cached residue directly without reporting a completion indication.
>=20
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: extract the calculation for the single active virt-dma transactio=
n]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-submit-dw-=
dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com?part=3D5

