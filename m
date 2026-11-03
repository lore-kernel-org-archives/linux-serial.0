Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745108;
	b=oDUchsjJ1Ukr88jePTxOLhhoExlpnQVWjOaI+ce/gLM0YBcuv6MwUQZin7irwaN29P8i
	 DEHndagivqFawg6fZJCMDgSH92ZgxAsoVeqYrUMy2M0eOFCfGdYA9o9jgLRRJCs//Ukyh
	 U3X0DDKEpj103s32QuevImlE5auKWq7jT2A/cThy9hceC2672grtN6Ea4taDDF7pJ2CmX
	 k0FkoeyH4tvyBRRmCLYTFzAHNdBfL+Vb6WT0wQceMGnYKZma4zh+182y/OJ7Ip/3Mk8C2
	 egBL+tOQqbFEyatN4L2Iu6pssiM+CoPVSktm98+Q+ElVf8hLpyVa8+xqXJ2PrCO+ngw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745108;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bPN9LL36+RiRW7xW/dFpxjzYkWKJpsTsMJ3rjfNgYaA=;
	b=I0ERyBO0qa1KUReYOiPvrKolnzJzHv87He7EmoqbyBkACqg5i9cIUHVTVINmVSJMa6Qc
	 JjehUeXneuhdSsHNTAOGVW2zjDV6nz5KGUGwbdx2canJrCFYyhCHSrOiVlQ8WMHpq/ekb
	 bXOnskZKS4M1146HiiXDYwfUvRv2Oo+Ai1tekhskJFbkQF4sduVh+P/yFn7rcfjYwFVF4
	 caW2Bgps+m/uiuCuQiUDDhiAe8fpGXV7YC3u58vBts61e+cZydavM0odILnG0yXhNxgba
	 zBcYGwBNg6ctCxs+VchlLyHYqCk5K5F78iXVqDIiJ4oUtzhKS5mvPtYJ17htFSZqAgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDXLdhjW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411F606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDXLdhjW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EA11F000C1;
	Tue,  3 Nov 2026 22:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745107;
	bh=bPN9LL36+RiRW7xW/dFpxjzYkWKJpsTsMJ3rjfNgYaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WDXLdhjW+0OSmxDcNyqMOohR80izLcy5QVLiaq/Aodv5GtQCRvikGWJqjuuqjAqsz
	 Q9BvMReXNoZOhssYL1l2vumerF0Uydqln6aIkiQqvnP8uRH8C/MURvsBqJC2y7nxU0
	 HK/sIcM4FkHtjt6ka2yzkzMey8XL7cXPX1W1bdxpsAvj/hm6mGfhkSNEJxTYVrs2D5
	 K+oY03AMlfN9BJziSxG4K2kS9IKiXpJRAnAyo7+KWqPvr6fXMXB576GdI+jJvr6D7j
	 HkuXUHy3uUc6utIgfWoGjTlVQoFQgYhkuV6rh6CVsADvVpfCPGaMxIIGELD8VQa73R
	 1FkDpJgkVWdDA==
Message-ID: <sashiko-outbox-196119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/10] dmaengine: dw: complete cookies before
 releasing the channel lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-3-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-3-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:31:47 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Completion detaches a descriptor from the active list under the channel
> lock, but updates its cookie later when freeing it. Termination can take
> the lock in between and complete newer descriptors. Completing the older
> cookie afterwards moves completed_cookie backwards and makes an already
> terminated transfer appear outstanding again.
>=20
> Complete cookies while detaching descriptors in the completion, error
> recovery and termination paths. Keep the active-before-queued ordering
> when terminating so completed_cookie advances in submission order.
> Descriptor freeing and client notification no longer update cookies.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-dw-=
dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com?part=3D3

