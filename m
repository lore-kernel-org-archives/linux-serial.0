Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597164;
	b=aFHB/Flxh20FUyjjLvPR3JGvEnRUSt3vEdYmrS27QjVguUmr9AugYTr7R6FOTxU4faON
	 q007tme/pnwc5LCLBMMyKe2XE+WvYScigL6RK9m/boVf59MlV2KyV1KFOKCiVa0aIiHip
	 foKZh5IBQy5YqdQdOnsP58WlVfKKKdNl2XymgVgBI+jT4Fb6b2rBI/3l6usBXWwnXplxv
	 eHysXNRqHxtPsNdBvcyV0M1l5bvnz05zL+GJKfLZSKgdZBo03Cj5JQ1bCzn1WpFfEzjoj
	 O19A4LyJzd1NYaw/Ymj7FbVgXKdVbzRl0kmCwykZHwNsnx33rLYgm7d1jbnd9amtr+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597164;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2OTDK9is7oFieh3NdpfWnoIcrHhiABaGlo6zgKRVWYQ=;
	b=z81tOxkAJTIZzUTEJ4ro6lw4xh2hSUW/+TLbYLF787LpXaNqdVZwPh26AzRT3sLaykFg
	 JedAEwGwzXg7wwkmNCsWEWHKS+OAizladJBJ0WgBBC/TxS2vk+vpeuRHxW1t0D83++LZ/
	 JWrQW6PFscPcrajr/Ft55klkDacNnTN8mmLl+I1vPSKTGjdZNsb9ZsyGSZhgB5k0LYYdk
	 JrhqVig/hlXqB1BhO6gR0qdugcv2evSDkp/csG78HljYxoTx9N+ty5zYQoDCRoZY+Q1Qy
	 DKTGqJO3O0J9CmD8Exa/JLXGdiuwZ1wnqp3sWMhX65kXU6cjJ1h+EiN84/0XeknB+gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsOTv3Zg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D7606A327
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsOTv3Zg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D391F000C4;
	Fri, 13 Nov 2026 19:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597164;
	bh=2OTDK9is7oFieh3NdpfWnoIcrHhiABaGlo6zgKRVWYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XsOTv3ZgSInriprbkh1pOepX7SZAXtJjag0l69rtK6eLutyrmGQuCr3q3oexA2/No
	 a8UlhQFiy2LOAIFgyPtZ9YFLnsaXrOOaa+bNFTSxgc/IagZ6sKLnbhuVmMoNXp5qZ5
	 X0Uj2fFG6qfleHnExWGLOQ/O6DpVKnsqV3Xb2OP7Pd9oV/1bYYXNOpcUgzqYb1Mcg6
	 GHH2oley25phit7nhfvy2m5KeGPl77JwJghvOoJjfmck5AAdfM2p8gPxrT+DKtJJ5f
	 9V+PW31ieb2DhpIj3XO9br13mR+UtCR5RB/6JciDbdTg/iCRPiO1XaQnbeNHwmr6bS
	 G0ZHvCPgkYRwA==
Message-ID: <sashiko-outbox-213523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT6895
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Letuchiy" <asalde.le1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-initial-mt6895-v2-3-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-3-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:12:43 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add a compatible string for the watchdog of the MediaTek MT6895
> (Dimensity 8000/8100) SoC. It does not fall back to mediatek,mt6589-wdt,
> which implies the MT6589 TOPRGU reset layout, as the MT6895 one is not
> known yet.
>=20
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-initial-mt=
6895-v2-0-4ab0aa9fa391@gmail.com?part=3D3

